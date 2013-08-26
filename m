From: Ryan Sawhill <rsaw@redhat.com>
Subject: Re: Problem using ecryptfs on top of NFS
Date: Mon, 26 Aug 2013 14:08:50 -0400
Message-ID: <521B99B2.1030606@redhat.com>
References: <CAF_v8EnuFajjQ3BDTYQnqWpKdJbUh+APS51WyY09TNvzjkD=Xw@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:31129 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751381Ab3HZSIv (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
	Mon, 26 Aug 2013 14:08:51 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r7QI8psd009812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ecryptfs@vger.kernel.org>; Mon, 26 Aug 2013 14:08:51 -0400
Received: from [10.10.56.230] (vpn-56-230.rdu2.redhat.com [10.10.56.230])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id r7QI8oEY011285
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ecryptfs@vger.kernel.org>; Mon, 26 Aug 2013 14:08:50 -0400
In-Reply-To: <CAF_v8EnuFajjQ3BDTYQnqWpKdJbUh+APS51WyY09TNvzjkD=Xw@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: ecryptfs@vger.kernel.org

On 08/04/2013 03:20 PM, Ruben Gaspar wrote:
> I am trying to mount ecryptfs on top of an NFS mount, but I get following error:
>
> Error mounting eCryptfs: [-22] Invalid argument
> Check your system logs; visit <http://launchpad.net/ecryptfs>
>
>
> Checking my /var/log/messages I found:
>
> Mount request on top of filesystem type [nfs]
> Mount on filesystem of type [nfs] explicitly disallowed due to known
> incompatibilities
> Invalid lower filesystem type
>

I'm confused by your comments -- you copied and pasted the above error 
message, but you don't seem to have read it..? In any case, what it says 
is true.

Here's a comment (from one of the main developers) on the relevant bug 
-- still accurate AFAIK: 
https://bugs.launchpad.net/ecryptfs/+bug/277578/comments/23
