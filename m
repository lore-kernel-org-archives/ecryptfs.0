Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590153D45F7
	for <ecryptfs@vger.kernel.org>; Thu,  1 Oct 2026 20:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790885377; cv=none; b=b5A/9fArasqIsGvPNM8t6U4LzXjaQ6T539dMlo7+FlFpF4iRGA3gJi7yKixYq7M1LYeVNi/f46QahNTT7igFjv3rDMTHMQJ+nwAAGmVrAPDsvDAis+fJ0xX3eiZmg1oL78N8s/zveqamvlXUQUKi6afkvwhJFiwWdUv2V35deCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790885377; c=relaxed/simple;
	bh=VahqGADbt5fuK3JlL4oEwwlE+u4deUseRKS0PGeHNoM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=j9srG8IKjAS4v8b3wIbQwCLFi0xkediwsm8CK+Jgz4Z+qWiwVP5jX7bfUWSnGgyn9WwKhOXlxFOlpuiuKWtYBhz+MgsUBcG56/mCIo7jCTi1n2/ccMADrGYzTvLKzCKBSiNwOxPfZyDK7tKHakrAHMNz2L9HxrThOh+ODfxYPJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4f4612a1a5cso983487b6e.0
        for <ecryptfs@vger.kernel.org>; Thu, 01 Oct 2026 13:09:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790885374; x=1791490174;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Mg3Z0ilu9klqB8OJi0Z+pxt4D4ewmjhUamshblmHZY=;
        b=e0ya+g05siOWg0VyKMkoVatzSPI2jVGsQwMWLGncaSNjl/0fAl/9TGmGPOxYMwXfy6
         25zPIKCHkNuRQp8/IrpDq1IMNxfOAQj9bYMqEInUFRjUmrPRqYlBvxHLee14aINdiEwV
         hyqzzvVIW+x6Fji+zPbapJN0IR4Ist1V2WkqDgHFb27YI+58hAc2ErHokfVcU3FxMBea
         RXMUZq8iQ8P6WKoWHRYHEiDVB5Q8ddaqyCVLQWdSWggvR7Ks8ceKZe2+3PFykH0S71eI
         lV2AmbMyY8YEAVudYBuogzzbo3oHIY/IwfUywRcj+X5UrV9+0PyaV7hZWZQwVFTZlKbe
         pP7w==
X-Forwarded-Encrypted: i=1; AKwUvBzJumneSsQrcDAaiMi6VsRwIzyX2ZynsRQmpIJfIhJy3IoLsmoBjr+owPKPASjOSOgnvM7oQhgw4g==@vger.kernel.org
X-Gm-Message-State: AFuF++l+34StxmdWjEDqTcFOEUvUrMB0n3CfPFaB4v0tqlfHfZMV8WNj
	ag/bRZc5W0NPe3NOhW+wReHYpIC1C2uFeWszyNxvnps7dQ1zyfav4dFTR69U7zs0meZsfjdMCta
	HXZ59ULoq/U24sw0KHcsyTEia54Y/LyEzuzU1/+6mvbw829X6ucsNElYVfNk=
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1648:b0:4d6:9133:cfdf with SMTP id
 5614622812f47-4f30b02378fmr3239079b6e.36.1790885374315; Thu, 01 Oct 2026
 13:09:34 -0700 (PDT)
Date: Thu, 01 Oct 2026 13:09:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6abebdfe.7503fbd6.2d3f6.0009.GAE@google.com>
Subject: [syzbot] [ecryptfs?] KASAN: slab-out-of-bounds Read in md5_block
From: syzbot <syzbot+03c68e42ce4b33f7ce9b@syzkaller.appspotmail.com>
To: code@tyhicks.com, ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    551c722f4080 Merge tag 'rtc-7.3-fixes' of git://git.kernel..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15154035580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d012d9c67977ee4
dashboard link: https://syzkaller.appspot.com/bug?extid=03c68e42ce4b33f7ce9b
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13154035580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+03c68e42ce4b33f7ce9b@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in md5_block+0x95/0x8d0 lib/crypto/md5.c:40
Read of size 64 at addr ffff8880310c0ce0 by task syz-executor265/6033

