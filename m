From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [RFC][PATCH] ecryptfs: Allow only one instance per lower path
Date: Mon, 3 Aug 2015 00:27:58 -0500
Message-ID: <20150803052758.GA24915@boyd>
References: <1438338190-22518-1-git-send-email-richard@nod.at>
 <20150802010259.GA19522@boyd>
 <55BDCBF4.1050305@nod.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:33702 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbbHCF2E (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 3 Aug 2015 01:28:04 -0400
Content-Disposition: inline
In-Reply-To: <55BDCBF4.1050305@nod.at>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Richard Weinberger <richard@nod.at>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2015-08-02 09:51:16, Richard Weinberger wrote:
> Am 02.08.2015 um 03:03 schrieb Tyler Hicks:
> > Thanks for the report and for the patch, Richard!
> >=20
> > On 2015-07-31 12:23:10, Richard Weinberger wrote:
> >> Mounting the same lower path multiple times should not result
> >> into multiple ecryptfs instances, otherwise ecryptfs gets confused.
> >>
> >> A command sequence of:
> >=20
> > An important detail that took me a while to realize is that /tmp should
> > be tmpfs in order to trigger the warnings below. I was unable to
> > reproduce the warnings with ext4 as the lower filesystem.
>=20
> Hmm, I saw it with UBIFS found that it triggers with tmpfs too.
> I gave ext4 a quick try and yes, it behaves differently, I get
> a EIO upon the second unlink().
>=20
> >> $ mount -t ecryptfs /tmp/.secret /mnt_a/secret/
> >> $ mount -t ecryptfs /tmp/.secret /mnt_b/secret/
> >> $ mkdir -p /mnt_a/secret/xxx
> >> $ mkdir -p /mnt_b/secret/xxx
> >=20
> > Note that the -p option is covering up the fact that /mnt_b/secret/xxx
> > already exists. Remove that option and you should see this error:
> >=20
> >   mkdir: cannot create directory =E2=80=98/mnt_b/secret/xxx=E2=80=99: F=
ile exists
> >=20
> > This really isn't important other than understanding that the second
> > mkdir it isn't needed.
> >=20
> >> $ echo foo > /mnt_a/secret/xxx/test.txt
> >> $ echo foo > /mnt_b/secret/xxx/test.txt
> >=20
> > /mnt_b/secret/xxx/test.txt should already exist (it does for me, at
> > least) so the same file is being written to twice in a row. Again, not
> > really important other than to know that it isn't needed.
> >=20
> >> $ rm -rf /mnt_a/secret/xxx
> >> $ rm -rf /mnt_b/secret/xxx
> >=20
> > The /mnt_b/secret/xxx dcache entry is stale here because the underlying
> > file was removed by the first rm command in the /mnt_a/secret mount. The
> > lower inode's nlink is 0 at this point and what should be happening
> > here, I think, is that the eCryptfs dentry should be invalidated and the
> > eCryptfs inode should be destroyed.
> >=20
> > I think that the proper fix is to catch this condition in
> > ecryptfs_d_revalidate(). I've started working on coming up with a patch
> > for that but I'll need some more time to finish and test it.
>=20
> So ecryptfs definitely supports mounting the same lower path multiple tim=
es?
> What is the benefit of that behavior?

No, it doesn't support that in a way that provides consistency among all
of the eCryptfs mounts.

However, multiple mounts on the same lower path is not the cause of this
bug. The real issue is a stale dcache entry when the lower filesystem
has been modified without eCryptfs' knowing. I can trigger the same
warnings with only a single eCryptfs mount.

Tyler
>=20
> Thanks,
> //richard

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVvvveAAoJENaSAD2qAscKGMsP/0ce7rMtWtOt/q/E7rduhwj5
S+YuRT9V5zd4r+aMmN2yYcPYLTMC8z2ff/RWa+S6sm7RqiyxtO2ZlNHPaCMuJgq+
e9QuyF00QHKrSGoQIsshJ6TqpgZlmxGiY5ijftC+KXSsUsjQOdcBW0T4YCx6011H
HzKUE6xegTRm0sp0JDN5xIn4fPnI/N0ZxqTDLYA6t5yukWBe4wQFt2NUx9wlL7xn
CBWppDbdXDJUTTOl/hdN7mRiRfuLPKhRlrKlv6IculH0frUvVGQT0N9uZfdpU1pB
eVdi7b5GYIlfLEPs9JcIvqve8h13f/OvCamMSsDQ1AyP9Hyomtl8rbU326ptHwnZ
L1Bo9rA1yhg0UlvR6rtMOa1O77Tfbg6KFxHMs0M2NmZ9YDPx6qPJw6GAZloR/53q
IZNOk4h2ujHR9POZvTINx4IjzpzmOKPm5ZNLk/NrUEwOix8GslzfoklwS4VpZwZq
WoIbPHBLsJhYUlTSfbh4Dp+n4rvkjmLOjE6leY4ts+laiyRJQ4kbNgKx+l7e/c5t
q+nHNG4RfG8K54kisyQUUn2PoDrgH58laQE/UZOZkdKWRLS1CABqeFf8m0/zLTTi
onLPcW6UXcEcY/uyLGpiuoZpyN3lDpVatR752igB7iiVo01MhTWCOZp6u9Ffu9AD
hqsagR1urfmUy9AzayN7
=x67b
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
