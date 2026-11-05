Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793877757;
	b=kcjXsMyCxAv3k1tY71cJ90iJwK/V1TdT1NornLxWVnO/CKFcWgLN1jShlUlJYJiCb4Fm
	 75l1dx8kK5HukZ0vIKZAjKhC52ic4q68FnZTgeiyvYvtVn63fU6EXYpytpYgH1SQbAZxL
	 R5s4MZglOI7HvWLZiRcjxHoSMTndmQTgWE0cq3loqRdXcnXQpqXdkgB6MILk9JZvztY/1
	 lCBuETqjNc5haUAPLtyN7TCmxWykIfd8ZDGMnjjN7HCpKYzJqOU+mIbCYPheIggpTkUCy
	 NNFB7Da5Nm8+ZK8qp8r8UAIBg+a1C9BRowxqW3T9TXwEUxRveZ/BWYUKeNzwraE6tOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793877757;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=Qswaive52YYO7uidStbaEcMfM0Df4Lv2OiJl5FEZtFI=;
	b=fKZ4yRsKhnqtwCcteqPMhX98e6TNFqu2zkiwsj2fY0RlhlPeQh96PVn3BnyOHFe3/U5V
	 JuMZHkmph8EpAkt1RyxDPMt62k4HVxaAZH8Yg/Oo89MMSE/iUA8x0m/LMfFyBmAk7Oc8E
	 Y8z8siN18/oSsAlsJwjCYcu5cxK0NAyniBjqqR1LxB5ZRoTDZKEaYHbs0n+/WCJ+XU0Zb
	 RInTjca0gNF5OdbsBYvq8rZxN9ulfCx+iUQSQbYCnFfvbcGpQPsFHcQIeqTfbx0RtX24V
	 RDDUYVdIWS0XeqYtuyXc89nUY635aAzFJ/3d0vuf2OttnPhFmM44Voc29Ojh5S7ea9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAB1606A326
	for <ecryptfs@vger.kernel.org>; Thu,  5 Nov 2026 11:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDAB1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4a41f46d629so2628257b6e.3
        for <ecryptfs@vger.kernel.org>; Thu, 05 Nov 2026 03:22:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793877755; x=1794482555;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qswaive52YYO7uidStbaEcMfM0Df4Lv2OiJl5FEZtFI=;
        b=JvVVGcbL7SPdtTgaCtLIoe13jHJinrqt41bHmrzkLGhx/HL7sNtf5G/JdHCICBUcPo
         ay26JTnfreggKiqiTOxL+3fhaLu9+WkeMlzMQBnMsUvjXXXiF2Zt5WAUJGLdUpshfw6M
         UDGn67fm7ssOCc4FXh/8tePi7QuQsLoin1TZE2ejFmi2o+1smos8Em+nkUuJNSX5uNJL
         7tRpp9LBZjaOIl4r5b9YlI0q7Pv84uH1c8VuQHfpmTog9yVkCKugrhb3ejsk+PYko+kp
         jZOXMh3E+OEgGq4DP4HvHVYeSmUG/H/Mgp80AMbB72+1jY4Snc4hBQ8dh7EQCKuqbTKk
         fILg==
X-Forwarded-Encrypted: i=1; AKwUvByoJhv1N+t9biQJ3WLNn/4D3ZGsGlzEnhDGCWIvAZNPZa4wKSeiYncmw/acFz9QTwCHIqXS6aNISw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/IXpLik5h/s3QJ5S3PV/hCAPOpw+6pRdBjmDW4dq+rV8G6lcOj
	3SLX2nOSH7SgCW96rw0ZtzXEETywJQLnYJvp0UT8KITXmpDmyjpYRazqk0z9vfOCiUz7zKDzA+u
	dVQEMST/IUNP7RxmVMiu843R4l8MXllpHAaQtNDpBkSK9mThZhg89IEIbF54=
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Post: <mailto:ecryptfs@vger.kernel.org>
List-Help: <mailto:ecryptfs+help@vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ecryptfs+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1b27:b0:4f4:fc4e:77e9 with SMTP id
 5614622812f47-5640de136b1mr13104191b6e.42.1793877755723; Thu, 05 Nov 2026
 03:22:35 -0800 (PST)
