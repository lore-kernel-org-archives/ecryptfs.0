From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: eCryptfs ablkcipher patch
Date: Thu, 10 Jan 2013 10:36:50 -0800
Message-ID: <20130110183649.GA30916@boyd>
References: <068EA2D22589DD4FBD9A55E6FF1EA0B50F1BF7B0@SIXPRD0211MB419.apcprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:38093 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754688Ab3AJShj (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Thu, 10 Jan 2013 13:37:39 -0500
Content-Disposition: inline
In-Reply-To: <068EA2D22589DD4FBD9A55E6FF1EA0B50F1BF7B0@SIXPRD0211MB419.apcprd02.prod.outlook.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Zeev Zilberman <zeev@annapurnaLabs.com>
Cc: "ecryptfs@vger.kernel.org" <ecryptfs@vger.kernel.org>


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2013-01-06 15:36:38, Zeev Zilberman wrote:
> Hello,

Hi Zeev!

>=20
> I've seen earlier discussions about ecryptfs ablkcipher patch, but I see
> it was not merged.
> Are you planning to apply this patch in the future, or did you decide to
> drop it?

Its status is somewhere between those two extremes. Not applied, but
also not dropped. It is useful, but I'm not sure that its benefits
outweigh the risks of merging it.

The problem with the patch is that it didn't provide a clear performance
increase across the board. I don't have the performance testing results
handy, but it gave a nice increase on some systems and hurt performance
on others. That, coupled with how risky the patch is, makes me hesitant
to merge it.

I don't currently have the bandwidth to provide the amount of testing
that would be needed (nor the time to spend on fixing regressions) and
the patch author has not been active in eCryptfs development for quite
some time. In other words, no one has stepped up to usher the patch
through.

Very few eCryptfs users test the mainline -rc kernels and I don't want
the users of whatever distro first ships this patch to find all of the
regressions caused by it.

>=20
> I tried to apply the patch locally and saw the following issues:
>=20
> 1. I've encountered a problem with ecryptfs_encrypt_extent_done that is
> calling functions
> that can sleep (kmap/kunmap). It fails with ablkcipher crypto drivers that
> invoke the
> callback from interrupt handler bh (tasklet).
> Moving the write part to a work queue (using queue_work) seems to solve i=
t.

Please send me patches, and cc this list, for these fixes. I will push
everything to a branch in the eCryptfs git tree on kernel.org so that we
don't lose any useful code.

>=20
>=20
> 2. I saw that ecryptfs was reverted from writeback to writethrough cache
> mode.

That's correct

> This seems to be problematic in regard to performance while using async
> interfaces.
> The original change to writepage (that uses ecryptfs_encrypt_page_async)
> allowed
> submitting async crypto operations and continuing without waiting for the
> result.

Nice catch, that would have to be changed.

> write_end uses ecryptfs_encrypt_page (and needs its return value), so
> we'll have to wait
> for encryption (and write) to complete before continuing to the next
> operation.
> Are you planning to return ecryptfs cache to writeback mode?

No, it caused quite a few bugs. I suspect that eCryptfs will stay with
the writethrough cache.


Have you done any performance testing yourself? I'm curious if you're
interested in this patch because it made a significant difference in
your use case.

Tyler

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCgAGBQJQ7wpBAAoJENaSAD2qAscKcJsP/i0J7k9bmjQHvys++k7S6CeO
wXhZfFfU1ScRLYaWHa6gB4jmDOMD6sDWbXb1QsDYEj8z29A3iSVwhhgLZGemlYGM
6xurr+DmBl3yjBcuJCwmdmk7sj+G/j7dkdVXxybsmG9NmY78GgV86lRkK4RMI7Te
F38xCQkindRxvZBiHUOojk5BVzMggacm2ARps2mDA6PGYRqjciAgp+AWPuT9N8XT
DWhPRlJIhavQxNwm8yN4eaWi/tkz3cpCp8Ndq+VAIEw5xYyh7cLv0R5SA6Mq7mHL
ZGourRJBDkteCthuAO07Yz6ZWrqLTKE4b61Yom53Mjs30beQsdJ69Fs5+iADu+B/
6ub9saqMgrRWOtzpND7aKW/sIRvmumhKGSt2OKJJKJ9JfVfZvUH4EOX7Tpig7U4t
05mMqJ+P+zBXsVwr+7PCdecLzbkkN863L7XputyGwOZffxx9d17FsLAQ2f07g/+V
jvPnBw1bCH0Lh1URE/eOEwOl0v02C7UT9DVRlnMwOLLTdG61ryUcexqN1ye3tfJL
1KLcM2nCxr2+zus6DF6Vcpu2dHbfbVI6+kbo1HHT5292pXPKwGFvqLXTkGUdtLG3
fA9k379cSgEtPtdht9gjySpaMmsU+pceCVOy+S4hkxrYHCPnI1QPcJFLdypcKe2y
AWR4xaRrRlZ9CTQyboAZ
=GAo3
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
