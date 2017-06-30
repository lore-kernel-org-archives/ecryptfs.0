From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] eCryptfs: constify attribute_group structures.
Date: Fri, 30 Jun 2017 15:03:23 +0530
Message-ID: <eea99b6294d950736f63fd6d88ab129435233bd5.1498814950.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tyhicks@canonical.com, viro@zeniv.linux.org.uk
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org

attribute_groups are not supposed to change at runtime. All functions
working with attribute_groups provided by <linux/sysfs.h> work with const
attribute_group. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
   6122	    636	     24	   6782	   1a7e	fs/ecryptfs/main.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   6186	    604	     24	   6814	   1a9e	fs/ecryptfs/main.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 fs/ecryptfs/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index 9014479..eea4c0f 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -782,7 +782,7 @@ static ssize_t version_show(struct kobject *kobj,
 	NULL,
 };
 
-static struct attribute_group attr_group = {
+static const struct attribute_group attr_group = {
 	.attrs = attributes,
 };
 
-- 
1.9.1

