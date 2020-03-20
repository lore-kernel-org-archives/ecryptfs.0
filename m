From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 0/2] Don't generate thousands of new warnings when
 building docs
Date: Fri, 20 Mar 2020 17:10:20 -0600
Message-ID: <20200320171020.78f045c5@lwn.net>
References: <cover.1584716446.git.mchehab+huawei@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from ms.lwn.net ([45.79.88.28]:44012 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbgCTXKk (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
        Fri, 20 Mar 2020 19:10:40 -0400
In-Reply-To: <cover.1584716446.git.mchehab+huawei@kernel.org>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, linux-kernel@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>, Paul Mackerras <paulus@samba.org>, Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>, "David S. Miller" <davem@davemloft.net>, Ricardo Ribalda Delgado <ribalda@kernel.org>, Luca Ceresoli <luca@lucaceresoli.net>, dmaengine@vger.kernel.org, Matthias Maennich <maennich@google.com>, Harry Wei <harryxiyou@gmail.com>, x86@kernel.org, ecryptfs@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, target-devel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Johannes Berg <johannes.berg@intel.com>, Jacopo Mondi <jacopo@jmondi.org>, Tyler Hicks <>

On Fri, 20 Mar 2020 16:11:01 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> This small series address a regression caused by a new patch at
> docs-next (and at linux-next).

I don't know how I missed that mess, sorry.  I plead distracting times or
something like that.  Heck, I think I'll blame everything on the plague
for at least the next few weeks.

Anyway, I've applied this, thanks for cleaning it up.

jon
