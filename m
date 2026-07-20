Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B553B6362
	for <ecryptfs@vger.kernel.org>; Mon, 20 Jul 2026 18:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784571105; cv=none; b=mwOM5p2Oj90wtiY9ui0cgv6fejV16DYJDPcIO8QuNl95E2r6hKu/RMzxj1Y8Qsa7oYYXCEsL3FpqiFEqDuAxzWU+oJM1O3gSeSaeP/OwaaUMUEImtV6LCTTld4tKwd9lK7v+M/Czsb1nDGHEp8WQ9QPl329nRa7DtauiAr4MZus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784571105; c=relaxed/simple;
	bh=nvpseMWWNvqBqQA/visskGijBjdrLlgLlu1zMoYPPUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qteF+Qj9g05Ngqo5yWmbJDdZbMoS/hIDLyuhPERDF7duyXtque7GFu2tLshhjmX70H7FtCuUbcar15b1nNqiOmDH38f6hzy6QN2fIkK64qM1nXX/c9dzXBh+eSl5X75lbaJMRtxl85P4Y27ARkNs8iJ2gRPx1hNSkJDeZdA5d/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=artiphishell.com; spf=pass smtp.mailfrom=artiphishell.com; dkim=pass (2048-bit key) header.d=artiphishell.com header.i=@artiphishell.com header.b=LmHfse/W; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=artiphishell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=artiphishell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=artiphishell.com header.i=@artiphishell.com header.b="LmHfse/W"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-ca965de53baso3822472a12.0
        for <ecryptfs@vger.kernel.org>; Mon, 20 Jul 2026 11:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=artiphishell.com; s=google; t=1784571104; x=1785175904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cnXpA5gX0T/aWSVJgbbvan8lTs+4lAWEeczKmMO+XEc=;
        b=LmHfse/WECvPIGomIlv2lFbVVtXZS2IFmo5X+Ff/AQlJG7PrUKpBW4o59cHFcSCaBc
         xSTACRvqLogrfkiXV22Cb9ruq9rnObkv2bD10BY/d48RqPfx+2gy1B+ZJbo3rzZodBPc
         wPSuQJq9cFpiNUQblTgdlUjQJsAhYy+BdPQRhoGgdATP1kE5g84bHToI+SEYxXFS3+B3
         M91yYr8BwWBgz2bry1DwzB2utyKnqRH9x1W+GTwTgRigPSUvOwY4fY/g8ZgjYHWpDUA/
         zVFG4pTWNyrhK9OkscRAHEgXOvdf/ybdYxuvn4QysIb+LxUcuX6mSXZiXlb5LIhO6fLL
         EFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784571104; x=1785175904;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cnXpA5gX0T/aWSVJgbbvan8lTs+4lAWEeczKmMO+XEc=;
        b=cdJxO0Tyyt0aBxADKWxK6ruEK+mbQl0LGZvem9lwYcc/49+aff24Ab8D/MpqVJuvkC
         FbhP0EUSJWxY2JLh3QDp6xL9AnJ1Z0ukEm1WkrerXH5Q5a/zviNfgxqcaeQSrZs2POUM
         XDrpH3smGEQQYzRQmjy03Y+RViXl49P5oDchCT9djvkdLOMB8hpzz/ecstWApDD9fvSS
         4DLZcKf3dLcGdLWSA0CpyRI42VCHu3Mhq/qsZ07d1ecEUXTRHYjjz1QAMfZS955vLZhB
         ovh3kcVdPOsYojfFsZbia+nsANyOnEBTyoJr4sUqconCdhWv+K48rfMCIdtm2W2beqKb
         rXhQ==
X-Gm-Message-State: AOJu0YwxdkVNHziShxJQXJgd/UO5iqeGDnTM1lLFFn51ItrGfsqqnos3
	Wzn+ysH5OkjDRyeQ04u0j3OrgSGJJJR295E8Evra3DKNt1OM8ZrPG54TvEWPOPv6Mvzg
