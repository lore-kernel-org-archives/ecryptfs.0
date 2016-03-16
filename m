From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: eCryptfs: Use skcipher and shash
Date: Wed, 16 Mar 2016 10:41:41 +0300
Message-ID: <20160316074141.GB12860@mwanda>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:30265 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933603AbcCPHl6 (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Wed, 16 Mar 2016 03:41:58 -0400
Content-Disposition: inline
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: herbert@gondor.apana.org.au
Cc: ecryptfs@vger.kernel.org

Hello Herbert Xu,

The patch 3095e8e366b4: "eCryptfs: Use skcipher and shash" from Jan
25, 2016, leads to the following static checker warning:

	fs/ecryptfs/keystore.c:1117 ecryptfs_parse_tag_70_packet()
	error: potential null dereference 's'.  (kzalloc returns null)

fs/ecryptfs/keystore.c
   908  int
   909  ecryptfs_parse_tag_70_packet(char **filename, size_t *filename_size,
   910                               size_t *packet_size,
   911                               struct ecryptfs_mount_crypt_stat *mount_crypt_stat,
   912                               char *data, size_t max_packet_size)
   913  {
   914          struct ecryptfs_parse_tag_70_packet_silly_stack *s;
   915          struct key *auth_tok_key = NULL;
   916          int rc = 0;
   917  
   918          (*packet_size) = 0;
   919          (*filename_size) = 0;
   920          (*filename) = NULL;
   921          s = kzalloc(sizeof(*s), GFP_KERNEL);
   922          if (!s) {
                    ^^^
   923                  printk(KERN_ERR "%s: Out of memory whilst trying to kmalloc "
   924                         "[%zd] bytes of kernel memory\n", __func__, sizeof(*s));
   925                  rc = -ENOMEM;
   926                  goto out;
                        ^^^^^^^^
   927          }

[ snip ]

  1107  out:
  1108          if (rc) {
  1109                  (*packet_size) = 0;
  1110                  (*filename_size) = 0;
  1111                  (*filename) = NULL;
  1112          }
  1113          if (auth_tok_key) {
  1114                  up_write(&(auth_tok_key->sem));
  1115                  key_put(auth_tok_key);
  1116          }
  1117          skcipher_request_free(s->skcipher_req);
                                      ^^^^^^^^^^^^^^^
  1118          kfree(s);
  1119          return rc;
  1120  }

regards,
dan carpenter
