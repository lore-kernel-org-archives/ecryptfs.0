Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792581554;
	b=UhMM3sLUnY7mOP9ZsJKy4SFb+k2awI8LEu4j1C0rzBAk1yqK21oM7L6L0FWydaLykwcC
	 bbnaUtT7jdrXKEmbcOPvykORn+Q74bqDWHa+L3AmS/VuMPI8V0TRGDKk+BDtHlfxjptEC
	 QPVksNaShgo6OlYO4rU+k2R/n8lsykmDQ2qBPYZLe8IdnpUGlbX7yCLn6FnvkpJnoaQ8L
	 0rS3jax6PIUZj9F8GJxd6kBS9GnIy6k1TpXEeTisORhWUosAbk5p1fpdpfESv0wtTUw0n
	 75KAPhOk65Hl6/+aGehDi34V/F64aPiRkaIYCw6XsX1KIqeCNuKn0pLKfM6GIGOFJ0A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792581554;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=o4GqgC/8uo2HzaoUqlTv+3o9qdHmo/p865F4COeyagY=;
	b=H6xKnuha2z1RBL0P/d0QiKX97Bkd9nCG6frKO7/B+riytzY3fnekFOcf1XAWd0THATti
	 5SGeMk3n8M09A+f9VQqnrBrhkzmTh33QoWURysKMIYa9CZaxtMvT4Kbxw6xtUZ0ArsMe8
	 48+97pfdjehwo4dUGlFj7mMyNzJRPLSPBkPFJ+YQUEFCvAhnyaEKcfRuILG7hHDLGAtHh
	 RThckFFS94iRjPjMfPAKV6JbZCetnoYtkvCdx2kg+0pYHXlU9DPRrEqiqdIlf67JGE9hL
	 EC8ToCYxOWuBjKzog35CgoekhtR/+VfoowAWVfT/GK1NK9B728bI7RzlYWnd98PNxjw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OdTQxZhU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A26606A319
	for <ecryptfs@vger.kernel.org>; Wed, 21 Oct 2026 11:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2A26606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OdTQxZhU
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c40f29667e6so88090466b.0
        for <ecryptfs@vger.kernel.org>; Wed, 21 Oct 2026 04:19:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792581552; cv=none;
        d=google.com; s=arc-20260327;
        b=XbBAmhvtDuqe56LwjO97s6V+p8ZTxVxzocgfoERE72fopa7p3IglkIy+EkalKiqMQC
         lcV+MVNOJP+PCsC68TGYdBbMbcl+sgcfKtJMlndUodPLUbhpMiSCF4eb4RbtJyXIJHCD
         YcbSQW3lCpeSIqLqjy1aPiRos+JYCobbW1jD3ElsICiWKvPoF6uIU0tX8iIyGOCY1n0C
         Xg5y8aEQ3nR4dL5NC0BwNWThu4Rsasa+lzwYYlmgk4mH9d6QsKQAjwwAD+7Ps1qWJoAZ
         Gw/c3gt1r9NIIz9Z4jmO1pL8Rf6jeSSUyjGOWms82VSk85ogQv//YKBuNwmc/8CVmkGI
         smbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=o4GqgC/8uo2HzaoUqlTv+3o9qdHmo/p865F4COeyagY=;
        fh=eH1Ca7VLtGkNGqf25yfKzcMyVblry9f4ABZdsyo4ItI=;
        b=DrJu/MwzyhEUV9KdiBWlr/ajW9O6IFoY2YXsikZoXLRKWYrN5ApkX1FUMhtkvTvgXk
         DZLQN2RSgLdRDo7+PdR9axZVHTm9At61vAHVykdHJjF6uj+bszma80ypq/bnSlQNz0xn
         HnmiWL38VvM0azxdP7OitbwNEsAzN0ntyCvZK+4t6+4QCIbzfr32YVmiXV5s+uLGtv+v
         ryiRrqz0uYUmzoXfo4E+Cz290EJLLk7DVgMcjyOBYBbiFSAfh57v5IFQfWDIW41yyB/n
         QX6pe0Ln1QZKLxV32zLN2A7rOjo3mbHfEckRwFry3d51y9xa5egvsOtjisKf1C5P7rQi
         ccEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792581552; x=1793186352; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o4GqgC/8uo2HzaoUqlTv+3o9qdHmo/p865F4COeyagY=;
        b=OdTQxZhUXfbcrZCBYp3yHotpszVXdULIYN/rEwoLPO4S/UQXkDoEiMZtH+Lnd7v+/8
         SasnUNOOtRk5YshNiHEHp7b79tptB8Pux5rAd5p+gu6x7K+ipvATspyXRo9kerLbAcy/
         jmPeS+dnfrT5Vz2wXz2eaHva9PEflF6U3Qm7AHmmA8Y2XkUKSMqGaWy4dT/GhPQljGCn
         UxTq5/j0/3rvY5XXNfuOq7fp4kcmXP00WMpdGdpjV6Le+U8zOGXMs0FY10wKNhU6F9y1
         Dd9kOwRxcQyFW8tHdUypMvlX5hx7pf9o1VU3DChJpHg1BS8gd65a0IP5prBmN/+VEAqs
         jCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792581552; x=1793186352;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=o4GqgC/8uo2HzaoUqlTv+3o9qdHmo/p865F4COeyagY=;
        b=17bsTdAJtCOTs7dsrAIUil7wXhKj0sB8Ojpcc26MNeNeI+FvoT/hcJn8CMk780sENb
         wAH1oL0lYelNRf3+4FsvQfvF7OEq+xb/xtzXwZ/5hE/rsSgC3+kX/SbUwNZnufE46GUx
         HqlJgsr8JJkTPlGqOPXyFHVNZ8LPNajjcIlmfPH4wCkirBEQFZRPLa+Dm7pvhVqBpHcw
         zpwj/zd4zKMNAulXcVoBctj3LA5xtzF4c9JnqABcrzrgyhFEGwWS/lQpgtQPK4ytLSH9
         JmIRcIoPcy5z280UiSsADVNUaOggrQe+POU5/C9SbFVCOG9qf2gp87CbYoaOGHRVHPmK
         U6Gg==
