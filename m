From: Andrey Pronin <apronin@chromium.org>
Subject: Re: [PATCH] CHROMIUM: ecryptfs: sync before truncating lower inode
Date: Fri, 21 Apr 2017 16:52:13 -0700
Message-ID: <20170421235213.GA134008@apronin>
References: <20170418233649.78805-1-apronin@chromium.org>
 <8ce53762-80fb-2e1d-07bb-95aff17c5d33@canonical.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8ce53762-80fb-2e1d-07bb-95aff17c5d33@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tyler Hicks <tyhicks@canonical.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, gwendal@chromium.org, dtor@chromium.org

On Thu, Apr 20, 2017 at 06:27:52PM -0500, Tyler Hicks wrote:
> On 04/18/2017 06:36 PM, Andrey Pronin wrote:
> > If the updated ecryptfs header data is not written to disk before
> > the lower file is truncated, a crash may leave the filesystem
> > in the state when the lower file truncation is journaled, while
> > the changes to the ecryptfs header are lost (if the underlying
> > filesystem is ext4 in data=ordered mode, for example). As a result,
> > upon remounting and repairing the file may have a pre-truncation
> > length and garbage data after the post-truncation end.
> > 
> > To reproduce, make a snapshot of the underlying ext4 filesystem
> > mounted with data=ordered while asynchronously truncating to zero a
> > group of files in ecryptfs mounted on top. Mount ecryptfs for the
> > snapshot and check the contents of the group of files that was
> > being truncated. The following script reproduces it in almost 100%
> > of runs:
> > 
> > cd /tmp
> > mkdir -p ./loop
> > dd if=/dev/zero of=./file.img bs=1M count=10
> > PW=secret
> > 
> > LOOPDEV=`losetup --find --show ./file.img`
> > mkfs -t ext4 $LOOPDEV
> > mount -t ext4 -o rw,nodev,relatime,seclabel,commit=600,data=ordered\
> >  $LOOPDEV ./loop
> > mkdir -p ./loop/vault ./loop/mount
> > mount -t ecryptfs -o rw,relatime,seclabel,ecryptfs_cipher=aes,\
> > ecryptfs_key_bytes=16,ecryptfs_unlink_sigs,ecryptfs_passthrough=no,\
> > ecryptfs_enable_filename_crypto=no,passphrase_passwd="$PW",no_sig_cache\
> >  ./loop/vault ./loop/mount
> > for i in `seq 1 100`; do echo $i > ./loop/mount/test.$i; done
> > sync
> > for i in `seq 100 -1 1`; do truncate -s 0 ./loop/mount/test.$i; done &
> > sleep 0.1; sync; cp ./file.img ./file.snap; sleep 1
> > umount ./loop/mount
> > umount ./loop
> > losetup -d $LOOPDEV
> > 
> > LOOPDEV=`losetup --find --show ./file.snap`
> > mount -t ext4 -o rw,nodev,relatime,seclabel,commit=600,data=ordered\
> >  $LOOPDEV ./loop
> > mount -t ecryptfs -o rw,relatime,seclabel,ecryptfs_cipher=aes,\
> > ecryptfs_key_bytes=16,ecryptfs_unlink_sigs,ecryptfs_passthrough=no,\
> > ecryptfs_enable_filename_crypto=no,passphrase_passwd="$PW",no_sig_cache\
> >  ./loop/vault ./loop/mount
> > for i in `seq 1 100`; do
> >   if [ `stat -c %s ./loop/mount/test.$i` != 0 ] &&
> >      [ `cat ./loop/mount/test.$i` != $i ]; then
> >        echo -n "!!! garbage at $i: ";  cat ./loop/mount/test.$i; echo
> >   fi
> > done
> > umount ./loop/mount
> > umount ./loop
> > losetup -d $LOOPDEV
> > 
> > Signed-off-by: Andrey Pronin <apronin@chromium.org>
> > ---
> 
> Hi Andrey - Thanks for the patch and for the test case. I was able to
> reproduce the bug using the test case. I have some comments below.
> 
> >  fs/ecryptfs/ecryptfs_kernel.h |  1 +
> >  fs/ecryptfs/inode.c           |  6 ++++++
> >  fs/ecryptfs/read_write.c      | 22 ++++++++++++++++++++++
> >  3 files changed, 29 insertions(+)
> > 
> > diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
> > index f622a733f7ad..567698421270 100644
> > --- a/fs/ecryptfs/ecryptfs_kernel.h
> > +++ b/fs/ecryptfs/ecryptfs_kernel.h
> > @@ -689,6 +689,7 @@ int ecryptfs_read_lower_page_segment(struct page *page_for_ecryptfs,
> >  				     pgoff_t page_index,
> >  				     size_t offset_in_page, size_t size,
> >  				     struct inode *ecryptfs_inode);
> > +int ecryptfs_fsync_lower(struct inode *ecryptfs_inode, int datasync);
> >  struct page *ecryptfs_get_locked_page(struct inode *inode, loff_t index);
> >  int ecryptfs_parse_packet_length(unsigned char *data, size_t *size,
> >  				 size_t *length_size);
> > diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> > index 5eab400e2590..e7eb8ea154d2 100644
> > --- a/fs/ecryptfs/inode.c
> > +++ b/fs/ecryptfs/inode.c
> > @@ -827,6 +827,12 @@ static int truncate_upper(struct dentry *dentry, struct iattr *ia,
> >  			       "rc = [%d]\n", rc);
> >  			goto out;
> >  		}
> > +		rc = ecryptfs_fsync_lower(inode, 0);
> 
> Wouldn't we want datasync to be true in this situation?
> 
> 
> I am also wondering if it'd be best to sync from inside
> ecryptfs_write_inode_size_to_metadata() itself. Your test case shows
> that the code path when truncating an inode size to zero is affected
> but, from what I can tell, the code path when increasing an inode size
> should also be affected:
> 
>  truncate_upper -> ecryptfs_write() ->
>   ecryptfs_write_inode_size_to_metdata()
> 
> Did you consider/test doing that?

