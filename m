From: Wiebe Cazemier <wiebe@halfgaar.net>
Subject: Re: Key derivation and passprhase wrapping
Date: Wed, 20 Jan 2016 20:51:43 +0100 (CET)
Message-ID: <1032370780.234696.1453319503133.JavaMail.zimbra@halfgaar.net>
References: <794484591.224591.1452104561446.JavaMail.zimbra@halfgaar.net> <676716416.231851.1453112857325.JavaMail.zimbra@halfgaar.net> <20160120030556.GC5623@boyd>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from meel.halfgaar.net ([83.137.146.229]:44936 "EHLO
	meel.halfgaar.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758319AbcATTvt (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Wed, 20 Jan 2016 14:51:49 -0500
In-Reply-To: <20160120030556.GC5623@boyd>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Tyler Hicks <tyhicks@canonical.com>
Cc: ecryptfs@vger.kernel.org

----- Original Message -----
> From: "Tyler Hicks" <tyhicks@canonical.com>
> To: "Wiebe Cazemier" <wiebe@halfgaar.net>
> Cc: ecryptfs@vger.kernel.org
> Sent: Wednesday, 20 January, 2016 4:05:57 AM
> Subject: Re: Key derivation and passprhase wrapping
> 
> On 2016-01-18 11:27:37, Wiebe Cazemier wrote:
> > Hi,
> > 
> > I was looking at the ecryptfs source code, and saw that the actual
> > encryption key inserted into the kernel keyring is the *original*
> > wrapped passphrase, SHA512'ed 65536 times. Why is a user-given
> > passphrase encrypted as key, and not data from /dev/random?
> 
> This assumes that the mount.ecryptfs helper is used and not the
> mount.ecryptfs_private helper.
> 
> mount.ecryptfs does key stretching (SHA512 * 65536) on a user-provided
> passphrase and uses that as the file encryption key encryption key
> (FEKEK). This keeps things simple so that the only thing a user needs to
> access their encrypted files is the passphrase. There's no chance of
> losing track of a file containing a wrapped FEKEK that is randomly
> generated. However, mount.ecryptfs could be extended to make use of
> wrapped, randomly generated FEKEK which would provide a more secure
> option.
> 
> > I unwrapped the passphrase on my Linux Mint system and saw it is
> > actually a random string, so the Ubuntu/Mint installer took care of it
> > for me. But why is that responsibility given to the user / outside
> > world?
> 
> All of the logic that set up that random FEKEK is in upstream
> ecryptfs-utils. The confusion is probably caused by the unfortunate
> split between the mount.ecryptfs and mount.ecryptfs_private helpers.
> 
> > One of the problems is that I can't change it. Had I made a
> > ecryptfs archive myself and wrapped 'hello' as passphrase, that weak
> > key will be used and cannot be changed by rewrapping.
> > 
> > Would it be possible/feasible to do something like:
> > 
> > * generate random encryption key A for insertion into kernel keyring.
> > * derive encryption key B from password with 'generate_passphrase_sig(...)'
> > to encrypt key A.
> > * In v2 wrapped passphrase file, Octets 26-N1, store encrypted A, instead
> > of encrypted passphrase.
> 
> I'm not following the intent here. You're wanting to change the FEKEK
> that the Ubuntu/Mint installer generated?
> 
> Tyler
> 
> > 
> > Depending on how it's implemented, it could even be done completely
> > backwards compatible (by ignoring the to-wrap passphrase).
> > 
> > Regards,
> > 
> > Wiebe

I think I missed an important bit. I was looking at ecryptfs-wrap-passphrase, which makes you supply the FEK and FEKEK, but ecryptfs-setup-private actually already uses a random passphrase:

-m, --mountpass MOUNTPASS
    Passphrase for mounting the ecryptfs directory, default is 16 bytes from /dev/urandom if omitted

Never mind ;)