X-Forwarded-Encrypted: i=1; AKwUvBwfy+0ygTXjTevGgQeU3EJpvLP2L0KauurfGOeE3vhugX8MUbae4NZINwpfwdm2xuKEnunq5iSFgg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKsTAdjVDWhLjItAP7abtPVaAFm7XrfKsFe9Dj8uDexkSa55qDk
	ZmqVzaJxKZr6MWb5C++2rNB6lt5SuuzN7h5XoQnG7vvPaENYWpIt5mx+yCTcMQ/axs8pjv3VguD
	UjKq5ke3nZ++vKY0GE2t1w41bOQ+DaOs=
X-Gm-Gg: AYBFou2JhJjlHwQi08vumopCztp2QxBOTi/VDK4lksuFPwE/XNiqyOgmV/gSuv7gFLf
	y3BI33dfb/dBHzrjiBCA10l5QElf/xjf6FLGr5K4LtnVo72eFuXMjYC8bCVtd30VPFFtp6/tKpI
	HzZWk/fndXvnv0lfUf/nF036dWiaetKQOOIzJuK+hIG/e2zxOTZ6SwbYLZR9P2ONQ8CDf+0TLo4
	9Jgv17Nki2Q/jCI8Cf0bPr5bzBJe9PkkTz5jFTmfaCUbXH9ipSQtxRZqC9NoDi9n1bVGWpBr0Jc
	BPVx4EPuCvRBDyceVDSao7Jixoa03uNlpaHxj6MTcI+kIaysS1O0T+cIX4kA1hu+VlOzcVMFNpR
	Bd/MP8ky7koDGCUboW8U6Nrd1hpy1R/og7+Lmsw==
X-Received: by 2002:a17:907:9608:b0:c28:599b:7782 with SMTP id
 a640c23a62f3a-c467959800cmr145664366b.21.1792581552020; Wed, 21 Oct 2026
 04:19:12 -0700 (PDT)
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Post: <mailto:ecryptfs@vger.kernel.org>
List-Help: <mailto:ecryptfs+help@vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ecryptfs+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: DRIF ABDELMALEK MOHAMED SAID <drifabdelmalekmohamedsaid@gmail.com>
Date: Wed, 21 Oct 2026 12:19:00 +0100
X-Gm-Features: AclHuK95cnmQUwRjUGBQFe8hBFruDLBNtySqrDloIqyCO5VZ-yqafKYk9aUkxq4
Message-ID: <CA+xk8n-n535aeZLEYeENYXzhrp54cBHtp5kGxt85qERk4ECd9Q@mail.gmail.com>
Subject: [PATCH v2] ecryptfs: replace ecryptfs_from_hex() with hex2bin()
To: Tyler Hicks <code@tyhicks.com>, Christian Brauner <brauner@kernel.org>
Cc: Thorsten Blum <blum@kernel.org>, Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org, 
	ecryptfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ecryptfs_from_hex() relied on the deprecated simple_strtoul(). Rather
