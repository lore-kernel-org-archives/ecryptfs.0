Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2521D4A99B2
	for <ecryptfs@vger.kernel.org>; Fri, 11 Sep 2026 17:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789147591; cv=pass; b=JwzOCI950vt4kjFzhulXzF3+IMdrvMPdBwMA5OdkkW7rQ6p1J8V9KHaf8Il+kH/dHN5g/c5B65s+5NEDcpwWwyfKbVnijO3Ox2DZMJk/dkugTpWgBoC17YtZGR4lDpgvcWLiJM5+mEQSNZDH5jaFfgMWu/DbVIzgthezLSGWtPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789147591; c=relaxed/simple;
	bh=ldK747M23rZ7cFFezZj7AC14RnZIeg8h4Sw0nTwsO34=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Vfqi5SpgpYFb99k7mmXwy8dqb2PshGtiuep3n/FVjvss8JithWuqwc6VccyyJY+ZKXxXhwTZmKVAPhJdWHUXt0pcfuHQehPeP2GYHlC7aJW+FJjUTtlYmuRB1VJLw8z7iw4OBPyPMdCGD9+Kq29cP81op6TVE9KxaW9at4l313o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=tnBmjNN4; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="tnBmjNN4"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2caced6038eso12799515ad.0
        for <ecryptfs@vger.kernel.org>; Fri, 11 Sep 2026 10:26:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789147588; cv=none;
        d=google.com; s=arc-20260327;
        b=ZqAexsayx6KQKYpR3FGL3NqOH3zyzanCUnaBEhynfciHg2MUoBkNx3m8WrP+g8CJ3b
         CQ3RpQqFgnmZN0es6ANd4GOOzrVpcQNkLL16LeDVcgzrD6+qfb6Gf4nkIla37EA54DwY
         bVQVhqi6OudesVJ5qiRPsmAdTEi/Yp8d78VfpAr6E0FD0NL7EDHu7CZtI01Q4NhZyfLu
         EJnb7RfQNXe80l/iB97nVBs8oeSJRBYi7RaPPds50eU7E7fx42wkMq2F7Y5tAai+lwFX
         IIUUT/SsW762HuLR+9gJeeFjVd2SXa2ztA/meCyh09y9Q6OvAKAnFXm7t4h+n6t7Qylf
         fVgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=WiUI+dtIbkbreqYjSYP1GnxpMhwj7Yq7zlTjSbDgQYg=;
        fh=ALhIxoubzPUnReVrmjH2BOMIXiFLDCygV7S/eIjdxTQ=;
        b=QU4HPiBguvAEKrKiWb4Z3jDNvLst0JWEYy3L0yVIh7Ck1bsaeMbRPqxzFaCubqmCcf
         A+CHd7c3pa3sPMo9eoGEKjjGs4UoEXVOdOO+EGQMGbdVzu99aCblId99YC4ySElyejUW
         sxDvfGOBNCR1YFnDyq+udfdxOpVxBXKpWmxLa8AevUGYpdDdLK+a7Fd/ks2+aO9FpLyJ
         vjt6GSOWiytmZihbioIhryyjY2QjAU9uelXLGxi++73DlpiyIeKyE/KZiwEwKIkOBSlv
         TAMFgSg2+EzpCmBNroMEkQJydAlC0rYkGoHPQrU1HvMwq8q/e1FIuxzWQQlBefTpkNrN
         xX0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1789147588; x=1789752388; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WiUI+dtIbkbreqYjSYP1GnxpMhwj7Yq7zlTjSbDgQYg=;
        b=tnBmjNN4cIuL2mucMnsBKkP9phy38Hy/dFHruX1jBIDotYZk1GkI9Rwedn1G08FKo5
         83fVCvEgSuwjFUoIy5R3zh4XoZx7tLuDEx2AuzDIljt3qZqfHAVFAD82HiVijSufPSVM
         Xz/WYseWyWKgYRHj6I2PR2cpuCedrP3aT3s8Z4jbU945G0z9NcRApgxwzc7cS2hoqCld
         rjJD/4GFK3M+mOo8e4ebAY5vtNx78TITBcfSa8CfZ+usg83OeJ2LaEEcwcfKEQA7+tum
         fRg6+ogSVJaawV11Perl7L/QZaRn9sToizJ3EbugXXgiH5T9JD9H180cbvAtOWg8DsSi
         x18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789147588; x=1789752388;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WiUI+dtIbkbreqYjSYP1GnxpMhwj7Yq7zlTjSbDgQYg=;
        b=nh8TUOK04wnkzRSPk1ISadv2vtWrcc90zKt0DxNB2+mIjMuXN6Rf1MntkE7cmgzlhF
         dswFFL8Ug3lXmu09woWkkijvPRje9b/gsuIncZb1ZkFwU4K+3WwFhCWXgYHdT2xndewf
         D+3iyr90mGt72Ex+R8clCm8axVz0c/E+CzdufzBgon7V3lkbt3hfLFcg6Ise2+5yGoiw
         xnyqcMsP4YNCwyCMQxQEG+pf+vDlJRadBCpELKtyAcBMhCQhRoFE120DmzZYKHvNmf/1
         mCXBUCz1wOv4ut0KYxTuGnksx5rEJ1mQvsD9z6tvPbvs6c0ikbi0WR2RF7HqwDzZk6GG
         k+8g==
