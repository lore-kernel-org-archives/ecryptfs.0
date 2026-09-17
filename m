Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B07F403E9D
	for <ecryptfs@vger.kernel.org>; Thu, 17 Sep 2026 05:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789624408; cv=none; b=BBtC1Wxcq2+UrOhm6HETLAUrQAYoM0vtWnuLV4fkmGAyjD7kquxw/6WRIWoOmJGgP/gABm9XK13fmznp89fKFA/OE+TIkBDnjn3pz0W4KiIK7OLkUcPgsM/90hHQqqzdJxgcfWXPfGHEThqZhS68L/eiHMj9N+S1Wk4ssQzc2yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789624408; c=relaxed/simple;
	bh=XkVG5NjY+O6gUgUJOTBFJE7DZl05c0v2rG1fmZ/0u4E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gHn57SlqoZzeDLB65W7rrdy+W45t9wm4Ma7lqKGJY2fMEKKtwKdJZekw02P+i+7N9aTGaP51SQagyrKBqkVTj48rD0088z5zoSnmJ0vo7VFmriFV9Ydu97LDCqfyjmyLxCt28h2MsgaqWCQHzNePVDn5wJ134oRpeKp6VgsPlis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-6b0e7370be1so521482eaf.0
        for <ecryptfs@vger.kernel.org>; Wed, 16 Sep 2026 22:53:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789624405; x=1790229205;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SEBd5Iukoqb77pKkBIu0zapO4TqrobQyg7PyGeW4Cw4=;
        b=2hTD/DCeAysvtjqyMdkT/GzwhDy1Xs2eaEyICyKAzZlQOTqwlMt64kxFr1+0ON98gB
         765xfMI1I1G4SNaGjFlFgPN/eZLaVO9WjcfqYKj8K9ipBMN/hOVrbWwzTqa9rrTjB3+f
         NL9yArnZSYZ4rrAa/fcHlrNFhzWLBM7wm8Liav6o2T7XBoFbVdSllZdJU0J5qvedVUPH
         g2WG22Twf5/3a6ZUtUwsqGQe0wacq4cyVNrzMMj1OX+AFgaPiOEGVvdpObd3+6O5fjRW
         4FLU3X4ChU3vU4xCsMA5H5nxhZtWvlkCfnPSx3O1gqjqc5RUhm9zZlcexhQfrx/9EVu+
         ejig==
X-Forwarded-Encrypted: i=1; AKwUvBxWOSCEiJ2sXEu3hOG1cD1cKlhZbLRIs8ywdf/twgIV2RkVj2Hp0cuE5NF3SaaAm8mv1J6XvfOB/Q==@vger.kernel.org
X-Gm-Message-State: AFuF++n6oUrJsYXmlV1XzfDDUXWZJIKHGkYUiAeqCnHsV/6G3hus9wHc
	d6IpeFFLlF4eqLuk2MwVcQfYFcNVLLub+KGKcR5SGU6+LJCLL3q0c2hEbVRtkcjjI97aTqUoo1R
	nJBImLJMN4yuvmfmyJpTYr6NFJGVWiKXkHplSJsfIh/Yf4ZUYJa9OweafyRc=
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:198c:b0:6b1:a146:1297 with SMTP id
 006d021491bc7-6c8fba8181emr1449050eaf.1.1789624405332; Wed, 16 Sep 2026
 22:53:25 -0700 (PDT)
Date: Wed, 16 Sep 2026 22:53:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aab8055.71f81b7d.278072.0015.GAE@google.com>
Subject: [syzbot] [ecryptfs?] KASAN: slab-use-after-free Read in ecryptfs_destroy_mount_crypt_stat
From: syzbot <syzbot+baa24e4b7e349e388442@syzkaller.appspotmail.com>
To: code@tyhicks.com, ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    238650ef6c7c Merge tag 'powerpc-7.3-4' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15684915580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5c3949d762a91f
dashboard link: https://syzkaller.appspot.com/bug?extid=baa24e4b7e349e388442
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13684915580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=122fdbf9580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-238650ef.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7608108a1c05/vmlinux-238650ef.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4d6d01769695/bzImage-238650ef.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+baa24e4b7e349e388442@syzkaller.appspotmail.com

R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007f6210a25fac R14: 00007f6210a25fa0 R15: 00007f6210a25fa0
 </TASK>
==================================================================
BUG: KASAN: slab-use-after-free in ecryptfs_destroy_mount_crypt_stat+0x28f/0x360 fs/ecryptfs/crypto.c:137
Read of size 4 at addr ffff88802b378610 by task syz.0.20/5927

CPU: 2 UID: 0 PID: 5927 Comm: syz.0.20 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 ecryptfs_destroy_mount_crypt_stat+0x28f/0x360 fs/ecryptfs/crypto.c:137
 ecryptfs_get_tree+0x10b6/0x15b0 fs/ecryptfs/main.c:566
 vfs_get_tree+0x92/0x320 fs/super.c:1933
 fc_mount fs/namespace.c:1198 [inline]
 do_new_mount_fc fs/namespace.c:3772 [inline]
 do_new_mount fs/namespace.c:3848 [inline]
 path_mount+0x7d0/0x24c0 fs/namespace.c:4168
 do_mount fs/namespace.c:4181 [inline]
 __do_sys_mount fs/namespace.c:4397 [inline]
 __se_sys_mount fs/namespace.c:4374 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:4374
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f621079e159
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff0780ea08 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f6210a25fa0 RCX: 00007f621079e159
RDX: 0000200000000480 RSI: 0000200000000000 RDI: 0000200000000400
RBP: 00007fff0780ea70 R08: 0000200000000500 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007f6210a25fac R14: 00007f6210a25fa0 R15: 00007f6210a25fa0
 </TASK>