than patching it to use kstrtoul(), its intended replacement, remove it
entirely and switch all call sites to the generic hex2bin() helper
from <linux/hex.h>, which already provides the same functionality.

Update call sites with the (u8 *) casts required by hex2bin()'s
signature.

All call sites guarantee that src is at least 2*dst_size bytes,
but nothing guarantees that src is valid hex, and also hex2bin's return
value needs to be checked, so we add a fail early check to call sites.

Signed-off-by: Drif Abdelmalek Mohamed Said
<drifabdelmalekmohamedsaid@gmail.com>
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
 #define DECRYPT                0
 #define ENCRYPT                1

-/**
- * ecryptfs_from_hex
- * @dst: Buffer to take the bytes from src hex; must be at least of
- *       size (src_size / 2)
- * @src: Buffer to be converted from a hex string representation to raw value
- * @dst_size: size of dst buffer, or number of hex characters pairs to convert
- */
-void ecryptfs_from_hex(char *dst, char *src, int dst_size)
-{
-       int x;
-       char tmp[3] = { 0, };
-
-       for (x = 0; x < dst_size; x++) {
-               tmp[0] = src[x * 2];
-               tmp[1] = src[x * 2 + 1];
-               dst[x] = (unsigned char)simple_strtol(tmp, NULL, 16);
-       }
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
@@ -713,9 +714,14 @@ ecryptfs_write_tag_70_packet(char *dest, size_t
*remaining_bytes,
                goto out_free_unlock;
        }
        s->i += s->packet_size_len;
-       ecryptfs_from_hex(&dest[s->i],
+       rc = hex2bin((u8 *)&dest[s->i],
                          mount_crypt_stat->global_default_fnek_sig,
                          ECRYPTFS_SIG_SIZE);
+       if (rc) {
+               printk(KERN_ERR "%s: Invalid fnek sig [%s]; rc = [%d]\n",
+                          __func__,
mount_crypt_stat->global_default_fnek_sig, rc);
+               goto out_free_unlock;
+       }
        s->i += ECRYPTFS_SIG_SIZE;
        s->cipher_code = ecryptfs_code_for_cipher_string(
                mount_crypt_stat->global_default_fn_cipher_name,
@@ -2015,8 +2021,12 @@ write_tag_1_packet(char *dest, size_t *remaining_bytes,
        int rc = 0;

        (*packet_size) = 0;
-       ecryptfs_from_hex(key_rec->sig, auth_tok->token.private_key.signature,
+       rc = hex2bin((u8 *)key_rec->sig, auth_tok->token.private_key.signature,
                          ECRYPTFS_SIG_SIZE);
+       if (rc) {
+               printk(KERN_ERR "Invalid token private key signature;
rc = [%d]\n", rc);
+               goto out;
+       }
        encrypted_session_key_valid = 0;
        for (i = 0; i < crypt_stat->key_size; i++)
                encrypted_session_key_valid |=
@@ -2179,8 +2189,12 @@ write_tag_3_packet(char *dest, size_t *remaining_bytes,
        int rc = 0;

        (*packet_size) = 0;
-       ecryptfs_from_hex(key_rec->sig, auth_tok->token.password.signature,
+       rc = hex2bin((u8 *)key_rec->sig, auth_tok->token.password.signature,
                          ECRYPTFS_SIG_SIZE);
+       if (rc) {
+               printk(KERN_ERR "Invalid token password signature; rc
= [%d]\n", rc);
+               goto out;
+       }
        rc = ecryptfs_get_tfm_and_mutex_for_cipher_name(&tfm, &tfm_mutex,
                                                        crypt_stat->cipher);
        if (unlikely(rc)) {
--
2.43.0
