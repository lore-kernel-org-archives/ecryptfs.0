Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C843C9890
	for <ecryptfs@vger.kernel.org>; Thu,  1 Oct 2026 23:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790897375; cv=none; b=PXw9qyJ7vl4G/IG700Hh3s+d/99h66XRuVEzGD80Rh5YwZtgiHrM9oBxUFvm95mTCvo1GqyUtZU69WGe30X2LnGpmcb61QA8e1cG7Mr0zCylZLMlSRhfMsVUteT+dMtpjaT1l3L0ILVvtEiTUJspBG1UpAUjeefbVf+ZX7iEC8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790897375; c=relaxed/simple;
	bh=lulebXRJYgCMf2sepGhL7uwJpGuNxICxTGjtx3e9IlI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rDZEVJi3HoH8T8/IJivO8ZuIlzxBCp120Cy4K45T5sqXAV1Oe3XEKcY/VGaTdPdBe6TFrqPKPnYjW2CR5M7MTtzrNrQ9PHqUFyzMvwKJ8QumM+oQRJeur+LvnEo+ilKvUHn/4aHl+Qy3AoEj7CG9OQoRSBVPa5DaksT9saKShkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4b28d7ffab1so2231227b6e.1
        for <ecryptfs@vger.kernel.org>; Thu, 01 Oct 2026 16:29:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790897372; x=1791502172;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jm8A7dbfF6HWsE7A81+LRliaab1wzvv5kbVtrXeQkyk=;
        b=daVu5k1hDT0322MwSzeKe1g4VsC6xHSVTdOV9RW9i+bOkO98Jb22zUr+KJ8zs8r5Vb
         dkddMZm4wuHOLF5wqWwCZEMJuvEfmXJnGE5fxxvgqyPRE8Z9lkP3pArx7hUh9XpMBVhB
         WzRBMIsGNdE9HfglGcWDeqLoEDsR6PRklHS6dr5CloeB6HvEnt/bUHQJPFMrv2NPxjtM
         zWU+wMzce4Zv8qD3U5vTW00qNPiS9UOIbZKLIw/ZnWkOLrp2Xa0SrpQn5wl0TUgoIiYW
         PsFd+4wIywG3pZEZY8eJ4DMab8w4hu4KPXSeUImW//eejvX2umUGeanVL6xPh0zOQK4W
         //tw==
X-Forwarded-Encrypted: i=1; AKwUvBym9tADRj5GUIuoLGIBguQ57lqDVi8a1ETZr4+RnCJzuiogx+lmMWO/9+JD3zSlDZmzsFKFX9V/bg==@vger.kernel.org
X-Gm-Message-State: AFuF++lV3F8P/8OJAL6S/kFvOc4GeKePWatKRM9iBGIiFWsxl19nvMZj
	KYOmMqYIQ9yHMNd10+e5MJYp0xueVrJrZm1td4KYfzdQ6Cs8wp2hsWcCJfDly1zsGhAkfvlotDN
	4saWGjZEJJmWtQrjiEWUzOkR6OfEJhihBo9he4NrEptvjXOuj69lYtwNTvKM=
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:16a5:b0:4d6:9133:cfe6 with SMTP id
 5614622812f47-4f30bcdf81amr3861437b6e.43.1790897372471; Thu, 01 Oct 2026
 16:29:32 -0700 (PDT)
Date: Thu, 01 Oct 2026 16:29:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6abeecdc.7503fbd6.2d3f6.0010.GAE@google.com>
Subject: [syzbot] [ecryptfs?] KASAN: slab-out-of-bounds Read in md5_blocks
From: syzbot <syzbot+46bbbe175b7eea8036b8@syzkaller.appspotmail.com>
To: code@tyhicks.com, ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6375e61c01e9 Add linux-next specific files for 20260928
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17231325580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1dae85014253be90
dashboard link: https://syzkaller.appspot.com/bug?extid=46bbbe175b7eea8036b8
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=138ff605580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d21ac9580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/dac817cfa9ca/disk-6375e61c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e503a06f8d7e/vmlinux-6375e61c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6a6051b849cb/bzImage-6375e61c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+46bbbe175b7eea8036b8@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in md5_block lib/crypto/md5.c:40 [inline]
BUG: KASAN: slab-out-of-bounds in md5_blocks+0x120/0xbd0 lib/crypto/md5.c:126
Read of size 64 at addr ffff88803236dce0 by task syz.1.18/5953

