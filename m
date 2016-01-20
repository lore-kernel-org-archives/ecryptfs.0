From: Wiebe Cazemier <wiebe@halfgaar.net>
Subject: Re: bcrypt or other key derivation algorithm
Date: Wed, 20 Jan 2016 20:33:29 +0100 (CET)
Message-ID: <1009266489.234663.1453318409855.JavaMail.zimbra@halfgaar.net>
References: <148109963.231852.1453113382610.JavaMail.zimbra@halfgaar.net> <477778683.231885.1453114296832.JavaMail.zimbra@halfgaar.net> <20160120024844.GA5623@boyd>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from meel.halfgaar.net ([83.137.146.229]:44816 "EHLO
	meel.halfgaar.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112AbcATTdi (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Wed, 20 Jan 2016 14:33:38 -0500
In-Reply-To: <20160120024844.GA5623@boyd>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Tyler Hicks <tyhicks@canonical.com>
Cc: ecryptfs@vger.kernel.org

----- Original Message -----
> From: "Tyler Hicks" <tyhicks@canonical.com>
> To: "Wiebe Cazemier" <wiebe@halfgaar.net>
> Cc: ecryptfs@vger.kernel.org
> Sent: Wednesday, 20 January, 2016 3:48:44 AM
> Subject: Re: bcrypt or other key derivation algorithm
> 
> > It should be easy enough to borrow code from OpenSSH, which uses
> > bcrypt in their secure new private key file format (ssh-keygen -o;
> > their old format is pretty weak (MD5 once, encrypt with AES 128)).
> > 
> > Questions:
> > 
> > 1) The v2 wrapped does not have a field to indicate which algorithm is
> >    used (like /etc/shadow (crypt API) has). Does this necessitate a
> >    v3, which does have said field?
> 
> Yes. The v2 wrapped passphrase format was intended to be the most simple
> fix possible for CVE-2014-9687 in order to make backporting to stable
> releases and transparent upgrades easy.
> 
> The thought was always that a v3 would be needed to support greater
> algorithm agility.

Has there already been plans for the layout of v3? Is it as simple as my suggestion?

The read_v2_wrapped_passphrase_file method could be renamed to read_v2plus_wrapped_passphrase_file and use different offsets for v3. 

> 
> > 2) Are there objections to including BSD licensed code from OpenSSH?
> 
> That bit of code looks like it is under the 4-clause BSD license. I
> think that'll be a problem since the ecryptfs-utils project is GPLv2.
> 
> Can you reuse the crypt(3) interface, passing the "2a" ID for bcrypt?

The man page for crypt says: 

  2a | Blowfish (not in mainline glibc; added in some Linux distributions)". 

A Debian 5 system I still have says:

  2a | Blowfish (on some Linux distributions)

It's not as portable, apparently.

Also, it's a little inconvenient that it returns an encoded string, not bytes. But I guess that's convertable.

I'll look a bit more for bcrypt code/libs.

Is ecryptfs Linux only, BTW?
