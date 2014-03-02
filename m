From: Will Morrison <camocrazed@gmail.com>
Subject: PATCH [0/3] Integrity protection with GCM
Date: Sun, 02 Mar 2014 12:52:08 -0500
Message-ID: <53136FC8.9010607@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="6HS1hl14EHwDLDR3e8Ta5SsQRb0whxA33"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:52160 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309AbaCBRwD (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Sun, 2 Mar 2014 12:52:03 -0500
Received: by mail-ig0-f177.google.com with SMTP id ur14so214685igb.4
        for <ecryptfs@vger.kernel.org>; Sun, 02 Mar 2014 09:52:02 -0800 (PST)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Tyler Hicks <tyhicks@canonical.com>
Cc: ecryptfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6HS1hl14EHwDLDR3e8Ta5SsQRb0whxA33
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

The following 3 patches allow eCryptfs to use the GCM cipher mode to
provide integrity protection as well as confidentiality for files. This
mode of operation is optional, and CBC is still the default.

Files encrypted in CBC mode by eCryptfs with the patches applied should
be byte for byte compatible with files created by eCryptfs in CBC mode
without these patches. Additionally, unpatched versions of eCryptfs will
refuse to open files encrypted using GCM mode. The cipher mode is stored
in the header, so CBC mode files and GCM mode files can be mixed in a
single eCryptfs mount.

A new mount option, ecryptfs_cipher_mode, has been added to allow users
to specify which mode of operation to use for new files, which defaults
to CBC mode. Existing files will have their mode of operation preserved.

Differences from last RFC patch
-------------------------------
We sorted out our problems regarding truncation, and cleaned up some of
our code in the process. The test suite now shows all tests passing (on
ext4), both in CBC mode and GCM mode. We updated the test suite to
allow passing arbitrary options to mount so we could test this, and
changes are at
https://code.launchpad.net/~zmanji/ecryptfs/1270455/+merge/202197

It was pointed out to us that GCM is a stream cipher mode of operation,
and that we were reusing the same key/IV across multiple encryptions. As
such, we have made some changes that apply when GCM mode is in use.

In CBC mode, the IV for an extent is derived from the root IV stored in
the file header and the extent offset, and does not change for the
lifetime of the file. Doing this with GCM would allow an attacker with
access to only ciphertext to discover diffs by XORing new and old
versions of an extent, because the keystream would be the same for both
versions.

We now store IVs for each extent using the metadata extent mechanism we
are using to store auth tags. When we read an extent in GCM mode, we
retrieve the IV and auth tag from the appropriate metadata extent and
pass them to the decryption function. When an extent is written, we need
to use a new IV, so we generate one via get_random_bytes() and store
that with the auth tag we get back from the encryption function. This
ensures that each new version of an extent that we write will have been
encrypted with a different IV, and thus a new keystream.

One important note is that this will use up some bytes from the entropy
pool when get_random_bytes() is called. I could not think of a way to
get unpredictable IVs safely without doing this. The reason for not
doing something like newIV=3Dhash(oldIV), or even newIV =3D HMAC(oldIV,
secretIVGeneratingKey) is that an attacker could try inserting an old IV
into the file to get a next IV that they already know, and may have seen
data encrypted under. With get_random_bytes(), the next IV should be as
unpredictable as /dev/urandom, and is independent of the file which the
attacker may have modified.

To recap: when using GCM mode, eCryptfs with our patches does not derive
extent IVs from the file's root IV, but generates a new one from the
entropy pool on each write, and stores it alongside the auth tag for
that data extent in the metadata extents that are present when using GCM
mode.


--6HS1hl14EHwDLDR3e8Ta5SsQRb0whxA33
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJTE2/IAAoJEH8zVN2+6bAcLlYP/01ZuQhNbNatCkMUn0kzjryD
vh7CBEPGtZxo6IOd8Noz4zNWSlMCBxH9JYH5MslnWW72OaAGA4i73YGBkklzvVaa
QKa8HUALaSdGGuKLUL9kllkpKeWDWlcqCFQgbpshXA1qGVT9cRzrlO4jCVYEwQKl
/FlN2u+WTTSjj6aSdsey8fvyoydaKVA/ScBPyW4VZmrOpA5cSKECJ7ETug3MfFe2
S6GeoFrPzia7xdg6zFDr4KQwRs8gv7MnOSC8ffLDvrTbB+kWsy/RT21iVkMZktkg
E4AyOkssents+3t8tBTvsX1J66xI0x5TwrshZAs8HHehVjrVqrC+kKLGFuBI8j4D
aYqqeHmn05+ZPKq1Zblp/AAfKcQfWmjdeeKdT7gM5/wKNeWWz/GOZg0uJflU55HU
yqOUI3c7OHKOrVMcvuUrEQXtKyZH34Dl4X5CerU2iZwYP8UvnoDz+ISgm4MM/HrA
QXHmPMjB1ASL9am223fBZpdp66ggUYlwVSVK4l5T61YwdCSt+s8VK8IKrk1lApwg
bjk5wyvXJ+tij+BhYdRC+w3opCS0VtI7vsQDJ429mZOMTGFSRAwSAtwFsy6PWHDf
ZgGbxKntF/qs8WL/Y/4lK8C54D5lrun1zbaDLR1iAkKcNsGuS7vutCJZthK2L9OH
X9dB+D/6rMCZWMHFD3gT
=sQ0v
-----END PGP SIGNATURE-----

--6HS1hl14EHwDLDR3e8Ta5SsQRb0whxA33--
