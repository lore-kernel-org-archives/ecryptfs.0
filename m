From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [RFC] eCryptfs: Add mount option for cipher mode
Date: Tue, 4 Jun 2013 09:25:36 -0700
Message-ID: <20130604162535.GB5087@boyd>
References: <51ACCEC9.3070303@gmail.com>
 <20130604015101.GA4162@boyd>
 <51AD6324.1070505@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VrqPEDrXMn8OVzN4"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:48007 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755205Ab3FDQZm (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 4 Jun 2013 12:25:42 -0400
Content-Disposition: inline
In-Reply-To: <51AD6324.1070505@gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Will Morrison <camocrazed@gmail.com>
Cc: ecryptfs@vger.kernel.org, Zameer Manji <zmanji@gmail.com>, Michael Chang <thenewme91@gmail.com>, Alvin Tran <althaitran@gmail.com>


--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2013-06-03 23:46:44, Will Morrison wrote:
> On 13-06-03 09:51 PM, Tyler Hicks wrote:
>=20
> > To start things off... when you have a side note, such as your
> > paragraph above mentioning that this is your first kernel patch,
> > you don't want something like that to end up in the commit log
> > history forever. A good place for notes like that is below the ---
> > line and above the diff command. Most patch merging tools should
> > ignore that content and keep it from being recorded forever in the
> > commit history. (I know that you didn't intend for this patch to be
> > upstreamed at this time, but I thought I'd mention this tip.)
>=20
> Didn't know that, thanks for the tip. :)
>=20
> > I'll assume that this means that you're not using git. If you plan
> > to continue doing kernel development (or really any open source=20
> > development) after this feature, I'd recommend that you work on=20
> > acquiring basic git skills. You previously asked what can help
> > speed up your development workflow and understanding git is
> > certainly something that will help.
>=20
> We are actually using git for development. I used diff to generate the
> patch because I was following Documentation/SubmittingPatches, which
> gives diff commands.
>=20
> What should we be using to generate the patches? git diff?

git format-patch will generate the patches and save them as files

git send-email will email those patches out. You can also use git
format-patch directly and skip the git format-patch step if you'd like.

>=20
> > In fact, this patch won't apply for me using `git am -is
> > /path/to/mbox`. I'm not immediately sure why, but I do see some
> > extra '-' characters in the areas that git complains about.
> >=20
> > It might be because you GPG-signed the email. GPG signing patches
> > would seem like a good thing to do, but
> > Documentation/email-clients.txt claims that it causes some problems
> > and recommends that you don't sign patches.
>=20
> I can disable GPG signing for patches easily enough, or switch to
> using PGP/MIME. Would one or the other be preferable? I don't know if
> git can deal with PGP/MIME emails.

I'm not sure about PGP/MIME. I know that unsigned works perfectly so
that's probably the easiest option.

>=20
> > Running the following search and replace in vim:
> >=20
> > :%s/^- -/-/g
> >=20
> > and stripping off the GPG header/footer, I'm kind of able to get
> > the patch to apply. There's offset and fuzz issues, so git am won't
> > apply it (but patch will, of course). Which kernel tree did you
> > develop the patch against?
>=20
> will@Aldor ~/FYDP/ecryptfs_base $ git log -1
> commit f6161aa153581da4a3867a2d1a7caf4be19b6ec9
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Sun Mar 10 16:54:19 2013 -0700
>=20
>     Linux 3.9-rc2

So a little bit behind. Typically, you'd want to rebase and test your
patches at least against current mainline before you send them out. Even
better would be to do it against my next branch
(http://git.kernel.org/cgit/linux/kernel/git/tyhicks/ecryptfs.git/log/?h=3D=
next),
which contains the latest eCryptfs patches, but mainline will probably
offer a more stable kernel for you to work against.

I'm really not picky though. eCryptfs development moves slow enough that
you will normally be fine developing against a slightly older codebase.
If there's a big conflict, I'll just ask you to fix it. I'll handle
small conflicts myself.

>=20
> >> +	strncpy(crypt_stat->cipher_mode, +
> >> crypt_stat->mount_crypt_stat->global_default_cipher_mode_name, +
> >> ECRYPTFS_MAX_CIPHER_MODE_NAME_SIZE);
> >=20
> > This is a problem. eCryptfs files are atomic in that they contain
> > all of the information needed to decrypt the file (except for the
> > FEKEK) in the header. So a single eCryptfs mount may contain files
> > encrypted by AES-128, AES-256, blowfish, the FEK can be wrapped
> > with a public key, multiple FEKEKs can be used, etc., and eCryptfs
> > can seamlessly handle it because of the various metadata stored in
> > the file header.
> >=20
> > At first glance, it doesn't look like RFC2440 defines a field for=20
> > different cipher modes. eCryptfs has always just made the
> > assumption that it should use its tweaked CBC mode and that has
> > always been sufficient.
> >=20
> > We will need a place to store the cipher mode in the header and
> > that field will need to be read in somewhere around here.
> >=20
> > Also, when writing out the header information, we'll need to store
> > the cipher mode.
>=20
> This is something we've been discussing amongst ourselves, and were
> planning on addressing that in another patch. This was mainly a
> stop-gap until then. However, since I don't see anything based on a
> quick read through the RFCs you mentioned, I'll send an email sometime
> tomorrow regarding this.

Sounds good.

>=20
> >> +	const char *mode_white_list[] =3D {"cbc", "ecb", "gcm"};
> >=20
> > When you submit a patch, it should be able to stand on its own.
> > This patch doesn't stand on its own because ecb and gcm aren't
> > supported but this patch happily accepts them. This white list
> > should only contain "cbc" at this point.
> >=20
> > The idea you had with testing with ECB was a good idea, but it
> > isn't something that we'd want to ever support in eCryptfs since
> > our default is more secure. So the "ecb" element should of just
> > been a local change that you made on top of this patch, only for
> > testing.
>=20
> Will have that removed for actual patch submission.
>=20
> >> +			cipher_mode_name_dst =3D +				mount_crypt_stat-> +
> >> global_default_cipher_mode_name;
> >=20
> > Yuck. I don't know if this is better or worse than breaking the 80
> > char rule. eCryptfs uses variable names that are too long in most
> > cases. (This isn't something that you need to worry about)
>=20
> Are there specific exceptions to the 80 char rule, or is this an area
> where it's down to experience and judgment?

Printed strings are one example for breaking the 80 char rule (eCryptfs
wraps them in most cases, though). But, it mostly comes down to
experience/judgement.=20

It is probably best if you stay within the 80 char limit in most
situations. If I have a problem with some line wrapping, I'll fix it up
while merging the patch.

>=20
> >> +		BUG_ON(cipher_mode_name_len >=3D +
> >> ECRYPTFS_MAX_CIPHER_MODE_NAME_SIZE);
> >=20
> > I see that you copied and pasted this logic from the
> > !cipher_name_set conditional. So it isn't your fault, but this is
> > terrible.
> >=20
> > This is something that should be caught at build time rather than
> > at runtime (why force this BUG() on our users?). These BUG_ON()'s
> > should probably be replaced with a BUILD_BUG_ON().
>=20
> I'm not too familiar with kernel macros, but my assumption based on a
> quick google search is that this is something like an assert?

I haven't actually used BUILD_BUG* before. I stumbled upon it after not lik=
ing
that runtime BUG_ON(). However, the comments of BUILD_BUG_ON() are pretty
clear:

/**
 * BUILD_BUG_ON - break compile if a condition is true.
 * @condition: the condition which the compiler should know is false.
 *
 * If you have some code which relies on certain constants being equal, or
 * some other compile-time-evaluated condition, you should use BUILD_BUG_ON=
 to
 * detect if someone changes it.

You'll have to give it a try and make sure it works as you expect.

Tyler

>=20
> > This was a nice submission for your first shot at it. The biggest=20
> > problem to fix will be figuring out where to store the mode in the=20
> > header. Take a look through RFC2440 (and 4880 and 5581) to see if=20
> > there's already a field we can use for this. If not, we'll have to
> > give it some more thought. I don't want to rely on the user
> > specifying the correct ecryptfs_cipher_mode mount option.
> >=20
> > Thanks again for working on this!
> >=20
> > Tyler
> >=20
> Thanks for being helpful and responsive. :)

--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCgAGBQJRrhT/AAoJENaSAD2qAscKsgMP/R0ZbQAkuy8iNwBLdC8b+WG6
LEpXmJFYgi5I9OANz7CoyowPxiIamBbIkNWHS+BwVUk4OqHKwev9I5nIsAURyuRU
Tsw7nzCbQR96qFs2N9WnjpVCZtA54ED0HPrp0106VtP3fd67RegLgq0Gw80O9sEA
XJC95nMvigKje32MZGf5vrtBlVXKnTmeDXvi0nmzaiTJO015XQUclvKzTIOf1PmQ
r6+BhL4iUBh/XxOsfzkWGDUe4fO+MHj8Ihu0an2ikXoDm2Qfh4yMYzhEeawhrj+Q
6VQRISpu25W/cNdIsfGj5uYWpHO5UysmQDXczl4DlyW+MeqmEyQfQuEXqfKsnrDz
aBvltMdnry2n8lUcrMDp5bJKr+UeNW5pJb5Pu1MNV2PcP6R57xbI3ojZnq+usHil
QOqxIQuygppFAwL+0LwHOz66OKJOXPD5HiDx0fpg+uj5nqEdjCESxtitXWzvYE/s
rOvrRS+AN5YZzAjxa5UjiunHHjf8svtxYx2eFF333ONRdc8xSlo16iPUCHPVgbf0
g7H58AotR7bdQzq+H2mpK1OSpgpZvVhY9cPH8lmYFWNStDyr4OuSlIYs21OsJXfN
ewJK5wR96L2yJWZj/p4IWDeJ8sgGUmnuPJ762Lo/JJG1Hg6QDoXnYrOQMWg1l02G
JfFQSDEl9xGknDNIunci
=gxTM
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--