CPU: 0 UID: 0 PID: 5953 Comm: syz.1.18 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/16/2026
Call Trac
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x264/0x2c0 mm/kasan/generic.c:200
 __asan_memcpy+0x29/0x70 mm/kasan/shadow.c:105
 md5_block lib/crypto/md5.c:40 [inline]
 md5_blocks+0x120/0xbd0 lib/crypto/md5.c:126
 md5_update+0xef/0x150 lib/crypto/md5.c:161
 md5+0xed/0x180 lib/crypto/md5.c:202
 ecryptfs_write_tag_70_packet+0x820/0x12e0 fs/ecryptfs/keystore.c:741
 ecryptfs_encrypt_filename fs/ecryptfs/crypto.c:1378 [inline]
 ecryptfs_encrypt_and_encode_filename+0x576/0x1580 fs/ecryptfs/crypto.c:1789
 ecryptfs_lookup+0x20e/0x780 fs/ecryptfs/inode.c:402
 lookup_one_qstr_excl+0x12d/0x360 fs/namei.c:1810
 __start_dirop fs/namei.c:2920 [inline]
 start_dirop fs/namei.c:2942 [inline]
 filename_create+0x20e/0x370 fs/namei.c:5103
 filename_mkdirat+0xd2/0x510 fs/namei.c:5449
 __do_sys_mkdirat fs/namei.c:5477 [inline]
 __se_sys_mkdirat+0x35/0x150 fs/namei.c:5474
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe5ba99e159
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffeb47b2408 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 00007fe5bac25fa0 RCX: 00007fe5ba99e159
RDX: 0000000000000080 RSI: 0000200000000100 RDI: 0000000000000003
RBP: 00007fe5baa3506b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fe5bac25fac R14: 00007fe5bac25fa0 R15: 00007fe5bac25fa0
 </TASK>

Allocated by task 5953:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:409 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:426
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __do_kmalloc_node mm/slub.c:5531 [inline]
 __kmalloc_flags_noprof+0x52d/0x790 mm/slub.c:5719
 _kmalloc_flags_noprof mm/slab.h:55 [inline]
 __alloc_empty_sheaf+0x28/0x40 mm/slub.c:2854
 alloc_empty_sheaf mm/slub.c:2874 [inline]
 __pcs_replace_empty_main+0x43b/0x6c0 mm/slub.c:4806
 alloc_from_pcs mm/slub.c:4887 [inline]
 slab_alloc_node mm/slub.c:5021 [inline]
 kmem_cache_alloc_noprof+0x394/0x600 mm/slub.c:5047
 ecryptfs_init_fs_context+0x70/0x1b0 fs/ecryptfs/main.c:617
 alloc_fs_context+0x99e/0xd00 fs/fs_context.c:295
 do_new_mount+0x17f/0xdc0 fs/namespace.c:3841
 do_mount fs/namespace.c:4194 [inline]
 __do_sys_mount fs/namespace.c:4407 [inline]
 __se_sys_mount+0x31d/0x420 fs/namespace.c:4384
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88803236dc00
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 224 bytes inside of
 allocated 256-byte region [ffff88803236dc00, ffff88803236dd00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x3236c
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88813ff22b40 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88813ff22b40 dead000000000100 dead000000000122
head: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 00fff00000000001 ffffffffffffff81 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000002
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 29, tgid 29 (kdevtmpfs), ts 16571924726
 set_page_owner include/linux/page_owner.h:33 [inline]
 post_alloc_hook+0x1f9/0x250 mm/page_alloc.c:1854
 prep_new_page mm/page_alloc.c:1862 [inline]
 get_page_from_freelist+0x220f/0x2280 mm/page_alloc.c:3933
 __alloc_frozen_pages_noprof+0x1fc/0x400 mm/page_alloc.c:5441
 alloc_slab_page mm/slub.c:3384 [inline]
 allocate_slab+0x7d/0x5e0 mm/slub.c:3499
 new_slab mm/slub.c:3550 [inline]
 refill_objects+0x2d5/0x350 mm/slub.c:7539
 refill_sheaf mm/slub.c:2917 [inline]
 __pcs_replace_empty_main+0x2c8/0x6c0 mm/slub.c:4811
 alloc_from_pcs mm/slub.c:4887 [inline]
 slab_alloc_node mm/slub.c:5021 [inline]
 __do_kmalloc_node mm/slub.c:5530 [inline]
 __kmalloc_noprof+0x476/0x710 mm/slub.c:5556
 _kmalloc_noprof include/linux/slab.h:995 [inline]
 _kmalloc_array_noprof include/linux/slab.h:1211 [inline]
 security_inode_init_security+0x102/0x3e0 security/security.c:1386
 shmem_mknod+0x1ea/0x340 mm/shmem.c:4042
 vfs_mknod+0x448/0x610 fs/namei.c:5282
 handle_create drivers/base/devtmpfs.c:283 [inline]
 handle drivers/base/devtmpfs.c:435 [inline]
 devtmpfs_work_loop+0x861/0xdf0 drivers/base/devtmpfs.c:450
 devtmpfsd+0x4d/0x50 drivers/base/devtmpfs.c:492
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88803236dc00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88803236dc80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88803236dd00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                   ^
 ffff88803236dd80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88803236de00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
