From: Wiebe Cazemier <wiebe@halfgaar.net>
Subject: Re: bcrypt or other key derivation algorithm
Date: Tue, 19 Jan 2016 09:35:34 +0100 (CET)
Message-ID: <2036538347.232681.1453192534353.JavaMail.zimbra@halfgaar.net>
References: <148109963.231852.1453113382610.JavaMail.zimbra@halfgaar.net> <477778683.231885.1453114296832.JavaMail.zimbra@halfgaar.net> <CAOkUe-DgVJ6DPaL0UnTM7T1FzDEvWV6_HwsSvVDVTj5F_JW6vg@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from meel.halfgaar.net ([83.137.146.229]:59748 "EHLO
	meel.halfgaar.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757323AbcASIfj (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 19 Jan 2016 03:35:39 -0500
In-Reply-To: <CAOkUe-DgVJ6DPaL0UnTM7T1FzDEvWV6_HwsSvVDVTj5F_JW6vg@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Sylvain Pelissier <sylvain.pelissier@gmail.com>
Cc: ecryptfs@vger.kernel.org

----- Original Message -----
> From: "Sylvain Pelissier" <sylvain.pelissier@gmail.com>
> To: "Wiebe Cazemier" <wiebe@halfgaar.net>
> Cc: ecryptfs@vger.kernel.org
> Sent: Monday, 18 January, 2016 12:00:36 PM
> Subject: Re: bcrypt or other key derivation algorithm
> 
> Hi,
> 
> I think it is a good idea to support stronger algorithms. As a new
> hashing algorithm, you can also consider Argon2 algorithm, the winner
> of the Password hashing compettion (https://password-hashing.net/).
> The implementation is already available:
> https://github.com/p-h-c/phc-winner-argon2.
> Reagrds
> 
> Sylvain

That's interesting. I wonder why nobody is talking about it. Bcrypt and scrypt are all the rage, and even those are not fully trusted by all, because they haven't withstood the test of time.

Question remains though, I can't implement it without knowing what to do with the v2 wrapped passphrase file. I can think of something myself, but I'd rather do something that I know won't be rejected :)

From the source code:

 * Reads a version 2 wrapped passphrase file containing the following format:
 *
 *   Octet  0:      A ':' character
 *   Octet  1:      uint8_t value indicating file version (MUST be 0x02)
 *   Octets 2-9:    Wrapping salt
 *   Octets 10-25:  Signature of wrapping key (16 octets)
 *   Octets 26-N1:  Variable length field containing the encrypted
 *                  passphrase. (Up to 64 octets. Must be non-empty.)

Would a v3 be in order?:

 *   Octet  0:      A ':' character
 *   Octet  1:      uint8_t value indicating file version (MUST be 0x03)
 *   Octet  2:      uint8_t id of hashing algorithm.
 *   Octets 3-10:   Wrapping salt
 *   Octets 11-26:  Signature of wrapping key (16 octets)
 *   Octets 27-N1:  Variable length field containing the encrypted
 *                  passphrase. (Up to 64 octets. Must be non-empty.)


Regards,

Wiebe
