Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795133746;
	b=PdbTjfWuqwIW8DH0SVzgPIdD3z7FNzY1zbaCejo4oYUVaUN8s8ws1Na+qockLo36hz3M
	 tmLkxYG9B335EDnkJcA3Rx7+aqBz62bQK6b3OsyfkgmBwzj2YwbXg586/aYbrM3uLpmfH
	 v/2YmMG0wLss09NcFNzOTxEJ1ween2Cmgb8p5F9FPbbMgYZiXQLBasgPvZp+4sD1WJu8A
	 0Ous6cyrvozEwSNT1n5AitMgRp0DpuE67OV9uj+LQc/DEFjWrpTY9K5IBYb3yKShhzQFJ
	 ZqClSkH87lPiqIo5xpKZ6YsV0OLDvqFbDGsaHN6hbvvtJJOQTgKIDyD1JzZOAQAzN1w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795133746;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=5NnsEKZh5J9oPualMt3cBXpMiMJ9/gtv35OevmgsCbc=;
	b=H1UVTea3YWnJyH1Mz/JYu4XHx7tCC2v/nXs0UdFozhH7PsLDEbuKLi1HgkMBKM/X9QPQ
	 SC5tQX7qsaiunK8CZfJ6xBygdEFkx4Ln10nZYEUn7nl39EgrWzRFaBRttTOjyryAH/iYq
	 RM4bajjxka98ErHk2brw6wIsM2hrGj5uEreM3uGCYrJHKzyeJ2swAf90m19a+P5XgIQ4E
	 yDSG7Jc0dTefHt2XGHtOzg9JCY721KBTnrZ3+7oNCxOrnCZvDb5Hv9RiRwiQwJEScp5eB
	 RrjDg3KUVkcLL1AsXGn9A3wbOxmv++kZrf2SS4v+vtBSelc+TwbPTbaCiXqonYD4G3w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Kj4hjFfK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0FF606A320
	for <ecryptfs@vger.kernel.org>; Fri, 20 Nov 2026 00:15:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC0FF606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Kj4hjFfK
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-67c0bd676eeso309037d50.3
        for <ecryptfs@vger.kernel.org>; Thu, 19 Nov 2026 16:15:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795133745; cv=none;
        d=google.com; s=arc-20260327;
        b=SRdYqEGDooocKFtzvzrWDoT92r7W8EfQvLgmN2suKe4BLO+niQ2LozVxdLV/jc45EM
         CprIYCPDFwj25NIItLaiSXAonNnmvEig15jQMiwl+tcSQ9uQZyHju/b0mFngEh5UxCFm
         OB/rYvGTtyc/jvtkj07AhB7WCRHsCeDjv7Pf0EdlR6QtAYS/hidA2ipbglMoTr+J5yxU
         NWvbJnTFwcy788Id86e8tzdIEj4iT3S3Std6ab8QVUMQh/ZrxKZQx6MMPZTur+L5qvNY
         Hpq715SL5cJj1RlJiQTt6BkXCH2uSXp3x51jKR7SKHCmXAGxv/gMbnaDybCil0IWTFE0
         bceg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=5NnsEKZh5J9oPualMt3cBXpMiMJ9/gtv35OevmgsCbc=;
        fh=VZIsjlek2ZNvd+GjJ4kIPtBls8/G+zGcXejeEwKpGYk=;
        b=eZbfDwrLpFRSVP19halfIwio51Y7vJIWF3sa9ZXxtywINqMC3OFoiwOOfF20iiTh8l
         VhIVlAsbWE+PFqP5aVCIzIOcsZjDHOmJzzFI6bqSoNW3GF8ygwMaADkzmEUVeOvcwyce
         tcmqngRbz+Cak5ip92zq6ZVlX90CuRsS7eoo63irJnE6GvThAeQwXvpNjM+1upZBYbrM
         VlDkzcCeHmh1QhlckTk5UVUzV7KpPKTwSV/avE7OdjzdmxuUFuOr32CZiJ8Ovnt/q/L+
         l0O+stIdjMkfoUhBKDbDkA91jGgClgAk35OFO4cwMREjwvme6FeNAzE3TnBqLZgbywCU
         bKNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795133745; x=1795738545; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5NnsEKZh5J9oPualMt3cBXpMiMJ9/gtv35OevmgsCbc=;
        b=Kj4hjFfKWtlyfd2L9n/nVjS09V6tE+JlVHNf1LZAfxSooMx1RJKu9XyfPhsb0ct0mK
         KexmT/on5zUlnb+1jSg6N5hno7uKegtQ5OvMmVjRBciQccq5KFAZz/SOaaA/8Y2wa2KA
         tgN4u1BNA7dUKdsUzmISXR99zSDSBA4gzZIrMkjrWb2XWbuuK6K5ZqtVFazMk/LwiYIp
         dnnB2GYQBJqbAvlbfjZDzDvYu+EuNvRtyjsCu0Z+axBpjEeC+bog2FoGh245JAX+S2Mi
         2Hn3YsHAesmk4Mg89ru2j5jGlcGF/qCSSXEN+z+Nab9GK9HWx09pNSEYonLVJiMFMlQi
         I3Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795133745; x=1795738545;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5NnsEKZh5J9oPualMt3cBXpMiMJ9/gtv35OevmgsCbc=;
        b=TuECVMJOlT90ACb/4W00aSCZaBgse/prJmH3ubyKlPdCFW7UGZD3AM9g3VbGnkEIB9
         zc78bAncxzC/JMdIGIVycwbMuPwyJ48WZdZvDCotcMkRsjQ890KK1trDyBuwfbqVI3ZC
         Jt9VW/0coYFGlf9HzYAVq5hmnc4EZypxpCTXKEr/wJDIbcL9Iqrigdr+l9BsLtGZ6Pu9
         h49pbjyfq1buMbicZNYpVwXLaGRnOMvKxMYKDIUhPkkkLKLcGjGgj4AyCo/d3BdkGiVL
         qEIdfN66+BriUA1S175KzLWd4gqRChafIKzYnT4ODh4N990bJ/FEidJoUr49wUvcezGS
         irag==
