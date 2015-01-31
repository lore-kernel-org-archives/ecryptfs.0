From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: small buffer overflow in ecryptfs_new_file_context()
Date: Sat, 31 Jan 2015 16:23:44 +0300
Message-ID: <20150131132344.GA10291@mwanda>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:47894 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715AbbAaNYD (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Sat, 31 Jan 2015 08:24:03 -0500
Content-Disposition: inline
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mhalcrow@us.ibm.com
Cc: ecryptfs@vger.kernel.org

Hello Michael Halcrow,

The patch 237fead61998: "[PATCH] ecryptfs: fs/Makefile and
fs/Kconfig" from Oct 4, 2006, leads to the following static checker
warning:

	fs/ecryptfs/crypto.c:846 ecryptfs_new_file_context()
	error: off-by-one overflow 'crypt_stat->cipher' size 32.  rl = '0-32'

fs/ecryptfs/crypto.c
   841          cipher_name_len =
   842                  strlen(mount_crypt_stat->global_default_cipher_name);
   843          memcpy(crypt_stat->cipher,
   844                 mount_crypt_stat->global_default_cipher_name,
   845                 cipher_name_len);
   846          crypt_stat->cipher[cipher_name_len] = '\0';

We're basically doing a complicated:

	strcpy(crypt_stat->cipher,
	       mount_crypt_stat->global_default_cipher_name);

But ->global_default_cipher_name has one more character than ->cipher so
it doesn't necessarily fit.

regards,
dan carpenter
