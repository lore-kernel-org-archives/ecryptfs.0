Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794649010;
	b=eUVcRioRvaBjsp7+Dc2jeXAGfcK9rz5s0ScgWag5bMWMTACLy5vrE6ol1IM2a/9gOUwx
	 Lccowm3kVxlHwBfnFOG+L1wFn7DrzMaRM3U5pbwJb5dX1hVvL39d5kEDkg9eT14PAc/gj
	 iRGztxBeh1lweGL8AJkHwn5dNqcFM8HUQC0zHYFGzA1k3yC0A7W312xz2TTpLdFIhybEV
	 Y5xBLtkajJirYGfkqcjLGM8ooYNjVfOQkxCgi2Ro3jp0ivieVMUKSNpRfVxOB7dZItOxc
	 bViWI7TUsjtA/Y8IoaSuQvjpcCWyYF7hB6JxM72TMEejBEU7aQaGnXKF2RUoP39dqjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794649010;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=4rT0eAwPFvmjSNwFGfR3YlSLMafIVhGOWDFd7IQ4gCc=;
	b=KlYpYewZt5VtZWK7J7VHZshn2NJpGuqAUNNMOoY13AF9EftflpRCcW1CrHoGma7FLpqZ
	 KuNcpAzd3M4FBwIzRl6924oYfcJoSfUN0uSIl9suzHYfoWKkGj8yOeg3r61v91aJkiI8Z
	 QMMQmeeTURbvXZuyzcOvGu3yK6iMoZn2M7UQ5EA1WpfQ3kGGrN8BDPZtz/NeYdY2rzNwX
	 8UfCEedNtdXUKoax/OxfJLrm4Ucej2+T880uAQgeXxkRwCmo34HtMvD7hwWdMsJWLon1k
	 GmEG5vixNXvQVS8esxAF7su1e7bTAUD9XrObdFMhd3U8Qw0/QgKTVz5TtsCeyVoKCXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gtajZqgr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585BA606A323;
	Sat, 14 Nov 2026 09:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gtajZqgr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880741F000C4;
	Sat, 14 Nov 2026 09:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794649009;
	bh=4rT0eAwPFvmjSNwFGfR3YlSLMafIVhGOWDFd7IQ4gCc=;
	h=Date:From:To:Cc:Subject;
	b=gtajZqgr8hns8TB8bF0mXs8JwrBhR93c9dhH3KrlmASOpOzNGBK3A+qNcSo3fWSEq
	 TWhy40qspYEiqL6LR0Shv1UfYtTJLBWH8ksjEaIo/9i7foxtSJqcvLOOVXqitad4Yt
	 2HZcOEcwT3yhAOPWWeu/qOLLxE2MfZAlZReTNxthV0JVCAoz0T3nDnX74zh78yfQvw
	 nZVUMvPU4iydUc8ZEU+2086P4zBx1vW49ytmgXgwPX2wv7a4dUKjZgzLKblM9+8x7R
	 rmefOoi6wqoMSrC8VBupuSvVComa6qTP0wR24gZIoLue8jSKcdb6eoPB+f0WoIZ4mE
	 SDLC2mJwv1PqA==
Date: Sat, 14 Nov 2026 10:36:46 +0100
From: Christian Brauner <brauner@kernel.org>
To: Tyler Hicks <code@tyhicks.com>
Cc: Jan Kara <jack@suse.cz>, ecryptfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: ecryptfs: the lower filesystem gets modified while it is frozen
Message-ID: <20261114-kranich-banknoten-anheuern-5d0a2354a51d@brauner>
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Post: <mailto:ecryptfs@vger.kernel.org>
List-Help: <mailto:ecryptfs+help@vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ecryptfs+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

I'm working on freeze protection fixes in the tree and this is the part
that affects ecryptfs.

A syscall on an ecryptfs mount only takes freeze protection for the
ecryptfs superblock. ecryptfs then modifies the lower filesystem
without any freeze protection for the lower superblock. So with the
lower filesystem frozen it gets modified anyway. On ext4 that trips the
WARN_ON() in ext4_journal_check_start().

