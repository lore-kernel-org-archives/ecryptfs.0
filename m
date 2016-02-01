From: Wiebe Cazemier <wiebe@halfgaar.net>
Subject: Re: bcrypt or other key derivation algorithm
Date: Mon, 1 Feb 2016 10:50:02 +0100 (CET)
Message-ID: <1568282244.245128.1454320201987.JavaMail.zimbra@halfgaar.net>
References: <148109963.231852.1453113382610.JavaMail.zimbra@halfgaar.net> <477778683.231885.1453114296832.JavaMail.zimbra@halfgaar.net> <CAOkUe-DgVJ6DPaL0UnTM7T1FzDEvWV6_HwsSvVDVTj5F_JW6vg@mail.gmail.com> <2036538347.232681.1453192534353.JavaMail.zimbra@halfgaar.net> <20160129223434.GC15683@boyd>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from meel.halfgaar.net ([83.137.146.229]:33206 "EHLO
	meel.halfgaar.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554AbcBAJuO (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 1 Feb 2016 04:50:14 -0500
In-Reply-To: <20160129223434.GC15683@boyd>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Tyler Hicks <tyhicks@canonical.com>
Cc: Sylvain Pelissier <sylvain.pelissier@gmail.com>, ecryptfs@vger.kernel.org

----- Original Message -----
> From: "Tyler Hicks" <tyhicks@canonical.com>
> To: "Wiebe Cazemier" <wiebe@halfgaar.net>
> Cc: "Sylvain Pelissier" <sylvain.pelissier@gmail.com>, ecryptfs@vger.kernel.org
> Sent: Friday, 29 January, 2016 11:34:34 PM
> Subject: Re: bcrypt or other key derivation algorithm
> > 
> > That's interesting. I wonder why nobody is talking about it. Bcrypt and
> > scrypt are all the rage, and even those are not fully trusted by all,
> > because they haven't withstood the test of time.
> > 
> > Question remains though, I can't implement it without knowing what to do
> > with the v2 wrapped passphrase file. I can think of something myself, but
> > I'd rather do something that I know won't be rejected :)
> > 
> > From the source code:
> > 
> >  * Reads a version 2 wrapped passphrase file containing the following
> >  format:
> >  *
> >  *   Octet  0:      A ':' character
> >  *   Octet  1:      uint8_t value indicating file version (MUST be 0x02)
> >  *   Octets 2-9:    Wrapping salt
> >  *   Octets 10-25:  Signature of wrapping key (16 octets)
> >  *   Octets 26-N1:  Variable length field containing the encrypted
> >  *                  passphrase. (Up to 64 octets. Must be non-empty.)
> > 
> > Would a v3 be in order?:
> > 
> >  *   Octet  0:      A ':' character
> >  *   Octet  1:      uint8_t value indicating file version (MUST be 0x03)
> >  *   Octet  2:      uint8_t id of hashing algorithm.
> 
> Don't you mean KDF instead of hashing algorithm here? (scrypt, PBKDF2,
> etc.)

Yeah, of course. I was thinking to much about hashing when I wrote this.

> 
> >  *   Octets 3-10:   Wrapping salt
> >  *   Octets 11-26:  Signature of wrapping key (16 octets)
> >  *   Octets 27-N1:  Variable length field containing the encrypted
> >  *                  passphrase. (Up to 64 octets. Must be non-empty.)
> 
> If octet 2 is KDF instead of hashing algorithm, octets 3-N1 are going
> to vary based on the KDF used. For instance, scrypt will need to store
> the values of N, r, and p while PBKDF2 will need to store the number of
> iterations.

Then I suggest having a variable length byte array in it. The signature can be constant regardless of KDF, so I'd say:

* Octet 0       :
* Octet 1       File version in uint_8
* Octet 2       KDF in uint8
* Octet 3-18    Signature (16 octects)
* Octet 19-N1   byte array, depending on KDF. 

When the KDF is SHA512*65536 as it's now, 19-N1 can contain the salt and encrypted passphrase. For other KDFs, it can be whatever the desired algorithm needs.

