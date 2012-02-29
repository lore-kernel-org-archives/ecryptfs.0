From: Randy Dunlap <rdunlap@xenotime.net>
Subject: [PATCH] ecryptfs: fix printk format warning for size_t
Date: Tue, 28 Feb 2012 16:31:12 -0800
Message-ID: <4F4D71D0.2040904@xenotime.net>
References: <1330462222-25201-1-git-send-email-geert@linux-m68k.org> <4F4D663D.2040100@xenotime.net> <CA+55aFzzfuiu-ScRmRFYWDmrstYC4kvS0QQidBZsmjCpL_tkqw@mail.gmail.com> <4F4D704A.7040508@xenotime.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from oproxy9.bluehost.com ([69.89.24.6]:44379 "HELO
	oproxy9.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1030223Ab2B2AbG (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 28 Feb 2012 19:31:06 -0500
In-Reply-To: <4F4D704A.7040508@xenotime.net>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Tyler Hicks <tyhicks@canonical.com>, Dustin Kirkland <dustin.kirkland@gazzang.com>, ecryptfs@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix printk format warning (from Linus's suggestion):

on i386:
fs/ecryptfs/miscdev.c:433:38: warning: format '%lu' expects type 'long unsigned int', but argument 4 has type 'unsigned int'

and on x86_64:
fs/ecryptfs/miscdev.c:433:38: warning: format '%u' expects type 'unsigned int', but argument 4 has type 'long unsigned int'

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
Cc:	Geert Uytterhoeven <geert@linux-m68k.org>
Cc:	Tyler Hicks <tyhicks@canonical.com>
Cc:	Dustin Kirkland <dustin.kirkland@gazzang.com>
Cc:	ecryptfs@vger.kernel.org
---

In case you didn't already make the change...

 fs/ecryptfs/miscdev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-33-rc5.orig/fs/ecryptfs/miscdev.c
+++ lnx-33-rc5/fs/ecryptfs/miscdev.c
@@ -429,7 +429,7 @@ ecryptfs_miscdev_write(struct file *file
 		goto memdup;
 	} else if (count < MIN_MSG_PKT_SIZE || count > MAX_MSG_PKT_SIZE) {
 		printk(KERN_WARNING "%s: Acceptable packet size range is "
-		       "[%d-%lu], but amount of data written is [%zu].",
+		       "[%d-%zu], but amount of data written is [%zu].",
 		       __func__, MIN_MSG_PKT_SIZE, MAX_MSG_PKT_SIZE, count);
 		return -EINVAL;
 	}
