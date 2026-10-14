Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53BC3BA237
	for <ecryptfs@vger.kernel.org>; Wed, 14 Oct 2026 10:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791975398; cv=none; b=po14augDLlAIoxkj1gq3SVlqP4mxy0RKpPRYd+hrZ/sWw2axzmNWbV3qCRzfPfuZ7j/XW8tuxIPleTYQJ5Ymv71IhuWklzne1hK2K+lns6j9Qu6fKIggAI5W4MmyvmvbEbZmdmtdXOZTiyjepOqraFC5ARJAykSykn6h/C9SF+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791975398; c=relaxed/simple;
	bh=I4W1oBOW70rZbETdibQfUVo4ly3sAm3uCSUKq0yd3EA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LvOGMxZhoX/a2QVnwVsg7ca565HuO6uncpqFjo4hoOqwRNcVXpAcIKPyIdEK8Nh1/i/Vd/LUHzOJOdurFg8xFYwKp4f/rUj0oIs5cdNdCfXJ+Zts1U9cYgfEZw+qx//jwbDRGpZntt1dTW8YjSEPyysh4i8RSS+JyX8F1d9upP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmSTpbJ/; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmSTpbJ/"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48afcfc4bf5so296021f8f.1
        for <ecryptfs@vger.kernel.org>; Wed, 14 Oct 2026 03:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791975395; x=1792580195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zPHEdS90glsg1krHN0zA7UOVAf+2NQvXNCjI6VwnN5A=;
        b=WmSTpbJ/v8qxlupDB4sx6pMYDNLPjFOW1hE8hjxNefOe8HX1Zm0V5Nz1WGxtn8OP/l
         wNDc/jYp0dkcKFFCvD5VinVnrxiiTceIVTQMjOvHuuLehxgUkamy1xB0PzoKfViU37TQ
         0DWSGNBz374Qcn3cNVRJOY/Dww/OyVbGt/5ZN3d/5rc+UfuXqrqBB2T3N+30N/bseRra
         /NAx0Mw0OusM9yVTo1iApHh+RUh1lBhvXXHs5q/CfcRKS3ZyqPSNicFf/rpz5mW5mlwJ
         JUOBecsPqghIV85RHox9HwqJXpY/XVET8N8gIOkCj7e/wYL6XPI76vvVc8LrHykxN1RB
         kQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791975395; x=1792580195;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zPHEdS90glsg1krHN0zA7UOVAf+2NQvXNCjI6VwnN5A=;
        b=VaVa9bhK6uxQJnMAkOFSa0Mth+WvuK7Qq5F//seaQH3VtGVjMmyEZ3wWNiVz/wgZ5x
         aTPQAL6teahyRcs8+zGxwJTzOHep7k1J4wHxU/V5T21AJYb/1eqGwTjWxJvHpC7xd9of
         zicaK6Qyat7KM/jl+DKWPoJFZa3YB5tCHvGbDA1qr/fCijQBvRc0mwugmonsYyNkMa4Q
         FElpbJiSzQ5siYZSV0jGDZBAWXxahxZEHBBDjUa9Wd/XyTEXJpDQWQjmVZSX8hzlLt7K
         QfF5Xkeq32rWyAI/KMO/sTqfONH1Jzsxn3thzl1fFQN1aSJtPXO+09G459GIJ2FN4r52
         pGMg==
X-Forwarded-Encrypted: i=1; AKwUvBwJFGrkw0B6n7AdN4jK5Tg/KDk5//q2sT2TFhyFOV9Ixs46wJrxYA7/GsPvrQeq4131Mkc/LmumbA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJtHLM+A5L+kXM1NPBHsuYsPL9fUjk3+3tAbdVusDdhyp8CRKLa
	sdH4cl14LB0+iu2kX9AhWq5Fa3BBmG4I+zvv29FFhBF07YJZJZec8EJY
X-Gm-Gg: AYBFou0LzeXt1ZvGF31gaaGHB0l597AU2m6DjAP17f3qWI3H7ZOsdn8eZVpDVMangAr
	h6uPULkrmqJzf7RRYdjkzpGmCWHfkuM5+ScfAVI5Chw5Liag3PE2wYHd4Zc+XijXRDcD6QXA8Gs
	vS0kU0iSnMb0C7qZ5a0LvClZhhS4+yT+YWXKUi3tXpIcX1Nf4qautBUOn+8NaAOj+UXKEFzLUqB
	zsluZ2iN/O9NzRCdeuamHC/5PA35bZZt6BiGiDc5s3yP6inBUTvMclk7mzr6UEeHGGNHFmd1UVe
	qK9TfRtNuwt6IOnoUBC8muP6/HG/EU/LOlqOAU7XQdv/Tp4leWGOC2bc3pvRWleok8s6V4t0Pgq
	ftOPHII8thC0XG0+fHjRzTDQ2GEQagNruk/GLxeWE8DnLFofsdz2d7sl5WLTsn9U5dfbTZpKfUP
	R1G1BAZW0FOIldhGl0I0xWvCKskgHUZbzNybWwIQcKMOpR9biKsU5ExZ0Mr8irFIl1DJdTfw9VA
	kKqO4aH54kKM9KZuICiHI7FpdRhsd+Gz9rCHCc+gxSYdZG+6rc=
X-Received: by 2002:a05:600c:46cc:b0:4a1:688d:a41c with SMTP id 5b1f17b1804b1-4a18e4c06a8mr290167455e9.25.1791975394835;
        Wed, 14 Oct 2026 03:56:34 -0700 (PDT)
