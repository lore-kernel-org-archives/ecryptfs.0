Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9605366060
	for <ecryptfs@vger.kernel.org>; Fri, 28 Aug 2026 03:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787887106; cv=pass; b=YUcYbt3+6CaCqJSz1qNyomqZKTtx01C9z3zQlru7pX+u/SBugbE13QM3TCGX3XNGWXAWmWACk7O+zstuyA5m5mqgAnZqbiTMwzRHDNPbz/R3QhcYZu9VVyXeqlEGxzI+jVkMTTp4nDa7jHdUSJI3szwadWONFVLhmaSdUbj6H6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787887106; c=relaxed/simple;
	bh=HQ0WnQR17PYv7KRSkhcEskYCEIEvo6me8U9g6cEGAd4=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=tLPIjaq8GTyWDc9/VgtSOHhbb8gqQfrZ70v7Hxl6DTqqUTmREHDZstxrUNvqzFqNc6af13z59nPdV5rSukGFxi1MtfzJ3ai+5Ik7oaRdVB7PD9u3mT7yWQdTLMoVbl4tG0DqH6avpLouC3PVDO9bFD7cQ/7qG+BxBvvYUlEHBsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=VFH70jzd; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="VFH70jzd"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso6388905ad.3
        for <ecryptfs@vger.kernel.org>; Thu, 27 Aug 2026 20:18:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787887093; cv=none;
        d=google.com; s=arc-20260327;
        b=pHHXUX5iCeHxG+1keNnahQWAkN6AwWFTAnBgvHqbJZU5DWVDW/vXPGEropoc4BLiGo
         rmXbcZ7VCwFXAq4qOD6jiwp83t/I6PxjU117QaOQ/o37+TPw+qytL+/Qk2Acz3qNu2X9
         2ukUWarcV7KfCq22pDThfsnJEKsPdQAabDRFHPEIyXUOQYs/NKh5f9L8Y/sRvfpWIUXc
         ZSk8iKsLlPS7yuwtZ7x7dDfXos14RXAwJHvQKMjbp7KRzAiRPS7CkGn7uP/+jkVQXRcd
         JjnO0mwdSgt05JmC9bAIIbbZXWp2GpmJKQt+RCjzFX9vr/3wTDmXejftj8bIZynXjfeG
         DonQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=M+pcBwoGootdTMgC9yQZBi4o63OAS0ou1pi32Jt08/8=;
        fh=1oawYY5tFFPuzIiVQKvS2SKvor/9zAhUEIaoMr/Yalo=;
        b=f4pPZ+1HsbhTX5dP+OEsOSEgw+DApdHC8Vudz+SaYBd8KeaB0P0K9NaCv7JaikuIRK
         1SOUrw+hl5TElIwgyReCq6NoERlz6r3g6MByq2NBTE/QLMFgKIgeBfMH6NZhWqSvvfdS
         vtxGtbLzVTOoyxUgXMeJgMuXxYcpuFZnrad/D9wtIOUPQ9xUPVUYcAUi3sMiP/Q1X/Ap
         zB+bfTPGFDXg7hraYBTNPbvSzflymG2B96xlXGhspNr2gEDtg/EQ51NX48ufFLQAGYxI
         hCySv/veKoifqP7cnsSP8cV7/u91VxRbz7kaRyWPFfvodQaq6sR0iLaLgENbJY+2aA+6
         ug3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1787887093; x=1788491893; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M+pcBwoGootdTMgC9yQZBi4o63OAS0ou1pi32Jt08/8=;
        b=VFH70jzdqS8zgGI3gE+SQbNwQrRlaT6XDnWXTDnjVih2Yes3iYu0591m2QMX7ypFbx
         fkEynZIAK98WDQXwEP9eAULpnrOYuddPOuzOvUc7HbdbJXoP0mjN56Ct/Po0dVS1kCSu
         cQLf4GJ2Z1EDplwj6fU/SUN1dGTwRC9PNatRN7iyXwaEEz83o3sS0eqIyqEtB/dJRY5P
         ss9Q/c+HygNlfNb9hygwuoTCZcwqWzwWz7xEAgAf8f46Q2nHtCXsL43hEeKG49XAVxtn
         RulZNEg776bCrxlH0O+L5EB59YHxm/QIwPc8w7f5m8lu6eEgz1STCp0v+z3a6Ab62YBb
         PVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787887093; x=1788491893;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=M+pcBwoGootdTMgC9yQZBi4o63OAS0ou1pi32Jt08/8=;
        b=sOBr7sb24JZvA63Q7OkJrhopaRZSuSxygDuFBEl9qMwI6lNY7FwajdMNZtR7iR5XfC
         m6RtdR/yaSauIHDb7035B/dndPatZlzGH64f58wkiaLQ491AXUGlNB1+s1QJZcEyvyCP
         vchx4OT80uesfntxjpkXEXBA6Wm+dsxVMW1VYOKgnQhqyaFSxFCQEFm5lpvYH8Eq7ARf
         iiOzde6EahEPPRLGN0Z8ygZaYO+ZJ3v6889B7OBi9ugXx+tGClZAeBfHK424QpzGboZY
         ufemVPsi1MCOzWBmouYQ0BizjAhftWdrnaAct86YNxrCGk0ACmznKN/Ji8BNv/+oO3Jt
         5/Iw==
