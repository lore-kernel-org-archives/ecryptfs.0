Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4DB30FC1D
	for <ecryptfs@vger.kernel.org>; Sat, 29 Aug 2026 19:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788032736; cv=none; b=GRLxIilNdW4dWcX7oL4ARLVSZtriJiQEPo1iBM7jRudCJkaTSBddmkaM/oy/BNgR/dVSJCf1kCpwHAqoSccqNhRS3uXBXWO6ea+ATNllw731ltgbJ6a8HKC8lZRPL9uG1IitWvohKyf9J4iOR+7/CS/aeFmUHhPb5pnaEUhhcbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788032736; c=relaxed/simple;
	bh=Wn3lHpFAY3tGdDO9+6Ocxf7DHPNZxuJUQTAwBkAJHdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=in59kazy8Rkdxe8wTLvXxQ7+ywSYSNxIuOOBOXdZ+lrgPf54k1Ct17/Zioh2PIw9Qw3gJOBdyB+6tWv3eT3orrlOs7LUGYoY4+PYByqgo1IgvINup3Ja44P4rZmLfZpQlRnjWE8jQNKI1wni1xBQJuKlxxRWETITmDhUxOt8RGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjZBrQXp; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjZBrQXp"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49b0d8bc2aaso19657885e9.0
        for <ecryptfs@vger.kernel.org>; Sat, 29 Aug 2026 12:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788032733; x=1788637533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/kbbSrwfc8m59jo6SWrl2+0hoNc0s7nX+Eqw6AC2OSo=;
        b=PjZBrQXpIE/Y6ZtlMOisqYJKpqKCLv2+TZ1lah29Ltt/vNmKaHbDbXBJCxpu3/DvoK
         Rr/uBTmLQT41Q33cyrIe7Sy3H9MukFvxsrS4Lee/QqkVfdWv48qXNda+p1346mQawReE
         augrgbXRFyC/BLguPRWOBoMS90k4XZZE5zjaAiQZfL91R8/Z7rGvk9uSW3aogAkFy5Da
         T0puCGTsTMZLNJMTmW4phN0HKzucaYqpODZxQ7lOXaE9iz7Oa2/L/63l+p6rJHAICD4l
         Fxp2zaUb2roXtuBH8ZTb871srxNF95vMol1LXOlTNheO2yHhEsaW1XoIcw/HFX7XvWLn
         +qKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788032733; x=1788637533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/kbbSrwfc8m59jo6SWrl2+0hoNc0s7nX+Eqw6AC2OSo=;
        b=WZEzd1t0Fl6627zT0LWkWqTCR1kyxuiO484kx4QBytNSYvdwmFMZy/kc2L77aFR9q5
         84I750/uhJxjaNPLWrPqE3i3ZFd3YNV+M8cbw8sl5uewvnUp6TGPeFhmcp1NkeS31Zj1
         PyCpZcNfPW7RjKyJpMuPOFqyabOnC2/HGkbrJhXJq/JsKUQSt0ro3CT/gqakFQhbx75n
         u/oeLeEtjjea4nL2oHq2TOrIqVa5tWJs6AL6DImpM17Kaw86vFbrXnL2ZwkcxV+Tv6cJ
         WRTzUsUIF81OmBUnrcJMq9Kv3dm90LU413f0dUdx7/pa+PqVBYqzpE2h14pY43V/mhsx
         AddA==
X-Forwarded-Encrypted: i=1; AHgh+RqZIemoRdmndPdW+fzpZV+bb49Er28nxayJ0BUcgp/mGCMHDkGmwNnsfUQlB13JoTAXbkM6MEow4Q==@vger.kernel.org
X-Gm-Message-State: AFuF++mLgWa8pMFj6iPm6z3xJM5H2KI4cKnnwuFL/hAiGSLfkNlsqK6l
	f4z8qGxcsTdWwGlniad+uPEj0cOTEOgKYG+xskt+4EqDEy5o8MoVhVwS