X-Gm-Gg: AfdE7clU49yUmiWxd9GjZG6RaOTe+pzXlC7FFSk3F2VjPoSjwNiQrcbyQx4ATIG/sBQ
	YeOmkgFlmMzmf8dyuW+1tm8xDgoNGs3jD/aZQHd4BAZp6gEqys7i3qPGQi8r2Sqcb+n1jeuS3kX
	6TNbAHUhH3RSeCeh8iVsm8yr8F4vumKUTSO6FJEtGr1x0RaekRn/Y1FHlHINLXp5ejNDa5dhrRM
	YyQipkWWFBYkK8uKVv2OtkfUFJs7JveUkZNVQ/l9KoGBEJSHPSL8BNWeVRNdm29vusKTkcA7fSU
	o6AuDB9Kxa1VaEdrOvXwi3k5O91BrZFwAddp04JiLO63VMB43Qk3YORwti/kz7YLyyPMc+G1iTG
	/4v62NdffZPAnNbtyG4UheOHpQmIlqSwlK7OJSCGR6VHV0AN7W8DcSiBzgVPEKzom2Z9QtxJw1h
	f1zfVG
X-Received: by 2002:a05:6a20:4310:b0:3bf:bde7:d679 with SMTP id adf61e73a8af0-3c3ada190aemr15930906637.40.1784571103675;
        Mon, 20 Jul 2026 11:11:43 -0700 (PDT)
Received: from nixos ([2001:579:62a8:47:a62e:8055:eada:6f4c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429cf22b3sm39506222eec.0.2026.07.20.11.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 11:11:43 -0700 (PDT)
From: Jay Vadayath <jay@artiphishell.com>
To: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jay Vadayath <jay@artiphishell.com>
Subject: [PATCH] fs/ecryptfs: fix slab-out-of-bounds write when decrypting session key
Date: Mon, 20 Jul 2026 11:11:39 -0700
Message-ID: <20260720181140.8512-1-jay@artiphishell.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

parse_tag_3_packet() only bounds the Tag 3 encrypted key size against
ECRYPTFS_MAX_ENCRYPTED_KEY_BYTES (512), but
decrypt_passphrase_encrypted_session_key() decrypts that many bytes
straight into the fixed-size auth_tok->session_key.decrypted_key buffer,
which is only ECRYPTFS_MAX_KEY_BYTES (64) bytes long. A crafted lower
file whose Tag 3 packet advertises an encrypted key larger than 64 bytes
therefore causes the cipher to write past the end of the decrypted_key
buffer (and past the ecryptfs_auth_tok_list_item slab object).

KASAN report from opening a crafted eCryptfs file as an unprivileged
user:

  BUG: KASAN: slab-out-of-bounds in aes_decrypt+0x1587/0x1640
  Write of size 4 at addr ffff88800616af38 by task poc/115
  Call Trace:
   dump_stack_lvl+0x64/0x80
   print_report+0xce/0x620
   kasan_report+0xec/0x120
   aes_decrypt+0x1587/0x1640
   crypto_ecb_decrypt2+0xe9/0x150
   crypto_lskcipher_crypt_sg+0x233/0x360
   decrypt_passphrase_encrypted_session_key+0x4b9/0xb00
   ecryptfs_parse_packet_set+0x5d6/0x1d70
   ecryptfs_read_metadata+0x102/0x430
   ecryptfs_open+0x274/0x5f0
   do_dentry_open+0x401/0x1280
   vfs_open+0x74/0x350
   path_openat+0x23e7/0x3eb0
   do_file_open+0x1ef/0x450
   do_sys_openat2+0xd7/0x170
   __x64_sys_openat+0x133/0x1d0
   do_syscall_64+0x107/0x5a0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

Reject encrypted key sizes that exceed the size of the decrypted_key
buffer before performing the decryption.

This bug was discovered by Artiphishell's vTriage pipeline, which
generated a userspace reproducer (opening a crafted lower file) that
reliably triggers the KASAN report on an unpatched kernel. The fix
below was drafted with the Claude coding assistant; a userspace
reproducer is available on request.

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Jay Vadayath <jay@artiphishell.com>

---
 fs/ecryptfs/keystore.c | 8 ++++++++
 1 file changed, 8 insertions(+)

--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -1615,6 +1615,14 @@ decrypt_passphrase_encrypted_session_key(struct ecryptfs_auth_tok *auth_tok,
 	struct skcipher_request *req = NULL;
 	int rc = 0;

+	if (auth_tok->session_key.encrypted_key_size > ECRYPTFS_MAX_KEY_BYTES) {
+		printk(KERN_WARNING "%s: Encrypted key size [%d] is larger than "
+		       "the maximum decrypted key size [%d]\n", __func__,
+		       auth_tok->session_key.encrypted_key_size,
+		       ECRYPTFS_MAX_KEY_BYTES);
+		rc = -EINVAL;
+		goto out;
+	}
 	if (unlikely(ecryptfs_verbosity > 0)) {
 		ecryptfs_printk(
 			KERN_DEBUG, "Session key encryption key (size [%d]):\n",
