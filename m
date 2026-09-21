Received: from mail-oo2-f5.google.com (mail-oo2-f5.google.com [74.125.231.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE5F4BB278
	for <ecryptfs@vger.kernel.org>; Mon, 21 Sep 2026 15:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790006016; cv=none; b=eBL+xybrizXutPp1jtEaCHfrGKCgTWRM6BcYmlqHE4U841pc+3VBNLEUPMgBYm7U7c1YAjtSdM+IVyoIXJK/037oLZ5H1g1J4NQt94g4a7EXR3DTRUu2VaxDwmIqzeYRPtuEYcdiYBKXXSCu0ue6OO+iht2aVXcPjZnbEejnHEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790006016; c=relaxed/simple;
	bh=fTvNvME2QHx0C88CSWRrZq/fVoC6CXah0IoLt2dTyJ4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fDSM+P7TCPIFf+xKrFEoOo9FFjg9M3YBi+ikLCzVNXSFShDbMoj1YN81giQmhFBLUbavRyQ5LN4xai/4sJfN+1ugxCN75iHwZ9Bgm6vhVoy/J+cOtCRCPrTHZwArJN1Bqx73hyt5z/rLyH4J0R2jfIyBYxLQXNTktw3AISetHB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo2-f5.google.com with SMTP id 006d021491bc7-6c184d8081eso222621eaf.0
        for <ecryptfs@vger.kernel.org>; Mon, 21 Sep 2026 08:53:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790006012; x=1790610812;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y2YyDT5aQohfeEoOXtxE5mWkAxqK5sgs5x7QOqMz9t0=;
        b=OdvrVpNYwisdEItE5xCwNerOZsRhApVddBdNxu19aDKsYImTngYZeDzk5FAKJF6gh+
         p1tSyb/fWV+MdHzz3qQ5T2VZ20GbtTGcb00O7w2DN5L/tysiKfYFz68YBvnrcGWWALjL
         ColTDLjlmTk57rnrg1nEVqYz02UCFKyLSr5muSTFfFbePv8t1h1VZDPSZ990X0hahAx/
         qU0QNpuN2oJc0FLRDP4g6fGYHT4qMqmpkajCvmAKlDw0nQBS3g8KiLnH6XgpaUGYqfBA
         emQsRv+PywbQxzDBIeqzmdYOxSeZQABY7bGH/SYeyemjfeUXPU1nIxbjB6y54Vy3wjYX
         EmnA==
X-Forwarded-Encrypted: i=1; AKwUvBw2RmoVezlf3NK7/E1kysbRvGRMDkEuWqvIitDnM2FXsFE8a/J3x6Er1V3s36XyYyrXUhJj3Fxopw==@vger.kernel.org
X-Gm-Message-State: AFuF++nRPLOzPJwkjsKH/dNInJ90xFFpcbB1g/gW74y6PBAzdtYOdIRc
	kPPryZKeoiTUUaWFbj8Nn1LYiTdBnDTTOTwfDszjxGsaC5EJpT/6k8Ed7lCIRw5chsBQmqVMFMM
	cv/inrDqrch2r0pj3o6YfIh0LgStsnC07kYIgd9CHB35SSc3e3sqLKfVeZRE=
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:8c5:b0:6b7:8396:f3d4 with SMTP id
 006d021491bc7-6ca9cb58539mr10773263eaf.54.1790006012641; Mon, 21 Sep 2026
 08:53:32 -0700 (PDT)
Date: Mon, 21 Sep 2026 08:53:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ab152fc.71f81b7d.15fa6d.0030.GAE@google.com>
Subject: [syzbot] [ecryptfs?] KASAN: slab-out-of-bounds Read in ecryptfs_write_tag_70_packet
From: syzbot <syzbot+e4391e0d6e7c89b8c84e@syzkaller.appspotmail.com>
To: code@tyhicks.com, ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    518e5b794c06 Merge tag 'for-7.3-rc3-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17e5fff9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c3bddd52b22c2498
dashboard link: https://syzkaller.appspot.com/bug?extid=e4391e0d6e7c89b8c84e
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1015fff9580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10b73915580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-518e5b79.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5307a29f916b/vmlinux-518e5b79.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7d4c698a99b1/bzImage-518e5b79.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/4a20c8843682/mount_0.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=13e5fff9580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e4391e0d6e7c89b8c84e@syzkaller.appspotmail.com

EXT4-fs (loop0): mounted filesystem 76b65be2-f6da-4727-8c75-0525a5b65a09 r/w without journal. Quota mode: none.
ext4 filesystem being mounted at /0/mnt supports timestamps until 2038-01-19 (0x7fffffff)
==================================================================
BUG: KASAN: slab-out-of-bounds in ecryptfs_write_tag_70_packet+0x1241/0x12e0 fs/ecryptfs/keystore.c:742
Read of size 4 at addr ffff88801225e298 by task syz.0.17/5512

CPU: 0 UID: 0 PID: 5512 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 ecryptfs_write_tag_70_packet+0x1241/0x12e0 fs/ecryptfs/keystore.c:742
 ecryptfs_encrypt_filename fs/ecryptfs/crypto.c:1378 [inline]
 ecryptfs_encrypt_and_encode_filename+0x576/0x1580 fs/ecryptfs/crypto.c:1789
 ecryptfs_lookup+0x20e/0x780 fs/ecryptfs/inode.c:402
 lookup_open+0x9e1/0x1a40 fs/namei.c:4528
 open_last_lookups fs/namei.c:4767 [inline]
 path_openat+0x677/0x1d60 fs/namei.c:4997
 do_file_open+0x23e/0x4a0 fs/namei.c:5029
 do_sys_openat2+0x115/0x200 fs/open.c:1417
 do_sys_open fs/open.c:1423 [inline]
 __do_sys_openat fs/open.c:1439 [inline]
 __se_sys_openat fs/open.c:1434 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1434
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa04199e159
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff0259f088 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007fa041c25fa0 RCX: 00007fa04199e159
RDX: 0000000000000800 RSI: 0000200000000680 RDI: ffffffffffffff9c
RBP: 00007fa041a3506b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fa041c25fac R14: 00007fa041c25fa0 R15: 00007fa041c25fa0
 </TASK>

Allocated by task 5512:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __do_kmalloc_node mm/slub.c:5414 [inline]
 __kmalloc_noprof+0x36b/0x720 mm/slub.c:5439
 _kmalloc_noprof include/linux/slab.h:995 [inline]
 user_preparse+0x9e/0x160 security/keys/user_defined.c:67
 __key_create_or_update+0x3a9/0xa80 security/keys/key.c:857
 key_create_or_update+0x42/0x60 security/keys/key.c:1021
 __do_sys_add_key security/keys/keyctl.c:134 [inline]
 __se_sys_add_key+0x349/0x420 security/keys/keyctl.c:74
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88801225e000
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 270 bytes to the right of
 allocated 394-byte region [ffff88801225e000, ffff88801225e18a)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1225e
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b041c80 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801b041c80 dead000000000100 dead000000000122
head: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
head: 00fff00000000001 ffffffffffffff81 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000002
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5447, tgid 5447 (syz-executor), ts 113774270032
 set_page_owner include/linux/page_owner.h:33 [inline]
 post_alloc_hook+0x1f9/0x250 mm/page_alloc.c:1871
 prep_new_page mm/page_alloc.c:1879 [inline]
 get_page_from_freelist+0x2209/0x2280 mm/page_alloc.c:3943
 __alloc_frozen_pages_noprof+0x217/0x5a0 mm/page_alloc.c:5436
 alloc_slab_page mm/slub.c:3347 [inline]
 allocate_slab+0x7d/0x620 mm/slub.c:3462
 new_slab mm/slub.c:3513 [inline]
 refill_objects+0x2d5/0x350 mm/slub.c:7417
 refill_sheaf mm/slub.c:2885 [inline]
 __pcs_replace_empty_main+0x2c8/0x6c0 mm/slub.c:4774
 alloc_from_pcs mm/slub.c:4850 [inline]
 slab_alloc_node mm/slub.c:4984 [inline]
 __do_kmalloc_node mm/slub.c:5413 [inline]
 __kmalloc_noprof+0x47b/0x720 mm/slub.c:5439
 _kmalloc_noprof include/linux/slab.h:995 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 fib6_info_alloc+0x30/0xf0 net/ipv6/ip6_fib.c:155
 ip6_route_info_create+0x149/0x890 net/ipv6/route.c:3833
 ip6_route_add+0x49/0x1b0 net/ipv6/route.c:3962
 addrconf_prefix_route+0x3a2/0x480 net/ipv6/addrconf.c:2504
 inet6_addr_add+0x504/0xb50 net/ipv6/addrconf.c:3077
 inet6_rtm_newaddr+0x9fc/0xe00 net/ipv6/addrconf.c:5095
 rtnetlink_rcv_msg+0x802/0xc00 net/core/rtnetlink.c:7137
 netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2575
 netlink_unicast_kernel net/netlink/af_netlink.c:1338 [inline]
 netlink_unicast+0x7bd/0x940 net/netlink/af_netlink.c:1364
page last free pid 5421 tgid 5421 ts 110085182085 stack trace:
 reset_page_owner include/linux/page_owner.h:26 [inline]
 __free_pages_prepare mm/page_alloc.c:1418 [inline]
 __free_frozen_pages+0xc93/0xd90 mm/page_alloc.c:2962
 __tlb_remove_table_free mm/mmu_gather.c:228 [inline]
 tlb_remove_table_rcu+0x85/0x100 mm/mmu_gather.c:291
 rcu_do_batch kernel/rcu/tree.c:2650 [inline]
 rcu_core+0x926/0x1260 kernel/rcu/tree.c:2919
 handle_softirqs+0x226/0x860 kernel/softirq.c:645
 __do_softirq kernel/softirq.c:679 [inline]
 invoke_softirq kernel/softirq.c:519 [inline]
 __irq_exit_rcu+0xcb/0x220 kernel/softirq.c:758
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:775
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1062
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674

Memory state around the buggy address:
 ffff88801225e180: 00 02 fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88801225e200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88801225e280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                            ^
 ffff88801225e300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88801225e380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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