Hi Tyler!

I originally thought that truncating to a larger size can't lead to
serious inconsistencies. And that may still be true. In theory,
the worst that can happen if the lower inode changes are journaled
but the new ecryptfs header not sync'ed to disk yet, is the lower
file being larger than is actually needed for ecryptfs file
(since the ecryptfs header would contain the smaller pre-truncate
length).

However, in further experiments, I ran into yet another situation
when a combination of truncating up + writing + immediately
unlinking this file can lead to the lower file containing only
a completely zeroed-out ecryptfs header. So, open()-in ecryptfs
file then fails in marker check. I'm not sure yet if it is related
to the truncate issue we deal with here. Let me first further check
what's going on there.

Andrey

> 
> Thanks again!
> 
> Tyler
> 
> > +		if (rc) {
> > +			printk(KERN_WARNING "Problem with ecryptfs_fsync_lower,"
> > +			       "continue without syncing; "
> > +			       "rc = [%d]\n", rc);
> > +		}
> >  		/* We are reducing the size of the ecryptfs file, and need to
> >  		 * know if we need to reduce the size of the lower file. */
> >  		lower_size_before_truncate =
> > diff --git a/fs/ecryptfs/read_write.c b/fs/ecryptfs/read_write.c
> > index 09fe622274e4..ba2dd6263875 100644
> > --- a/fs/ecryptfs/read_write.c
> > +++ b/fs/ecryptfs/read_write.c
> > @@ -271,3 +271,25 @@ int ecryptfs_read_lower_page_segment(struct page *page_for_ecryptfs,
> >  	flush_dcache_page(page_for_ecryptfs);
> >  	return rc;
> >  }
> > +
> > +/**
> > + * ecryptfs_fsync_lower
> > + * @ecryptfs_inode: The eCryptfs inode
> > + * @datasync: Only perform a fdatasync operation
> > + *
> > + * Write back data and metadata for the lower file to disk.  If @datasync is
> > + * set only metadata needed to access modified file data is written.
> > + *
> > + * Returns 0 on success; less than zero on error
> > + */
> > +int ecryptfs_fsync_lower(struct inode *ecryptfs_inode, int datasync)
> > +{
> > +	struct file *lower_file;
> > +
> > +	lower_file = ecryptfs_inode_to_private(ecryptfs_inode)->lower_file;
> > +	if (!lower_file)
> > +		return -EIO;
> > +	if (!lower_file->f_op->fsync)
> > +		return 0;
> > +	return vfs_fsync(lower_file, datasync);
> > +}
> > 
> 
> 



