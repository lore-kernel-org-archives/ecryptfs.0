From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: Bugreport on Ubuntu LTS: not ok - 2 Objects creation does not
 break ACLs with restrictive umask
Date: Tue, 5 Jun 2012 22:45:25 +0200
Message-ID: <CALbm-Ea2e=zYnzmvUrzbmJwXBD8j5EizbcLaZgD=5T4gJsYvdA@mail.gmail.com>
References: <20120605075614.GE25809@sigill.intra.peff.net>
	<vpq4nqqj8ss.fsf@bauges.imag.fr>
	<CALbm-EbGoaxkvBXphAPF8rRkS=VFeeFHXQSFdWVrZUJJ8DYovw@mail.gmail.com>
	<vpqk3zlhorc.fsf@bauges.imag.fr>
	<20120605140449.GA15640@sigill.intra.peff.net>
	<20120605141039.GB15640@sigill.intra.peff.net>
	<20120605142813.GA17238@sigill.intra.peff.net>
	<20120605150550.GA19843@sigill.intra.peff.net>
	<7vpq9dpvnp.fsf@alter.siamese.dyndns.org>
	<20120605164439.GA2694@sigill.intra.peff.net>
	<20120605191637.GC25709@boyd>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:51304 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239Ab2FEUp0 convert rfc822-to-8bit (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 5 Jun 2012 16:45:26 -0400
In-Reply-To: <20120605191637.GC25709@boyd>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Tyler Hicks <tyhicks@canonical.com>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, ecryptfs@vger.kernel.org, git@vger.kernel.org

Hi Tyler et all,

thanks for all your help :)

cat /proc/version_signature
Ubuntu 3.2.0-25.40-generic 3.2.18

I filed a bug at launchpad, which contains all my OS versions etc,
please see https://bugs.launchpad.net/ubuntu/+source/ecryptfs-utils/+bu=
g/1009207
I marked it as security issue as it deals with ACL.

Thanks for all the help here on the git mailing list.

A happy git user,
Stefan



2012/6/5 Tyler Hicks <tyhicks@canonical.com>:
> On 2012-06-05 12:44:39, Jeff King wrote:
>> On Tue, Jun 05, 2012 at 09:31:54AM -0700, Junio C Hamano wrote:
>>
>> > >> =A0 setfacl -m m:rwx .
>> > >> =A0 perl -MFcntl -e 'sysopen(X, "a", O_WRONLY|O_CREAT, 0444)'
>> > >> =A0 umask 077
>> > >> =A0 perl -MFcntl -e 'sysopen(X, "b", O_WRONLY|O_CREAT, 0444)'
>> > >> =A0 getfacl a b
>> > [...]
>> > >
>> > > Reading the withdrawn posix 1003.1e and "man 5 acl", it seems pr=
etty
>> > > clear that if a default ACL is present, it should be used, and u=
mask
>> > > consulted only if it is not (so the umask should not be making a
>> > > difference in this case).
>> > >
>> > > The reproduction recipe above shows the minimum required to trig=
ger it;
>> > > adding a more realistic default ACL (with actual entries for use=
rs) does
>> > > not seem to make a difference.
>> >
>> > Thanks; so combining the above with your earlier patch to 1304 we
>> > would have a good detection for SETFACL prerequisite?
>>
>> Yes, I think we can detect it reliably. I'd like to hear back from
>> ecryptfs folks before making a final patch, though. It may be that t=
here
>> is some subtle reason for their behavior, and I want to make sure be=
fore
>> we write it off as just buggy.
>
> It is likely a bug in the eCryptfs filesystem stacking code.
>
> However, using the above script, I get the same results on eCryptfs a=
s I
> do on ext4 in the Ubuntu 12.04 (Precise) LTS:
>
> # file: a
> # owner: tyhicks
> # group: tyhicks
> user::r--
> group::r--
> other::r--
>
> # file: b
> # owner: tyhicks
> # group: tyhicks
> user::r--
> group::---
> other::---
>
> Stefan - can you specify which LTS release you're running as well as =
the
> output of `cat /proc/version_signature`? Thanks!
>
> Tyler
