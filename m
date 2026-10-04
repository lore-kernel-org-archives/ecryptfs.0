Received: from mail-vs2-f41.google.com (mail-vs2-f41.google.com [74.125.227.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A0C134CCF
	for <ecryptfs@vger.kernel.org>; Sun,  4 Oct 2026 12:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791117495; cv=none; b=lS8jrseEx3Gjq2qQKwWRgiJwhUs7etCjxu70AyGUNmGKzXSte2FrRid1DYSLnLLtmky7gYplGPQhr38msrFkHMwppDIxJ/37SOPtUFPn+rzrSBaPg8kI4DmL97GzMdmpXZIH9O/g6ez6xoFAzXDmAGC9TZvQtGXWGdJ270AMuUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791117495; c=relaxed/simple;
	bh=nbzSApltMb6Mmzx6pDMX1NHejjTdFwoNtGdhP2hrtZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QfzvH2HkjAaMdP2RDc4z9vDFy1sX/Qm4H/HVq3RGigTc7j9is+oFLbKBrTOxBF8qqoDPNxjBlgPy4a1ILcAAvxjoYNoZzw8lT2k3tnN+IjnBlNxmNgRzV5HtO6q7z4+aO48IQUSFw/1LxALuWJtmBNvPyEJClmgIKkmUwfGhLS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fe/xnYgd; arc=none smtp.client-ip=74.125.227.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fe/xnYgd"
Received: by mail-vs2-f41.google.com with SMTP id 71dfb90a1353d-5c67e529da9so300345e0c.2
        for <ecryptfs@vger.kernel.org>; Sun, 04 Oct 2026 05:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791117493; x=1791722293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9QkwpOl3Lc/mMo5+42pmcC+xB8UyEuLu9bt8ien1zho=;
        b=Fe/xnYgdWMRP4f6wvTn0qxbpFH+eCkwc4Tey/pf34voNKiuZPzdVVEAOxLr+qMbcYB
         hcHOtSPi6Bay/NaDmz8brARS6H/hPucNHdIG7IR5gMgUDJCnL+ZQEVW+NWty3GaOWiTv
         TRfV+6/UeNx85B/9ppA8rXMZSGAqg4GutuaStgh7nr61k5cCVrPDiMOegyddFm/dw4yG
         VLFhUsSGHtTIClm2STdjl3cTrrfRJQJzamQLezU29v5gD3PVoU+9s7mHvMTtTln9wtu6
         n4lLvANQYaYuhYG485R/FS/xVnSrgnaTHPM7F43ZVKmI6qfdZGP8BzIntx8E8p0okbB4
         +G7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791117493; x=1791722293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9QkwpOl3Lc/mMo5+42pmcC+xB8UyEuLu9bt8ien1zho=;
        b=mD9X0ngGt/PJKOtnC7XK3TiCVoqe3OQR7WP/zb2ZugAL32OCIs2dJaE0IZWjLq3aKl
         8r9Jr61jLB3Adp9p8lqjbVUEFGuyv3ALjPnAIj98p1YbXxkjbD+6rko7DfeCfe+ORdTp
         A8GeFnJNiLevERDQynwvuRpPGTbnMgzBlMPGoJZNUaR3+U7oa7IVxfFmJLut2reQiKqY
         dVBH2BObyiYRRiIWThOkp/q/2beF7Huk9dGphxaL2GcBjfRSgVOjXUKm974O7RVDhRFB
         OzaUA2kCi99C1wIXSNJvdI431tg4v+2HCVUqTkAIEgVA/kJi5rULhl2ugkEYhaC5ZaA1
         TfbQ==
X-Gm-Message-State: AFq9FYIRiKqeVgGzABBYVmzDui/Wx5q6UooTlhfcz1E7H7DvF21A4M/v
	NTktORMST+spRXA/oiK9VOkapYQg1sw4+YOdrTEzd52qMPMFKUE2scsV
X-Gm-Gg: AYBFou30L5U5p0Z07lcNCIMJg03f5eS6ZfLfNp7XCwN7Q39e5XTHfknkAJuCtALD7L9
	s+1NSkOO4fVfFZSXbJRxQRvaSfi5rhC1HuOyJ3ZtRmHL5M8+j7z7KSgHo7WRPKjJg4kDdIWhoZ7
	WH+3AsmpugYgDeikFJj68LgdHaTcbzlBH2kbRGVRhzGVAwfYTNczYV+bZaLx73q1JfS0N71B9N4
	BUidXolVU6OfFJmdU7AXNxAuQwu5UULOGIpbZonyJIrPc4sAPXncb1td03pz0ltNrC5BcaNtRBS
	BT8AdYw6d731cRf/FupQ5dJ266c9oBtvCvJ8t787iA5wVWU6wUTj95ZJF+I9YoMneHFnE4dhpBh
	mkOzXOuFNvCv4qC5oHZ+9/8kaSOVFPIp5xTGGnvJbF6KO/sZE0GrVSFL+FyY4XdmKNY1fiD0nE8
	KyYXjKhBcv03d1pb+Rl7crXKWX9P/g3/iYirKVSfs5vJQFHoOxXZMIqlFx77sca0OzjQ==
X-Received: by 2002:a05:6102:f08:b0:7a5:9a:3a31 with SMTP id ada2fe7eead31-7c0f5bb206dmr1662153137.34.1791117493357;
        Sun, 04 Oct 2026 05:38:13 -0700 (PDT)
Received: from adriano ([190.215.95.120])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5da641688e2sm10530137e0c.18.2026.10.04.05.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 05:38:12 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
To: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adriano Cordova <adrianox@gmail.com>,
	stable@vger.kernel.org,
	syzbot+03c68e42ce4b33f7ce9b@syzkaller.appspotmail.com,
	Nguyen Duy Nhat Anh <neganhat@gmail.com>
Subject: [PATCH v2] ecryptfs: validate auth tok payload size
Date: Sun,  4 Oct 2026 09:37:55 -0300
Message-ID: <20261004123755.14642-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Validate that a key payload is large enough to hold a struct
ecryptfs_auth_tok, and that the password token's
session_key_encryption_key_bytes fits within
session_key_encryption_key[], before the payload is dereferenced.

Cc: <stable@vger.kernel.org>
Reported-by: syzbot+03c68e42ce4b33f7ce9b@syzkaller.appspotmail.com
Reported-by: Nguyen Duy Nhat Anh <neganhat@gmail.com>
Tested-by: syzbot+03c68e42ce4b33f7ce9b@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=03c68e42ce4b33f7ce9b
Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
Changes in v2:
- Add Reported-by tag.

 fs/ecryptfs/ecryptfs_kernel.h | 6 ++++++
 fs/ecryptfs/keystore.c        | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 58165928ed1e..4315c18ba1cd 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -88,6 +88,9 @@ ecryptfs_get_encrypted_key_payload_data(struct key *key)
 	if (!payload)
 		return ERR_PTR(-EKEYREVOKED);
 
+	if (payload->payload_datalen < sizeof(struct ecryptfs_auth_tok))
+		return ERR_PTR(-EINVAL);
+
 	return (struct ecryptfs_auth_tok *)payload->payload_data;
 }
 
@@ -124,6 +127,9 @@ ecryptfs_get_key_payload_data(struct key *key)
 	if (!ukp)
 		return ERR_PTR(-EKEYREVOKED);
 
+	if (ukp->datalen < sizeof(struct ecryptfs_auth_tok))
+		return ERR_PTR(-EINVAL);
+
 	return (struct ecryptfs_auth_tok *)ukp->data;
 }
 
diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index 51651314b7a6..7f2dbc81fcbc 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -477,6 +477,13 @@ ecryptfs_verify_auth_tok_from_key(struct key *auth_tok_key,
 		rc = -EINVAL;
 		goto out;
 	}
+	if ((*auth_tok)->token_type == ECRYPTFS_PASSWORD
+	    && (*auth_tok)->token.password.session_key_encryption_key_bytes
+	       > ECRYPTFS_MAX_KEY_BYTES) {
+		printk(KERN_ERR "Invalid password auth_tok sKEK size\n");
+		rc = -EINVAL;
+		goto out;
+	}
 out:
 	return rc;
 }
-- 
2.51.0

