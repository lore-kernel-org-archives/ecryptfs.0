From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: size limitations?
Date: Thu, 3 Jan 2013 17:10:11 -0800
Message-ID: <20130104011010.GA24866@boyd>
References: <2ADEBEF7-C8C5-40BE-A308-FDFEAC36BFC2@princelaw.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:34880 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753799Ab3ADBKQ (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Thu, 3 Jan 2013 20:10:16 -0500
Content-Disposition: inline
In-Reply-To: <2ADEBEF7-C8C5-40BE-A308-FDFEAC36BFC2@princelaw.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: "Warren H. Prince" <wprince@princelaw.com>
Cc: ecryptfs@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 2013-01-03 18:56:49, Warren H. Prince wrote:
> I've read some posts about efficiency dropping with large numbers of
> encrypted files.

A link to the specific post(s) would be helpful. I would be taking a
shot in the dark otherwise.

> Is there any way to determine when encryptfs is no longer an
> appropriate solution?

Not really. Your workflow is going to be different than the next
person's workflow, so it is impossible to say. You can compare your
workflow on eCryptfs to the same workflow on dm-crypt/LUKS to the same
workflow on a non-encrypted filesystem, but that could be a lot of work.

If you're happy with the performance that you're seeing, then there's no
need to worry. If you're tired of waiting for filesystem operations to
complete, then you'll need to start looking around.

> For example, I have pretty well filled a 200 G AWS volume with pdf
> files.  I have no idea how many are there, but I do know I have close
> to 20K sub directories.  These files are all of a sensitive nature.
> My guess would be that this is way too big to be an ecryptfs volume
> without very major overhead.  Am I correct?--

Since the files are sensitive in nature and stored in the cloud, I'll
assume that you have a requirement to keep the data encrypted. That will
always introduce a considerable overhead.

Now you'll need to determine which encryption solution best meets your
need. You're already using eCryptfs and migration will require some
level of effort, so you must factor that in.

The best performing Linux-based solution, on average, is going to be
dm-crypt/LUKS but it can be less flexible to deploy than eCryptfs.

Good luck with your decision!

Tyler

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCgAGBQJQ5ivyAAoJENaSAD2qAscKIncQAKIM8DEOCE1uHrFCe9KjE52o
KDhwQFEJr/RvzGSkxJ1ngEY7UJHsO/Q3DPmA+zOmnn7vCC0taTL5gFryZQYqCe3T
p7hzqGuxOlUcboafwB25eTwmF/4jhrIJi1lMrz2UpRx9FQ3Z8Z6ARmMsGnajIdn2
jW3x1sfrUQUEo4Krl2KK46Y/fPSYe89C7mUkfmZPZdiWR7i+QtwMpooVHTL8sHny
XDPqWzE/pJXICB/hHRmkndisjfy3oDswgYjhHu8T9zZJv1bp10XbkOg23i1przBv
D2LZF6Qfd6kNJKLqztxOok3PwbxKyqi3LEoFfYs2kDXzdyIbYMvE3Hz/T0MHZ25q
zFoTBQDPFct6Kq2swm1eTJu771TmOhxWQq5b1BpfSZ86dx88xInpCWZ0NyDzGKOo
PIkSfQvfY1czYwlwC8K5/mDiAYhMO7ss+drl5SIWhdOVcN3XwglMzhduWy5rZW2T
S3x1MuUllgCyBY3xDxPC5MbLYgMZEMJkLn9S4RVvF1MAWF12Jswm0Bdxe8ko/+FQ
P2h8s23GcMYZAtLv018mPdvO5ZIOsvr2k5BdfUK0jXsD5V21ol6A12lBYaDDm6to
2bcYsSBMs3y+JdQVUCBmJxngBUy6u9+A/pJISnHeyQvZGfCzTnGA7r+pN+f7tasE
4SraJ4iWZyHrNBm/RmsC
=bPal
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
