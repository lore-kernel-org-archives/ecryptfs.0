Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94F3542805
	for <ecryptfs@vger.kernel.org>; Fri, 16 Oct 2026 17:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792170407; cv=none; b=KbGAgWrSX6U6qjNXS+gXBTm6WFbiaG7EUyrKhBqgdHFZ0ySwuqLOwTtzjIMH2F6kq20hC2EPLW70aFjbusVft+2CxSQyvDL4/ifMBe3y317jiadr6mX+JmeT1zrYasLIKi3pSMb5Bd/O2IepNhd8tIRrRToAI9o4pF5PeHydO6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792170407; c=relaxed/simple;
	bh=jtdF2NbRO9Tk+EJfzWagLec3dR6hkcpuqPZZnpc2Vvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BfuX4TTZOlG/WodMM+TsuDn+Qca7pW+XHWH6MuvoQtOruZq3BxPPdAJ5nG6NDHyhT5Gh9ByfmfzDQYI7Xm3rbZNAlWPFDopJ72sL3elROeA2mZe9ffWaWJ+CCSZIxAz+59BXiGd2KQi4F6oexWa61pT9cXO45rSg0g7QMjfP7as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/MuoAAR; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/MuoAAR"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3514b90bb89so222446eec.1
        for <ecryptfs@vger.kernel.org>; Fri, 16 Oct 2026 10:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792170405; x=1792775205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GxIjjfxwXom2YZho8tvK34GRsgnUG+0wvm+DBzj19gg=;
        b=U/MuoAAR369u4J5sLi4C/rJPfadtfJUQyKL5XEwcAJ8O/AbVncLqW1gQ6FgyvO+Tju
         EgNy7V/c37UuALpZ01DGdiDfLRiUkpqsMvO7N2ePUQI/qsh3645d/SjKXOCSxuVOA4uD
         hZoVA6aZE+eOctU0f1zKXx//Z2sQU1LgtJ/9KSd1ozhhSL9Nt36WuQziF98M4/z9hdXD
         LVJKQwyExXKKx8kCRLnvi/2wqLCnvsC439xXJX7e+I1ILQbevtV1lUULU0wXatTZSCE7
         gpburMTWdxo53qf0/JOME2gkufc0L7Szkd+e7TooOjQw+rnio3cg4Ybdkr006IsWkxJu
         d79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792170405; x=1792775205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GxIjjfxwXom2YZho8tvK34GRsgnUG+0wvm+DBzj19gg=;
        b=FDs9IckqKdwyYE2bAN4bBBS5ytEdpu69j3mAW9n37Nxjic3TTIvchYEFSWdgmXLOU9
         Ar7bOQD4wyEF6O7+7BttkxM0xrAsAxo5YqqSjfQmIMUxsYUvMZfnkcOaFQTbigc81uIn
         ue/x+OtD4DCYzDjXq7uSiIfXEBZkc7iaLByNnukdQ4/o3MlSXb0I+ktsAnH6ataFpSxF
         0H3pF+/QZuZ9fGuSKCKrdy0hRaei1DlaSoOTjlWWrYAFouVV+2VKPvUBpRS9ZeGwbnUb
         OtVGfcOg/xCqzG6WEBbmQWgJCGEjPKcoM5FxuysB+8Ajz2LCaGr0X2NVk82Z8/PLBXw7
         2Cwg==
X-Forwarded-Encrypted: i=1; AKwUvBxHJ+m9pD54fw0mHrBysewN90BQYeSy1jRIuM5DH9eNA6b+lmmBrxQSDSrdQdYp0BUBVlQHjPe4Kg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKKq38gdaCX2OCbsu90T0dGTd+ozCLIm/DxhOfUBNugSTzfL9FY
	qVZ6CDhROyRzSJ1wwa4/v7Jt/bTI3y6r6rD5MUO1WHwpRYW7bxFHVIvS1Oy5RfjS