Received: from DESKTOP-IR7J1S9.localdomain ([154.121.24.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0aaa9f9sm11281588f8f.19.2026.10.14.03.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 03:56:34 -0700 (PDT)
From: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
To: Tyler Hicks <code@tyhicks.com>
Cc: Thorsten Blum <blum@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	ecryptfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
Subject: [PATCH v2] ecryptfs: replace ecryptfs_from_hex() with hex2bin()
Date: Wed, 14 Oct 2026 11:56:34 +0100
Message-ID: <20261014105634.2858-1-drifabdelmalekmohamedsaid@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ecryptfs_from_hex() relied on the deprecated simple_strtoul(). Rather
than patching it to use kstrtoul(), its intended replacement, remove it
entirely and switch all call sites to the generic hex2bin() helper
from <linux/hex.h>, which already provides the same functionality.

Update call sites with the (u8 *) casts required by hex2bin()'s
signature.

All call sites guarantee that src is at least 2*dst_size bytes,
but nothing guarantees that src is valid hex, and also hex2bin's return
value needs to be checked, so we add a fail early check to call sites.

Signed-off-by: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
---
v2:
 - Added fail early check for hex2bin's return value
 - Fixed doubline empty lines
v1:https://lore.kernel.org/ecryptfs/20260829194528.5652-1-drifabdelmalekmohamedsaid@gmail.com/
 fs/ecryptfs/crypto.c          | 19 -------------------
 fs/ecryptfs/ecryptfs_kernel.h |  2 --
 fs/ecryptfs/keystore.c        | 20 +++++++++++++++++---
 3 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index e67119b6029c..059294df4b38 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -29,25 +29,6 @@
 #define DECRYPT		0
 #define ENCRYPT		1
 
-/**
- * ecryptfs_from_hex
- * @dst: Buffer to take the bytes from src hex; must be at least of
- *       size (src_size / 2)
- * @src: Buffer to be converted from a hex string representation to raw value
- * @dst_size: size of dst buffer, or number of hex characters pairs to convert
- */
-void ecryptfs_from_hex(char *dst, char *src, int dst_size)
-{
-	int x;
-	char tmp[3] = { 0, };
-
-	for (x = 0; x < dst_size; x++) {
-		tmp[0] = src[x * 2];
-		tmp[1] = src[x * 2 + 1];
-		dst[x] = (unsigned char)simple_strtol(tmp, NULL, 16);
-	}
-}
-
 static int ecryptfs_crypto_api_algify_cipher_name(char **algified_name,
 						  const char *cipher_name,
 						  const char *chaining_modifier)
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 58165928ed1e..0efda4cea71d 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -47,8 +47,6 @@ ecryptfs_to_hex(char *dst, char *src, size_t src_size)
 	*end = '\0';
 }
 
-extern void ecryptfs_from_hex(char *dst, char *src, int dst_size);
-
 struct ecryptfs_key_record {
 	unsigned char type;
 	size_t enc_key_size;
diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index 51651314b7a6..4aaf62e61f3a 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -18,6 +18,7 @@
 #include <linux/random.h>
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
+#include <linux/hex.h>
 #include "ecryptfs_kernel.h"
 
 /*
@@ -713,9 +714,14 @@ ecryptfs_write_tag_70_packet(char *dest, size_t *remaining_bytes,
 		goto out_free_unlock;
 	}
 	s->i += s->packet_size_len;
-	ecryptfs_from_hex(&dest[s->i],
+	rc = hex2bin((u8 *)&dest[s->i],
 			  mount_crypt_stat->global_default_fnek_sig,
 			  ECRYPTFS_SIG_SIZE);
+	if (rc) {
+		printk(KERN_ERR "%s: Invalid fnek sig [%s]; rc = [%d]\n",
+			   __func__, mount_crypt_stat->global_default_fnek_sig, rc);
+		goto out_free_unlock;
+	}
 	s->i += ECRYPTFS_SIG_SIZE;
 	s->cipher_code = ecryptfs_code_for_cipher_string(
 		mount_crypt_stat->global_default_fn_cipher_name,
@@ -2015,8 +2021,12 @@ write_tag_1_packet(char *dest, size_t *remaining_bytes,
 	int rc = 0;
 
 	(*packet_size) = 0;
-	ecryptfs_from_hex(key_rec->sig, auth_tok->token.private_key.signature,
+	rc = hex2bin((u8 *)key_rec->sig, auth_tok->token.private_key.signature,
 			  ECRYPTFS_SIG_SIZE);
+	if (rc) {
+		printk(KERN_ERR "Invalid token private key signature; rc = [%d]\n", rc);
+		goto out;
+	}
 	encrypted_session_key_valid = 0;
 	for (i = 0; i < crypt_stat->key_size; i++)
 		encrypted_session_key_valid |=
@@ -2179,8 +2189,12 @@ write_tag_3_packet(char *dest, size_t *remaining_bytes,
 	int rc = 0;
 
 	(*packet_size) = 0;
-	ecryptfs_from_hex(key_rec->sig, auth_tok->token.password.signature,
+	rc = hex2bin((u8 *)key_rec->sig, auth_tok->token.password.signature,
 			  ECRYPTFS_SIG_SIZE);
+	if (rc) {
+		printk(KERN_ERR "Invalid token password signature; rc = [%d]\n", rc);
+		goto out;
+	}
 	rc = ecryptfs_get_tfm_and_mutex_for_cipher_name(&tfm, &tfm_mutex,
 							crypt_stat->cipher);
 	if (unlikely(rc)) {
-- 
2.43.0