CPU: 1 UID: 0 PID: 6033 Comm: syz-executor265 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:186 [inline]
 kasan_check_range+0x10f/0x1e0 mm/kasan/generic.c:200
 __asan_memcpy+0x23/0x60 mm/kasan/shadow.c:105
 md5_block+0x95/0x8d0 lib/crypto/md5.c:40
 md5_blocks lib/crypto/md5.c:126 [inline]
 md5_update+0xf7/0x210 lib/crypto/md5.c:161
 md5+0xc7/0x120 lib/crypto/md5.c:202
 ecryptfs_write_tag_70_packet+0x880/0x1410 fs/ecryptfs/keystore.c:741
 ecryptfs_encrypt_filename fs/ecryptfs/crypto.c:1378 [inline]
 ecryptfs_encrypt_and_encode_filename+0x428/0xa60 fs/ecryptfs/crypto.c:1789
 ecryptfs_lookup+0x1f7/0x830 fs/ecryptfs/inode.c:402
 __lookup_slow+0x155/0x320 fs/namei.c:1919
 lookup_slow+0x50/0x70 fs/namei.c:1936
 walk_component fs/namei.c:2282 [inline]
 lookup_last fs/namei.c:2789 [inline]
 path_lookupat+0x5e8/0xc40 fs/namei.c:2813
 filename_lookup+0x202/0x590 fs/namei.c:2842
 __do_sys_chdir fs/open.c:557 [inline]
 __se_sys_chdir fs/open.c:550 [inline]
 __x64_sys_chdir+0xc8/0x280 fs/open.c:550
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f62183c3537
Code: 00 00 75 14 48 83 c4 28 5b 5d c3 0f 1f 84 00 00 00 00 00 8b 04 24 eb dc e8 c6 14 00 00 66 0f 1f 44 00 00 b8 50 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 d8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc52514f68 EFLAGS: 00000206 ORIG_RAX: 0000000000000050
RAX: ffffffffffffffda RBX: 00007f621841c0a9 RCX: 00007f62183c3537
RDX: 0000000000000000 RSI: 00007f621841e348 RDI: 00007f621841c0bd
RBP: 00007f621841c09e R08: 00007f621841e2b8 R09: 66615f7961727073
R10: 0000000000000000 R11: 0000000000000206 R12: 00007ffc52514f90
R13: 00007f621841c049 R14: 00007f621841c08f R15: 0000000000000002
 </TASK>

