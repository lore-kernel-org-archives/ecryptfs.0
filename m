From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: ecryptfs_privileged_open(): when kthread-ecryptfs is required ?
Date: Mon, 26 May 2014 15:53:36 +0200
Message-ID: <20140526135336.GA21624@boyd>
References: <1400855045.23090.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:49096 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752434AbaEZNxk (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 26 May 2014 09:53:40 -0400
Content-Disposition: inline
In-Reply-To: <1400855045.23090.25.camel@localhost.localdomain>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Yann Droneaud <ydroneaud@opteya.com>
Cc: ecryptfs@vger.kernel.org, linux-fsdevel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2014-05-23 16:24:05, Yann Droneaud wrote:
> Hi,
>=20
> While trying to investigate why using ecryptfs is painfully sluggish,

When is it painfully sluggish for you?

The two biggest pain points, off of the top of my head, are:

 1) Extending a file to a much larger size is slow because pages of
    zeros are encrypted in the process

 2) Utils such as find and ls are slow when dealing with large numbers
    of files because, during lookups, the eCryptfs metadata has to be
    read from the front of each lower file in order to fill the eCryptfs
    inode

> I've find a piece of code that, I believed at first, wouldn't scale.
>=20
> After adding some printk() there, I've found that it's not at all=20
> called in my use case.
> So I wonder: what's making  ecryptfs_privileged_open()[1] submit work=20
> to ecryptfs-kthread thread running ecryptfs_threadfn()[2] ?
>=20
> [1]
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/fs/ec=
ryptfs/kthread.c#n155
>=20
> [2]
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/fs/ec=
ryptfs/kthread.c#n56

This change (746f1e55) happened before my time of maintaining eCryptfs,
but we can piece together the reasoning...

Assume that an eCryptfs mount, /upper, is mounted on /lower and keep in
mind that there is only ever one lower file opened for all open eCryptfs
files that correspond to the lower inode. So, if two processes have open
file descriptors for /upper/foo, then /lower/foo is only opened once by
the eCryptfs and a pointer to the lower file struct is attached to the
eCryptfs inode's private data.

Since there's only ever one lower file opened for a given lower inode,
it must be opened as O_RDWR to satisfy all future open()s of the
eCryptfs file, as one of those future eCryptfs open()s may be O_RDWR.

The last paragraph of the 746f1e55 commit message, indicates that the
kthread was intended to work around DAC issues when opening the lower
file. That may have been the case back then, but it isn't the case now.
Today, dentry_open() succeeds even when the lower inode isn't writeable
by the current process.

Following the dentry_open() code path, I see that security_file_open()
is called from do_dentry_open(). That means that even though the kthread
is no longer needed from a DAC standpoint, it is still needed from the
LSM standpoint. I'll use AppArmor for a simple demonstration:

 1) Create a profile, "test", that grants access to all files but then
    revokes write permissions to /lower/foo
 =20
    $ echo "profile test { file, deny file /lower/foo w, }" | \
       sudo apparmor_parser -rq

 2) Create an eCryptfs the file
    - eCryptfs will create the lower file

    $ touch /upper/foo

 3) Open the eCryptfs file with O_RDONLY
    - It will succeed

    $ cat /upper/foo

 4) Open the eCryptfs file with O_RDONLY, while confined
    - It should succeed due to falling back to ecryptfs-kthread

    $ aa-exec -p test -- cat /upper/foo

 5) Remove the ecryptfs-kthread code, recompile the eCryptfs module,
    load the new module and set up the eCryptfs mount again

 6) Repeat step #4
    - It will fail this time since there's no ecryptfs-kthread

    $ aa-exec -p test -- cat /upper/foo
    cat: /upper/foo: Permission denied

 7) Note the eCryptfs error messages in the syslog

    [ 3395.362511] Error opening lower file for lower_dentry [0xffff8800746=
1c288] and lower_mnt [0xffff88007a105420]; rc =3D [-13]
    [ 3395.375967] ecryptfs_open: Error attempting to initialize the lower =
file for the dentry with name [foo]; rc =3D [-13]

> BTW, I have a patch that remove this kernel thread as I think
> credentials can be given to dentry_open(), so instead of running an
> helper kthread, some privileged credentials can be given to
> dentry_open() in the case ecryptfs_privileged_open() really need to=20
> open a file read/write. But as I'm not able to verify it's working as=20
> expected, I'm holding such trival patch.

This made me think of a patch set from years ago that, unfortunately,
went unreviewed:

  https://lkml.org/lkml/2011/4/29/104

I think Roberto probably had the right idea. By default, all lower
inodes are opened using a cred that was set up at eCryptfs mount time.
Optionally, an eCryptfs mount option can be given to specify the LSM
security context that should be used when opening the lower inodes.

Would you have any interest in reviving that patch set?

If so, note that although I used AppArmor in my example above, you'd
need to use SELinux or SMACK to test the ecryptfs_security_ctx mount
option since AppArmor doesn't have support for
set_security_override_from_ctx().

Tyler

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTg0dgAAoJENaSAD2qAscKYgEP/j8uS6oc894Yx50lecyMnfRl
3h5dn/9fgjjn26WDRsXCbW+48KchiCYFZczyTzhwzPk9n/j2/FElw8WT8Hwb2yqO
vF14w9QW3qKXb4Bt5zgAqys4JaiWV1THIflhI4cgHatax+f6cMSs//LDc4pB2Ia2
hr3jGf5e6WQbf545yjFZBSmV73Y5YeiLgqUKc1Ak0Cl8740p+PjmPxiONHL6ZLSV
betEUz1QVn2efXj/5O1dfrAwsaMm1WJicFGhiXAOYyo5V2tAbKyvJBwqjZOOIL14
Bi0n2ddh8SWfN8lmWoQEckGwMYyV3vkqCnPBRdjU7ZNj7VJgMuBBdqH6amg47LRw
AcmYNXHHvi0kvhLS668JaALlUepkumtbSXtLuqZCQc9A7NG5tC3Ud8jCJ/XI1OhN
zhJnYJ6AYj1zcJK6Dn2x6zvjtqT6J7uAMYMXQ9TIzqmzUGyfzP3HlhFQfvtiMPqT
0IZmMryBsrdrnQ+SNsrb2QfeV1OqW2p7ituf0XIrdxQzBN/UXZGWYExR6HenhG6j
h9IKS0QUOxLAdzvzuQPn4dcgEGYVQqcYasio73iuwB1WIbYKR0ykwUtuEAhOUmab
/Bw3koUu1JFyLLA099k4oa7n3iCiic6vfxF0sU/6fQRmY+fk2Hqfy8fi1bs32FHJ
uSmU8qKFutdGd1pdonP2
=7Za0
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