X-Gm-Message-State: AFuF++krnPIHFclSVdwmEUwubWI/yedpbjbBcqEPf8N96YygnF2T2Ib5
	ahDeg7tUsbWlfPe1l9VQlkIEUn8Xoa5YTRlHV2NYMPirN9kT2ApEUi8hiLHQ7Mgy3OloT/Zw+Ar
	QGLCriulQJxbSINudSvo3htC4Bby5j8kaOpPh+yoT
X-Gm-Gg: AYBFou1ovsvmL2TN3CXIvSyEPU+qzMJPAxx1N920GcwZ0n+N0lkNhGOCUDjXZf+Qz57
	u/DyRd9hxV7u6SXxPT9g+ptU5DxNKs/402mTUO+bTQTKpgUvMCd2PD6TAuLcY451yudnMQtXmPB
	eE3I724hrCtdFC9vtAg8qDruvxVoSjcZSsIMYNRbd5CEZtd2lgnHqjUgGx3bYPnzhXeftzUh8HM
	XpX5X/SadxhTaNtsW32C8i9K5a6jUSnMhFjpXgepkhg/yyw/VsV6sdzs4ur3ql24zGGayvi3gfM
	tVYV3fjaTBYlBAFFdCRlhbjMjctyqPDUtJvFyoaLO7cAGEGvvbgNGSBoSagtVXvUTfafzhpNc8J
	Fu5d5tw92novy0wbch/llQL7CKPdemPWRb/tV3+WbbTFnKOGg67hwkt+bJ1RLATieFHjY8awttg
	U=
X-Received: by 2002:a17:902:e74d:b0:2d7:1b20:e98f with SMTP id
 d9443c01a7336-2dd0e8a1969mr113067365ad.2.1789147587046; Fri, 11 Sep 2026
 10:26:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Farhad Alemi <farhad.alemi@berkeley.edu>
Date: Fri, 11 Sep 2026 10:26:14 -0700
X-Gm-Features: AcwNN1XeYjwEakd3cH7YjHrh3teBDKt0oBkQWeAVJuit5A83RflHWzoIHOSM8CM
Message-ID: <CA+0ovCjUMiroAcGE7bBQk3c0ith_s8OBc=zu50hcVbiLd2aKwQ@mail.gmail.com>
Subject: [BUG] KASAN: slab-use-after-free Read in ecryptfs_destroy_mount_crypt_stat
To: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000616b52065b3862c9"

