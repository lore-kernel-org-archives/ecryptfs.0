From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: INFO: possible circular locking dependency detected
Date: Wed, 20 Nov 2013 15:24:37 -0800
Message-ID: <528D44B5.8010800@schaufler-ca.com>
References: <CAMEtUuzfMTX6VfzrzU=yX+V6b=dpP+J=cexbW=SXdMdpCMbfAw@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-security-module-owner@vger.kernel.org>
In-Reply-To: <CAMEtUuzfMTX6VfzrzU=yX+V6b=dpP+J=cexbW=SXdMdpCMbfAw@mail.gmail.com>
Sender: linux-security-module-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Alexei Starovoitov <ast@plumgrid.com>, ecryptfs@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: Casey Schaufler <casey@schaufler-ca.com>

On 11/20/2013 12:15 PM, Alexei Starovoitov wrote:
> FYI just got this on 3.10.19 with few networking fixes and smack as
> default security:

This looks very much like a problem seen with another
stacked filesystem. It's been a while since that one
cropped up, so the details aren't fresh in my mind. I
will look into this. Additional information and suggested
patches are always welcome.

>
> # CONFIG_SECURITY_SELINUX is not set
> CONFIG_SECURITY_SMACK=y
> # CONFIG_SECURITY_TOMOYO is not set
> # CONFIG_SECURITY_APPARMOR is not set
> # CONFIG_SECURITY_YAMA is not set
>
> don't see it with selinux.
>
> [ 1447.337397] ======================================================
> [ 1447.337399] [ INFO: possible circular locking dependency detected ]
> [ 1447.337402] 3.10.19+ #19 Not tainted
> [ 1447.337403] -------------------------------------------------------
> [ 1447.337405] sshd/2709 is trying to acquire lock:
> [ 1447.337407]  (&type->i_mutex_dir_key#2){+.+.+.}, at:
> [<ffffffff812b1bd0>] ecryptfs_getxattr_lower+0x50/0xa0
> [ 1447.337420]
> [ 1447.337420] but task is already holding lock:
> [ 1447.337422]  (&isp->smk_lock){+.+.+.}, at: [<ffffffff812eb1aa>]
> smack_d_instantiate+0x6a/0x320
> [ 1447.337429]
> [ 1447.337429] which lock already depends on the new lock.
> [ 1447.337429]
> [ 1447.337432]
> [ 1447.337432] the existing dependency chain (in reverse order) is:
> [ 1447.337434]
> [ 1447.337434] -> #1 (&isp->smk_lock){+.+.+.}:
> [ 1447.337438]        [<ffffffff810b8cf2>] lock_acquire+0x92/0x1d0
> [ 1447.337444]        [<ffffffff8169e0ce>] mutex_lock_nested+0x6e/0x380
> [ 1447.337449]        [<ffffffff812eb1aa>] smack_d_instantiate+0x6a/0x320
> [ 1447.337452]        [<ffffffff812e6dab>] security_d_instantiate+0x1b/0x30
> [ 1447.337458]        [<ffffffff811bac1b>] d_splice_alias+0xeb/0x100
> [ 1447.337462]        [<ffffffff81258f58>] ext4_lookup+0xf8/0x170
> [ 1447.337467]        [<ffffffff811abefd>] lookup_real+0x1d/0x60
> [ 1447.337472]        [<ffffffff811ac118>] __lookup_hash+0x38/0x50
> [ 1447.337475]        [<ffffffff816992b3>] lookup_slow+0x47/0xab
> [ 1447.337478]        [<ffffffff811af455>] path_lookupat+0x745/0x790
> [ 1447.337482]        [<ffffffff811af4d4>] filename_lookup+0x34/0xc0
> [ 1447.337485]        [<ffffffff811af612>] do_path_lookup+0x32/0x40
> [ 1447.337489]        [<ffffffff811af89a>] kern_path+0x2a/0x50
> [ 1447.337492]        [<ffffffff811c65cd>] do_mount+0x8d/0xa20
> [ 1447.337495]        [<ffffffff811c6fee>] SyS_mount+0x8e/0xe0
> [ 1447.337498]        [<ffffffff816ab082>] system_call_fastpath+0x16/0x1b
> [ 1447.337502]
> [ 1447.337502] -> #0 (&type->i_mutex_dir_key#2){+.+.+.}:
> [ 1447.337506]        [<ffffffff810b8573>] __lock_acquire+0x1c63/0x1d50
> [ 1447.337510]        [<ffffffff810b8cf2>] lock_acquire+0x92/0x1d0
> [ 1447.337514]        [<ffffffff8169e0ce>] mutex_lock_nested+0x6e/0x380
> [ 1447.337518]        [<ffffffff812b1bd0>] ecryptfs_getxattr_lower+0x50/0xa0
> [ 1447.337521]        [<ffffffff812b1c39>] ecryptfs_getxattr+0x19/0x20
> [ 1447.337525]        [<ffffffff812eb0fc>] smk_fetch.isra.14+0x6c/0xb0
> [ 1447.337528]        [<ffffffff812eb2af>] smack_d_instantiate+0x16f/0x320
> [ 1447.337531]        [<ffffffff812e6dab>] security_d_instantiate+0x1b/0x30
> [ 1447.337535]        [<ffffffff811b88db>] d_instantiate+0x5b/0x80
> [ 1447.337538]        [<ffffffff812b0bc0>] ecryptfs_lookup+0x140/0x360
> [ 1447.337542]        [<ffffffff811abefd>] lookup_real+0x1d/0x60
> [ 1447.337545]        [<ffffffff811ac118>] __lookup_hash+0x38/0x50
> [ 1447.337548]        [<ffffffff816992b3>] lookup_slow+0x47/0xab
> [ 1447.337550]        [<ffffffff811ae595>] link_path_walk+0x865/0x8b0
> [ 1447.337554]        [<ffffffff811aed67>] path_lookupat+0x57/0x790
> [ 1447.337557]        [<ffffffff811af4d4>] filename_lookup+0x34/0xc0
> [ 1447.337561]        [<ffffffff811b286c>] user_path_at_empty+0x8c/0x100
> [ 1447.337564]        [<ffffffff811b28f1>] user_path_at+0x11/0x20
> [ 1447.337568]        [<ffffffff811a6c52>] vfs_fstatat+0x52/0xb0
> [ 1447.337572]        [<ffffffff811a6d7b>] vfs_stat+0x1b/0x20
> [ 1447.337575]        [<ffffffff811a6d95>] SYSC_newstat+0x15/0x30
> [ 1447.337578]        [<ffffffff811a706e>] SyS_newstat+0xe/0x10
> [ 1447.337581]        [<ffffffff816ab082>] system_call_fastpath+0x16/0x1b
> [ 1447.337584]
> [ 1447.337584] other info that might help us debug this:
> [ 1447.337584]
> [ 1447.337586]  Possible unsafe locking scenario:
> [ 1447.337586]
> [ 1447.337588]        CPU0                    CPU1
> [ 1447.337590]        ----                    ----
> [ 1447.337591]   lock(&isp->smk_lock);
> [ 1447.337594]                                lock(&type->i_mutex_dir_key#2);
> [ 1447.337597]                                lock(&isp->smk_lock);
> [ 1447.337600]   lock(&type->i_mutex_dir_key#2);
> [ 1447.337603]
> [ 1447.337603]  *** DEADLOCK ***
> [ 1447.337603]
> [ 1447.337606] 2 locks held by sshd/2709:
> [ 1447.337607]  #0:  (&type->i_mutex_dir_key#3){+.+.+.}, at:
> [<ffffffff816992a4>] lookup_slow+0x38/0xab
> [ 1447.337614]  #1:  (&isp->smk_lock){+.+.+.}, at:
> [<ffffffff812eb1aa>] smack_d_instantiate+0x6a/0x320
> [ 1447.337620]
> [ 1447.337620] stack backtrace:
> [ 1447.337623] CPU: 1 PID: 2709 Comm: sshd Not tainted 3.10.19+ #19
> [ 1447.337625] Hardware name: System manufacturer System Product
> Name/P8Z77 WS, BIOS 3007 07/26/2012
> [ 1447.337627]  ffffffff8214cb70 ffff880808b53788 ffffffff8169a0fd
> ffff880808b537d8
> [ 1447.337632]  ffffffff8169665d ffffffff81a02968 ffff880808b53868
> ffff8807e6634678
> [ 1447.337637]  ffff8807e66346a0 ffff8807e6634678 0000000000000001
> 0000000000000002
> [ 1447.337641] Call Trace:
> [ 1447.337646]  [<ffffffff8169a0fd>] dump_stack+0x19/0x1b
> [ 1447.337651]  [<ffffffff8169665d>] print_circular_bug+0x1fb/0x20c
> [ 1447.337655]  [<ffffffff810b8573>] __lock_acquire+0x1c63/0x1d50
> [ 1447.337660]  [<ffffffff810b3fc7>] ? __bfs+0x157/0x250
> [ 1447.337664]  [<ffffffff810b64f6>] ? check_irq_usage+0x96/0xe0
> [ 1447.337668]  [<ffffffff810b8cf2>] lock_acquire+0x92/0x1d0
> [ 1447.337672]  [<ffffffff812b1bd0>] ? ecryptfs_getxattr_lower+0x50/0xa0
> [ 1447.337677]  [<ffffffff8169e0ce>] mutex_lock_nested+0x6e/0x380
> [ 1447.337681]  [<ffffffff812b1bd0>] ? ecryptfs_getxattr_lower+0x50/0xa0
> [ 1447.337685]  [<ffffffff812b1bd0>] ecryptfs_getxattr_lower+0x50/0xa0
> [ 1447.337689]  [<ffffffff812b1c39>] ecryptfs_getxattr+0x19/0x20
> [ 1447.337692]  [<ffffffff812eb0fc>] smk_fetch.isra.14+0x6c/0xb0
> [ 1447.337696]  [<ffffffff812eb2af>] smack_d_instantiate+0x16f/0x320
> [ 1447.337700]  [<ffffffff812e6dab>] security_d_instantiate+0x1b/0x30
> [ 1447.337704]  [<ffffffff811b88db>] d_instantiate+0x5b/0x80
> [ 1447.337708]  [<ffffffff812b0bc0>] ecryptfs_lookup+0x140/0x360
> [ 1447.337711]  [<ffffffff811abefd>] lookup_real+0x1d/0x60
> [ 1447.337715]  [<ffffffff811ac118>] __lookup_hash+0x38/0x50
> [ 1447.337718]  [<ffffffff816992b3>] lookup_slow+0x47/0xab
> [ 1447.337722]  [<ffffffff811ae595>] link_path_walk+0x865/0x8b0
> [ 1447.337726]  [<ffffffff811aea12>] ? path_init+0x342/0x640
> [ 1447.337730]  [<ffffffff811aed67>] path_lookupat+0x57/0x790
> [ 1447.337734]  [<ffffffff811ada50>] ? getname_flags.part.25+0x30/0x140
> [ 1447.337739]  [<ffffffff811907dc>] ? kmem_cache_alloc+0x4c/0x260
> [ 1447.337743]  [<ffffffff811af4d4>] filename_lookup+0x34/0xc0
> [ 1447.337747]  [<ffffffff811b286c>] user_path_at_empty+0x8c/0x100
> [ 1447.337752]  [<ffffffff810b999f>] ? debug_check_no_locks_freed+0x8f/0x160
> [ 1447.337756]  [<ffffffff810b3be8>] ? debug_mutex_init+0x38/0x50
> [ 1447.337760]  [<ffffffff811b28f1>] user_path_at+0x11/0x20
> [ 1447.337764]  [<ffffffff811a6c52>] vfs_fstatat+0x52/0xb0
> [ 1447.337770]  [<ffffffff810fd496>] ? __call_rcu.constprop.55+0x116/0x280
> [ 1447.337774]  [<ffffffff811a6d7b>] vfs_stat+0x1b/0x20
> [ 1447.337777]  [<ffffffff811a6d95>] SYSC_newstat+0x15/0x30
> [ 1447.337780]  [<ffffffff816ab0a7>] ? sysret_check+0x1b/0x56
> [ 1447.337784]  [<ffffffff810b9835>] ? trace_hardirqs_on_caller+0x105/0x1d0
> [ 1447.337790]  [<ffffffff8133eefe>] ? trace_hardirqs_on_thunk+0x3a/0x3f
> [ 1447.337794]  [<ffffffff811a706e>] SyS_newstat+0xe/0x10
> [ 1447.337797]  [<ffffffff816ab082>] system_call_fastpath+0x16/0x1b
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

