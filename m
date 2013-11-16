From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: ecryptfs-mount-private fails the first time after boot
Date: Fri, 15 Nov 2013 16:41:35 -0800
Message-ID: <20131116004134.GB4911@boyd>
References: <CAAk6P0VYWJA+pC6CfeLKhZc6kZ5EVASS+8ELoAUEWCOnqVhhuw@mail.gmail.com>
 <20131115233445.GA4911@boyd>
 <CAAk6P0XLJK_aF-kvrdaBT7P6qoK_2Scu3hyjPJedDyqQUWmvSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i0/AhcQY5QxfSsSZ"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:56161 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754350Ab3KPAlk (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 15 Nov 2013 19:41:40 -0500
Content-Disposition: inline
In-Reply-To: <CAAk6P0XLJK_aF-kvrdaBT7P6qoK_2Scu3hyjPJedDyqQUWmvSw@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Benjamin Moody <benjamin.moody@gmail.com>
Cc: ecryptfs@vger.kernel.org


--i0/AhcQY5QxfSsSZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2013-11-15 19:29:01, Benjamin Moody wrote:
> Thanks for your quick reply!
>=20
> On 11/15/13, Tyler Hicks <tyhicks@canonical.com> wrote:
> > On 2013-11-15 17:51:49, Benjamin Moody wrote:
> >> I'm using ecryptfs on Scientific Linux 6.4 (kernel
> >> 2.6.32-358.23.2.el6.x86_64, ecryptfs-utils 82-6.el6_1.3)
> >
> > I don't have a system derived from RHEL 6 to test from. But I gave it a
> > shot with Ubuntu 10.04 (kernel 2.6.32-52.114-generic, ecryptfs-utils
> > 83-0ubuntu3.2.10.04.3).
> >
> > I wasn't able to reproduce the bug that you're seeing. I thought that
> > maybe the RHEL 6 derivatives don't enable the pam_ecryptfs module and
> > that it does something that ecryptfs-mount-private needs, so I commented
> > it out of my pam configs and tried again but still couldn't reproduce
> > it.
>=20
> I'm pretty sure it isn't using pam_ecryptfs, but that shouldn't make a
> difference in this case (since I'm not using the login password),
> right?
>=20
> >> When I run ecryptfs-mount-private for the first time, it shows the
> >> following:
> >>
> >> $ ecryptfs-mount-private
> >> Enter your wrapping passphrase:
> >> Inserted auth tok with sig [...] into the user session keyring
> >> keyctl_search: Required key not available
> >> Perhaps try the interactive 'ecryptfs-mount-private'
> >>
> >> At this point, the following messages appear in dmesg:
> >>
> >> $ dmesg
> >> ...
> >> TECH PREVIEW: ecryptfs may not be fully supported.
> >> Please review provided documentation for limitations.
> >> SELinux: initialized (dev ecryptfs, type ecryptfs), uses genfs_contexts
> >>
> >> And at this point, the filesystem is *mounted* but the files are not
> >> correctly decrypted (i.e. Private appears to be an exact mirror of
> >> .Private):
> >>
> >> $ ls Private/
> >> ECRYPTFS_FNEK_ENCRYPTED.FWaO.4n6KQUoiUR2FAbPNmeUAR1Zw4f3.rLCHzv3PNoOtE=
xPXP.Ei0KiAE--
> >> ECRYPTFS_FNEK_ENCRYPTED.FXaO.4n6KQUoiUR2FAbPNmeUAR1Zw4f3.rLC-NRvX4ESyX=
eGh90V8z6JRo2qp.xjwPLn8Fz1BXP8u22-
> >> ...
> >
> > It would be nice to see the mount options, from /proc/mounts, at this
> > point.
>=20
> /home/benjamin/.Private /home/benjamin/Private ecryptfs
> rw,relatime,ecryptfs_sig=3Ddceda47e1c1e65a1,ecryptfs_cipher=3Daes,ecryptf=
s_key_bytes=3D16,ecryptfs_unlink_sigs
> 0 0
>=20
> > I'm having to make some assumptions, but it looks like the mount happens
> > without the filename encryption key being loaded into the kernel
> > keyring.
> >
> > Also, seeing how many user keys are loaded at this point would be
> > helpful:
> >
> > $ keyctl show | grep user: | wc -l
> > 2
>=20
> Interesting.  It shows 0 when first starting up, and 1 after I run
> ecryptfs-mount-private for the first time.  Looks like you're right
> and it's loading the *file* decryption key but not the *filename* key.
>  (In fact I was partially incorrect before; the file contents are
> being decrypted correctly, it's just the filenames that remain
> encrypted.)
>=20
> >> I then unmount and remount it:
> >>
> >> $ ecryptfs-umount-private
> >> keyctl_search: Required key not available
> >> Perhaps try the interactive 'ecryptfs-mount-private'
> >>
> >> $ ecryptfs-mount-private
> >> Enter your wrapping passphrase:
> >> Inserted auth tok with sig [...] into the user session keyring
> >>
> >> at which point it works as expected.
> >
> > At this point, the keyctl show command above should spit out the same
> > result as above. But, I think you'll see "1" printed when you run it
> > above, and "2" printed now.
>=20
> Indeed, it now shows 2, and /proc/mounts shows
>=20
> /home/benjamin/.Private /home/benjamin/Private ecryptfs
> rw,relatime,ecryptfs_fnek_sig=3D9a046cc859c834ba,ecryptfs_sig=3Ddceda47e1=
c1e65a1,ecryptfs_cipher=3Daes,ecryptfs_key_bytes=3D16,ecryptfs_unlink_sigs
> 0 0

Now that I know my assumptions were correct, I think I know the cause of
the problem. When the eCryptfs kernel module is loaded, it creates
/sys/fs/ecryptfs/version to let userspace (ecryptfs-utils) know what
features the eCryptfs kernel module supports. One of those features is
filename encryption...

Ubuntu builds the eCryptfs module into the kernel, so that file always
exists. I bet RHEL, and its derivatives, do not build it in. So, the
file in sysfs does not exist and the utilities can't tell if the kernel
supports filename encryption. The first mount happens without the
filename encryption key and the eCryptfs kernel module is auto-loaded
when doing the mount. Now, the sysfs file exists and future mounts
result in filename encryption being enabled.

Try `modprobe ecryptfs` before running ecryptfs-mount-private for the
first time and see if the filenames are decrypted.

Tyler

--i0/AhcQY5QxfSsSZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBCgAGBQJShr8+AAoJENaSAD2qAscKEFUQAJs7fNDwGicoSFHUs8181Y8j
sl0qgwjXtcMZCEb5PKJqqzGngcZPVp/Wrou+FntaB8WIvcetVa8xVOKaYggHZnQ0
lFjTnMQj4z5hLxEfK8y3YD9F7ianbZcRGjrfcewR2V1KEI5Na7AeP4nzZ+bszs/f
yaF9n7pGfALxasBt6OuQfXabGHZ7+nAnCt8hdgUva3mLlcGR0NmbBkbTbVbTrnC7
ZIpFI5X58xd0MJ7zZkrzvsTt8fvLnFweS+lKZcR5iKcaGFTVhHegQbH6r/0Kmyzd
PGLmnp2CnqW923CvoNLi1dstCTVS5DAfly7JVj7f6J2ONl0ROjGDNtwlxI6CMs1z
J5QkYJBohc/DgyomfKx036fkSf0OFCqze58tetVtuwzG208Cn0W1A3nLDA9EKcnE
yrGVuRGotAeEZ6RMqsB2BTSZVr7U4GQR7WY+wUkbkpyPzsAukjJZw3mz4HxozwUp
ZHPqGHZFzuTEPMBqRV7FGLxhYx+ObuGoKmWeGEClvDYhsVX2YhMh43Xh2uRRKKTV
MH7zp0QfReV52/TRgdXzguffywKQf4sj3yW/h5aeJNBvCodhHnsUIcau06gRmsBw
vxEYAwE+sJtU6olplZWMue/Y/cLhJu+Jl6BkN3RWMOXFVbR3N7TSXoMKjXgArjEP
dzZDofV7s6sBpxhayi0R
=sjY5
-----END PGP SIGNATURE-----

--i0/AhcQY5QxfSsSZ--