X-Forwarded-Encrypted: i=1; AHgh+Rq4P5rEc/147B0sBG+R566frEYQ4D4/FGqhk9m9ItdrQtNr4rIsfsc2QbqivyBz9P7wUq97S4QNTA==@vger.kernel.org
X-Gm-Message-State: AFuF++mj13kTXnPbCyLE+Dm2xHUqpO3w3D1fFq9y3ZN/N7u64xignUac
	XySuhl8Ni+XydT/0sZkAhytBO0VXMSRLCHkPZjik1W6PyEM1UherxLTdG0s0mpTt7Xf+ecDcG7b
	HfsTsqnzsjExDw2aa+VxaD0jviKmgXuwIdc/GXJ5R
X-Gm-Gg: AR+sD11hGgmQM7dfPFZ/j7rx4kx/9pmK/h3vSO9otFg7gGZeSOM42yFCX1Gpq5d5PuS
	ZgNwe7rLUhjhuW+8PXDBnYKn+82+xglXBYaudJOQtuEi9P2sEOYfovMuMxRdq6FnMs0iPlnXcbL
	5BN6tHuhu4Bli5yyvgeH1PPBrJOa+lBwm0W9ex/gWh7RaurQI/8vBTZRvbtmrZW2uov+arYqGSe
	R8Tf/iQNedoLebKVkkQcqM/ozasZb2HwKgfvq4ErC5ZSMDV6lUxfgx7sJd4j3oXj3a2DbOB7pBo
	LgllPMPZm05jSOL3L+bEVhGQrCT16uQR6NHCcAQQ4/qOoUfXW7VDi0XbkyGvr+vLE/WFKBN8O9U
	uXjP0ev5HaFrpJ07L07ycXevatVt1UHkd
X-Received: by 2002:a17:903:1a2b:b0:2d7:11d2:1455 with SMTP id
 d9443c01a7336-2d74ddbe12dmr74674295ad.4.1787887092175; Thu, 27 Aug 2026
 20:18:12 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 20:18:11 -0700
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 20:18:11 -0700
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 27 Aug 2026 20:18:11 -0700
X-Gm-Features: AcwNN1VRnFOVAUc9Rv-gIKBNA-JVvlf1956tLSNytGprkbdWOWJLg0Y8x5Gg6po
Message-ID: <CA+0ovCgYP920GT68hAJK6Trjyv1kGv2dZAuem4LEunycQ=POww@mail.gmail.com>
Subject: [BUG] ecryptfs leaks an inode on lookup failure -> kernel BUG in generic_shutdown_super()
To: Tyler Hicks <code@tyhicks.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>
Cc: falemi@asu.edu, ecryptfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

As part of the kernel research at ASU's SEFCOM
lab, we hit the crash below. Crash reports can be found here:

  https://github.com/farhad-alemi/public_bug_reports/tree/main/128-ecryptfs-i_new-inode-leak-lookup-failure/

  ecryptfs_i_size_read: Error attempting to initialize the lower file
for the dentry with name [victim]; rc = [-26]
  VFS: Busy inodes after unmount of ecryptfs (ecryptfs)
  kernel BUG at fs/super.c:779!
  Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
  Call Trace:
   kill_anon_super+0x3b/0x70
   ecryptfs_kill_block_super+0x44/0xa0
   deactivate_locked_super+0xbc/0x110
   cleanup_mnt+0x437/0x4d0
   task_work_run+0x1d9/0x270
   exit_to_user_mode_loop+0x14e/0x540
   do_syscall_64+0x317/0x510
  Kernel panic - not syncing: Fatal exception

Our reproducer.c is available upon request.

Happy to test a patch if that would help.

Regards,
