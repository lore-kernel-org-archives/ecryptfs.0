From: Dustin Kirkland <dustin.kirkland@gazzang.com>
Subject: Re: ecryptfs with aes-ni slower bug
Date: Wed, 15 Feb 2012 10:16:49 -0600
Message-ID: <CANT6BaNYU_sMA=0rdtAh=tvx7NmOfbuno=2QvVXaFPooOHzm-A@mail.gmail.com>
References: <CAB89gJErehp2bw6XuWghBXT9D4632rgtowUVqSsna2ng8XQ5Sw@mail.gmail.com>
	<20120215104815.GB1991@boyd>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:57919 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907Ab2BOQQt convert rfc822-to-8bit (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Wed, 15 Feb 2012 11:16:49 -0500
Received: by pbcun15 with SMTP id un15so1518823pbc.19
        for <ecryptfs@vger.kernel.org>; Wed, 15 Feb 2012 08:16:49 -0800 (PST)
In-Reply-To: <20120215104815.GB1991@boyd>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Tyler Hicks <tyhicks@canonical.com>
Cc: =?ISO-8859-1?Q?Stefan_Dr=F6ge?= <stefan@sdroege.de>, ecryptfs@vger.kernel.org

On Wed, Feb 15, 2012 at 4:48 AM, Tyler Hicks <tyhicks@canonical.com> wr=
ote:
> On 2012-02-15 11:43:21, Stefan Dr=F6ge wrote:
>> Hi all,
>> A while ago I read at phoronix, that ecryptfs is actually slower whe=
n
>> having loaded the aesni-intel kernel module.
>> Out of curiosiy I checked whether this problem still exists in the
>> Ubuntu 12.04 alpha2, and it does.
>> I tried to find infos to this in the mailing list archive, but I fou=
nd nothing.
>>
>> So my question: Is somebody working on this?
>
> No, not currently. I've been focusing on stability rather than
> performance.
>
> I'd love for someone else to become interested in the problem and dig
> in. Otherwise, it will have to wait a while longer until I get some f=
ree
> cycles to look into it.

I have made contact with an engineer at Intel working on AES-NI who
agreed to take a look at this.  That was several weeks ago.  I'll
check in with them and report back if there's any progress.

--=20
:-Dustin

Dustin Kirkland
Chief Architect
Gazzang, Inc.
www.gazzang.com
