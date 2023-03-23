From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
Subject: Re: Does Landlock not work with eCryptfs?
Date: Thu, 23 Mar 2023 18:05:38 +0100
Message-ID: <ZByG4u1L6yF5kfeD@nuc>
References: <20230319.2139b35f996f@gnoack.org>
 <c1c9c688-c64d-adf2-cc96-dc2aaaae5944@digikod.net>
 <20230320.c6b83047622f@gnoack.org>
 <5d415985-d6ac-2312-3475-9d117f3be30f@digikod.net>
 <e70f7926-21b6-fbce-c5d6-7b3899555535@digikod.net>
 <20230321172450.crwyhiulcal6jvvk@wittgenstein>
 <42ffeef4-e71f-dd2b-6332-c805d1db2e3f@digikod.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjCWRFo (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Thu, 23 Mar 2023 13:05:44 -0400
Content-Disposition: inline
In-Reply-To: <42ffeef4-e71f-dd2b-6332-c805d1db2e3f@digikod.net>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, landlock@lists.linux.dev, Tyler Hicks <code@tyhicks.com>, linux-security-module <linux-security-module@vger.kernel.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, eCryptfs <ecryptfs@vger.kernel.org>

+ecryptfs mailing list FYI

Just some additional data points on the Landlock/eCryptfs issues.

On Tue, Mar 21, 2023 at 07:16:28PM +0100, Mickaël Salaün wrote:
> On 21/03/2023 18:24, Christian Brauner wrote:
> > On Tue, Mar 21, 2023 at 05:36:19PM +0100, Mickaël Salaün wrote:
> > > There is an inconsistency between ecryptfs_dir_open() and ecryptfs_open().
> > > ecryptfs_dir_open() actually checks access right to the lower directory,
> > > which is why landlocked processes may not access the upper directory when
> > > reading its content. ecryptfs_open() uses a cache for upper files (which
> > > could be a problem on its own). The execution flow is:
> > > 
> > > ecryptfs_open() -> ecryptfs_get_lower_file() -> ecryptfs_init_lower_file()
> > > -> ecryptfs_privileged_open()
> > > 
> > > In ecryptfs_privileged_open(), the dentry_open() call failed if access to
> > > the lower file is not allowed by Landlock (or other access-control systems).
> > > Then wait_for_completion(&req.done) waits for a kernel's thread executing
> > > ecryptfs_threadfn(), which uses the kernel's credential to access the lower
> > > file.
> > > 
> > > I think there are two main solutions to fix this consistency issue:
> > > - store the mounter credentials and uses them instead of the kernel's
> > > credentials for lower file and directory access checks (ecryptfs_dir_open
> > > and ecryptfs_threadfn changes);
> > > - use the kernel's credentials for all lower file/dir access check,
> > > especially in ecryptfs_dir_open().
> > > 
> > > I think using the mounter credentials makes more sense, is much safer, and
> > > fits with overlayfs. It may not work in cases where the mounter doesn't have
> > > access to the lower file hierarchy though.
> > > 
> > > File creation calls vfs_*() helpers (lower directory) and there is not path
> > > nor file security hook calls for those, so it works unconditionally.
> > > 
> > >  From Landlock end users point of view, it makes more sense to grants access
> > > to a file hierarchy (where access is already allowed) and be allowed to
> > > access this file hierarchy, whatever it belongs to a specific filesystem
> > > (and whatever the potential lower file hierarchy, which may be unknown to
> > > users). This is how it works for overlayfs and I'd like to have the same
> > > behavior for ecryptfs.
> > 
> > So given that ecryptfs is marked as "Odd Fixes" who is realistically
> > going to do the work of switching it to a mounter's credentials model,
> > making sure this doesn't regress anything, and dealing with any
> > potential bugs caused by this. It might be potentially better to just
> > refuse to combine Landlock with ecryptfs if that's possible.

There is now a patch to mark it orphaned (independent of this thread):
https://lore.kernel.org/all/20230320182103.46350-1-frank.li@vivo.com/

> If Tyler is OK with the proposed solutions, I'll get a closer look at it in
> a few months. If anyone is interested to work on that, I'd be happy to
> review and test (the Landlock part).

I wonder whether this problem of calling security hooks for the
underlying directory might have been affecting AppArmor and SELinux as
well?  There seem to be reports on the web, but it's possible that I
am misinterpreting some of them:

https://wiki.ubuntu.com/SecurityTeam/Roadmap
  mentions this "unscheduled wishlist item":
  "eCryptfs + SELinux/AppArmor integration, to protect encrypted data from root"

https://askubuntu.com/a/1195430
  reports that AppArmor does not work on an eCryptfs mount for their use case
  "i tried adding the [eCryptfs] source folder as an alias in apparmor and it now works."

—Günther

-- 
