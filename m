Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7241435E929
	for <ecryptfs@vger.kernel.org>; Sun, 11 Oct 2026 04:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791694781; cv=none; b=kc1isi2ZzxqMvDwpTJ+9JAkyF6YqBUompvznNTcqaFwOne9NrzWjWuAohw/VUm55PYrxR4FVu41qKoFpZemTOAnAscJplGYb61WHivF4bQ7jeoBrAIEx0wIilZ6/mMgiTIj13Btaels+Kr5u/i0ABEK0oY3OYxs0Xp19byuVSHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791694781; c=relaxed/simple;
	bh=wPj4Bok3H24lbkQJwDlWULA24cKLgaXTqoqPx5rxTXk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=W1FePgmTOKFogFRNcgpe5ngq/8lCh4CtG2dEWOXvskfWXdBNSFDTtzvzAq6EdlzPzIVDh5nG5n7dTXgd0U0mRhDrnAQIfGRpY4GNk9aA6QveSDyRfVju1QWuoKiQv6kkZd03dPpGjNBGGqC4zs16rw/5IVu+YLYs6B/i8S8LseM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4b28deb7ee3so2134949b6e.0
        for <ecryptfs@vger.kernel.org>; Sat, 10 Oct 2026 21:59:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791694778; x=1792299578;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LmFdIcktuWjbJ8pX7bSBlWaoMO1LS6gWZuAE3Csl9XI=;
        b=TE4QUsHRr3mP1LdSroevgjrFkru+WPhJV6C8YjQVhrvcaeQWJBiXy0vMu59RFXxfE1
         ihor3vPBOxTCVqiV7WCuCYcri0BMXrKu062ylFFmCEEFe6eiRdyvNvpn2627aihxHzlq
         oQZ/rtNKf49aKH3MpCB+9vJqXK8nO806WByOpOJjQIgNzf+wnOnO3KnTezxReGtUj3jO
         2G/1YKCxagDsQE/d4GetgjhIQJ4i/2T8Sas61hUlPjwUargxc710wevghO146hyhDO2W
         5uZ7MaOlJNHQUFy52UkpfjNFUqtdliiN030yVa0J8YOJDZNi1Lz/Kc/dvmHeg83MinmB
         jlqg==
X-Forwarded-Encrypted: i=1; AKwUvBzXMzH3zpdps7Ok/HkHuLt7kcUmQKcf+rR0SS+8AziDH1K3pF+PuC1lK9a2e/cKT6tQjS7PFA42Mw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLCsH5Ghe5ka3CrVwnTnSE2ze/3wET6QwqfX8T38oUFbPcJriS9
	p5BuvcZJSDqdCP/5PJ4OIlZnhpvZ2pbFltCgjyHXc3yr6RUAcgI1L8Ik53+4C6swP5t/Z5++3hc
	kbCpdHCCTq382xJy7uugpy/r6JyNxfJ1YgXQe2IOgEBKM0Z71jxj+JUsenHA=
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3384:b0:4b9:a8ac:489 with SMTP id
 5614622812f47-50c52a4eb8cmr6429470b6e.39.1791694778402; Sat, 10 Oct 2026
 21:59:38 -0700 (PDT)
Date: Sat, 10 Oct 2026 21:59:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6acb17ba.a150a118.27e199.0035.GAE@google.com>
Subject: [syzbot] [ecryptfs?] KASAN: slab-out-of-bounds Read in ecryptfs_from_hex
From: syzbot <syzbot+dc50906b100ac7a1c34d@syzkaller.appspotmail.com>
To: code@tyhicks.com, ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a5ebb76233b7 Merge tag 'edac_urgent_for_v7.3_rc7' of git:/..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15b396d1580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=129d675874dbf896
dashboard link: https://syzkaller.appspot.com/bug?extid=dc50906b100ac7a1c34d
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=117119a9580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dc50906b100ac7a1c34d@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in ecryptfs_from_hex+0x18c/0x1d0 fs/ecryptfs/crypto.c:45
Read of size 1 at addr ffff888048a432e0 by task syz-executor328/6037

CPU: 3 UID: 0 PID: 6037 Comm: syz-executor328 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 ecryptfs_from_hex+0x18c/0x1d0 fs/ecryptfs/crypto.c:45
 write_tag_3_packet+0x145/0x1430 fs/ecryptfs/keystore.c:2182
 ecryptfs_generate_key_packet_set+0x7ae/0x1880 fs/ecryptfs/keystore.c:2422
 ecryptfs_write_headers_virt fs/ecryptfs/crypto.c:955 [inline]
 ecryptfs_write_metadata+0x590/0x930 fs/ecryptfs/crypto.c:1065
 ecryptfs_initialize_file+0xb6/0x180 fs/ecryptfs/inode.c:252
 ecryptfs_create+0x393/0x550 fs/ecryptfs/inode.c:286
 lookup_open+0x1255/0x1990 fs/namei.c:4596
 open_last_lookups fs/namei.c:4796 [inline]
 path_openat+0xa2c/0x2440 fs/namei.c:5026
 do_file_open+0x20e/0x430 fs/namei.c:5058
 do_sys_openat2+0x10f/0x1e0 fs/open.c:1417
 do_sys_open fs/open.c:1423 [inline]
 __do_sys_openat fs/open.c:1439 [inline]
 __se_sys_openat fs/open.c:1434 [inline]
 __x64_sys_openat+0x12d/0x210 fs/open.c:1434
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fde6f0cb677
Code: 48 89 fa 4c 89 df e8 98 1d 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
RSP: 002b:00007ffc67310690 EFLAGS: 00000202 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000555560ff1400 RCX: 00007fde6f0cb677
RDX: 0000000000000042 RSI: 00007fde6f1040d5 RDI: ffffffffffffff9c
RBP: 00007fde6f104095 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000000001b6 R11: 0000000000000202 R12: 00007ffc67310858
R13: 0000000000000002 R14: 00007fde6f12ecc0 R15: 0000000000000002
 </TASK>

