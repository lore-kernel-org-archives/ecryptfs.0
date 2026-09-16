Received: from mail-oi2-f3.google.com (mail-oi2-f3.google.com [74.125.231.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDF74B95D1
	for <ecryptfs@vger.kernel.org>; Wed, 16 Sep 2026 15:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574004; cv=none; b=L8ln5jMVnVbBJlObSGdIwHXp9NLjtpZapNz2KaETaU2eNXowreJoikapPoEBuPSWv8n7FPI+pcVFayZ0c3QvowvqvJbTwpvaNmzMxOsCHncm2cAzJj1IbzVo0HPYQxwzppEwJcrsemqoVxDp/0eBHadvUfOtUBX7ELSkv/mf9S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574004; c=relaxed/simple;
	bh=H4dJSFg6iQExsnc8GmQ9MXm9bqW8/LCdhPf9gwQ9qsQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AwuA0oEPyNM3revyj2reXtzuScyEPQiFYD0af/LI3KPmjGqGTzyvel8/NnstPC5CcFy/W4V7+/NZhMiD2W2MwtYdO4ouPNArpOghWELX9SpGMZxKvnjefiZioDcX01xq/jxxH2cT2HdxuaMFuoXB11uBfa8KKOpLOZ2+Oe2uKbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f3.google.com with SMTP id 5614622812f47-4b38a6e8c79so1961499b6e.1
        for <ecryptfs@vger.kernel.org>; Wed, 16 Sep 2026 08:53:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789574000; x=1790178800;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oVuTkQSbYJyd5mxryohh1p8C995zu7x9GMGJgIy3IbA=;
        b=Y/qzTR0Ev867MnpgNk2ud+UyDGF4n7oVPavfSpKuUwVgHPsDd4E0bUCr3SgDeUbvOZ
         6g+nlYH/9WmuyZyhgA/GG2BHu0h4n5Qn88HLfUvXT5z3kKexTct6yu2Vm2KEiUA90YdR
         9bmEFZj9sitPsiAEbyc8EXkMr2VayDGJXxsNkL7jkEp19j99H33qqDglT2V4G7199x+/
         OnGXBuWWpqXciQiT1i9IM7Ax4+nPKDe7g9+APMNIGut4kglRa0PZLjbniuCX9aCpVw25
         lBVScMMnOQa1soK8N5ZjzL/Zaknkw7o7vrxSlhPlkM0GaIPQZTqxYANhZnKuXEObuaDP
         R0ZQ==
X-Forwarded-Encrypted: i=1; AKwUvByBlHtaNo03gBIyttfaligMUyNEFmmaVDJBDu/gUg3530+jNnGsI3Vyb1VFWJ4YqEDUtnaHUgbYWg==@vger.kernel.org
X-Gm-Message-State: AFuF++myOvAvumtT5H848gJN4MFR3OAm52vWv7htLXt3Dw31I9HfHLh0
	dvS23xbhjgHv1YH601ttPPsGwhlUK81IWrpl8WCYQt8+COX1XTyfMoafiL7rkyC27vy7OWBTDw5
	8sKUA2xS7+4skw3v8mfUz9FhHWKNZmV86tLeSgekwKu8lWdQDO/Lbj6otfxc=
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1443:b0:4b9:e65b:8c2a with SMTP id
 5614622812f47-4ca4c285b2bmr3659574b6e.24.1789574000733; Wed, 16 Sep 2026
 08:53:20 -0700 (PDT)
Date: Wed, 16 Sep 2026 08:53:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aaabb70.86093f18.33004f.0003.GAE@google.com>
Subject: [syzbot] [ecryptfs?] KASAN: slab-out-of-bounds Read in ecryptfs_verify_auth_tok_from_key
From: syzbot <syzbot+b9529ebe6a9394ddf825@syzkaller.appspotmail.com>
To: code@tyhicks.com, ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f6e7b42bf05b Merge tag 'sysctl-7.03-fixes-rc4' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=148603f9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e909ffe6b35dddb7
dashboard link: https://syzkaller.appspot.com/bug?extid=b9529ebe6a9394ddf825
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=119813f9580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=174acdf9580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-f6e7b42b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/93106cf47a8e/vmlinux-f6e7b42b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e73f0f00e455/bzImage-f6e7b42b.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/55bc8f3c0251/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=108603f9580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b9529ebe6a9394ddf825@syzkaller.appspotmail.com

XFS (loop0): Ending clean mount
XFS (loop0): Quotacheck needed: Please wait.
XFS (loop0): Quotacheck: Done.
==================================================================
BUG: KASAN: slab-out-of-bounds in ecryptfs_verify_auth_tok_from_key+0x38f/0x3a0 fs/ecryptfs/keystore.c:473
Read of size 2 at addr ffff88803ae2a71b by task syz.0.17/5484

CPU: 0 UID: 0 PID: 5484 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 ecryptfs_verify_auth_tok_from_key+0x38f/0x3a0 fs/ecryptfs/keystore.c:473
 ecryptfs_keyring_auth_tok_for_sig+0xec/0x250 fs/ecryptfs/keystore.c:1606
 ecryptfs_init_global_auth_toks fs/ecryptfs/main.c:194 [inline]
 ecryptfs_validate_options fs/ecryptfs/main.c:420 [inline]
 ecryptfs_get_tree+0x563/0x1370 fs/ecryptfs/main.c:453
 vfs_get_tree+0x92/0x2a0 fs/super.c:1933
 fc_mount fs/namespace.c:1198 [inline]
 do_new_mount_fc fs/namespace.c:3772 [inline]
 do_new_mount+0x319/0xdc0 fs/namespace.c:3848
 do_mount fs/namespace.c:4181 [inline]
 __do_sys_mount fs/namespace.c:4397 [inline]
 __se_sys_mount+0x31d/0x420 fs/namespace.c:4374
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f355439e159
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f35552a4028 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f3554625fa0 RCX: 00007f355439e159
RDX: 0000200000000480 RSI: 0000200000000440 RDI: 0000200000000400
RBP: 00007f355443506b R08: 0000200000000500 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f3554626038 R14: 00007f3554625fa0 R15: 00007ffd4f4b3c68
 </TASK>

Allocated by task 5484:
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

The buggy address belongs to the object at ffff88803ae2a700
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 0 bytes to the right of
 allocated 27-byte region [ffff88803ae2a700, ffff88803ae2a71b)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x3ae2a
flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000000 ffff88801b041780 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000400040 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0xd2800(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5056, tgid 5056 (rm), ts 60539039982
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
 __kmalloc_cache_noprof+0x39b/0x600 mm/slub.c:5559
 _kmalloc_noprof include/linux/slab.h:991 [inline]
 slab_free_hook mm/slub.c:2700 [inline]
 slab_free mm/slub.c:6508 [inline]
 kmem_cache_free+0x156/0x650 mm/slub.c:6635
 tear_down_vmas+0x31f/0x530 mm/mmap.c:1277
 exit_mmap+0x4ca/0x9f0 mm/mmap.c:1335
 __mmput+0x118/0x420 kernel/fork.c:1193
 exec_mm_put_old fs/exec.c:919 [inline]
 setup_new_exec+0x30d/0x360 fs/exec.c:1386
 load_elf_binary+0xbc0/0x28d0 fs/binfmt_elf.c:1024
 search_binary_handler fs/exec.c:1765 [inline]
 exec_binprm fs/exec.c:1797 [inline]
 bprm_execve+0x930/0x1590 fs/exec.c:1853
 do_execveat_common+0x4f4/0x670 fs/exec.c:1951
 __do_sys_execve fs/exec.c:2024 [inline]
 __se_sys_execve fs/exec.c:2018 [inline]
 __x64_sys_execve+0x97/0xc0 fs/exec.c:2018
page last free pid 5056 tgid 5056 ts 60538565273 stack trace:
 reset_page_owner include/linux/page_owner.h:26 [inline]
 __free_pages_prepare mm/page_alloc.c:1418 [inline]
 __free_frozen_pages+0xc93/0xd90 mm/page_alloc.c:2962
 tlb_batch_list_free mm/mmu_gather.c:161 [inline]
 tlb_finish_mmu+0x13e/0x220 mm/mmu_gather.c:552
 exit_mmap+0x4b2/0x9f0 mm/mmap.c:1328
 __mmput+0x118/0x420 kernel/fork.c:1193
 exec_mm_put_old fs/exec.c:919 [inline]
 setup_new_exec+0x30d/0x360 fs/exec.c:1386
 load_elf_binary+0xbc0/0x28d0 fs/binfmt_elf.c:1024
 search_binary_handler fs/exec.c:1765 [inline]
 exec_binprm fs/exec.c:1797 [inline]
 bprm_execve+0x930/0x1590 fs/exec.c:1853
 do_execveat_common+0x4f4/0x670 fs/exec.c:1951
 __do_sys_execve fs/exec.c:2024 [inline]
 __se_sys_execve fs/exec.c:2018 [inline]
 __x64_sys_execve+0x97/0xc0 fs/exec.c:2018
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88803ae2a600: 00 00 00 fc fc fc fc fc 00 00 00 00 fc fc fc fc
 ffff88803ae2a680: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
>ffff88803ae2a700: 00 00 00 03 fc fc fc fc fa fb fb fb fc fc fc fc
                            ^
 ffff88803ae2a780: fa fb fb fb fc fc fc fc 00 00 00 00 fc fc fc fc
 ffff88803ae2a800: fa fb fb fb fc fc fc fc 00 00 00 00 fc fc fc fc
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
