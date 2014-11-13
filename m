From: Anna Fischer <a.fischer@sirrix.com>
Subject: AW: BUG() in ecryptfs_send_miscdev()
Date: Thu, 13 Nov 2014 14:04:14 +0000
Message-ID: <ECC8F67CE961104EB2AFE8F7FD50F5D043D3E7@exchange2010.sirrix.de>
References: <ECC8F67CE961104EB2AFE8F7FD50F5D043D38F@exchange2010.sirrix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mx.sirrix.com ([176.9.214.66]:44764 "EHLO mx.sirrix.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932756AbaKMOEM convert rfc822-to-8bit (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Thu, 13 Nov 2014 09:04:12 -0500
Received: from [172.25.20.101] (helo=exchange2010.sirrix.de)
	by mx.sirrix.com with esmtp (Exim 4.76)
	(envelope-from <a.fischer@sirrix.com>)
	id 1Xov0N-00083P-85
	for ecryptfs@vger.kernel.org; Thu, 13 Nov 2014 15:04:11 +0100
In-Reply-To: <ECC8F67CE961104EB2AFE8F7FD50F5D043D38F@exchange2010.sirrix.de>
Content-Language: de-DE
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: "ecryptfs@vger.kernel.org" <ecryptfs@vger.kernel.org>

> Betreff: BUG() in ecryptfs_send_miscdev()
> 
> Hi,
> 
> I have a kernel BUG() with ecryptfs and I was hoping to get some help with
> debugging the problem. I run a Gentoo Linux kernel version 3.14.23. I have a
> BUG() trace as well which shows that the problem is in an ecryptfs kernel
> function. Looking at the code, it seems as if the problem occurs when
> ecryptfs kernelspace is trying to send an encrypted blob to the userspace
> daemon ecryptfsd. It attaches the message context to the daemon's queue,
> but that message context is already attached to that list. So the kernel prints
> a warning about a double add. Has anyone else ever seen this problem? I run
> ecryptfs-utils version 104.
> 
> Many thanks for your help.
> 
> Attempt to access file with crypto metadata only in the extended attribute
> region, but eCryptfs was mounted without xattr support ena0 list_add
> double add: new=ffff880407e41038, prev=ffff880407e41038,
> next=ffff880405cecf40.
> ------------[ cut here ]------------
> kernel BUG at lib/list_debug.c:45!
> invalid opcode: 0000 [#1] PREEMPT SMP
> Modules linked in: microcode vboxnetadp(O) vboxnetflt(O) vboxdrv(O)
> CPU: 3 PID: 6468 Comm: ShFolders Tainted: G O 3.14.23 #3 Hardware name:
> Hewlett-Packard HP ProDesk 600 G1 SFF/18E7, BIOS L01 v02.30 04/22/2014
> task: ffff8804048a4ec0 ti: ffff8804048a5458 task.ti: ffff8804048a5458
> RIP: 0010:[<ffffffff812f07fc>] [<ffffffff812f07fc>]
> __list_add_debug+0x65/0x6b
> RSP: 0018:ffff8803cdbd79f0 EFLAGS: 00010296
> RAX: 0000000000000058 RBX: ffff880407e41038 RCX: 0000000000000007
> RDX: 0000000000000006 RSI: 0000000000000046 RDI: ffff88041eacc030
> RBP: ffff8803cdbd79f0 R08: 00000000c5bc912d R09: ffffffff82080710
> R10: 00000000ffffff66 R11: 0000000000000000 R12: ffff880407e41038
> R13: ffff880405cecf40 R14: ffff880405cecf00 R15: 0000000000000066
> FS: 00007f26b17d6700(0000) GS:ffff88041eac0000(0000)
> knlGS:0000000000000000
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f26a803c000 CR3: 00000003cfb2c000 CR4: 00000000001627f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Stack:
> ffff8803cdbd7a18 ffffffff812f0819 ffff880405cecf10 000000000000021c
> 0000000000000214 ffff8803cdbd7a68 ffffffff8122df33 ffff8804082d5c00
> ffff880407e41048 ffff8804082d0c00 ffff880407e41000 ffff8803cdbd7ac8 Call
> Trace:
> [<ffffffff812f0819>] __list_add+0x17/0x31 [<ffffffff8122df33>]
> ecryptfs_send_miscdev+0xb1/0xf7 [<ffffffff8122d3ed>]
> ecryptfs_send_message+0x114/0x17a [<ffffffff8122a350>]
> decrypt_pki_encrypted_session_key+0x12a/0x3b9
> [<ffffffff8122bec9>] ecryptfs_parse_packet_set+0x753/0x903
> [<ffffffff81229132>] ecryptfs_read_headers_virt.part.26+0xfc/0x107
> [<ffffffff8122930c>] ecryptfs_read_metadata+0xf0/0x1b6
> [<ffffffff81224a20>] ecryptfs_open+0x1ae/0x24e [<ffffffff81224872>] ?
> ecryptfs_release+0x25/0x25 [<ffffffff8116ad7a>]
> do_dentry_open.isra.15+0x18d/0x235
> [<ffffffff8116ae3d>] finish_open+0x1b/0x25 [<ffffffff81178c02>]
> do_last+0xa3b/0xccc [<ffffffff811762cf>] ? link_path_walk+0x56/0x765
> [<ffffffff811790d3>] path_openat+0x240/0x626 [<ffffffff812490fd>] ?
> cifs_getattr+0x88/0xfb [<ffffffff8117a2ab>] do_filp_open+0x35/0x7a
> [<ffffffff811852e0>] ? __alloc_fd+0xdd/0xed [<ffffffff8116bd6a>]
> do_sys_open+0x142/0x1d1 [<ffffffff810cc093>] ?
> vtime_account_user+0x4d/0x52 [<ffffffff8116be12>] SyS_open+0x19/0x1b
> [<ffffffff8180de62>] tracesys+0xd1/0xd6
> Code: 81 31 c0 e8 cf 05 51 00 0f 0b 48 39 d7 74 05 48 39 c7 75 19 48 89 d1 48 89
> fe 48 89 c2 48 c7 c7 e5 f8 d6 81 31 c0 e8 ac 05 51 0 RIP [<ffffffff812f07fc>]
> __list_add_debug+0x65/0x6b RSP <ffff8803cdbd79f0> ---[ end trace
> 32deecf4531f4b92 ]--- Kernel panic - not syncing: Fatal exception Kernel
> Offset: 0x0 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-
> 0xffffffff9fffffff)
> drm_kms_helper: panic occurred, switching back to text console


After some more debugging I have found out that the problem occurs when a timeout happens in ecryptfs_wait_for_response(). In my case, the ecryptfsd does not manage to reply in time with the decrypted session key. Looking through the code, it seems to me as if there is a list_del() missing in that function. Instead, you are doing a ecryptfs_msg_ctx_alloc_to_free(msg_ctx); to put the message context back on the free list, but you have never removed it from the list. Is that possible? If a timeout occurs, would you not have to still remove the message context from the &daemon->msg_ctx_out_queue?

As a workaround, I can prevent the BUG() from occurring by upping the ecryptfs_message_wait_timeout kernel module parameter.

Regards,
Anna