Allocated by task 6037:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:409 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:426
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __do_kmalloc_node mm/slub.c:5414 [inline]
 __kmalloc_noprof+0x32f/0x840 mm/slub.c:5439
 _kmalloc_noprof include/linux/slab.h:995 [inline]
 user_preparse+0x9b/0x1c0 security/keys/user_defined.c:67
 __key_create_or_update+0x413/0xe30 security/keys/key.c:854
 key_create_or_update+0x42/0x60 security/keys/key.c:1021
 __do_sys_add_key+0x2e8/0x460 security/keys/keyctl.c:134
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888048a43000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 0 bytes to the right of
 allocated 736-byte region [ffff888048a43000, ffff888048a432e0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888048a45000 pfn:0x48a40
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000240(workingset|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000240 ffff88801d042dc0 ffff88801d040888 ffffea00015b1010
raw: ffff888048a45000 0000000000100008 00000000f5000000 0000000000000000
head: 00fff00000000240 ffff88801d042dc0 ffff88801d040888 ffffea00015b1010
head: ffff888048a45000 0000000000100008 00000000f5000000 0000000000000000
head: 00fff00000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5773, tgid 5773 (syz-executor), ts 50740633132
 set_page_owner include/linux/page_owner.h:33 [inline]
 post_alloc_hook+0xfd/0x120 mm/page_alloc.c:1871
 prep_new_page mm/page_alloc.c:1879 [inline]
 get_page_from_freelist+0x110d/0x35d0 mm/page_alloc.c:3943
 __alloc_frozen_pages_noprof+0x2eb/0x3300 mm/page_alloc.c:5436
 alloc_slab_page mm/slub.c:3347 [inline]
 allocate_slab mm/slub.c:3462 [inline]
 new_slab+0xa9/0x6e0 mm/slub.c:3513
 refill_objects+0xe3/0x410 mm/slub.c:7418
 refill_sheaf mm/slub.c:2885 [inline]
 __pcs_replace_empty_main+0x35e/0x650 mm/slub.c:4774
 alloc_from_pcs mm/slub.c:4850 [inline]
 slab_alloc_node mm/slub.c:4984 [inline]
 __do_kmalloc_node mm/slub.c:5413 [inline]
 __kmalloc_noprof+0x67c/0x840 mm/slub.c:5439
 _kmalloc_noprof include/linux/slab.h:995 [inline]
 batadv_hash_new+0x74/0x2e0 net/batman-adv/hash.c:55
 batadv_bla_init+0x361/0x700 net/batman-adv/bridge_loop_avoidance.c:1619
 batadv_mesh_init+0x550/0x8d0 net/batman-adv/main.c:251
 batadv_meshif_init_late+0xb26/0xe60 net/batman-adv/mesh-interface.c:867
 register_netdevice+0x685/0x25a0 net/core/dev.c:11468
 batadv_meshif_newlink+0x8f/0xc0 net/batman-adv/mesh-interface.c:1145
 rtnl_newlink_create net/core/rtnetlink.c:3974 [inline]
 __rtnl_newlink net/core/rtnetlink.c:4103 [inline]
 rtnl_newlink+0x1697/0x2620 net/core/rtnetlink.c:4220
 rtnetlink_rcv_msg+0x95e/0xe90 net/core/rtnetlink.c:7137
 netlink_rcv_skb+0x159/0x420 net/netlink/af_netlink.c:2575
page last free pid 5752 tgid 5752 ts 50049458993 stack trace:
 reset_page_owner include/linux/page_owner.h:26 [inline]
 __free_pages_prepare mm/page_alloc.c:1418 [inline]
 free_pages_prepare+0x586/0xe00 mm/page_alloc.c:1463
 __free_contig_range_common+0x14f/0x250 mm/page_alloc.c:7072
 __free_contig_range mm/page_alloc.c:7117 [inline]
 free_pages_bulk+0x12a/0x200 mm/page_alloc.c:5322
 vm_area_free_pages+0xb2/0x2a0 mm/vmalloc.c:3461
 vfree mm/vmalloc.c:3510 [inline]
 vfree+0xf7/0x6d0 mm/vmalloc.c:3484
 kcov_put kernel/kcov.c:449 [inline]
 kcov_put kernel/kcov.c:445 [inline]
 kcov_close+0x34/0x60 kernel/kcov.c:556
 __fput+0x400/0xb60 fs/file_table.c:512
 task_work_run+0x150/0x240 kernel/task_work.c:233
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x8da/0x2a50 kernel/exit.c:986
 do_group_exit+0xd5/0x2a0 kernel/exit.c:1129
 get_signal+0x1ec7/0x21e0 kernel/signal.c:3112
 arch_do_signal_or_restart+0x91/0x7e0 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:66 [inline]
 exit_to_user_mode_loop+0x139/0x700 kernel/entry/common.c:101
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:343 [inline]
 do_syscall_64+0x661/0x790 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888048a43180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888048a43200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888048a43280: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
                                                       ^
 ffff888048a43300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888048a43380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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