Allocated by task 5927:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4683 [inline]
 slab_alloc_node mm/slub.c:4996 [inline]
 kmem_cache_alloc_noprof+0x269/0x6a0 mm/slub.c:5010
 ecryptfs_init_fs_context+0x6b/0x200 fs/ecryptfs/main.c:617
 alloc_fs_context+0x60c/0xf40 fs/fs_context.c:295
 do_new_mount fs/namespace.c:3828 [inline]
 path_mount+0xdbd/0x24c0 fs/namespace.c:4168
 do_mount fs/namespace.c:4181 [inline]
 __do_sys_mount fs/namespace.c:4397 [inline]
 __se_sys_mount fs/namespace.c:4374 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:4374
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5927:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2748 [inline]
 slab_free mm/slub.c:6508 [inline]
 kmem_cache_free+0x127/0x6c0 mm/slub.c:6635
 ecryptfs_kill_block_super+0x81/0xa0 fs/ecryptfs/main.c:586
 deactivate_locked_super+0xbd/0x140 fs/super.c:589
 ecryptfs_get_tree+0x10e9/0x15b0 fs/ecryptfs/main.c:563
 vfs_get_tree+0x92/0x320 fs/super.c:1933
 fc_mount fs/namespace.c:1198 [inline]
 do_new_mount_fc fs/namespace.c:3772 [inline]
 do_new_mount fs/namespace.c:3848 [inline]
 path_mount+0x7d0/0x24c0 fs/namespace.c:4168
 do_mount fs/namespace.c:4181 [inline]
 __do_sys_mount fs/namespace.c:4397 [inline]
 __se_sys_mount fs/namespace.c:4374 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:4374
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88802b378600
 which belongs to the cache ecryptfs_sb_cache of size 280
The buggy address is located 16 bytes inside of
 freed 280-byte region [ffff88802b378600, ffff88802b378718)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2b378
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff888024ddadc0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000200150015 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff888024ddadc0 dead000000000100 dead000000000122
head: 0000000000000000 0000000200150015 00000000f5000000 0000000000000000
head: 00fff00000000001 ffffffffffffff81 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000002
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5924, tgid 5924 (syz.0.17), ts 74770264892
 set_page_owner include/linux/page_owner.h:33 [inline]
 post_alloc_hook+0xfd/0x120 mm/page_alloc.c:1871
 prep_new_page mm/page_alloc.c:1879 [inline]
 get_page_from_freelist+0x110d/0x35d0 mm/page_alloc.c:3943
 __alloc_frozen_pages_noprof+0x2eb/0x3300 mm/page_alloc.c:5436
 alloc_slab_page mm/slub.c:3347 [inline]
 allocate_slab mm/slub.c:3462 [inline]
 new_slab+0xa9/0x6e0 mm/slub.c:3513
 refill_objects+0xe3/0x410 mm/slub.c:7417
 refill_sheaf mm/slub.c:2885 [inline]
 __pcs_replace_empty_main+0x35e/0x650 mm/slub.c:4774
 alloc_from_pcs mm/slub.c:4850 [inline]
 slab_alloc_node mm/slub.c:4984 [inline]
 kmem_cache_alloc_noprof+0x4c4/0x6a0 mm/slub.c:5010
 ecryptfs_init_fs_context+0x6b/0x200 fs/ecryptfs/main.c:617
 alloc_fs_context+0x60c/0xf40 fs/fs_context.c:295
 do_new_mount fs/namespace.c:3828 [inline]
 path_mount+0xdbd/0x24c0 fs/namespace.c:4168
 do_mount fs/namespace.c:4181 [inline]
 __do_sys_mount fs/namespace.c:4397 [inline]
 __se_sys_mount fs/namespace.c:4374 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:4374
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5862 tgid 5862 ts 74382051531 stack trace:
 reset_page_owner include/linux/page_owner.h:26 [inline]
 __free_pages_prepare mm/page_alloc.c:1418 [inline]
 __free_frozen_pages+0x79f/0x10f0 mm/page_alloc.c:2962
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x47/0xf0 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x1a0/0x1f0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:350
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4683 [inline]
 slab_alloc_node mm/slub.c:4996 [inline]
 kmem_cache_alloc_lru_noprof+0x265/0x6a0 mm/slub.c:5029
 __d_alloc+0x35/0xa50 fs/dcache.c:1907
 d_alloc+0x4a/0x1e0 fs/dcache.c:1986
 lookup_one_qstr_excl+0x171/0x250 fs/namei.c:1806
 __start_dirop fs/namei.c:2920 [inline]
 start_dirop+0x59/0xb0 fs/namei.c:2942
 simple_start_creating+0xf9/0x110 fs/libfs.c:2308
 debugfs_start_creating.part.0+0x9f/0x180 fs/debugfs/inode.c:397
 debugfs_start_creating fs/debugfs/inode.c:368 [inline]
 __debugfs_create_file+0x86/0x4d0 fs/debugfs/inode.c:431
 debugfs_create_file_full+0x41/0x60 fs/debugfs/inode.c:463
 cfg80211_debugfs_rdev_add+0xce/0x250 net/wireless/debugfs.c:138
 wiphy_register+0x242d/0x3110 net/wireless/core.c:1184
 ieee80211_register_hw+0x3053/0x4580 net/mac80211/main.c:1626

Memory state around the buggy address:
 ffff88802b378500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802b378580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88802b378600: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff88802b378680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802b378700: fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc
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
