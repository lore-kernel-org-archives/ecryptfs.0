From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bugreport on Ubuntu LTS: not ok - 2 Objects creation does not
 break ACLs with restrictive umask
Date: Tue, 05 Jun 2012 10:27:39 -0700
Message-ID: <7v62b5pt2s.fsf@alter.siamese.dyndns.org>
References: <CALbm-EZrKGaj1Q7gbmPmG0wQHxksnJqaS3bz3tMDsego7Zm2ZQ@mail.gmail.com>
 <20120605075614.GE25809@sigill.intra.peff.net>
 <vpq4nqqj8ss.fsf@bauges.imag.fr>
 <CALbm-EbGoaxkvBXphAPF8rRkS=VFeeFHXQSFdWVrZUJJ8DYovw@mail.gmail.com>
 <vpqk3zlhorc.fsf@bauges.imag.fr>
 <20120605140449.GA15640@sigill.intra.peff.net>
 <20120605141039.GB15640@sigill.intra.peff.net>
 <20120605142813.GA17238@sigill.intra.peff.net>
 <20120605150550.GA19843@sigill.intra.peff.net>
 <7vpq9dpvnp.fsf@alter.siamese.dyndns.org>
 <20120605164439.GA2694@sigill.intra.peff.net>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48213 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753975Ab2FER1o (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
	Tue, 5 Jun 2012 13:27:44 -0400
In-Reply-To: <20120605164439.GA2694@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 5 Jun 2012 12:44:39 -0400")
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeff King <peff@peff.net>
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, ecryptfs@vger.kernel.org, Stefan Beller <stefanbeller@googlemail.com>, git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Jun 05, 2012 at 09:31:54AM -0700, Junio C Hamano wrote:
>
>> >>   setfacl -m m:rwx .
>> >>   perl -MFcntl -e 'sysopen(X, "a", O_WRONLY|O_CREAT, 0444)'
>> >>   umask 077
>> >>   perl -MFcntl -e 'sysopen(X, "b", O_WRONLY|O_CREAT, 0444)'
>> >>   getfacl a b
>> [...]
>> >
>> > Reading the withdrawn posix 1003.1e and "man 5 acl", it seems pretty
>> > clear that if a default ACL is present, it should be used, and umask
>> > consulted only if it is not (so the umask should not be making a
>> > difference in this case).
>> >
>> > The reproduction recipe above shows the minimum required to trigger it;
>> > adding a more realistic default ACL (with actual entries for users) does
>> > not seem to make a difference.
>> 
>> Thanks; so combining the above with your earlier patch to 1304 we
>> would have a good detection for SETFACL prerequisite?
>
> Yes, I think we can detect it reliably. I'd like to hear back from
> ecryptfs folks before making a final patch, though. It may be that there
> is some subtle reason for their behavior, and I want to make sure before
> we write it off as just buggy.

Sensible; thanks.
