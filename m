From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bugreport on Ubuntu LTS: not ok - 2 Objects creation does not
 break ACLs with restrictive umask
Date: Tue, 05 Jun 2012 09:31:54 -0700
Message-ID: <7vpq9dpvnp.fsf@alter.siamese.dyndns.org>
References: <7vy5o2ra7w.fsf@alter.siamese.dyndns.org>
 <vpqpq9ejnxs.fsf@bauges.imag.fr>
 <CALbm-EZrKGaj1Q7gbmPmG0wQHxksnJqaS3bz3tMDsego7Zm2ZQ@mail.gmail.com>
 <20120605075614.GE25809@sigill.intra.peff.net>
 <vpq4nqqj8ss.fsf@bauges.imag.fr>
 <CALbm-EbGoaxkvBXphAPF8rRkS=VFeeFHXQSFdWVrZUJJ8DYovw@mail.gmail.com>
 <vpqk3zlhorc.fsf@bauges.imag.fr>
 <20120605140449.GA15640@sigill.intra.peff.net>
 <20120605141039.GB15640@sigill.intra.peff.net>
 <20120605142813.GA17238@sigill.intra.peff.net>
 <20120605150550.GA19843@sigill.intra.peff.net>
Mime-Version: 1.0
Return-path: <git-owner@vger.kernel.org>
In-Reply-To: <20120605150550.GA19843@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 5 Jun 2012 11:05:50 -0400")
Sender: git-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeff King <peff@peff.net>
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, ecryptfs@vger.kernel.org, Stefan Beller <stefanbeller@googlemail.com>, git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> [+cc ecryptfs@vger, as I think this is an ecryptfs bug]
>
> On Tue, Jun 05, 2012 at 10:28:13AM -0400, Jeff King wrote:
>
>> OK, here's the _real_ issue. Git creates with mode 0444, which should
>> still allow read in the mask. But it's the restrictive umask at the top
>> of the test script that causes the problem. Try this:
>> 
>>   setfacl -m m:rwx .
>>   perl -MFcntl -e 'sysopen(X, "a", O_WRONLY|O_CREAT, 0444)'
>>   umask 077
>>   perl -MFcntl -e 'sysopen(X, "b", O_WRONLY|O_CREAT, 0444)'
>>   getfacl a b
>> 
>> On ext4, both files will have the read bit set in the mask. On ecryptfs,
>> "b" will have an empty mask. I think the wrong thing is that we should
>> not be respecting umask at all when default ACLs are in play, and
>> ecryptfs is getting that wrong. But I'm having trouble digging up an
>> authoritative source.
>
> Reading the withdrawn posix 1003.1e and "man 5 acl", it seems pretty
> clear that if a default ACL is present, it should be used, and umask
> consulted only if it is not (so the umask should not be making a
> difference in this case).
>
> The reproduction recipe above shows the minimum required to trigger it;
> adding a more realistic default ACL (with actual entries for users) does
> not seem to make a difference.

Thanks; so combining the above with your earlier patch to 1304 we
would have a good detection for SETFACL prerequisite?
 