X-Gm-Gg: AR+sD10xFw3WYgkv1zJhWRvox0X4Y3aWpKpScWMhTKrxhGxedo4b0U0BufTA1/VB04w
	eW3Ce7TLJ4+WWWU4N+RE283cDamfyd0JqgSUu1xLLC5ZjzCnqLOR+syzFdxDC8hXoEjI7uihZbN
	uWhoA0kkjT57/wjD1FT22PJDIXrKn7hKHgfelNbwl0OKQ3R29FQ3hrJ7hc7GZQ1Rze/AYWMg13o
	RLMt4xU53DN5wq849KRexrZTl/q2BQD3SgTw4OmWZjHGH3uWiYyusK3/5QD/muDv1ogBhnRxhQ3
	c6qEONPb9T+MkM4wHjL6Is1lcXyz6cauvgeZjkcn5kOV5N+r9FXP+JRyxmiS9Z9oP6gq3B88+w2
	ehYIZ0GxumMnVVwF0T8Xc4jv/4etAMVoAKiKiIEP6wwDFiseZ2e4jjF4mUJ79Q5VXlA4cHvBJP5
	V/JrTodz25d+QIkXA2CCIbvMj6I+hG51jVxQI4np3Gqhb0z96ag6yjKIXKxtHAawlfBbhoVQnTQ
	/P7jaQdM6HAzhnS3FoAzCyUP+bV+oQfGdVSwcs=
X-Received: by 2002:a05:600c:c3ce:10b0:49c:a2f3:8cb0 with SMTP id 5b1f17b1804b1-49ca2f38f29mr128279955e9.5.1788032733065;
        Sat, 29 Aug 2026 12:45:33 -0700 (PDT)
Received: from DESKTOP-IR7J1S9.localdomain ([105.98.30.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b49cc6446sm208625785e9.7.2026.08.29.12.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 12:45:32 -0700 (PDT)
From: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
To: Tyler Hicks <code@tyhicks.com>
Cc: Thorsten Blum <blum@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	ecryptfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
Subject: [PATCH] ecryptfs: replace ecryptfs_from_hex() with hex2bin()
Date: Sat, 29 Aug 2026 20:45:28 +0100
Message-ID: <20260829194528.5652-1-drifabdelmalekmohamedsaid@gmail.com>
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

All call sites guarantee src is composed only of valid hex characters
and that src is at least 2*dst_size bytes, so hex2bin()'s stricter
error handling is never triggered here.

Signed-off-by: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
---
 fs/ecryptfs/crypto.c          | 18 ------------------
 fs/ecryptfs/ecryptfs_kernel.h |  1 -
 fs/ecryptfs/keystore.c        |  7 ++++---
 3 files changed, 4 insertions(+), 22 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index e67119b6029c..7e802fd631a6 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -29,24 +29,6 @@
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
 
 static int ecryptfs_crypto_api_algify_cipher_name(char **algified_name,
 						  const char *cipher_name,
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 58165928ed1e..be91f7c3fc58 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -47,7 +47,6 @@ ecryptfs_to_hex(char *dst, char *src, size_t src_size)
 	*end = '\0';
 }
 
-extern void ecryptfs_from_hex(char *dst, char *src, int dst_size);
 
 struct ecryptfs_key_record {
 	unsigned char type;
diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index 51651314b7a6..dcfb2e5fa88e 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -18,6 +18,7 @@
 #include <linux/random.h>
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
+#include <linux/hex.h>
 #include "ecryptfs_kernel.h"
 
 /*
@@ -713,7 +714,7 @@ ecryptfs_write_tag_70_packet(char *dest, size_t *remaining_bytes,
 		goto out_free_unlock;
 	}
 	s->i += s->packet_size_len;
-	ecryptfs_from_hex(&dest[s->i],
+	hex2bin((u8 *)&dest[s->i],
 			  mount_crypt_stat->global_default_fnek_sig,
 			  ECRYPTFS_SIG_SIZE);
 	s->i += ECRYPTFS_SIG_SIZE;
@@ -2015,7 +2016,7 @@ write_tag_1_packet(char *dest, size_t *remaining_bytes,
 	int rc = 0;
 
 	(*packet_size) = 0;
-	ecryptfs_from_hex(key_rec->sig, auth_tok->token.private_key.signature,
+	hex2bin((u8 *)key_rec->sig, auth_tok->token.private_key.signature,
 			  ECRYPTFS_SIG_SIZE);
 	encrypted_session_key_valid = 0;
 	for (i = 0; i < crypt_stat->key_size; i++)
@@ -2179,7 +2180,7 @@ write_tag_3_packet(char *dest, size_t *remaining_bytes,
 	int rc = 0;
 
 	(*packet_size) = 0;
-	ecryptfs_from_hex(key_rec->sig, auth_tok->token.password.signature,
+	hex2bin((u8 *)key_rec->sig, auth_tok->token.password.signature,
 			  ECRYPTFS_SIG_SIZE);
 	rc = ecryptfs_get_tfm_and_mutex_for_cipher_name(&tfm, &tfm_mutex,
 							crypt_stat->cipher);
-- 
2.43.0

