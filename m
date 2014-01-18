From: Will Morrison <camocrazed@gmail.com>
Subject: [RFC 0/3] Enable GCM support
Date: Sat, 18 Jan 2014 14:26:06 -0500
Message-ID: <52DAD54E.2010501@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="iv8NPBq3pWm7eRPhglMX5vWvWJRbaAQ5V"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:58945 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480AbaARTcs (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Sat, 18 Jan 2014 14:32:48 -0500
Received: by mail-ie0-f170.google.com with SMTP id u16so5044862iet.1
        for <ecryptfs@vger.kernel.org>; Sat, 18 Jan 2014 11:32:48 -0800 (PST)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Tyler Hicks <tyhicks@canonical.com>
Cc: ecryptfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iv8NPBq3pWm7eRPhglMX5vWvWJRbaAQ5V
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

This set of patches is the work we've done so far on adding integrity
protection. We've been using a modified version of the test suite,
available at
https://code.launchpad.net/~zmanji/ecryptfs/1270455/+merge/202197 to
test GCM using the existing tests. This is done by passing -o
"ecryptfs_cipher_mode=3Dgcm" to the test script along with other flags.

When GCM mode is used, most of the test suite passes, but several tests
involving truncating a file to a larger size fail. We believe this to be
a result of calling read_mapping_page at mmap.c:49, which sometimes
calls ecryptfs_readpage with a fresh page. This new page does not have a
valid auth tag, so E_BADMSG is returned. We think this was fine before,
as whatever was in the page would get overwritten and ignored,
but now we're doing integrity checks, so we run into issues.

We'd like to know if there is an alternative to read_mapping_page that
preserves the necessary semantics, or if there is some field in the page
that gets passed to ecryptfs_readpage that would allow us to distinguish
between pages we have never written to before and pages that were just
fetched from the cache or disk.

-Will


--iv8NPBq3pWm7eRPhglMX5vWvWJRbaAQ5V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJS2tVOAAoJEH8zVN2+6bAcStEP/RX8uxt1CSMOoS2wCHU8rBjx
eIGYgjZLJO53MbSWv/bZ+wsn/oBg3d5LileAl9iMuCQqRkVEtSfWjjEf0UQYJ5e+
1PNm3N4+V8BYqzbZ9vgpBX0POjOdUTLQJlNmWvIOM9GyCNSCQlK5FOvdU6cQhQ8w
dkMcDWrBaaYn7oQ1M7Lx+2hsJf8arc3+i76ZgSYURDH6oLK5ra61s+afgteCEExl
WoS7GkbrqoKdjugH1hI09dcSVGu5TEY2yf97y+GEM6Cgrq+Vuvm9fPYyCcEQieeP
KqvjtBpuP3M4qVxlHA83GOPjPD0n79kzmL89+HmsY4i36FGdUGdyq1ZOQcuDh/w2
dvtUocaVJ6s+SpTOZPXLSSXslkp3CO3IipjWJ2buE8TSrJ9svmnepf0nGOZ+Q16b
6KqBBGieG5SV1XDsI1jGQw1Ij6y0ABK8q1hwaqEf3HrCzjF2z3ST8yBfeJIFuW43
yRUFlS8MIQNX9N6trnk1YXCfwFiUWcI6/GKOGITOqj4/wmz8urf7BJo0+3+4Jtdp
miclcSsiLvXVJG9BddOjrZ4XYtALsrVyghRuUWsKEsHcrDT3ZwbAPdGa540kMmu/
WVwNoatJDbrfguaVAMO/ZZWtgHDXz/CrwyRxQP59+AzUiJyA2ZOs8ECHBxQydJma
tE3/y65mrGT1e64wL31C
=Ho81
-----END PGP SIGNATURE-----

--iv8NPBq3pWm7eRPhglMX5vWvWJRbaAQ5V--
