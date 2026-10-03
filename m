Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E69351C0B
	for <ecryptfs@vger.kernel.org>; Sat,  3 Oct 2026 17:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791049602; cv=none; b=KID11rKlMku/fNFYLuKp9pGl+vux6D135chvQGvoGhRFj589Vrct8KfH2CrMob60+0aSZWftKtsdDnTcSUIGuuREcgYAG+xpccOpTTBTaL1YkZS7ySZ4JfT+9+WZArlEF6pNBaAIDErkUIo1fBpTs8N4t+1xVqhHujVbOe/2nY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791049602; c=relaxed/simple;
	bh=kGwbGAS53FdH0sXmbn3xnwx4Ym7V3BLVw8M55PwAbOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k12aKYUn5tTJc06b+EcahM1jrt71mRIfePWtqdTk/YGJUk73ChRsXcUqFYuNzp7xednipEJKoaSmJAUMVWU2XwcITEu/onIL1BrNTY38eG1K5y5+lqYwzrQqLfa6whc+Y3hTdms/vG8Jl/A55mSSdBwD6MOgqcKlpfcL3BbjXoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVxUak9e; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVxUak9e"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c2dc8cb0decso68606266b.2
        for <ecryptfs@vger.kernel.org>; Sat, 03 Oct 2026 10:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791049599; x=1791654399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=98g+KQuWq0F2GGahW0f/vDtlyZeObmh8xnn+HTlcro8=;
        b=gVxUak9e0jD8OJXHJdTk0UyEM2s+ddTgQmB411fNGKiC7hVi/D/rb9qZLYdGuE60JG
         NtLQkQDmvi6d25S85M5EwbChVVy7eYflfT0TC//aB/nt+L0jyjNYZYX/6MuimY6I478E
         Jr1UlK+jxyldAJke8CnnvJ7U10bQd21big/IKsNzMCApyGke+6i+ix36ciLLlHECF3VW
         IOtXWy60tznIPcQjt9AizW7VpCA234T3AaSFlv2VwtV5EjINRVjc5Dd97tA8ox3keyyY
         BGHcbzYHo2dvwf9Y4COBHR/+zTqGmvKkxdhhKnAdC0CXAA/UCZmUVBhLHFdi6By7S9jr
         RTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791049599; x=1791654399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=98g+KQuWq0F2GGahW0f/vDtlyZeObmh8xnn+HTlcro8=;
        b=HaRB3xisKapoZnPEKGm3YgsBcfrANTQitzc1Ho5i7Fjq7GXsPe+/KwYoLGGBWP+M10
         XbWUG8243e2Y6Co0MOYu588pWQzyNMREl2VwxqelzDfpMIpVxrTbZX5ayGEbesi+E0XH
         sZu61EEoeWcAS/39wuwanAvW2L++wqMB0GCn+6Bj/8csLFxrfr14mNACleZQhc47aTtu
         hgQzUMZc6MXU4j3kJ2nbBBp6Fzii+5GhvT3n1XaTvdOFy60nz8/wCT1BtJRV4rhB8XJk
         8U+0aAj0+C+SICwnzhbLf/TCqpmNggr8ycMvH+uC3zM4yE53O57Yus/yQSASJ46HasFr
         4Klw==
X-Forwarded-Encrypted: i=1; AKwUvBzQI/tA8SQNwAYU1R3QsUtxT3UOP0Woete4l8Ee/IAuyevmSCtoZ95PCZ8N7xEHPbbEY+jjOWbJkA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKgPRQob2okAiyJPosRUS7P+tT9HfINngPDe0uINpkXX3fboyJd
	ZOZ6zlVuzrzqdY1AAH9WO73FaAzAm1hBjE1z9MI0AR99L0L/kpJt/V5Y
X-Gm-Gg: AYBFou33PCrLLiThNqjKtiU5AU62EKHcj57zIPcsZrhm5p3yXJG02etkHnG12/OE/zW
	2PSJaT7xBwqbw9BTZDP2fG+KX7mIg0TvPV3qK8pRmQfsAy+xuJifjPYWVB3xtuykJ+u3yMzj/j+
	6DKQTq9VqtyvLLzj7gte/Ry8mrW+yy5UgrNS1bZvNMMEuy2pPrbT53daKHS9M+Q32MoYH5kGrbR
	bKH5e3mnczhsqmvjwG1Tp2DwGcpjLM3cRLfaUVGsn/oYTVD+1soR9ul5doSFoENCY6z2ntQFSHS
	PPb0KyoIVaKQRw+ZpfEuHT2dyfqIzDc/AL2liLRc36x5atlLooWULqAlPtpRemQVwx0Ek3gHdgT
	EgatKPJKEX0vvcH0925VNnaUW8EMsbJxWZ2WwldyKeyo5uV3RDcJVNBIfG3cgpYi3Wog/nChO/F
	Y3iKu3aZHS6TZfVBnQ92QypqW9ipZ3ws6iVwP0zi6GdB2XyNd1m+s5Y0q5B55JK04r4OJFmTHdQ
	GpxWqmysKhXTmwM
