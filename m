Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC793F7AA8
	for <ecryptfs@vger.kernel.org>; Tue, 22 Sep 2026 04:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790052255; cv=none; b=SAhBugTbUcrH42ARoXPe0Y4BZ9VqEOZUfm0h+Iqz3E2r4uq92lsnYaTdPvnuoSVWodAV1Gs5eNGHOKx343L0szzxSwqaBRsFLlYbP0aACPEmA8a9uxF1Y0wI+UlvL0PIKmbNBM25Zb8Po3sSNFPe1gl9TurWwPiIPykh42fVdUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790052255; c=relaxed/simple;
	bh=opW3UCyYmUGIh685jbNut0YC/KSIFOxVldRZxwjwqf8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=POocv3/u4B72Zsm+1B7Qa4WJdfeH+/uOGwwKjsTH45lVDpPYtcthqhxfG/H3sCL8hr3gZpqO8pyAbPO8cFjmLGoFGnuU6X0/46/hzS0SPIIFqZle51el7HCZEAEqAZ3KB6maii01HK5QscXVczfgWSEczX3lwH73voc7Mz5ugi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JCs/Gi5z; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCs/Gi5z"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-398cb5615deso4329733a91.3
        for <ecryptfs@vger.kernel.org>; Mon, 21 Sep 2026 21:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790052252; x=1790657052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nd2sNIwsDlUojlzUKsazShmKean8n/g0XREbYRxOeao=;
        b=JCs/Gi5zIsBW2gU4j05Wt5wOYcGAR3qiK9Dhk9x0TJzUujKDoX6uid4zemMzJYT1KI
         JVaTaqXNDpSDO64+8TR8aazTJ3ijcRnfpuiVKuq4dhQclUG2N26UwL7mqYPt0IXYocFw
         fL9BB/0jfojTT55ff5tN1SpzFfY0dN17C5Pxg1Q9Sz+S4HFIL7zS/Lm39m0h+mGiXf+8
         QUC3NXFtAfdkkLDwBk5Ukkyt6zvQe2YZlkmomcEguYWs0J7l3/x9Oe3GQdKLS0+h8Iag
         PZLYe07wQGdWj5Yt421+meDNZMtLcfr598QT+w+ZQQzA40i6SqyLpf8k+9O78MAjsXCR
         vNhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790052252; x=1790657052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nd2sNIwsDlUojlzUKsazShmKean8n/g0XREbYRxOeao=;
        b=PBArXQYYYd0WjpJE+jTOyGXK3KRlip0Q5p/6XO83qmk7Ij1jkzSANKF+CYp9yXF+3g
         OOftV/W6BWmYj4PK3b/V8iiJVzX2UwrKK9CsRA7w4rmWbMS6FP9l6Vmo0vvszsA9/3Lf
         u/9pJi32dRLQhJg82qhfFUYOc7wY5pdesowPdE8ZxSenl0cspbqyR1zBu5FlM08HU0si
         A8JVUIPWhkASef3G/yWdlZPT5kYaQX2PgHKYj38UuzPon4jp2+oosqjRIIUJCzvsv1/+
         0+N9O35UyIHs0nUjLqGKCz1Mr/loW5iLKG0E/fYp4ue0g/C8gk4GBajnBAqKl8egiKUG
         YX+A==
X-Forwarded-Encrypted: i=1; AKwUvBxbirYZsqUsgAXY8cp7oRK31Lo7N031YiCeaMxWKQXCyiKJcx9IRSFYVQHxd8KlckwUQ+BfpitwgA==@vger.kernel.org
X-Gm-Message-State: AFuF++lHnYXDg4yQpxmSiACT+Hkz7DO7oPTc3xI7HGwV54+PzwN2gr/I
	Vu8VtBNd/fc9mqtJX98aQgCuP1RJzVNmwsWWFOly1W/YZ73dZaHLkL8n
