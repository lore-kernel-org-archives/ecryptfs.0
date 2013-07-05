From: Karl-Philipp Richter <krichter722@aol.de>
Subject: Filesystem boundaries
Date: Fri, 05 Jul 2013 17:11:54 +0200
Message-ID: <51D6E23A.7000103@aol.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2DQRTGDBDXWTEJOSRODOP"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from omr-d09.mx.aol.com ([205.188.108.133]:43795 "EHLO
	omr-d09.mx.aol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757352Ab3GEPVp (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 5 Jul 2013 11:21:45 -0400
Received: from mtaout-mb03.r1000.mx.aol.com (mtaout-mb03.r1000.mx.aol.com [172.29.41.67])
	by omr-d09.mx.aol.com (Outbound Mail Relay) with ESMTP id A58A27009265B
	for <ecryptfs@vger.kernel.org>; Fri,  5 Jul 2013 11:12:03 -0400 (EDT)
Received: from [192.168.178.54] (port-92-195-81-132.dynamic.qsc.de [92.195.81.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mtaout-mb03.r1000.mx.aol.com (MUA/Third Party Client Interface) with ESMTPSA id 20813E0000C8
	for <ecryptfs@vger.kernel.org>; Fri,  5 Jul 2013 11:12:02 -0400 (EDT)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: ecryptfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2DQRTGDBDXWTEJOSRODOP
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi together,
I'm new to mailing list and hope to be at the right address. I tried to
figure out how to prevent ecryptfs to cross file system borders or
exclude subdirectories of the source directory (the current setup is
that I linked a lot of directories from an encrypted disk, which don't
need encryption). I guess it's explained somewhere. So I'd rather
suggest to put it on the man page.

Greetings, Kalle


------enig2DQRTGDBDXWTEJOSRODOP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJR1uJAAAoJEGadKJ8eJ7ZGsJ0H/0sLWrsJzr5wZpgRF3bQN39r
UyYRiekBJX5gM/mKNZteg0+L3MeP29yvkmRio/zvxMf1UJBwIUVHdJo05RRbyIun
/US3gPZ8+XHMHC6ebp/WDPjEfQ0ETT2AMMmTSjio2WuBsaFwDIc9yzx3bEW29jRz
2NTQCpsOKSUrrSTS+TsHJQv5NxrWyMRqgsyw0GCMamK0EuG0WHhZBhrQiclr/7om
oBWcQHfDHP3fxGC4qhlcvA0lM/9ICvntZ2MCCmUx63uyXWM45HmE4CgE7omsJw0Q
5hhpEmAqPYxwtmt1jwyIcitJWJvRda85Jx9RF/FDLMsg6EMA5PcXVneHFHSBq7U=
=B/Pe
-----END PGP SIGNATURE-----

------enig2DQRTGDBDXWTEJOSRODOP--
