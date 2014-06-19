From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [trace:ftrace/core 1/3] include/trace/syscall.h:39:6: error:
 'TIF_SYSCALL_TRACEPOINT' undeclared
Date: Wed, 18 Jun 2014 21:38:33 -0400
Message-ID: <20140618213833.731d5fc4@gandalf.local.home>
References: <53a1e7ba.ZIiv6DbOB78b9RzY%fengguang.wu@intel.com>
	<20140618211559.76bdea15@gandalf.local.home>
	<20140618211737.719fcf49@gandalf.local.home>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140618211737.719fcf49@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Oleg Nesterov <oleg@redhat.com>
Cc: kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org, LKML <linux-kernel@vger.kernel.org>, Tyler Hicks <tyhicks@canonical.com>, ecryptfs@vger.kernel.org


Hmm, removed Michael Halcrow as I'm guessing he no longer works for IBM.

On Wed, 18 Jun 2014 21:17:37 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 18 Jun 2014 21:15:59 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Thu, 19 Jun 2014 03:25:46 +0800
> > kbuild test robot <fengguang.wu@intel.com> wrote:
> > 
> > > tree:   git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git ftrace/core
> > > head:   72fa1a896d8ef355e81270667803ceb16a3dd13f
> > > commit: 32def52ce8faec72c353b6304ca98176687e18f1 [1/3] tracing: Fix syscall_*regfunc() vs copy_process() race
> > > config: make ARCH=xtensa allyesconfig
> > > 
> > > All error/warnings:
> > > 
> > >    In file included from include/linux/syscalls.h:80:0,
> > >                     from fs/ecryptfs/keystore.c:29:
> > >    include/trace/syscall.h: In function 'syscall_tracepoint_update':
> > > >> include/trace/syscall.h:39:6: error: 'TIF_SYSCALL_TRACEPOINT' undeclared (first use in this function)
> > >    include/trace/syscall.h:39:6: note: each undeclared identifier is reported only once for each function it appears in
> > > 
> > > vim +/TIF_SYSCALL_TRACEPOINT +39 include/trace/syscall.h
> > > 
> > >     33		struct ftrace_event_call *exit_event;
> > >     34	};
> > >     35	
> > >     36	#ifdef CONFIG_TRACEPOINTS
> > >     37	static inline void syscall_tracepoint_update(struct task_struct *p)
> > >     38	{
> > >   > 39		if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
> > >     40			set_tsk_thread_flag(p, TIF_SYSCALL_TRACEPOINT);
> > >     41		else
> > >     42			clear_tsk_thread_flag(p, TIF_SYSCALL_TRACEPOINT);
> > > 
> > > ---
> > > 0-DAY kernel build testing backend              Open Source Technology Center
> > > http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
> > 
> > My allyesconfig build passed with flying colors. Although we should
> 
> I should elaborate. I was building against mainline, I noticed that the
> kbuild test included linux-next.

My entire test suite passed. I'm not going to bother with adding the
header now, as it shouldn't affect mainline. I'm going to push my
changes up to linux-next tonight and push to Linus tomorrow.

The keystore.c shouldn't have included the syscall.h file, so if it
needs to be fixed before we get the thread_info.h in, they can just
remove it (my patch was attached to the previous email).

-- Steve
