From: Pieter Smith <pieter@boesman.nl>
Subject: [PATCH 16/56] fs/encryptfs: support compiling out splice
Date: Thu, 13 Nov 2014 22:22:53 +0100
Message-ID: <1415913813-362-17-git-send-email-pieter@boesman.nl>
References: <pieter@boesman.nl>
 <1415913813-362-1-git-send-email-pieter@boesman.nl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415913813-362-1-git-send-email-pieter@boesman.nl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: pieter@boesman.nl
Cc: Josh Triplett <josh@joshtriplett.org>, Tyler Hicks <tyhicks@canonical.com>, "open list:ECRYPT FILE SYSTEM" <ecryptfs@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

Compile out splice support from encryptfs when the splice-family of syscalls is
not supported by the system (i.e. CONFIG_SYSCALL_SPLICE is undefined).

Signed-off-by: Pieter Smith <pieter@boesman.nl>
---
 fs/ecryptfs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index db0fad3..107a316 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -345,7 +345,7 @@ const struct file_operations ecryptfs_dir_fops = {
 	.release = ecryptfs_release,
 	.fsync = ecryptfs_fsync,
 	.fasync = ecryptfs_fasync,
-	.splice_read = generic_file_splice_read,
+	SPLICE_READ_INIT(generic_file_splice_read)
 	.llseek = default_llseek,
 };
 
@@ -366,5 +366,5 @@ const struct file_operations ecryptfs_main_fops = {
 	.release = ecryptfs_release,
 	.fsync = ecryptfs_fsync,
 	.fasync = ecryptfs_fasync,
-	.splice_read = generic_file_splice_read,
+	SPLICE_READ_INIT(generic_file_splice_read)
 };
-- 
1.9.1
