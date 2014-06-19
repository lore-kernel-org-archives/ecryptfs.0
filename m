From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [trace:ftrace/core 1/3] include/trace/syscall.h:39:6: error:
 'TIF_SYSCALL_TRACEPOINT' undeclared
Date: Thu, 19 Jun 2014 12:08:24 -0400
Message-ID: <20140619120824.1fed4b2f@gandalf.local.home>
References: <53a1e7ba.ZIiv6DbOB78b9RzY%fengguang.wu@intel.com>
	<20140618211559.76bdea15@gandalf.local.home>
	<20140618211737.719fcf49@gandalf.local.home>
	<20140618213833.731d5fc4@gandalf.local.home>
	<20140619150300.GA7215@redhat.com>
	<20140619112635.41412408@gandalf.local.home>
	<20140619155108.GA15883@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.227]:50726 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758069AbaFSQI1 (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Thu, 19 Jun 2014 12:08:27 -0400
In-Reply-To: <20140619155108.GA15883@redhat.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Oleg Nesterov <oleg@redhat.com>
Cc: kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org, LKML <linux-kernel@vger.kernel.org>, Tyler Hicks <tyhicks@canonical.com>, ecryptfs@vger.kernel.org

On Thu, 19 Jun 2014 17:51:08 +0200
Oleg Nesterov <oleg@redhat.com> wrote:

> Please tell me if I should another "[PATCH]" email or resend 2-3 as well.
> Sorry for inconvenience.

This is fine. I'm going to do what I seldom do and rebase my for-next
branch with this one instead.

But first I'll run this through my cross-compile tests. I should have
done that the fist time :-/

-- Steve

> 
> -------------------------------------------------------------------------------
> Subject: [PATCH] tracing: Fix syscall_*regfunc() vs copy_process() race
> 
> syscall_regfunc() and syscall_unregfunc() should set/clear
> TIF_SYSCALL_TRACEPOINT system-wide, but do_each_thread() can race
> with copy_process() and miss the new child which was not added to
> the process/thread lists yet.
> 
> Change copy_process() to update the child's TIF_SYSCALL_TRACEPOINT
> under tasklist.
> 
> Link: http://lkml.kernel.org/p/20140413185854.GB20668@redhat.com
> 
> Cc: stable@vger.kernel.org # 2.6.33
> Fixes: a871bd33a6c0 "tracing: Add syscall tracepoints"
> Acked-by: Frederic Weisbecker <fweisbec@gmail.com>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  include/trace/syscall.h |   15 +++++++++++++++
>  kernel/fork.c           |    2 ++
>  2 files changed, 17 insertions(+), 0 deletions(-)
> 
> diff --git a/include/trace/syscall.h b/include/trace/syscall.h
> index fed853f..9674145 100644
> --- a/include/trace/syscall.h
> +++ b/include/trace/syscall.h
> @@ -4,6 +4,7 @@
>  #include <linux/tracepoint.h>
>  #include <linux/unistd.h>
>  #include <linux/ftrace_event.h>
> +#include <linux/thread_info.h>
>  
>  #include <asm/ptrace.h>
>  
> @@ -32,4 +33,18 @@ struct syscall_metadata {
>  	struct ftrace_event_call *exit_event;
>  };
>  
> +#if defined(CONFIG_TRACEPOINTS) && defined(CONFIG_HAVE_SYSCALL_TRACEPOINTS)
> +static inline void syscall_tracepoint_update(struct task_struct *p)
> +{
> +	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
> +		set_tsk_thread_flag(p, TIF_SYSCALL_TRACEPOINT);
> +	else
> +		clear_tsk_thread_flag(p, TIF_SYSCALL_TRACEPOINT);
> +}
> +#else
> +static inline void syscall_tracepoint_update(struct task_struct *p)
> +{
> +}
> +#endif
> +
>  #endif /* _TRACE_SYSCALL_H */
> diff --git a/kernel/fork.c b/kernel/fork.c
> index cafea61..f7417f5 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1485,7 +1485,9 @@ static struct task_struct *copy_process(unsigned long clone_flags,
>  
>  	total_forks++;
>  	spin_unlock(&current->sighand->siglock);
> +	syscall_tracepoint_update(p);
>  	write_unlock_irq(&tasklist_lock);
> +
>  	proc_fork_connector(p);
>  	cgroup_post_fork(p);
>  	if (clone_flags & CLONE_THREAD)
