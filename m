From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: eCryptfs: Use skcipher and shash
Date: Tue, 15 Mar 2016 23:28:06 +0300
Message-ID: <20160315202806.GA4687@mwanda>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:39728 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752321AbcCOU2U (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 15 Mar 2016 16:28:20 -0400
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

	fs/ecryptfs/keystore.c:867 ecryptfs_write_tag_70_packet()
	error: potential null dereference 's'.  (kzalloc returns null)

fs/ecryptfs/keystore.c
   624  int
   625  ecryptfs_write_tag_70_packet(char *dest, size_t *remaining_bytes,
   626                               size_t *packet_size,
   627                               struct ecryptfs_mount_crypt_stat *mount_crypt_stat,
   628                               char *filename, size_t filename_size)
   629  {
   630          struct ecryptfs_write_tag_70_packet_silly_stack *s;
   631          struct key *auth_tok_key = NULL;
   632          int rc = 0;
   633  
   634          s = kzalloc(sizeof(*s), GFP_KERNEL);
   635          if (!s) {
   636                  printk(KERN_ERR "%s: Out of memory whilst trying to kmalloc "
   637                         "[%zd] bytes of kernel memory\n", __func__, sizeof(*s));
   638                  rc = -ENOMEM;
   639                  goto out;
                        ^^^^^^^^
   640          }

[ snip ]

   862  out:
   863          if (auth_tok_key) {
   864                  up_write(&(auth_tok_key->sem));
   865                  key_put(auth_tok_key);
   866          }
   867          skcipher_request_free(s->skcipher_req);
                                      ^^^^^^^^^^^^^^^
   868          kzfree(s->hash_desc);
                       ^^^^^^^^^^^^
   869          kfree(s);
   870          return rc;
   871  }

regards,
dan carpenter