X-Received: by 2002:a17:906:f586:b0:c2d:c8be:4e71 with SMTP id a640c23a62f3a-c2e6ed46571mr232518966b.19.1791049599021;
        Sat, 03 Oct 2026 10:46:39 -0700 (PDT)
Received: from localhost.localdomain ([94.240.182.136])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e4cd25986sm224625066b.27.2026.10.03.10.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 10:46:38 -0700 (PDT)
From: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
To: code@tyhicks.com
Cc: blum@kernel.org,
	chenyichong@uniontech.com,
	liubaolin@kylinos.cn,
	slark_xiao@163.com,
	eilaimemedsnaimel@gmail.com,
	ebiggers@kernel.org,
	a.velichayshiy@ispras.ru,
	brauner@kernel.org,
	ardb@kernel.org,
	ecryptfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Svyatoslav Nikolenko <nsvatoslav515@gmail.com>,
	syzbot+46bbbe175b7eea8036b8@syzkaller.appspotmail.com
Subject: [PATCH v1] ecryptfs: validate key payload size and session key length
Date: Sat,  3 Oct 2026 20:46:08 +0300
Message-ID: <20261003174609.2834-1-nsvatoslav515@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzkaller reported an out-of-bounds read, which sometimes manifests as a
slab-use-after-free, in ecryptfs_write_tag_70_packet(). This is caused by
two structural validation failures when handling malformed user keys.

First, eCryptfs blindly casts the user key payload into a
`struct ecryptfs_auth_tok` without verifying the physical size of the
allocation. If a user provides a key that is significantly smaller than
sizeof(struct ecryptfs_auth_tok), accessing struct fields located deep
within the memory layout (such as `session_key_encryption_key_bytes`)
forces the kernel to read past the end of the allocated slab object. If
the adjacent slab object was recently freed, KASAN reports this as a
use-after-free.

Second, eCryptfs does not validate the internal length field
`session_key_encryption_key_bytes` before passing it to md5().
A maliciously large value causes md5() to read out of bounds.

Fix this by explicitly checking the user_key_payload `datalen` to ensure
the physical memory is large enough to hold the expected structure, and
subsequently bounding `session_key_encryption_key_bytes` to the actual
size of the `session_key_encryption_key` array.

Reported-by: syzbot+46bbbe175b7eea8036b8@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=46bbbe175b7eea8036b8
Tested-by: syzbot+46bbbe175b7eea8036b8@syzkaller.appspotmail.com
Fixes: 0bbb838f385a ("ecryptfs: Use MD5 library instead of crypto_shash")
Signed-off-by: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
---
 fs/ecryptfs/keystore.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index 51651314b7a6..b2fd238bcd97 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -621,6 +621,7 @@ ecryptfs_write_tag_70_packet(char *dest, size_t *remaining_bytes,
 {
 	struct ecryptfs_write_tag_70_packet_silly_stack *s;
 	struct key *auth_tok_key = NULL;
+	struct user_key_payload *ukp;
 	int rc = 0;
 
 	s = kzalloc_obj(*s);
@@ -738,6 +739,20 @@ ecryptfs_write_tag_70_packet(char *dest, size_t *remaining_bytes,
 		goto out_free_unlock;
 	}
 
+	ukp = user_key_payload_locked(auth_tok_key);
+	if (!ukp || ukp->datalen < sizeof(struct ecryptfs_auth_tok)) {
+		printk(KERN_ERR "Error key payload too small\n");
+		rc = -EINVAL;
+		goto out_free_unlock;
+	}
+
+	if (s->auth_tok->token.password.session_key_encryption_key_bytes >
+			sizeof(s->auth_tok->token.password.session_key_encryption_key)) {
+		printk(KERN_ERR "Error FNEK key size too large\n");
+		rc = -EINVAL;
+		goto out_free_unlock;
+	}
+
 	md5(s->auth_tok->token.password.session_key_encryption_key,
 	    s->auth_tok->token.password.session_key_encryption_key_bytes,
 	    s->hash);
-- 
2.47.3

