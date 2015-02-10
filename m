From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: Changing salt value
Date: Tue, 10 Feb 2015 16:44:29 -0600
Message-ID: <20150210224428.GA27607@boyd>
References: <CAOkUe-CMpJNpStZTOPnASaiEA8VC3kJAqKMBon6xodRgMJ5A1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:41017 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381AbbBJWod (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 10 Feb 2015 17:44:33 -0500
Content-Disposition: inline
In-Reply-To: <CAOkUe-CMpJNpStZTOPnASaiEA8VC3kJAqKMBon6xodRgMJ5A1A@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Sylvain Pelissier <sylvain.pelissier@gmail.com>
Cc: ecryptfs@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2015-02-10 10:04:07, Sylvain Pelissier wrote:
>  Hi,
>=20
> I am trying to change the default salt value used by ecryptfs-utils to
> wrapped the encryption key stored in
> "/home/.ecryptfs/user/.ecryptfs/wrapped-passphrase". I'm using Ubuntu
> 14.04 with the complete home folder encryption. I created a file
> .ecryptfsrc in the unencrypted home folder of the user which contains:
>=20
> salt=3D04ae48987b177f01
>=20
> Then I wrap the passphrase key with the tool
> ecryptfs-unwrap-passphrase, I noticed that the result has changed and
> thus I think it uses the new salt value. However, when I replace the
> file /home/.ecryptfs/user/.ecryptfs/wrapped-passphrase with the new
> one, then when I log with the user credential I have the error telling
> that the key is not in the kernel keyring.
> Did I miss something ?

Hi Slyvain - Using the .ecryptfsrc file with the encrypted home tools
(ecryptfs-setup-private, ecryptfs-wrap-passphrase,
ecryptfs-unwrap-passphrase, mount.ecryptfs_private, etc.,) is not
recommended.

I recognize that ecryptfs_read_salt_hex_from_rc() is called from most of
those tools. However, I think that those call sites are incorrect in
doing so and I'd like to eventually remove those calls.

There is an unfortunate difference of usage and configuration in the
mount.ecryptfs helper and the mount.ecryptfs_private helper. The
=2Eecryptfsrc file is something that *should* be specific to the
mount.ecryptfs mount helper so attempting to specify a salt in that file
would be incorrect for the mount.ecryptfs_private helper.

That means that there is currently not a way to specify a non-default
salt value for use with the encrypted home tools.

Dustin and I have been discussing this today. The current plan is that
we will implement a "version 2" of the wrapped-passphrase file. It will
contain a randomly generated salt value. Storing the salt outside of the
wrapped-passphrase file, such as in the .ecryptfsrc, would greatly
increase the chance that a user may migrate their wrapped-passphrase
file to another machine (for example, while upgrading to a new laptop)
but forget to migrate their .ecryptfsrc file. We want to include the
salt value in the wrapped-passphrase file to reduce the chances of data
loss those types of situations.

Additionally, the ecryptfs_unwrap_passphrase() function will be modified
to automatically migrate salt-less, "version 1" wrapped-passphrase files
to the new "version 2" format and the file will be rewrapped with the
new key. By doing this migration in ecryptfs_unwrap_passphrase(), it
means that users will only need to log in through PAM and the
pam_ecryptfs module will be able to trigger the migration.

We're working on this now. Thanks for bring this issue to our attention.

Tyler

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU2onMAAoJENaSAD2qAscK9scQAIeA/c5I2GOd6KmQOKR4CFyb
nEEr5eWayYFjZ9cQ7HIFfEcUjGLJgeNbABReihL247vdC4qyRM09B7dVdKrrslqW
WE2YeuxRxaylI3KvRfD0EvanHNd+eTbV1LSLVOyQ/kBQ1If4QhHFYoLH1R/5qCZa
FriTR8Ow+o5KiEJVeNeIdBgSU8L6NcfSujmyRgugDMx/+j7JQfqF/0fAAePz9pjf
TDU1P0ZkT9/VEH/Cj7pfn3rL17Y2371giiKmN9XGtMIjtV+2fdTOWhflUCxHP1uq
0RqYWVGp5X7ykG/yClEQlQ1NPYTq2PKkZL1MLOmQS3Ewv0LPeQ8STNtO0AV7fFnN
aqCDg0Vjbm8CRUpBGjup2fMgQr9hY3xitm2NEv3NsaG8+oIZTScFx4URGfx6p05B
Lgb5fQCTi/OaO6N1/YKzbyKmm9GxVEnE84J+tCQJJGJvVYIH3lHfhEyzp0ceR8kF
UoETJpKEe1J6ZUTVZDZuvamNn9XMkBVk57vvoQPnLirPMG4zrlwKe5+xHsgCFBac
8VFpTzzp9QTobN6fAnduaNjZSB9wctZd2oC9X49+sHfXPsStpyMcBMIGAbQTr8rd
3YNXOwUbwPpjwnK6wi8gQ61kHQYmAsRBTRJg7wWGbAjwD4DanVmpPXXd5OvLUkMQ
zH+9+NbZZabZHVEwu2Zr
=POUK
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