X-Gm-Message-State: APuU4Z/l3WEwRfAZNaBgo98iXdq1pTwKvAbqTMbDUw/qTdfaolGV18NP
	EQX7y8R+XwNns7RmHgmt++b+TW2nZJvljd5DNHTw4gPiWfdP1sRN6zvuoztxI0neRfVQclySgFk
	poCirRyCRWdtlWLC1lBScpqTKYLTPgnA=
X-Gm-Gg: AZFdTZe0GD7ZMHt6WQ9pxMiMC5BCHxERrc46pJTbx+90c4ToQqAthj1Ck7NnSrBuPog
	S4uEsMZykKkWrS9tXfyYT+FLL0sX97WxyJKFoK1YUPW4zPmzKCShkE+Vq69FR+/H8aJ3KwRHjAo
	v90+oFd17pPZyFV5Wj7dFtO7qfcIaIXU5aCmnUNE/hwM25SSYP7NNOhRkY0WpF5YbhlY4djHnQU
	rV0oet8x9S/zx1C8K2jAEAk1x6JbVUsQdJDJH5eVae94LYnvXnm7/pA9OImiAnEr7d0Tps08C8J
	dFv/K2pEi2ePAG2MnHe/YzPTgpUTOXBQzDTGKuaTDtsYjQsXdbI2MqGIqi8DItQ+icvlfVwN/xe
	tF8aF0WwWk/p2cbjXkXfA/S+84mdP45opVKl49tgcPmNrpgtpHpk4RZctxZj3tUxmWNbvOA==
X-Received: by 2002:a05:690e:4507:10b0:67d:b449:857e with SMTP id
 956f58d0204a3-67df42d0716mr398478d50.6.1795133744479; Thu, 19 Nov 2026
 16:15:44 -0800 (PST)
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Post: <mailto:ecryptfs@vger.kernel.org>
List-Help: <mailto:ecryptfs+help@vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ecryptfs+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Jyothi Bommisetty <jyothi.b09052007@gmail.com>
Date: Fri, 20 Nov 2026 10:47:38 +0530
X-Gm-Features: AclHuK-zSHJ_pObok_tJ-4Y2XrXTXysJD4sBi2T9xMmKc9gIvRS2ziQuJ6HjFmk
Message-ID: <CAOCJsgwxy9tYUuaP1jjjo=BfiqG-iGfTgL=E3530Oz01MX6jcA@mail.gmail.com>
Subject: [PATCH] ecryptfs: fix use-after-free in mount cleanup
To: code@tyhicks.com
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+baa24e4b7e349e388442@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

When sget_fc() succeeds, it transfers ownership of fc->s_fs_info
to the superblock and clears the filesystem context pointer.

However, ecryptfs_get_tree() retains a local pointer to the same
ecryptfs_sb_info. If super_setup_bdi() fails, deactivate_locked_super()
can destroy the superblock and free this private data.

The subsequent error cleanup then accesses the stale local pointer,
resulting in a use-after-free.

Clear the local sbi pointer immediately after sget_fc() succeeds,
so the error cleanup does not access memory owned and freed by
the superblock. Also remove the redundant call to
ecryptfs_set_superblock_private(), since sget_fc() already assigns
the superblock's private data.

Fixes: 2ccde7c631f9 ("Clean ecryptfs ->get_sb() up")
Reported-by: syzbot+baa24e4b7e349e388442@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=baa24e4b7e349e388442
Signed-off-by: Jyothi Bommisetty <jyothi.b09052007@gmail.com>
---
 fs/ecryptfs/main.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index 5f37cddb9..bfc125462 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -468,14 +468,12 @@ static int ecryptfs_get_tree(struct fs_context *fc)
  goto out;
  }

+ /* sget_fc() transfers ownership of sbi to the superblock */
+ sbi = NULL;
+
  rc = super_setup_bdi(s);
  if (rc)
  goto out1;
-
- ecryptfs_set_superblock_private(s, sbi);
-
- /* ->kill_sb() will take care of sbi after that point */
- sbi = NULL;
  s->s_op = &ecryptfs_sops;
  s->s_xattr = ecryptfs_xattr_handlers;
  set_default_d_op(s, &ecryptfs_dops);
-- 
2.56.0
