From: Andrey Pronin <apronin@chromium.org>
Subject: Re: [PATCH] CHROMIUM: ecryptfs: sync before truncating lower inode
Date: Wed, 26 Apr 2017 10:43:22 -0700
Message-ID: <20170426174322.GA33763@apronin>
References: <20170418233649.78805-1-apronin@chromium.org>
 <8ce53762-80fb-2e1d-07bb-95aff17c5d33@canonical.com>
 <20170421235213.GA134008@apronin>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33822 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932072AbdDZRn0 (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Wed, 26 Apr 2017 13:43:26 -0400
Received: by mail-pf0-f170.google.com with SMTP id c198so3386104pfc.1
        for <ecryptfs@vger.kernel.org>; Wed, 26 Apr 2017 10:43:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170421235213.GA134008@apronin>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tyler Hicks <tyhicks@canonical.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, gwendal@chromium.org, dtor@chromium.org

On Fri, Apr 21, 2017 at 04:52:13PM -0700, Andrey Pronin wrote:
> On Thu, Apr 20, 2017 at 06:27:52PM -0500, Tyler Hicks wrote:
> > On 04/18/2017 06:36 PM, Andrey Pronin wrote:
> > > If the updated ecryptfs header data is not written to disk before
> > > the lower file is truncated, a crash may leave the filesystem
> > > in the state when the lower file truncation is journaled, while
> > > the changes to the ecryptfs header are lost (if the underlying
> > > filesystem is ext4 in data=ordered mode, for example). As a result,
> > > upon remounting and repairing the file may have a pre-truncation
> > > length and garbage data after the post-truncation end.
> > > 
> > > To reproduce, make a snapshot of the underlying ext4 filesystem
> > > mounted with data=ordered while asynchronously truncating to zero a
> > > group of files in ecryptfs mounted on top. Mount ecryptfs for the
> > > snapshot and check the contents of the group of files that was
> > > being truncated. The following script reproduces it in almost 100%
> > > of runs:
> > > 
> > > cd /tmp
> > > mkdir -p ./loop
> > > dd if=/dev/zero of=./file.img bs=1M count=10
> > > PW=secret
> > > 
> > > LOOPDEV=`losetup --find --show ./file.img`
> > > mkfs -t ext4 $LOOPDEV
> > > mount -t ext4 -o rw,nodev,relatime,seclabel,commit=600,data=ordered\
> > >  $LOOPDEV ./loop
> > > mkdir -p ./loop/vault ./loop/mount
> > > mount -t ecryptfs -o rw,relatime,seclabel,ecryptfs_cipher=aes,\
> > > ecryptfs_key_bytes=16,ecryptfs_unlink_sigs,ecryptfs_passthrough=no,\
> > > ecryptfs_enable_filename_crypto=no,passphrase_passwd="$PW",no_sig_cache\
> > >  ./loop/vault ./loop/mount
> > > for i in `seq 1 100`; do echo $i > ./loop/mount/test.$i; done
> > > sync
> > > for i in `seq 100 -1 1`; do truncate -s 0 ./loop/mount/test.$i; done &
> > > sleep 0.1; sync; cp ./file.img ./file.snap; sleep 1
> > > umount ./loop/mount
> > > umount ./loop
> > > losetup -d $LOOPDEV
> > > 
> > > LOOPDEV=`losetup --find --show ./file.snap`
> > > mount -t ext4 -o rw,nodev,relatime,seclabel,commit=600,data=ordered\
> > >  $LOOPDEV ./loop
> > > mount -t ecryptfs -o rw,relatime,seclabel,ecryptfs_cipher=aes,\
> > > ecryptfs_key_bytes=16,ecryptfs_unlink_sigs,ecryptfs_passthrough=no,\
> > > ecryptfs_enable_filename_crypto=no,passphrase_passwd="$PW",no_sig_cache\
> > >  ./loop/vault ./loop/mount
> > > for i in `seq 1 100`; do
> > >   if [ `stat -c %s ./loop/mount/test.$i` != 0 ] &&
> > >      [ `cat ./loop/mount/test.$i` != $i ]; then
> > >        echo -n "!!! garbage at $i: ";  cat ./loop/mount/test.$i; echo
> > >   fi
> > > done
> > > umount ./loop/mount
> > > umount ./loop
> > > losetup -d $LOOPDEV
> > > 
> > > Signed-off-by: Andrey Pronin <apronin@chromium.org>
> > > ---
> > 
> > Hi Andrey - Thanks for the patch and for the test case. I was able to
> > reproduce the bug using the test case. I have some comments below.
> > 
> > >  fs/ecryptfs/ecryptfs_kernel.h |  1 +
> > >  fs/ecryptfs/inode.c           |  6 ++++++
> > >  fs/ecryptfs/read_write.c      | 22 ++++++++++++++++++++++
> > >  3 files changed, 29 insertions(+)
> > > 
> > > diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
> > > index f622a733f7ad..567698421270 100644
> > > --- a/fs/ecryptfs/ecryptfs_kernel.h
> > > +++ b/fs/ecryptfs/ecryptfs_kernel.h
> > > @@ -689,6 +689,7 @@ int ecryptfs_read_lower_page_segment(struct page *page_for_ecryptfs,
> > >  				     pgoff_t page_index,
> > >  				     size_t offset_in_page, size_t size,
> > >  				     struct inode *ecryptfs_inode);
> > > +int ecryptfs_fsync_lower(struct inode *ecryptfs_inode, int datasync);
> > >  struct page *ecryptfs_get_locked_page(struct inode *inode, loff_t index);
> > >  int ecryptfs_parse_packet_length(unsigned char *data, size_t *size,
> > >  				 size_t *length_size);
> > > diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> > > index 5eab400e2590..e7eb8ea154d2 100644
> > > --- a/fs/ecryptfs/inode.c
> > > +++ b/fs/ecryptfs/inode.c
> > > @@ -827,6 +827,12 @@ static int truncate_upper(struct dentry *dentry, struct iattr *ia,
> > >  			       "rc = [%d]\n", rc);
> > >  			goto out;
> > >  		}
> > > +		rc = ecryptfs_fsync_lower(inode, 0);
> > 
> > Wouldn't we want datasync to be true in this situation?

