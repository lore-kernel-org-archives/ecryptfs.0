From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: Plans for adding cipher mode to file headers
Date: Tue, 11 Jun 2013 07:07:52 -0700
Message-ID: <20130611140752.GC30092@boyd>
References: <51AEA774.7010702@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6zdv2QT/q3FMhpsV"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:37561 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322Ab3FKOH5 (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 11 Jun 2013 10:07:57 -0400
Content-Disposition: inline
In-Reply-To: <51AEA774.7010702@gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Will Morrison <camocrazed@gmail.com>
Cc: ecryptfs@vger.kernel.org


--6zdv2QT/q3FMhpsV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Sorry for not getting back to you sooner. I've been busy with other
things.

On 2013-06-04 22:50:28, Will Morrison wrote:
> To make the changes to store the cipher mode in the file header, we
> are proposing the following.
>=20
> 1. Change ECRYPTFS_SUPPORTED_FILE_VERSION to 4. This should prevent
> old versions of eCryptfs from trying to read new style headers.
>=20
> 2. Add a new cipher mode field in the appropriate packets of version 4
> file headers. (I believe these are tag 1 and tag 3, for asymmetric and
> symmetric keys). Since there is no equivalent to this field in the
> OpenPGP RFCs, we will be creating a new list of constants similar to
> the ones in ecryptfs.h for the mode type.
>=20
> 3. When reading a file header and initializing a crypt_stat, if the
> version number is 4 or greater, read the mode out of the header,
> otherwise, default to CBC.
>=20
> 4. When writing out headers, refer to the file_version field in the
> crypt_stat to determine what to write out. If it's 4 or greater,
> include the mode field.
>=20
> This should result in the new version 4 header being written for all
> new files. Old files would still be read and written with the version
> 3 headers and default to using CBC mode. Older versions of eCryptfs
> should refuse to open files with version 4 headers.
>=20
> Does this make sense? If not, what are we missing?

It makes sense, but I don't really like it. It prevents old kernels from
being able to open files created by newer kernels even when CBC is used
for the new files.

Breaking backwards compatibility should only be done for really good
reasons, when there's no other option.


I didn't want to shoot this idea down without proposing a solution of
my own, but I haven't had time to read back through the OpenPGP RFCs and
look at what other fields we have in our metadata.

The good news is that this shouldn't block you for the time being. You
can hardcode your new mount_crypt_stat and crypt_stat cipher mode fields
to GCM for now and then figure out how to dynamically set them later
when we come to a decision on the metadata format changes.

Tyler

>=20
> Thanks,
> -Will

--6zdv2QT/q3FMhpsV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCgAGBQJRty84AAoJENaSAD2qAscKscwP/i6RhkbIShk42vlNYgZYKvo+
i/yhyonm2z0PEudX2TIhdux7RpPKIzMWdkGbk6OLwqTOfa5EJZC8vEFJBTAlhSsz
FDihjRoiJ2t3yB+rFWw0T3/9c7Ulp3b7hCgDdippkAS6YSREFkAPQHKME9W0QjyV
vjjh2KuHLTbvq/nnxneIH0JXs0AkqFdwvPbyXqY18Ud/CghgXebqbLdxulsqZmnb
60fy3pENXywqgsUOn8Y9qZVLQwFdxxR/2FmHkdksyE37T/7yoN8c9ujS1gsAETmc
G6QTbbJsqs3fdoU/zieafwQ76I/dRALcytjGzGlmSRWx6WTwjVGyI68BGqNMaeso
/qJv3WwcFZpqzr4iroE22RVhMrNWDDJmDq3BwLzKibHTUN76mylXRpZzpgaXBPG4
MGB+KysWF6eTRzZTrSAIVBgIa1fiIjKkOjlXYf5BZw2YlBhSJ0Oot5nLOVxFYcnN
yEPlrmxmVM0KBJDojwVEV9iB1ktdLlMJ11dQqVxqDGtHsJEdeVasGVhfXsZ4dmLa
0wWMtNcuhfGNR4KLcis2OTauJvki+NwXp/8aYXb2lV9Cgb0KSlq+GaTO54QCL9/7
fNwPS1H7vh7iQZFRfS+ETNDq7L+uvZs6e3u6/U4wNkC1wzhtpF8t8CTaCTwTA+F5
5EqY5WpvR6QpyNwPCMa/
=FRZI
-----END PGP SIGNATURE-----

--6zdv2QT/q3FMhpsV--
