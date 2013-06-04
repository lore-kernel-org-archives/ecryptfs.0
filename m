From: Will Morrison <camocrazed@gmail.com>
Subject: Re: [RFC] eCryptfs: Add mount option for cipher mode
Date: Mon, 03 Jun 2013 23:46:44 -0400
Message-ID: <51AD6324.1070505@gmail.com>
References: <51ACCEC9.3070303@gmail.com> <20130604015101.GA4162@boyd>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:33522 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756871Ab3FDDqm (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 3 Jun 2013 23:46:42 -0400
Received: by mail-oa0-f49.google.com with SMTP id k14so1487660oag.8
        for <ecryptfs@vger.kernel.org>; Mon, 03 Jun 2013 20:46:42 -0700 (PDT)
In-Reply-To: <20130604015101.GA4162@boyd>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Tyler Hicks <tyhicks@canonical.com>
Cc: ecryptfs@vger.kernel.org, Zameer Manji <zmanji@gmail.com>, Michael Chang <thenewme91@gmail.com>, Alvin Tran <althaitran@gmail.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 13-06-03 09:51 PM, Tyler Hicks wrote:

> To start things off... when you have a side note, such as your
> paragraph above mentioning that this is your first kernel patch,
> you don't want something like that to end up in the commit log
> history forever. A good place for notes like that is below the ---
> line and above the diff command. Most patch merging tools should
> ignore that content and keep it from being recorded forever in the
> commit history. (I know that you didn't intend for this patch to be
> upstreamed at this time, but I thought I'd mention this tip.)

Didn't know that, thanks for the tip. :)

> I'll assume that this means that you're not using git. If you plan
> to continue doing kernel development (or really any open source 
> development) after this feature, I'd recommend that you work on 
> acquiring basic git skills. You previously asked what can help
> speed up your development workflow and understanding git is
> certainly something that will help.

We are actually using git for development. I used diff to generate the
patch because I was following Documentation/SubmittingPatches, which
gives diff commands.

What should we be using to generate the patches? git diff?

> In fact, this patch won't apply for me using `git am -is
> /path/to/mbox`. I'm not immediately sure why, but I do see some
> extra '-' characters in the areas that git complains about.
> 
> It might be because you GPG-signed the email. GPG signing patches
> would seem like a good thing to do, but
> Documentation/email-clients.txt claims that it causes some problems
> and recommends that you don't sign patches.

I can disable GPG signing for patches easily enough, or switch to
using PGP/MIME. Would one or the other be preferable? I don't know if
git can deal with PGP/MIME emails.

> Running the following search and replace in vim:
> 
> :%s/^- -/-/g
> 
> and stripping off the GPG header/footer, I'm kind of able to get
> the patch to apply. There's offset and fuzz issues, so git am won't
> apply it (but patch will, of course). Which kernel tree did you
> develop the patch against?

will@Aldor ~/FYDP/ecryptfs_base $ git log -1
commit f6161aa153581da4a3867a2d1a7caf4be19b6ec9
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun Mar 10 16:54:19 2013 -0700

    Linux 3.9-rc2

>> +	strncpy(crypt_stat->cipher_mode, +
>> crypt_stat->mount_crypt_stat->global_default_cipher_mode_name, +
>> ECRYPTFS_MAX_CIPHER_MODE_NAME_SIZE);
> 
> This is a problem. eCryptfs files are atomic in that they contain
> all of the information needed to decrypt the file (except for the
> FEKEK) in the header. So a single eCryptfs mount may contain files
> encrypted by AES-128, AES-256, blowfish, the FEK can be wrapped
> with a public key, multiple FEKEKs can be used, etc., and eCryptfs
> can seamlessly handle it because of the various metadata stored in
> the file header.
> 
> At first glance, it doesn't look like RFC2440 defines a field for 
> different cipher modes. eCryptfs has always just made the
> assumption that it should use its tweaked CBC mode and that has
> always been sufficient.
> 
> We will need a place to store the cipher mode in the header and
> that field will need to be read in somewhere around here.
> 
> Also, when writing out the header information, we'll need to store
> the cipher mode.

This is something we've been discussing amongst ourselves, and were
planning on addressing that in another patch. This was mainly a
stop-gap until then. However, since I don't see anything based on a
quick read through the RFCs you mentioned, I'll send an email sometime
tomorrow regarding this.

>> +	const char *mode_white_list[] = {"cbc", "ecb", "gcm"};
> 
> When you submit a patch, it should be able to stand on its own.
> This patch doesn't stand on its own because ecb and gcm aren't
> supported but this patch happily accepts them. This white list
> should only contain "cbc" at this point.
> 
> The idea you had with testing with ECB was a good idea, but it
> isn't something that we'd want to ever support in eCryptfs since
> our default is more secure. So the "ecb" element should of just
> been a local change that you made on top of this patch, only for
> testing.

Will have that removed for actual patch submission.

>> +			cipher_mode_name_dst = +				mount_crypt_stat-> +
>> global_default_cipher_mode_name;
> 
> Yuck. I don't know if this is better or worse than breaking the 80
> char rule. eCryptfs uses variable names that are too long in most
> cases. (This isn't something that you need to worry about)

Are there specific exceptions to the 80 char rule, or is this an area
where it's down to experience and judgment?

>> +		BUG_ON(cipher_mode_name_len >= +
>> ECRYPTFS_MAX_CIPHER_MODE_NAME_SIZE);
> 
> I see that you copied and pasted this logic from the
> !cipher_name_set conditional. So it isn't your fault, but this is
> terrible.
> 
> This is something that should be caught at build time rather than
> at runtime (why force this BUG() on our users?). These BUG_ON()'s
> should probably be replaced with a BUILD_BUG_ON().

I'm not too familiar with kernel macros, but my assumption based on a
quick google search is that this is something like an assert?

> This was a nice submission for your first shot at it. The biggest 
> problem to fix will be figuring out where to store the mode in the 
> header. Take a look through RFC2440 (and 4880 and 5581) to see if 
> there's already a field we can use for this. If not, we'll have to
> give it some more thought. I don't want to rely on the user
> specifying the correct ecryptfs_cipher_mode mount option.
> 
> Thanks again for working on this!
> 
> Tyler
> 
Thanks for being helpful and responsive. :)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJRrWMkAAoJEH8zVN2+6bAcjnoP/37JHcXKdvQQ+VCOznBkJz/u
J5p01ulqoXd0KJ+tCJQunmGUmVlY7AYk87xr/pkcbQkZru98G/cTbIVVOrQ2Zbu0
+ENGfW8XitghDos5aVD4I9ny1+5txrGitSecoWzzOGduvdAV35Qsm+bgNPxzczZu
ZOI4hkKlBDOKLrw6SsKHHgzW8k/VCML+zSU4Arq3xuMg0VY6SMykRudrWlO4gcXn
EGibwWmh1v/UFZ5qviNb0XYHbWvcmp7YqrVZUzi5gZzO8oUpjgvza0vApm6d/tj/
1SSjouDbhcie1jbLW32dFjVnmp2gr24uymfIjnQPP99816WKCRMoTlnECNvmMwt3
qJMpsROquQZQDFRPYDKMOch4YcrSeBfptHwwYjiI042W71SWoNIxEv43U101IInd
5GG/DVl2+8WBAJqrBt+rlsN93l4PScEaz/82f5ieyPI6T1AV1MqvIeoCeBnGyXhU
W+vM1jHvSYACjyQIiRi5BcUUjEKOr+GQEtlMB6deL75YMmGcoPSO4R7cJAWnyP9F
3w1yE4EDy+O6vavAYnS/8diTcosLohZcxv64qnCGcDXcJSghvhP3If4OvsUFCOHL
wjExnKGXdSf+HSlYCPL42njUR5RHCcwhbR88Jm6JO55GvsU9v33MdBDQ6oTAkiDH
OL11HkuaBgBzEuoftw//
=QEhN
-----END PGP SIGNATURE-----
