From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: Full lockup when compiling kernel with "optimal" number of threads
Date: Mon, 03 Oct 2011 15:09:47 +0530
Message-ID: <4E8982E3.9080809@linux.vnet.ibm.com>
References: <CAG1a4rvdYnOSWu3DJ+DL+Q_bfsfTv_px20vP06fBKRm6B8cwMw@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from e28smtp01.in.ibm.com ([122.248.162.1]:55597 "EHLO
	e28smtp01.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754004Ab1JCJju (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 3 Oct 2011 05:39:50 -0400
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
By the way "optimal" is supposed to be make -j <nr_cpus*2> isn't it?
IIRC, "maximal" refers to make -j


-- 
Regards,
Srivatsa S. Bhat  <srivatsa.bhat@linux.vnet.ibm.com>
Linux Technology Center,
IBM India Systems and Technology Lab
