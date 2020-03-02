From: Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.4, 4.9, 4.14] ecryptfs: Fix up bad backport of fe2e082f5da5b4a0a92ae32978f81507ef37ec66
Date: Mon,  2 Mar 2020 13:39:13 -0700
Message-ID: <20200302203912.27370-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42975 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgCBUjy (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Mon, 2 Mar 2020 15:39:54 -0500
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, ecryptfs@vger.kernel.org, Wenwen Wang <wenwen@cs.uga.edu>, Tyler Hicks <tyhicks@canonical.com>, Nathan Chancellor <natechancellor@gmail.com>

When doing the 4.9 merge into certain Android trees, I noticed a warning
from Android's deprecated GCC 4.9.4, which causes a build failure in
those trees due to basically -Werror:

fs/ecryptfs/keystore.c: In function 'ecryptfs_parse_packet_set':
fs/ecryptfs/keystore.c:1357:2: warning: 'auth_tok_list_item' may be used
uninitialized in this function [-Wmaybe-uninitialized]
  memset(auth_tok_list_item, 0,
  ^
fs/ecryptfs/keystore.c:1260:38: note: 'auth_tok_list_item' was declared
here
  struct ecryptfs_auth_tok_list_item *auth_tok_list_item;
                                      ^

GCC 9.2.0 was not able to pick up this warning when I tested it.

Turns out that Clang warns as well when -Wuninitialized is used, which
is not the case in older stable trees at the moment (but shows value in
potentially backporting the various warning fixes currently in upstream
to get more coverage).

fs/ecryptfs/keystore.c:1284:6: warning: variable 'auth_tok_list_item' is
used uninitialized whenever 'if' condition is true
[-Wsometimes-uninitialized]
        if (data[(*packet_size)++] != ECRYPTFS_TAG_1_PACKET_TYPE) {
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
fs/ecryptfs/keystore.c:1360:4: note: uninitialized use occurs here
                        auth_tok_list_item);
                        ^~~~~~~~~~~~~~~~~~
fs/ecryptfs/keystore.c:1284:2: note: remove the 'if' if its condition is
always false
        if (data[(*packet_size)++] != ECRYPTFS_TAG_1_PACKET_TYPE) {
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
fs/ecryptfs/keystore.c:1260:56: note: initialize the variable
'auth_tok_list_item' to silence this warning
        struct ecryptfs_auth_tok_list_item *auth_tok_list_item;
                                                              ^
                                                               = NULL
1 warning generated.

Somehow, commit fe2e082f5da5 ("ecryptfs: fix a memory leak bug in
parse_tag_1_packet()") upstream was not applied in the correct if block
in 4.4.215, 4.9.215, and 4.14.172, which will indeed lead to use of
uninitialized memory. Fix it up by undoing the bad backport in those
trees then reapplying the patch in the proper location.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 fs/ecryptfs/keystore.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index 3f3ec50bf773..b134315fb69d 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -1285,7 +1285,7 @@ parse_tag_1_packet(struct ecryptfs_crypt_stat *crypt_stat,
 		printk(KERN_ERR "Enter w/ first byte != 0x%.2x\n",
 		       ECRYPTFS_TAG_1_PACKET_TYPE);
 		rc = -EINVAL;
-		goto out_free;
+		goto out;
 	}
 	/* Released: wipe_auth_tok_list called in ecryptfs_parse_packet_set or
 	 * at end of function upon failure */
@@ -1335,7 +1335,7 @@ parse_tag_1_packet(struct ecryptfs_crypt_stat *crypt_stat,
 		printk(KERN_WARNING "Tag 1 packet contains key larger "
 		       "than ECRYPTFS_MAX_ENCRYPTED_KEY_BYTES");
 		rc = -EINVAL;
-		goto out;
+		goto out_free;
 	}
 	memcpy((*new_auth_tok)->session_key.encrypted_key,
 	       &data[(*packet_size)], (body_size - (ECRYPTFS_SIG_SIZE + 2)));
-- 
2.25.1