X-Gm-Gg: AYBFou3/Sd4A6gc+CZio0afzW+CA9HmGD9f26TFkrdC+25+kHhQ7z2MkNevcuolceqA
	cKcx/ZMM0sN8vjfkR4TZ09wT8kFYGyZ68WKlDtTuV+n3LJBoyIbT35wD1vyJfIj7Kbo4iVbwe/a
	npNP9NEmTGnLc9/8RsnJqwzWgBNfShn24+VuSqAh0zuJgXst0Eikudf6uXJn8f+0vE6GhoVpNzH
	/vjFUYedYfTf6IxpKqW4d2pIoKwW53faEGMXvLCKu7V5BSM4FXxle1Nd12Qf96Eq4C42fYRpzOq
	dEEfKKea0BTWnEn4KYFAZrWMpG4Yul7AOLIMZGpXzV71iAB6WSHT5AWQ1UzN24el3UHSJxSVLmH
	hrMbMX+Xt5IzNVu1p9s8W7ppL43egfhNayPH6nr3pK2roElzUUZj0fYZpnVw62bvFCNKkFMFUyr
	tm7EoC9sEXgdvPypLHfZSxGl4GFOuyuyAVFKtKzRvPISOUA6thp+GdlESuITGDbryiM2RGtLiPk
	YG4hK+KYQyb1c6ekED42xtwmAtVtPxy05joPjh3jlBVjXrxj475jdeBu/uR4lYpIpImuZepKQ==
X-Received: by 2002:a17:90b:580c:b0:39e:4c81:6c96 with SMTP id 98e67ed59e1d1-39e54f8a187mr19084529a91.28.1790052252288;
        Mon, 21 Sep 2026 21:44:12 -0700 (PDT)
Received: from deepanshu-Legion-Pro-5-16AFR10.. ([2405:201:682f:383f:6cb2:ad3:ad92:1570])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06e5751f2sm943802a91.9.2026.09.21.21.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 21:44:11 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: code@tyhicks.com
Cc: blum@kernel.org,
	chenyichong@uniontech.com,
	a.velichayshiy@ispras.ru,
	kees@kernel.org,
	liubaolin@kylinos.cn,
	eilaimemedsnaimel@gmail.com,
	ebiggers@kernel.org,
	roberto.sassu@polito.it,
	ecryptfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+e4391e0d6e7c89b8c84e@syzkaller.appspotmail.com
Subject: [PATCH] ecryptfs: validate auth_tok key payload size before use
Date: Tue, 22 Sep 2026 10:14:00 +0530
Message-ID: <20260922044400.14078-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ecryptfs_verify_auth_tok_from_key() casts a "user" type key's raw
payload directly to struct ecryptfs_auth_tok without checking that
the key actually holds enough data to back that struct. Since a
user-type key's payload length is fully attacker-controlled via
add_key(2), an undersized key whose description matches
global_default_fnek_sig lets later code (e.g.
ecryptfs_write_tag_70_packet()) read fields such as
session_key_encryption_key/session_key_encryption_key_bytes past the
end of the actual allocation, causing a slab-out-of-bounds read.

Reject the key up front if its datalen is smaller than
sizeof(struct ecryptfs_auth_tok).

Fixes: 0e1fc5ef470cc ("eCryptfs: verify authentication tokens before their use")
Reported-by: syzbot+e4391e0d6e7c89b8c84e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e4391e0d6e7c89b8c84e
Tested-by: syzbot+e4391e0d6e7c89b8c84e@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ecryptfs/keystore.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index 51651314b7a6..81768a0e43b1 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -462,6 +461,14 @@ ecryptfs_verify_auth_tok_from_key(struct key *auth_tok_key,
 		goto out;
 	}
 
+	if (auth_tok_key->datalen < sizeof(struct ecryptfs_auth_tok)) {
+		printk(KERN_ERR "Auth tok key payload too small (have %d bytes; need %zu)\n",
+		       auth_tok_key->datalen, sizeof(struct ecryptfs_auth_tok));
+		rc = -EINVAL;
+		*auth_tok = NULL;
+		goto out;
+	}
+
 	if (ecryptfs_verify_version((*auth_tok)->version)) {
 		printk(KERN_ERR "Data structure version mismatch. Userspace "
 		       "tools must match eCryptfs kernel module with major "
-- 
2.43.0