Date: Thu, 05 Nov 2026 03:22:35 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aec66fb.059f5055.2712e4.0000.GAE@google.com>
Subject: [syzbot] [ecryptfs?] KASAN: slab-out-of-bounds Read in write_tag_3_packet
From: syzbot <syzbot+2e8c4ecc07730b29ae27@syzkaller.appspotmail.com>
To: code@tyhicks.com, ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    05441d697f7f Merge tag 'cocci-7.4-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10a8a055580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c210800cfc8f61e
dashboard link: https://syzkaller.appspot.com/bug?extid=2e8c4ecc07730b29ae27
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137858be580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14a3668d580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-05441d69.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c75df30900d6/vmlinux-05441d69.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3f7e073a900b/bzImage-05441d69.xz

AI-generated root cause summary:
In eCryptfs, ecryptfs_verify_auth_tok_from_key() and
ecryptfs_get_key_payload_data() cast the data buffer of a key's payload (struct
user_key_payload or struct encrypted_key_payload) to struct ecryptfs_auth_tok
without validating that the key payload length (datalen) is at least
sizeof(struct ecryptfs_auth_tok) (740 bytes). When a user key is provided with a
smaller payload length, subsequent accesses to auth_tok fields (such as
auth_tok->token.password.salt at offset 729 bytes) in write_tag_3_packet() read
beyond the allocated user_key_payload buffer into adjacent slab objects, causing
a slab-out-of-bounds read and leaking kernel memory into file metadata.

full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=2e8c4ecc07730b29ae27

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2e8c4ecc07730b29ae27@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in write_tag_3_packet+0xe4f/0x1430 fs/ecryptfs/keystore.c:2353
Read of size 8 at addr ffff888043e1bcf1 by task syz.0.17/6007

CPU: 3 UID: 0 PID: 6007 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
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
 write_tag_3_packet+0xe4f/0x1430 fs/ecryptfs/keystore.c:2353
 ecryptfs_generate_key_packet_set+0x7ae/0x1880 fs/ecryptfs/keystore.c:2422
 ecryptfs_write_headers_virt fs/ecryptfs/crypto.c:955 [inline]
 ecryptfs_write_metadata+0x590/0x930 fs/ecryptfs/crypto.c:1065
 ecryptfs_initialize_file+0xb6/0x180 fs/ecryptfs/inode.c:252
 ecryptfs_create+0x393/0x550 fs/ecryptfs/inode.c:286
 lookup_open+0xd8a/0x19e0 fs/namei.c:4575
 open_last_lookups fs/namei.c:4774 [inline]
 path_openat+0xe75/0x23f0 fs/namei.c:5013
 do_file_open+0x20e/0x430 fs/namei.c:5045
 do_sys_openat2+0x163/0x1d0 fs/open.c:1442
 do_sys_open fs/open.c:1448 [inline]
 __do_compat_sys_openat fs/open.c:1510 [inline]
 __se_compat_sys_openat fs/open.c:1508 [inline]
 __ia32_compat_sys_openat+0x12d/0x210 fs/open.c:1508
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:79 [inline]
 __do_fast_syscall_32+0x14b/0x8c0 arch/x86/entry/syscall_32.c:282
 do_fast_syscall_32+0x32/0x70 arch/x86/entry/syscall_32.c:307
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf73eefbc
Code: d2 74 05 c1 e8 0c 89 02 8b 5d fc 31 c0 c9 c3 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 2e 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00 58 b8
RSP: 002b:00000000ffad3b4c EFLAGS: 00000292 ORIG_RAX: 0000000000000127
RAX: ffffffffffffffda RBX: 00000000ffffff9c RCX: 0000000080000580
RDX: 0000000000101042 RSI: 000000000000009d RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Allocated by task 5949:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:409 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:426
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __do_kmalloc_node mm/slub.c:5531 [inline]
 __kmalloc_noprof+0x32f/0x840 mm/slub.c:5556
 _kmalloc_noprof include/linux/slab.h:995 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 fib_create_info+0x5bf/0x4640 net/ipv4/fib_semantics.c:1432
 fib_table_insert+0x169/0x1c70 net/ipv4/fib_trie.c:1210
 fib_magic+0x4d4/0x5c0 net/ipv4/fib_frontend.c:1147
 fib_add_ifaddr+0x3a1/0x560 net/ipv4/fib_frontend.c:1184
 fib_netdev_event+0x3d6/0x710 net/ipv4/fib_frontend.c:1529
 notifier_call_chain+0x99/0x3f0 kernel/notifier.c:86
 call_netdevice_notifiers_info+0xbe/0x110 net/core/dev.c:2313
 call_netdevice_notifiers_extack net/core/dev.c:2351 [inline]
 call_netdevice_notifiers net/core/dev.c:2365 [inline]
 __dev_notify_flags+0x22c/0x4b0 net/core/dev.c:10032
 netif_change_flags+0x108/0x160 net/core/dev.c:10061
 do_setlink.isra.0+0x1b9f/0x3f50 net/core/rtnetlink.c:3294
 rtnl_changelink net/core/rtnetlink.c:3942 [inline]
 __rtnl_newlink net/core/rtnetlink.c:4113 [inline]
 rtnl_newlink+0x13c1/0x2620 net/core/rtnetlink.c:4252
 rtnetlink_rcv_msg+0x95e/0xe90 net/core/rtnetlink.c:7169
 netlink_rcv_skb+0x159/0x420 net/netlink/af_netlink.c:2584
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x668/0x950 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x9ac/0x10c0 net/netlink/af_netlink.c:1920
 sock_sendmsg_nosec net/socket.c:800 [inline]
 __sock_sendmsg net/socket.c:818 [inline]
 __sys_sendto+0x492/0x4e0 net/socket.c:2283
 __do_compat_sys_socketcall net/compat.c:474 [inline]
 __se_compat_sys_socketcall net/compat.c:422 [inline]
 __ia32_compat_sys_socketcall+0x59a/0x770 net/compat.c:422
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:79 [inline]
 do_int80_emulation+0x166/0x650 arch/x86/entry/syscall_32.c:166
 asm_int80_emulation+0x1a/0x20 arch/x86/include/asm/idtentry.h:598

