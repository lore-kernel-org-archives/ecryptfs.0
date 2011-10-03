From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: Full lockup when compiling kernel with "optimal" number of threads
Date: Mon, 03 Oct 2011 15:08:12 +0530
Message-ID: <4E898284.7060906@linux.vnet.ibm.com>
References: <CAG1a4rvdYnOSWu3DJ+DL+Q_bfsfTv_px20vP06fBKRm6B8cwMw@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from e28smtp07.in.ibm.com ([122.248.162.7]:54770 "EHLO
	e28smtp07.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753891Ab1JCJiO (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 3 Oct 2011 05:38:14 -0400
In-Reply-To: <CAG1a4rvdYnOSWu3DJ+DL+Q_bfsfTv_px20vP06fBKRm6B8cwMw@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Pavel Ivanov <paivanof@gmail.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>

On 09/03/2011 09:04 AM, Pavel Ivanov wrote:
> Hi,
> 
> I can reliably reproduce a complete machine lockup when compiling
> kernel sources with "make -j". After making some progress machine
> stops responding to anything (including CapsLock/NumLock switching or
> mouse moving) and after hard reboot nothing is left in kern.log or
> syslog. Only attaching a serial console gives me the following clues
> to what happens:
> 

[...]

> After that only doing "make distclean" allows me to compile kernel
> again. And note that when I build with "make -j 10" everything works
> fine (I have 2 CPUs with 4 cores each without hyper-threading).

How much memory does your system have? Doing so many fork()s could cause
a lot of resource conflict and memory pressure leading to heavy swapping
etc., which can ultimately hang your system, especially when your RAM
size is small. It is advisable to use make -j only on systems with lot
of RAM (> 3 or 4GB).

-- 
Regards,
Srivatsa S. Bhat  <srivatsa.bhat@linux.vnet.ibm.com>
Linux Technology Center,
IBM India Systems and Technology Lab
