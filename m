From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: file->f_op is never NULL...
Date: Tue, 12 Nov 2013 13:30:13 +0300
Message-ID: <20131112103013.GB10651@elgon.mountain>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:25561 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752488Ab3KLKa3 (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 12 Nov 2013 05:30:29 -0500
Content-Disposition: inline
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org
Cc: viro@zeniv.linux.org.uk

Hello Ecrypt FS People,

Al Viro has a patch in linux-next and it upsets Smatch:

The patch 72c2d5319200: "file->f_op is never NULL..." from Sep 22, 
2013, leads to the following
static checker warning: "fs/ecryptfs/file.c:320 ecryptfs_unlocked_ioctl()
	 error: potential NULL dereference 'lower_file'."

fs/ecryptfs/file.c
   312  static long
   313  ecryptfs_unlocked_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
   314  {
   315          struct file *lower_file = NULL;
   316          long rc = -ENOTTY;
   317  
   318          if (ecryptfs_file_to_private(file))
   319                  lower_file = ecryptfs_file_to_lower(file);
   320          if (lower_file->f_op && lower_file->f_op->unlocked_ioctl)
   321                  rc = lower_file->f_op->unlocked_ioctl(lower_file, cmd, arg);

If there is no file->private_data then "lower_file" is NULL.  However,
I think file->private_data is always set to a valid pointer in
ecryptfs_open() so really we should just remove the
"if (ecryptfs_file_to_private(file))" check.  Is that right, or am I
missing something.

   322          return rc;
   323  }
   324  
   325  #ifdef CONFIG_COMPAT
   326  static long
   327  ecryptfs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
   328  {
   329          struct file *lower_file = NULL;
   330          long rc = -ENOIOCTLCMD;
   331  
   332          if (ecryptfs_file_to_private(file))
   333                  lower_file = ecryptfs_file_to_lower(file);
   334          if (lower_file->f_op && lower_file->f_op->compat_ioctl)
   335                  rc = lower_file->f_op->compat_ioctl(lower_file, cmd, arg);

Same things.

   336          return rc;
   337  }
   338  #endif

regards,
dan carpenter