The buggy address belongs to the object at ffff888043e1bc00
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 241 bytes inside of
 allocated 248-byte region [ffff888043e1bc00, ffff888043e1bcf8)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x43e1a
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x4fff00000000040(head|node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000040 ffff88801d442b40 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 04fff00000000040 ffff88801d442b40 dead000000000100 dead000000000122
head: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 04fff00000000001 ffffffffffffff81 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000002
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5864, tgid 5864 (syz-executor), ts 41561072516
 set_page_owner include/linux/page_owner.h:33 [inline]
 post_alloc_hook+0xfd/0x120 mm/page_alloc.c:1856
 prep_new_page mm/page_alloc.c:1864 [inline]
 get_page_from_freelist+0x1113/0x35e0 mm/page_alloc.c:3935
 __alloc_frozen_pages_noprof+0x2bd/0x3280 mm/page_alloc.c:5444
 alloc_slab_page mm/slub.c:3384 [inline]
 allocate_slab mm/slub.c:3499 [inline]
 new_slab+0xb1/0x6d0 mm/slub.c:3550
 refill_objects+0xe3/0x410 mm/slub.c:7539
 refill_sheaf mm/slub.c:2917 [inline]
 __pcs_replace_empty_main+0x35e/0x650 mm/slub.c:4811
 alloc_from_pcs mm/slub.c:4887 [inline]
 slab_alloc_node mm/slub.c:5021 [inline]
 __kmalloc_cache_noprof+0x4ef/0x6d0 mm/slub.c:5676
 _kmalloc_noprof include/linux/slab.h:991 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 ____ip_mc_inc_group+0x40b/0x10d0 net/ipv4/igmp.c:1601
 br_ip4_multicast_join_snoopers.isra.0+0x152/0x400 net/bridge/br_multicast.c:4263
 br_multicast_join_snoopers+0x8b/0x120 net/bridge/br_multicast.c:4283
 br_dev_open+0x112/0x150 net/bridge/br_device.c:175
 __dev_open+0x3ad/0x8f0 net/core/dev.c:1762
 __dev_change_flags+0x596/0x850 net/core/dev.c:9991
 netif_change_flags+0x8d/0x160 net/core/dev.c:10056
 do_setlink.isra.0+0x1b9f/0x3f50 net/core/rtnetlink.c:3294
 rtnl_changelink net/core/rtnetlink.c:3942 [inline]
 __rtnl_newlink net/core/rtnetlink.c:4113 [inline]
 rtnl_newlink+0x13c1/0x2620 net/core/rtnetlink.c:4252
page last free pid 5856 tgid 5856 ts 40658746840 stack trace:
 reset_page_owner include/linux/page_owner.h:26 [inline]
 __free_pages_prepare mm/page_alloc.c:1403 [inline]
 __free_frozen_pages+0x7b4/0x1110 mm/page_alloc.c:2954
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x47/0xf0 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x1a0/0x1f0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:361
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4720 [inline]
 slab_alloc_node mm/slub.c:5033 [inline]
 kmem_cache_alloc_node_noprof+0x282/0x6e0 mm/slub.c:5105
 __alloc_skb+0x140/0x710 net/core/skbuff.c:705
 alloc_skb include/linux/skbuff.h:1390 [inline]
 nlmsg_new include/net/netlink.h:1055 [inline]
 rtmsg_ifinfo_build_skb+0x81/0x260 net/core/rtnetlink.c:4617
 rtmsg_ifinfo_event net/core/rtnetlink.c:4659 [inline]
 rtmsg_ifinfo_event net/core/rtnetlink.c:4649 [inline]
 rtmsg_ifinfo+0xa4/0x1b0 net/core/rtnetlink.c:4668
 netif_close_many+0x3ca/0x810 net/core/dev.c:1866
 unregister_netdevice_many_notify+0x563/0x1e00 net/core/dev.c:12694
 unregister_netdevice_many net/core/dev.c:12796 [inline]
 unregister_netdevice_queue net/core/dev.c:12592 [inline]
 unregister_netdevice_queue+0x30b/0x3c0 net/core/dev.c:12578
 unregister_netdevice include/linux/netdevice.h:3509 [inline]
 __tun_detach+0x1386/0x1850 drivers/net/tun.c:641
 tun_detach drivers/net/tun.c:657 [inline]
 tun_chr_close+0xc2/0x220 drivers/net/tun.c:3608
 __fput+0x3fb/0xb50 fs/file_table.c:512
 fput_close_sync+0x118/0x250 fs/file_table.c:618
 filp_close_sync+0x75/0xa0 fs/open.c:1573

Memory state around the buggy address:
 ffff888043e1bb80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888043e1bc00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888043e1bc80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fc
                                                                ^
 ffff888043e1bd00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888043e1bd80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
----------------
Code disassembly (best guess):
   0:	d2 74 05 c1          	shlb   %cl,-0x3f(%rbp,%rax,1)
   4:	e8 0c 89 02 8b       	call   0x8b028915
   9:	5d                   	pop    %rbp
   a:	fc                   	cld
   b:	31 c0                	xor    %eax,%eax
   d:	c9                   	leave
   e:	c3                   	ret
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
  16:	90                   	nop
  17:	90                   	nop
  18:	90                   	nop
  19:	90                   	nop
  1a:	90                   	nop
  1b:	90                   	nop
  1c:	90                   	nop
  1d:	90                   	nop
  1e:	0f 1f 00             	nopl   (%rax)
  21:	51                   	push   %rcx
  22:	52                   	push   %rdx
  23:	55                   	push   %rbp
  24:	89 e5                	mov    %esp,%ebp
  26:	0f 34                	sysenter
  28:	cd 80                	int    $0x80
* 2a:	5d                   	pop    %rbp <-- trapping instruction
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	ret
  2e:	90                   	nop
  2f:	2e 8d b4 26 00 00 00 	cs lea 0x0(%rsi,%riz,1),%esi
  36:	00
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  3e:	58                   	pop    %rax
  3f:	b8                   	.byte 0xb8


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