--000000000000616b52065b3862c9
Content-Type: text/plain; charset="UTF-8"

Hello,

We are reporting the following crash (reproducer attached):
Linux version 7.3.0-rc2 50d05c7c76c96b90462f24debacca971d2e86713
Build Config: UpstreamAppArmorKASAN (KASAN + UBSAN, panic_on_warn=1)

[   43.958731][ T9497] BUG: KASAN: slab-use-after-free in
ecryptfs_destroy_mount_crypt_stat+0x2f0/0x300
[   43.958743][ T9497] Read of size 4 at addr ffff88802bed3b10 by task
repro/9497
[   43.958748][ T9497]
[   43.958752][ T9497] CPU: 0 UID: 0 PID: 9497 Comm: repro Not tainted
7.3.0-rc2-00099-g50d05c7c76c9 #1 PREEMPT(full)
[   43.958759][ T9497] Hardware name: QEMU Standard PC (Q35 + ICH9,
2009), BIOS 1.17.0-debian-1.17.0-1ubuntu1 04/01/2014
[   43.958763][ T9497] Call Trace:
[   43.958766][ T9497]  <TASK>
[   43.958768][ T9497]  dump_stack_lvl+0xe8/0x150
[   43.958776][ T9497]  print_address_description+0x55/0x1e0
[   43.958783][ T9497]  ? ecryptfs_destroy_mount_crypt_stat+0x2f0/0x300
[   43.958792][ T9497]  print_report+0x58/0x70
[   43.958798][ T9497]  kasan_report+0x117/0x150
[   43.958809][ T9497]  ? ecryptfs_destroy_mount_crypt_stat+0x2f0/0x300
[   43.958819][ T9497]  ecryptfs_destroy_mount_crypt_stat+0x2f0/0x300
[   43.958829][ T9497]  ecryptfs_get_tree+0xda7/0x1370
[   43.958838][ T9497]  ? __pfx_ecryptfs_get_tree+0x10/0x10
[   43.958847][ T9497]  vfs_get_tree+0x92/0x2a0
[   43.958855][ T9497]  do_new_mount+0x341/0xd30
[   43.958861][ T9497]  ? apparmor_capable+0x126/0x170
[   43.958869][ T9497]  ? __pfx_do_new_mount+0x10/0x10
[   43.958875][ T9497]  ? ns_capable+0x89/0xe0
[   43.958882][ T9497]  ? user_path_at+0xd4/0x160
[   43.958889][ T9497]  __se_sys_mount+0x31d/0x420
[   43.958896][ T9497]  ? __pfx___se_sys_mount+0x10/0x10
[   43.958903][ T9497]  ? __x64_sys_mount+0x20/0xc0
[   43.958910][ T9497]  do_syscall_64+0x155/0x510
[   43.958919][ T9497]  ? trace_irq_disable+0x3b/0x140
[   43.958927][ T9497]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   43.958933][ T9497]  ? clear_bhb_loop+0x30/0x80
[   43.958940][ T9497]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   43.958946][ T9497] RIP: 0033:0x412c9e
[   43.958952][ T9497] Code: 0f 1f 40 00 48 c7 c2 f0 ff ff ff f7 d8 64
89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 49 89 ca b8 a5
00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 f0 ff ff ff f7 d8
64 89 01 48
[   43.958957][ T9497] RSP: 002b:00007fff96e11b18 EFLAGS: 00000203
ORIG_RAX: 00000000000000a5
[   43.958964][ T9497] RAX: ffffffffffffffda RBX: 0000000000000001
RCX: 0000000000412c9e
[   43.958969][ T9497] RDX: 00000000004860fb RSI: 0000000000486071
RDI: 0000000000486068
[   43.958973][ T9497] RBP: 00007fff96e11e40 R08: 0000000000486020
R09: 0000000000000000
[   43.958977][ T9497] R10: 0000000000000000 R11: 0000000000000203
R12: 00007fff96e11f68
[   43.958982][ T9497] R13: 00007fff96e11f78 R14: 0000000000000002
R15: 00000000004ac140
[   43.958988][ T9497]  </TASK>
[   43.958991][ T9497]
[   43.958994][ T9497] Allocated by task 9497:
[   43.958997][ T9497]  kasan_save_track+0x3e/0x80
[   43.959005][ T9497]  __kasan_slab_alloc+0x6c/0x80
[   43.959012][ T9497]  kmem_cache_alloc_noprof+0x2bd/0x610
[   43.959019][ T9497]  ecryptfs_init_fs_context+0x70/0x1b0
[   43.959026][ T9497]  alloc_fs_context+0x9d5/0xd50
[   43.959033][ T9497]  do_new_mount+0x187/0xd30
[   43.959037][ T9497]  __se_sys_mount+0x31d/0x420
[   43.959043][ T9497]  do_syscall_64+0x155/0x510
[   43.959051][ T9497]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   43.959056][ T9497]
[   43.959058][ T9497] Freed by task 9497:
[   43.959061][ T9497]  kasan_save_track+0x3e/0x80
[   43.959068][ T9497]  kasan_save_free_info+0x46/0x50
[   43.959073][ T9497]  __kasan_slab_free+0x5c/0x80
[   43.959081][ T9497]  kmem_cache_free+0x182/0x650
[   43.959088][ T9497]  deactivate_locked_super+0xbc/0x110
[   43.959093][ T9497]  ecryptfs_get_tree+0x1013/0x1370
[   43.959100][ T9497]  vfs_get_tree+0x92/0x2a0
[   43.959106][ T9497]  do_new_mount+0x341/0xd30
[   43.959111][ T9497]  __se_sys_mount+0x31d/0x420
[   43.959117][ T9497]  do_syscall_64+0x155/0x510
[   43.959125][ T9497]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   43.959130][ T9497]
[   43.959132][ T9497] The buggy address belongs to the object at
ffff88802bed3b00
[   43.959132][ T9497]  which belongs to the cache ecryptfs_sb_cache of size 280
[   43.959139][ T9497] The buggy address is located 16 bytes inside of
[   43.959139][ T9497]  freed 280-byte region [ffff88802bed3b00,
ffff88802bed3c18)
[   43.959146][ T9497]
[   43.959148][ T9497] The buggy address belongs to the physical page:
[   43.959155][ T9497] page: refcount:0 mapcount:0
mapping:0000000000000000 index:0x0 pfn:0x2bed2
[   43.959162][ T9497] head: order:1 mapcount:0 entire_mapcount:0
nr_pages_mapped:0 pincount:0
[   43.959167][ T9497] flags:
0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
[   43.959178][ T9497] page_type: f5(slab)
[   43.959186][ T9497] raw: 00fff00000000040 ffff888105d93280
dead000000000100 dead000000000122
[   43.959192][ T9497] raw: 0000000000000000 0000000200150015
00000000f5000000 0000000000000000
[   43.959198][ T9497] head: 00fff00000000040 ffff888105d93280
dead000000000100 dead000000000122
[   43.959203][ T9497] head: 0000000000000000 0000000200150015
00000000f5000000 0000000000000000
[   43.959208][ T9497] head: 00fff00000000001 ffffffffffffff81
00000000ffffffff 00000000ffffffff
[   43.959214][ T9497] head: ffffffffffffffff 0000000000000000
00000000ffffffff 0000000000000002
[   43.959217][ T9497] page dumped because: kasan: bad access detected
[   43.959222][ T9497] page_owner tracks the page as allocated
[   43.959224][ T9497] page last allocated via order 1, migratetype
Unmovable, gfp_mask
0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC),
pid 9497, tgid 9497 (repro), ts 43923897227
[   43.959235][ T9497]  post_alloc_hook+0x1f9/0x250
[   43.959242][ T9497]  get_page_from_freelist+0x235a/0x23e0
[   43.959250][ T9497]  __alloc_frozen_pages_noprof+0x217/0x5a0
[   43.959257][ T9497]  alloc_pages_mpol+0x241/0x4a0
[   43.959267][ T9497]  allocate_slab+0x89/0x610
[   43.959272][ T9497]  ___slab_alloc+0x165/0x960
[   43.959280][ T9497]  kmem_cache_alloc_noprof+0x142/0x610
[   43.959292][ T9497]  ecryptfs_init_fs_context+0x70/0x1b0
[   43.959299][ T9497]  alloc_fs_context+0x9d5/0xd50
[   43.959305][ T9497]  do_new_mount+0x187/0xd30
[   43.959310][ T9497]  __se_sys_mount+0x31d/0x420
[   43.959315][ T9497]  do_syscall_64+0x155/0x510
[   43.959324][ T9497]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   43.959330][ T9497] page last free pid 15 tgid 15 ts 43909882275 stack trace:
[   43.959334][ T9497]  __free_frozen_pages+0xc9f/0xd90
[   43.959341][ T9497]  rcu_core+0x985/0x1250
[   43.959349][ T9497]  handle_softirqs+0x22c/0x860
[   43.959355][ T9497]  run_ksoftirqd+0x36/0x60
[   43.959361][ T9497]  smpboot_thread_fn+0x562/0xa60
[   43.959367][ T9497]  kthread+0x38b/0x480
[   43.959375][ T9497]  ret_from_fork+0x514/0xb70
[   43.959382][ T9497]  ret_from_fork_asm+0x1a/0x30
[   43.959389][ T9497]
[   43.959391][ T9497] Memory state around the buggy address:
[   43.959394][ T9497]  ffff88802bed3a00: fc fc fc fc fc fc fc fc fc
fc fc fc fc fc fc fc
[   43.959398][ T9497]  ffff88802bed3a80: fc fc fc fc fc fc fc fc fc
fc fc fc fc fc fc fc
[   43.959403][ T9497] >ffff88802bed3b00: fa fb fb fb fb fb fb fb fb
fb fb fb fb fb fb fb
[   43.959406][ T9497]                          ^
[   43.959409][ T9497]  ffff88802bed3b80: fb fb fb fb fb fb fb fb fb
fb fb fb fb fb fb fb
[   43.959413][ T9497]  ffff88802bed3c00: fb fb fb fc fc fc fc fc fc
fc fc fc fc fc fc fc
[   43.959416][ T9497]
==================================================================
[   43.959424][ T9497] Kernel panic - not syncing: KASAN: panic_on_warn set ...
[   44.428268][ T9497] CPU: 0 UID: 0 PID: 9497 Comm: repro Not tainted
7.3.0-rc2-00099-g50d05c7c76c9 #1 PREEMPT(full)
[   44.429202][ T9497] Hardware name: QEMU Standard PC (Q35 + ICH9,
2009), BIOS 1.17.0-debian-1.17.0-1ubuntu1 04/01/2014
[   44.430148][ T9497] Call Trace:
[   44.430455][ T9497]  <TASK>
[   44.430726][ T9497]  vpanic+0x56d/0xa60
[   44.431095][ T9497]  ? __pfx_vpanic+0x10/0x10
[   44.431541][ T9497]  panic+0xc5/0xd0
[   44.431884][ T9497]  ? __pfx_panic+0x10/0x10
[   44.432313][ T9497]  ? ecryptfs_destroy_mount_crypt_stat+0x2f0/0x300
[   44.432897][ T9497]  ? ecryptfs_destroy_mount_crypt_stat+0x2f0/0x300
[   44.433485][ T9497]  ? ecryptfs_destroy_mount_crypt_stat+0x2f0/0x300
[   44.434068][ T9497]  ? ecryptfs_destroy_mount_crypt_stat+0x2f0/0x300
[   44.434655][ T9497]  check_panic_on_warn+0x89/0xb0
[   44.435105][ T9497]  ? ecryptfs_destroy_mount_crypt_stat+0x2f0/0x300
[   44.435691][ T9497]  end_report+0x73/0x170
[   44.436080][ T9497]  ? ecryptfs_destroy_mount_crypt_stat+0x2f0/0x300
[   44.436667][ T9497]  kasan_report+0x128/0x150
[   44.437081][ T9497]  ? ecryptfs_destroy_mount_crypt_stat+0x2f0/0x300
[   44.437669][ T9497]  ecryptfs_destroy_mount_crypt_stat+0x2f0/0x300
[   44.438240][ T9497]  ecryptfs_get_tree+0xda7/0x1370
[   44.438702][ T9497]  ? __pfx_ecryptfs_get_tree+0x10/0x10
[   44.439195][ T9497]  vfs_get_tree+0x92/0x2a0
[   44.439640][ T9497]  do_new_mount+0x341/0xd30
[   44.440073][ T9497]  ? apparmor_capable+0x126/0x170
[   44.440559][ T9497]  ? __pfx_do_new_mount+0x10/0x10
[   44.441026][ T9497]  ? ns_capable+0x89/0xe0
[   44.441424][ T9497]  ? user_path_at+0xd4/0x160
[   44.441848][ T9497]  __se_sys_mount+0x31d/0x420
[   44.442297][ T9497]  ? __pfx___se_sys_mount+0x10/0x10
[   44.442768][ T9497]  ? __x64_sys_mount+0x20/0xc0
[   44.443203][ T9497]  do_syscall_64+0x155/0x510
[   44.443630][ T9497]  ? trace_irq_disable+0x3b/0x140
[   44.444087][ T9497]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   44.444636][ T9497]  ? clear_bhb_loop+0x30/0x80
[   44.445064][ T9497]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   44.445600][ T9497] RIP: 0033:0x412c9e
[   44.445958][ T9497] Code: 0f 1f 40 00 48 c7 c2 f0 ff ff ff f7 d8 64
89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 49 89 ca b8 a5
00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 f0 ff ff ff f7 d8
64 89 01 48
[   44.447670][ T9497] RSP: 002b:00007fff96e11b18 EFLAGS: 00000203
ORIG_RAX: 00000000000000a5
[   44.448421][ T9497] RAX: ffffffffffffffda RBX: 0000000000000001
RCX: 0000000000412c9e
[   44.449125][ T9497] RDX: 00000000004860fb RSI: 0000000000486071
RDI: 0000000000486068
[   44.449833][ T9497] RBP: 00007fff96e11e40 R08: 0000000000486020
R09: 0000000000000000
[   44.450542][ T9497] R10: 0000000000000000 R11: 0000000000000203
R12: 00007fff96e11f68
[   44.451247][ T9497] R13: 00007fff96e11f78 R14: 0000000000000002
R15: 00000000004ac140
[   44.451958][ T9497]  </TASK>
[   44.452533][ T9497] Kernel Offset: disabled
[   44.453078][ T9497] Rebooting in 86400 seconds..