Yes, datasync=1 is sufficient in this situation. Will fix up in the next
version of the patch that I'm about to send. Thanks!

> > 
> > 
> > I am also wondering if it'd be best to sync from inside
> > ecryptfs_write_inode_size_to_metadata() itself. Your test case shows
> > that the code path when truncating an inode size to zero is affected
> > but, from what I can tell, the code path when increasing an inode size
> > should also be affected:
> > 
> >  truncate_upper -> ecryptfs_write() ->
> >   ecryptfs_write_inode_size_to_metdata()
> > 
> > Did you consider/test doing that?
> 
> Hi Tyler!
> 
> I originally thought that truncating to a larger size can't lead to
> serious inconsistencies. And that may still be true. In theory,
> the worst that can happen if the lower inode changes are journaled
> but the new ecryptfs header not sync'ed to disk yet, is the lower
> file being larger than is actually needed for ecryptfs file
> (since the ecryptfs header would contain the smaller pre-truncate
> length).
> 

I'm still convinced that adding a fsync to the path that truncates the
file to a smaller size (truncates "down') is sufficient. For the path
that truncates "up", i.e. to a bigger file size, (truncate_upper -> 
ecryptfs_write() -> ecryptfs_write_inode_size_to_metdata()), if the 
power is suddenly lost while performing this operation, fsync is not
required. Let's say a bigger size is already written to a lower inode,
while the ecryptfs header still contains the smaller size when the power
is lost. Then, after remounting, we'll still get a consistent file with
a smaller size, even though a larger lower file will be used to hold it.

When further using this file, if we truncate that file to a larger size
again, ecryptfs_write only cares about the size stored in the ecryptfs
header. If it is tasked to write past that position, it will fill the tail
with zeroes and write to the lower file again. So, the file will remain
in the consitent state.

Thus the only trade-off here is the performance hit from doing a fsync
when truncating "up" that we don't actually need to keep things
consistent vs. occupying more space than we need in the lower filesystem
if the truncate "up" operation is interrupted. I'd suggest to choose
performance in this case, and keep the truncate "up" path fsync-less.

> However, in further experiments, I ran into yet another situation
> when a combination of truncating up + writing + immediately
> unlinking this file can lead to the lower file containing only
> a completely zeroed-out ecryptfs header. So, open()-in ecryptfs
> file then fails in marker check. I'm not sure yet if it is related
> to the truncate issue we deal with here. Let me first further check
> what's going on there.
> 
> Andrey
>

This 2nd situation I ran into can be reproduced by this test script below
(usually detects the problem before the 30th iteration).
But it turned out that it contains truncate "down" paths on each
iteration, and adding fsync to that path only as in the original patch
is sufficient to fix it (runs for 7K+ iterations with this patch
applied).

===
cd /tmp
mkdir -p ./loop
PW=secret
ECRYPTFS_OPT=rw,relatime,seclabel,ecryptfs_cipher=aes,\
ecryptfs_key_bytes=16,ecryptfs_unlink_sigs,ecryptfs_passthrough=no,\
ecryptfs_enable_filename_crypto=no,passphrase_passwd="$PW",no_sig_cache
EXT4_OPT=rw,nodev,relatime,seclabel,commit=600,data=ordered

error_detected=0
iter=0

while [ $error_detected -eq 0 ]; do
  iter=$((iter+1))
  echo "======== Iteration $iter"
  dd if=/dev/zero of=./file.img bs=1M count=10
  LOOPDEV=`losetup --find --show ./file.img`
  mkfs -t ext4 $LOOPDEV
  mount -t ext4 -o $EXT4_OPT $LOOPDEV ./loop
  mkdir -p ./loop/vault ./loop/mount
  mount -t ecryptfs -o $ECRYPTFS_OPT ./loop/vault ./loop/mount
  sync
  for i in `seq 100 -1 1`; do 
    touch ./loop/mount/test.$i
    truncate -s 8 ./loop/mount/test.$i
    echo -n TESTTEST > ./loop/mount/test.$i
    unlink ./loop/mount/test.$i
  done &
  sleep 0.1
  sync
  cp ./file.img ./file.snap
  sleep 5
  umount ./loop/mount
  umount ./loop
  losetup -d $LOOPDEV

  LOOPDEV=`losetup --find --show ./file.snap`
  mount -t ext4 -o $EXT4_OPT $LOOPDEV ./loop
  mount -t ecryptfs -o $ECRYPTFS_OPT ./loop/vault ./loop/mount
  for i in `seq 1 100`; do 
    local sz=`stat -c %s ./loop/mount/test.$i 2>/dev/null || echo -n 0`
    if [ $sz -gt 8 ]; then
      echo "!! garbage at $i:" 
      echo -n "    size="
      stat -c %s ./loop/mount/test.$i
      echo -n "    contents="
      cat ./loop/mount/test.$i
      echo
      error_detected=1
    fi
  done
  echo
  umount ./loop/mount
  umount ./loop
  losetup -d $LOOPDEV
done
echo "Reproduced on iteration $iter"
===

Thank you.
Andrey

> > 
> > Thanks again!
> > 
> > Tyler
> > 
> > > +		if (rc) {
> > > +			printk(KERN_WARNING "Problem with ecryptfs_fsync_lower,"
> > > +			       "continue without syncing; "
> > > +			       "rc = [%d]\n", rc);
> > > +		}
> > >  		/* We are reducing the size of the ecryptfs file, and need to
> > >  		 * know if we need to reduce the size of the lower file. */
> > >  		lower_size_before_truncate =
> > > diff --git a/fs/ecryptfs/read_write.c b/fs/ecryptfs/read_write.c
> > > index 09fe622274e4..ba2dd6263875 100644
> > > --- a/fs/ecryptfs/read_write.c
> > > +++ b/fs/ecryptfs/read_write.c
> > > @@ -271,3 +271,25 @@ int ecryptfs_read_lower_page_segment(struct page *page_for_ecryptfs,
> > >  	flush_dcache_page(page_for_ecryptfs);
> > >  	return rc;
> > >  }
> > > +
> > > +/**
> > > + * ecryptfs_fsync_lower
> > > + * @ecryptfs_inode: The eCryptfs inode
> > > + * @datasync: Only perform a fdatasync operation
> > > + *
> > > + * Write back data and metadata for the lower file to disk.  If @datasync is
> > > + * set only metadata needed to access modified file data is written.
> > > + *
> > > + * Returns 0 on success; less than zero on error
> > > + */
> > > +int ecryptfs_fsync_lower(struct inode *ecryptfs_inode, int datasync)
> > > +{
> > > +	struct file *lower_file;
> > > +
> > > +	lower_file = ecryptfs_inode_to_private(ecryptfs_inode)->lower_file;
> > > +	if (!lower_file)
> > > +		return -EIO;
> > > +	if (!lower_file->f_op->fsync)
> > > +		return 0;
> > > +	return vfs_fsync(lower_file, datasync);
> > > +}
> > > 
> > 
> > 
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