X-Gm-Gg: AYBFou24GwwTdHwLtw4bg7X52uRZqobf1KTY3+bjylhi0NgBxno9oDv8D4VLsMFBuwt
	q1llEnazSi17hPSdd2sgeUEwDQ1Q0O+auaBDHFR/5NusDaiBmO+IrrBAkgGtrFGrrKmEuNVX0rm
	s8MMcutgcaR8qW8MdDEo4LEBBLUdl58ix1lQIUClh8rjWaYfmYabT4ZYjgQSxrmt+FRzWI7FcKO
	PxE+5KKT7Z34oN5j22KFE9+c21nTFBrdXHSFMoGnaICo1ruLgMyagA/BlKeeVpcEHuOfxKMazGd
	BumfK1v8CK77j/Yj3k4lohgz7o2fiI6jvGku6p5elf5ErPNzt10Tb899XUmCvD6lGtTqy7Q1QHB
	/9EZVI7HZnyAJpbGWXNsyrxdvOZ1AWLrRi6sOdBfS1Gsmgy18HsUkz4b6ujqY+rC5FzSkVJWXt6
	LjIk/bV0OadGm0qvNQ7+9EgByHK6eLDQNZmC3HA2ZbHvL/aw4HMxq8uLoU6CwI
X-Received: by 2002:a05:701b:4502:10b0:143:6525:f9f6 with SMTP id a92af1059eb24-185118edabamr606397c88.13.1792170404876;
        Fri, 16 Oct 2026 10:06:44 -0700 (PDT)
Received: from adriano ([186.40.6.142])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831a6f58c2sm11285825c88.11.2026.10.16.10.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 10:06:44 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
To: Tyler Hicks <code@tyhicks.com>
Cc: Nguyen Duy Nhat Anh <neganhat@gmail.com>,
	ecryptfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adriano Cordova <adrianox@gmail.com>,
	stable@vger.kernel.org,
	syzbot+03c68e42ce4b33f7ce9b@syzkaller.appspotmail.com
Subject: [PATCH v3 2/2] ecryptfs: bound session_key_encryption_key_bytes in auth tok
Date: Fri, 16 Oct 2026 14:06:33 -0300
Message-ID: <20261016170633.1415240-2-adrianox@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261016170633.1415240-1-adrianox@gmail.com>
References: <20261016170633.1415240-1-adrianox@gmail.com>
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let ecryptfs_verify_auth_tok_from_key() validate the password's
session_key_encryption_key_bytes length. When it is larger than
ECRYPTFS_MAX_KEY_BYTES, md5() reads past session_key_encryption_key[].
Reject such auth toks.

Fixes: 9c79f34f7ee7 ("eCryptfs: Filename Encryption: Tag 70 packets")
Cc: <stable@vger.kernel.org>
Reported-by: syzbot+03c68e42ce4b33f7ce9b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=03c68e42ce4b33f7ce9b
Tested-by: syzbot+03c68e42ce4b33f7ce9b@syzkaller.appspotmail.com
Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
Changes in v3:
- Split the v2 patch.
- Change the Link: tag to Closes:.
- Remove Nguyen Duy Nhat Anh change and its Reported-by tag.

 fs/ecryptfs/keystore.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index 51651314b7a6..c2ba230c71fd 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -477,6 +477,13 @@ ecryptfs_verify_auth_tok_from_key(struct key *auth_tok_key,
 		rc = -EINVAL;
 		goto out;
 	}
+	if ((*auth_tok)->token_type == ECRYPTFS_PASSWORD &&
+	    (*auth_tok)->token.password.session_key_encryption_key_bytes >
+	    ECRYPTFS_MAX_KEY_BYTES) {
+		printk(KERN_ERR "Invalid password auth_tok session key size\n");
+		rc = -EINVAL;
+		goto out;
+	}
 out:
 	return rc;
 }
-- 
2.51.0