Affected are all the lower namespace operations, setattr, truncate,
xattrs, ACLs and fileattr:

- ecryptfs_create(), ecryptfs_mkdir(), ecryptfs_mknod(),
  ecryptfs_symlink(), ecryptfs_link(), ecryptfs_do_unlink(),
  ecryptfs_rmdir() and ecryptfs_rename() call vfs_create(),
  vfs_mkdir(), ... on the lower dentries
- ecryptfs_setattr() and __ecryptfs_truncate() call notify_change()
- ecryptfs_setxattr() and ecryptfs_removexattr() call
  __vfs_setxattr_locked() and __vfs_removexattr(), and with
  ecryptfs_xattr_metadata ecryptfs_write_metadata_to_xattr() and
  ecryptfs_write_inode_size_to_xattr() call __vfs_setxattr()
- ecryptfs_set_acl() and ecryptfs_fileattr_set() call vfs_set_acl()
  and vfs_fileattr_set()

Only data writes are protected because they go through kernel_write().

I triggered create, mkdir, unlink, rename, chmod and setxattr below.
The rest is from reading the code.

Reproduced on v7.4-rc1:

    mount /dev/vdb /lower; mkdir /lower/enc /ecr
    keyctl link @u @s
    keyctl add user kmk 0123456789abcdef0123456789abcdef @u
    keyctl add encrypted 1000100010001000 "new ecryptfs user:kmk 64" @u
    mount -t ecryptfs /lower/enc /ecr -o ecryptfs_sig=1000100010001000,ecryptfs_cipher=aes,ecryptfs_key_bytes=32
    cd /ecr; echo x > a; echo x > b; echo x > f; mkdir d1 d2; cd /; sync
    fsfreeze -f /lower
    touch /ecr/d1/new; mkdir /ecr/d2/nd; rm /ecr/a; mv /ecr/b /ecr/c
    chmod 600 /ecr/f; setfattr -n user.x -v 1 /ecr/f

Each of these warns, the mkdir, rename, chmod and setxattr complete
right away and "a" is gone from the frozen lower filesystem. The append
in

    echo y >> /ecr/f

waits for the thaw as it should. The create and the mkdir:

  WARNING: fs/ext4/ext4_jbd2.c:90 at ext4_journal_check_start+0x1f6/0x2d0, CPU#3: touch/309
  Call Trace:
   __ext4_journal_start_sb+0x7a/0x470
   __ext4_new_inode+0x23da/0x45d0
   ext4_create+0x286/0x530
   vfs_create+0x2a6/0x6a0
   ecryptfs_create+0xf8/0x4c0
   lookup_open+0xa80/0x1b20
   path_openat+0xd2b/0x2300
   do_file_open+0x209/0x480
   do_sys_openat2+0x128/0x180
   __x64_sys_openat+0x10e/0x210
   do_syscall_64+0x10e/0x5e0

  WARNING: fs/ext4/ext4_jbd2.c:90 at ext4_journal_check_start+0x1f6/0x2d0, CPU#3: mkdir/322
  Call Trace:
   __ext4_journal_start_sb+0x7a/0x470
   __ext4_new_inode+0x23da/0x45d0
   ext4_mkdir+0x249/0xb10
   vfs_mkdir+0x2bb/0x760
   ecryptfs_mkdir+0x11c/0x570
   vfs_mkdir+0x2bb/0x760
   filename_mkdirat+0x417/0x590
   __x64_sys_mkdir+0x68/0x90
   do_syscall_64+0x10e/0x5e0

The way overlayfs deals with this is ovl_want_write(), i.e.
mnt_want_write() on the upper mount around every modification of the
upper layer, taken before the upper inode locks. ecryptfs needs the same
for its lower mount. It must not wrap a region that later calls
kernel_write() on the same superblock though, as that nests
sb_start_write() and deadlocks against a pending freeze.

This predates freeze protection in the callers which came with
5accdf82ba25 ("fs: Improve filesystem freezing handling").
