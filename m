Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D160A2AD3C;
	Wed, 22 Jul 2026 00:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784678904; cv=none; b=S+Y8cE6kSZINMrL2lMxQmOu6c7Ve/eI0zNOmdbByOdx8Rxg9bNa6kW5YxVmeHtOZwh2fcfQggpx+fgQm2MqTfUBTAYz6seNebGQFO7q2KEhpPH2HW5v1IVHADccOKzPQ5CvBz0xqRsAG7gybTXxH3qEXWAsSvz0Sn/XQ6W/HDw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784678904; c=relaxed/simple;
	bh=21PJ+cBTbvH6ddPplLENCaMmJ8ImER5umbN+xBbjsUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fzzB1FSFbi14jJTBw7KGvPyyLlSikjpfX7gZZlFcqxXMBMg0DtbYvoXCGONvGkOHlCX/nnO9iqKemMGJfYR4INHkNf0+vk78ezi2Htn8OR8bEEgRB03zKUIsn/aU3gQ35TjuUQ36Oq73WCTuxPq/tsZrS1NWySV4Tuc43ShopSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YRJygKFx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YRJygKFx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=oiK1Yp12KYYZ9ij5inCaSWESdmWxYv/823Tcjv0qJ9c=; b=YRJygKFxBxpY0KA7exW/D7Z77s
	R1A6/y/+N299CPGDJx7VOKI/l/l6x1E5ZCTjYcHhBNExGI+TQcT9bP/CqfsZqrDrL3ScrkAH5LeIN
	dQVBCxD8vWOPwVx5sB9fsKqjJxQvsO84IkHYXTyesJsZovtd0x/wxj697sxb0+YlZYc6YI22sFrPQ
	qninknuhBTdZms5glmIVxDdYPvr237kEFKssrxwVNvxBdLzBN2cNbbLxuUM5dWP/eB6ub+aZVZLcM
	P+bj+5i0SlcVsvYfzG5UmkkfyCPtXjsLQcEFyoNyMLTvqD0NqDRKBHXhnsSuvB0As6QbY54XGZ2cM
	uUG9t44Q==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmKVQ-0000000AcuN-3suS;
	Wed, 22 Jul 2026 00:08:12 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Tyler Hicks <code@tyhicks.com>,
	ecryptfs@vger.kernel.org
Subject: [PATCH] ecryptfs: ecryptfs_kernel.h: clean up kernel-doc comments
Date: Tue, 21 Jul 2026 17:08:12 -0700
Message-ID: <20260722000812.3823299-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- don't use "/**" for non-kernel-doc comments
- use the struct keyword when describing structs
- delete one Excess struct member

to prevent the following warnings:

Warning: ./fs/ecryptfs/ecryptfs_kernel.h:14 cannot understand function
 prototype: 'ECRYPTFS_KERNEL_H'
Warning: ./fs/ecryptfs/ecryptfs_kernel.h:207 This comment starts with
 '/**', but isn't a kernel-doc comment.
 * This is the primary struct associated with each encrypted file.
Warning: ./fs/ecryptfs/ecryptfs_kernel.h:275 cannot understand function
 prototype: 'struct ecryptfs_global_auth_tok'
Warning: fs/ecryptfs/ecryptfs_kernel.h:283 Excess struct member
 'global_auth_tok' description in 'ecryptfs_global_auth_tok'
Warning: ./fs/ecryptfs/ecryptfs_kernel.h:298 cannot understand function
 prototype: 'struct ecryptfs_key_tfm'
Warning: ./fs/ecryptfs/ecryptfs_kernel.h:309 This comment starts with
 '/**', but isn't a kernel-doc comment.
 * This struct is to enable a mount-wide passphrase/salt combo. This

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org

 fs/ecryptfs/ecryptfs_kernel.h |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- linux-next-20260720.orig/fs/ecryptfs/ecryptfs_kernel.h
+++ linux-next-20260720/fs/ecryptfs/ecryptfs_kernel.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/**
+/*
  * eCryptfs: Linux filesystem encryption layer
  * Kernel declarations.
  *
@@ -204,7 +204,7 @@ struct ecryptfs_filename {
 	char dentry_name[ECRYPTFS_ENCRYPTED_DENTRY_NAME_LEN + 1];
 };
 
-/**
+/*
  * This is the primary struct associated with each encrypted file.
  *
  * TODO: cache align/pack?
@@ -255,7 +255,8 @@ struct ecryptfs_inode_info {
 };
 
 /**
- * ecryptfs_global_auth_tok - A key used to encrypt all new files under the mountpoint
+ * struct ecryptfs_global_auth_tok - A key used to encrypt all new files
+ *   under the mountpoint
  * @flags: Status flags
  * @mount_crypt_stat_list: These auth_toks hang off the mount-wide
  *                         cryptographic context. Every time a new
@@ -263,7 +264,6 @@ struct ecryptfs_inode_info {
  *                         the auth_toks on that list to the set of
  *                         auth_toks on the inode's crypt_stat
  * @global_auth_tok_key: The key from the user's keyring for the sig
- * @global_auth_tok: The key contents
  * @sig: The key identifier
  *
  * ecryptfs_global_auth_tok structs refer to authentication token keys
@@ -283,7 +283,7 @@ struct ecryptfs_global_auth_tok {
 };
 
 /**
- * ecryptfs_key_tfm - Persistent key tfm
+ * struct ecryptfs_key_tfm - Persistent key tfm
  * @key_tfm: crypto API handle to the key
  * @key_size: Key size in bytes
  * @key_tfm_mutex: Mutex to ensure only one operation in eCryptfs is
@@ -306,7 +306,7 @@ struct ecryptfs_key_tfm {
 
 extern struct mutex key_tfm_list_mutex;
 
-/**
+/*
  * This struct is to enable a mount-wide passphrase/salt combo. This
  * is more or less a stopgap to provide similar functionality to other
  * crypto filesystems like EncFS or CFS until full policy support is