Regards,

--000000000000616b52065b3862c9
Content-Type: application/octet-stream; name="reproducer.c"
Content-Disposition: attachment; filename="reproducer.c"
Content-Transfer-Encoding: base64
Content-ID: <f_mtx845sf0>
X-Attachment-Id: f_mtx845sf0

LyoKICogMjY1LWthc2FuLXNsYWItdXNlLWFmdGVyLWZyZWUtcmVhZC1pbi1lY3J5cHRmcy1kZXN0
cm95LW1vdW50LWNyeXB0LXN0YXQKICovCiNkZWZpbmUgX0dOVV9TT1VSQ0UKI2luY2x1ZGUgPGZj
bnRsLmg+CiNpbmNsdWRlIDxzdGRpby5oPgojaW5jbHVkZSA8c3RyaW5nLmg+CiNpbmNsdWRlIDxz
eXMvbW91bnQuaD4KI2luY2x1ZGUgPHN5cy9zdGF0Lmg+CiNpbmNsdWRlIDxzeXMvc3lzY2FsbC5o
PgojaW5jbHVkZSA8dW5pc3RkLmg+CgojZGVmaW5lIEVDUllQVEZTX01BWF9FTkNSWVBURURfS0VZ
X0JZVEVTIDUxMgojZGVmaW5lIEVDUllQVEZTX01BWF9LRVlfQllURVMgNjQKI2RlZmluZSBFQ1JZ
UFRGU19TSUdfU0laRV9IRVggMTYKI2RlZmluZSBFQ1JZUFRGU19TQUxUX1NJWkUgOAoKc3RydWN0
IGVjcnlwdGZzX3Nlc3Npb25fa2V5IHsKCXVuc2lnbmVkIGludCBmbGFnczsKCXVuc2lnbmVkIGlu
dCBlbmNyeXB0ZWRfa2V5X3NpemU7Cgl1bnNpZ25lZCBpbnQgZGVjcnlwdGVkX2tleV9zaXplOwoJ
dW5zaWduZWQgY2hhciBlbmNyeXB0ZWRfa2V5W0VDUllQVEZTX01BWF9FTkNSWVBURURfS0VZX0JZ
VEVTXTsKCXVuc2lnbmVkIGNoYXIgZGVjcnlwdGVkX2tleVtFQ1JZUFRGU19NQVhfS0VZX0JZVEVT
XTsKfTsKCnN0cnVjdCBlY3J5cHRmc19wYXNzd29yZCB7Cgl1bnNpZ25lZCBpbnQgcGFzc3dvcmRf
Ynl0ZXM7CglpbnQgaGFzaF9hbGdvOwoJdW5zaWduZWQgaW50IGhhc2hfaXRlcmF0aW9uczsKCXVu
c2lnbmVkIGludCBzZXNzaW9uX2tleV9lbmNyeXB0aW9uX2tleV9ieXRlczsKCXVuc2lnbmVkIGlu
dCBmbGFnczsKCXVuc2lnbmVkIGNoYXIgc2Vzc2lvbl9rZXlfZW5jcnlwdGlvbl9rZXlbRUNSWVBU
RlNfTUFYX0tFWV9CWVRFU107Cgl1bnNpZ25lZCBjaGFyIHNpZ25hdHVyZVtFQ1JZUFRGU19TSUdf
U0laRV9IRVggKyAxXTsKCXVuc2lnbmVkIGNoYXIgc2FsdFtFQ1JZUFRGU19TQUxUX1NJWkVdOwp9
OwoKc3RydWN0IGVjcnlwdGZzX2F1dGhfdG9rIHsKCXVuc2lnbmVkIHNob3J0IHZlcnNpb247Cgl1
bnNpZ25lZCBzaG9ydCB0b2tlbl90eXBlOwoJdW5zaWduZWQgaW50IGZsYWdzOwoJc3RydWN0IGVj
cnlwdGZzX3Nlc3Npb25fa2V5IHNlc3Npb25fa2V5OwoJdW5zaWduZWQgY2hhciByZXNlcnZlZFsz
Ml07CglzdHJ1Y3QgZWNyeXB0ZnNfcGFzc3dvcmQgcGFzc3dvcmQ7Cn0gX19hdHRyaWJ1dGVfXygo
cGFja2VkKSk7CgojZGVmaW5lIEVDUllQVEZTX1ZFUlNJT05fTUFKT1JfTUlOT1IgMHgwMDA0CiNk
ZWZpbmUgRUNSWVBURlNfUEFTU1dPUkQgMAojZGVmaW5lIEtFWV9TUEVDX1NFU1NJT05fS0VZUklO
RyAoLTMpCgojZGVmaW5lIEFVVEhfVE9LX1NJRyAiMDEyMzQ1Njc4OWFiY2RlZiIKc3RhdGljIGNv
bnN0IGNoYXIgZWNyeXB0ZnNfbW91bnRfb3B0aW9uc1tdID0KCSJlY3J5cHRmc19zaWc9IiBBVVRI
X1RPS19TSUcgIixlY3J5cHRmc19jaXBoZXI9YWVzLGVjcnlwdGZzX2tleV9ieXRlcz0xNiI7Cgoj
ZGVmaW5lIE1BWF9GQUlMU0xBQl9OVEggOTYKCmludCBtYWluKHZvaWQpCnsKCXN0cnVjdCBlY3J5
cHRmc19hdXRoX3RvayBhdXRoX3RvazsKCWludCBmYWlsc2xhYl9mZCwgZmFpbF9udGhfZmQsIG50
aDsKCglta2RpcigiL3RtcC9zcmMiLCAwNzc3KTsKCW1rZGlyKCIvdG1wL2RzdCIsIDA3NzcpOwoK
CW1lbXNldCgmYXV0aF90b2ssIDAsIHNpemVvZihhdXRoX3RvaykpOwoJYXV0aF90b2sudmVyc2lv
biA9IEVDUllQVEZTX1ZFUlNJT05fTUFKT1JfTUlOT1I7CglhdXRoX3Rvay50b2tlbl90eXBlID0g
RUNSWVBURlNfUEFTU1dPUkQ7CglzeXNjYWxsKFNZU19hZGRfa2V5LCAidXNlciIsIEFVVEhfVE9L
X1NJRywgJmF1dGhfdG9rLCBzaXplb2YoYXV0aF90b2spLAoJCShsb25nKUtFWV9TUEVDX1NFU1NJ
T05fS0VZUklORyk7CgoJbW91bnQoIm5vbmUiLCAiL3N5cy9rZXJuZWwvZGVidWciLCAiZGVidWdm
cyIsIDAsIE5VTEwpOwoKCWZhaWxzbGFiX2ZkID0gb3BlbigiL3N5cy9rZXJuZWwvZGVidWcvZmFp
bHNsYWIvaWdub3JlLWdmcC13YWl0IiwgT19XUk9OTFkpOwoJd3JpdGUoZmFpbHNsYWJfZmQsICJO
IiwgMSk7CgljbG9zZShmYWlsc2xhYl9mZCk7CgoJZmFpbF9udGhfZmQgPSBvcGVuKCIvcHJvYy90
aHJlYWQtc2VsZi9mYWlsLW50aCIsIE9fV1JPTkxZKTsKCglmb3IgKG50aCA9IDE7IG50aCA8PSBN
QVhfRkFJTFNMQUJfTlRIOyBudGgrKykgewoJCWNoYXIgbnRoX3RleHRbMTZdOwoJCWludCBtb3Vu
dF9yYzsKCgkJc25wcmludGYobnRoX3RleHQsIHNpemVvZihudGhfdGV4dCksICIlZCIsIG50aCk7
CgkJd3JpdGUoZmFpbF9udGhfZmQsIG50aF90ZXh0LCBzdHJsZW4obnRoX3RleHQpKTsKCgkJbW91
bnRfcmMgPSBtb3VudCgiL3RtcC9zcmMiLCAiL3RtcC9kc3QiLCAiZWNyeXB0ZnMiLCAwLAoJCQkJ
IGVjcnlwdGZzX21vdW50X29wdGlvbnMpOwoKCQl3cml0ZShmYWlsX250aF9mZCwgIjAiLCAxKTsK
CQlpZiAobW91bnRfcmMgPT0gMCkKCQkJdW1vdW50MigiL3RtcC9kc3QiLCBNTlRfREVUQUNIKTsK
CX0KCXJldHVybiAwOwp9Cg==
--000000000000616b52065b3862c9--