Allocated by task 5567:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:409 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:426
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __do_kmalloc_node mm/slub.c:5414 [inline]
 __kmalloc_flags_noprof+0x370/0x8e0 mm/slub.c:5602
 _kmalloc_flags_noprof mm/slab.h:55 [inline]
 __alloc_empty_sheaf mm/slub.c:2822 [inline]
 alloc_empty_sheaf mm/slub.c:2842 [inline]
 __pcs_replace_empty_main+0x3fa/0x650 mm/slub.c:4769
 alloc_from_pcs mm/slub.c:4850 [inline]
 slab_alloc_node mm/slub.c:4984 [inline]
 kmem_cache_alloc_noprof+0x4c4/0x6a0 mm/slub.c:5010
 __skb_ext_alloc+0x1a/0x80 net/core/skbuff.c:7152
 skb_ext_add+0x40b/0x810 net/core/skbuff.c:7256
 nf_bridge_alloc include/net/netfilter/br_netfilter.h:12 [inline]
 br_nf_pre_routing_ipv6+0xc7/0x8b0 net/bridge/br_netfilter_ipv6.c:171
 br_nf_pre_routing+0x90f/0x1560 net/bridge/br_netfilter_hooks.c:513
 nf_hook_entry_hookfn include/linux/netfilter.h:165 [inline]
 nf_hook_bridge_pre net/bridge/br_input.c:291 [inline]
 br_handle_frame+0xd59/0x1670 net/bridge/br_input.c:451
 __netif_receive_skb_core.constprop.0+0x6c5/0x3530 net/core/dev.c:6152
 __netif_receive_skb_one_core+0xb0/0x1e0 net/core/dev.c:6263
 __netif_receive_skb+0x1f/0x120 net/core/dev.c:6378
 process_backlog+0x487/0x1600 net/core/dev.c:6729
 __napi_poll.constprop.0+0xaf/0x450 net/core/dev.c:7798
 napi_poll net/core/dev.c:7861 [inline]
 net_rx_action+0xa40/0xf20 net/core/dev.c:8018
 handle_softirqs+0x1e6/0x9d0 kernel/softirq.c:645
 do_softirq kernel/softirq.c:546 [inline]
 do_softirq+0xaf/0xf0 kernel/softirq.c:533
 __local_bh_enable_ip+0xff/0x120 kernel/softirq.c:473
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:923 [inline]
 __dev_queue_xmit+0xa27/0x4970 net/core/dev.c:4961
 dev_queue_xmit include/linux/netdevice.h:3461 [inline]
 neigh_hh_output include/net/neighbour.h:544 [inline]
 neigh_output include/net/neighbour.h:558 [inline]
 ip6_finish_output2+0x102d/0x1d50 net/ipv6/ip6_output.c:138
 __ip6_finish_output+0x357/0xdf0 net/ipv6/ip6_output.c:210
 ip6_finish_output net/ipv6/ip6_output.c:221 [inline]
 NF_HOOK_COND include/linux/netfilter.h:314 [inline]
 ip6_output+0x2aa/0xa60 net/ipv6/ip6_output.c:248
 dst_output include/net/dst.h:471 [inline]
 NF_HOOK include/linux/netfilter.h:325 [inline]
 NF_HOOK.constprop.0+0x115/0x5a0 include/linux/netfilter.h:319
 mld_sendpack+0x8f7/0xec0 net/ipv6/mcast.c:1890
 mld_send_initial_cr+0x219/0x320 net/ipv6/mcast.c:2308
 ipv6_mc_dad_complete+0xa7/0x1d0 net/ipv6/mcast.c:2316
 addrconf_dad_completed+0xd91/0xff0 net/ipv6/addrconf.c:4376
 addrconf_dad_work+0x83c/0x1360 net/ipv6/addrconf.c:4304
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
 process_scheduled_works kernel/workqueue.c:3479 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3560
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff8880310c0c00
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 224 bytes inside of
 allocated 256-byte region [ffff8880310c0c00, ffff8880310c0d00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x310c0
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801c042b40 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801c042b40 dead000000000100 dead000000000122
head: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 00fff00000000001 ffffffffffffff81 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000002
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 39, tgid 39 (kdevtmpfs), ts 10593768918
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
 __do_kmalloc_node mm/slub.c:5413 [inline]
 __kmalloc_noprof+0x67c/0x840 mm/slub.c:5439
 _kmalloc_noprof include/linux/slab.h:995 [inline]
 _kmalloc_array_noprof include/linux/slab.h:1211 [inline]
 security_inode_init_security+0x113/0x370 security/security.c:1347
 shmem_mknod+0x2ce/0x480 mm/shmem.c:3841
 vfs_mknod+0x3a5/0x7f0 fs/namei.c:5269
 handle_create drivers/base/devtmpfs.c:232 [inline]
 handle drivers/base/devtmpfs.c:384 [inline]
 devtmpfs_work_loop+0x48d/0xae4 drivers/base/devtmpfs.c:399
 devtmpfsd+0x3f/0x50 drivers/base/devtmpfs.c:441
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
page_owner free stack trace missing

Memory state around the buggy address:
 ffff8880310c0c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8880310c0c80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff8880310c0d00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                   ^
 ffff8880310c0d80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880310c0e00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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
