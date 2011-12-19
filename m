From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] eCryptfs: Improve statfs reporting
Date: Mon, 19 Dec 2011 09:35:44 -0800
Message-ID: <CAGXu5jKPML0DB55umbVNc1bbZsLB6yosjTtYKNimctyQSytMEQ@mail.gmail.com>
References: <1324313961-16531-1-git-send-email-tyhicks@canonical.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44131 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752621Ab1LSRfq convert rfc822-to-8bit (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 19 Dec 2011 12:35:46 -0500
Received: by iaeh11 with SMTP id h11so8844121iae.19
        for <ecryptfs@vger.kernel.org>; Mon, 19 Dec 2011 09:35:45 -0800 (PST)
In-Reply-To: <1324313961-16531-1-git-send-email-tyhicks@canonical.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Tyler Hicks <tyhicks@canonical.com>
Cc: ecryptfs@vger.kernel.org, John Johansen <john.johansen@canonical.com>

On Mon, Dec 19, 2011 at 8:59 AM, Tyler Hicks <tyhicks@canonical.com> wr=
ote:
> statfs() calls on eCryptfs files returned the wrong filesystem type a=
nd,
> when using filename encryption, the wrong maximum filename length.

Thanks for getting this fixed up!

> +#define ENC_NAME_MAX_BLOCKLEN_8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0143
> +#define ENC_NAME_MAX_BLOCKLEN_16 =A0 =A0 =A0 143
=2E..
> + =A0 =A0 =A0 /* Return an exact amount for the common cases */
> + =A0 =A0 =A0 if (lower_namelen =3D=3D NAME_MAX) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cipher_blocksize =3D=3D 8) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (*namelen) =3D ENC_NAME=
_MAX_BLOCKLEN_8;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (cipher_blocksize =3D=3D 16) =
{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (*namelen) =3D ENC_NAME=
_MAX_BLOCKLEN_16;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }

Why different paths here when the defines are the same? Also, what
math is used to determine the "143"?

> + =A0 =A0 =A0 /* Return a safe estimate for the uncommon cases */
> + =A0 =A0 =A0 (*namelen) -=3D ECRYPTFS_FNEK_ENCRYPTED_FILENAME_PREFIX=
_SIZE;
> + =A0 =A0 =A0 /* Since this is the max decoded size, subtract 1 "deco=
ded block" len */
> + =A0 =A0 =A0 (*namelen) =3D ecryptfs_max_decoded_size(*namelen) - 3;
> + =A0 =A0 =A0 (*namelen) -=3D ECRYPTFS_TAG_70_MAX_METADATA_SIZE;
> + =A0 =A0 =A0 (*namelen) -=3D ECRYPTFS_FILENAME_MIN_RANDOM_PREPEND_BY=
TES;
> + =A0 =A0 =A0 /* Worst case is that the filename is padded nearly a f=
ull block size */
> + =A0 =A0 =A0 (*namelen) -=3D cipher_blocksize - 1;

Would it be less fragile to just use this path for all the
calculations? Almost everything is a literal value.

> +#define ECRYPTFS_TAG_70_MIN_METADATA_SIZE (1 + 1 + ECRYPTFS_SIG_SIZE=
 + 1 + 1)
> +#define ECRYPTFS_TAG_70_MAX_METADATA_SIZE (ECRYPTFS_TAG_70_MIN_METAD=
ATA_SIZE \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0+ 1)
=2E..
> - =A0 =A0 =A0 s->max_packet_size =3D (1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 /* Tag 70 identifier */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 + 3 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 /* Max Tag 70 packet size */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 + ECRYPTFS_=
SIG_SIZE /* FNEK sig */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 + 1 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 /* Cipher identifier */
> + =A0 =A0 =A0 s->max_packet_size =3D (ECRYPTFS_TAG_70_MAX_METADATA_SI=
ZE

Would it make sense to reproduce the sizing comments from here into
the #defines above, just to avoid losing this documentation?

Reviewed-by: Kees Cook <keescook@chromium.org>

--=20
Kees Cook
ChromeOS Security
