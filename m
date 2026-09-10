Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFB546F493
	for <ecryptfs@vger.kernel.org>; Thu, 10 Sep 2026 11:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789039038; cv=pass; b=X4AdVr4bFbmIQxquCAXU1UXha1nTQa1tMk28woiNlWrjrFKHEkyuLL0wJT4/0oVvpRQ5BtMnx6RfjP5EJV0ylnQBuBjkNPZzElFHsXsTa72pOGpjH8+BFbmn//JphgI9q+TrSI67TouJEFflEQHcoa5WJXX69tgGgrLGmMZgWEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789039038; c=relaxed/simple;
	bh=VjbPOkEoh1HzrTuoA8ZplNF97fKAdN/R4Sa7sm9fIvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kifaNYPnuirDjtBk1deYMUhMfjeTR8dMfGqyDiLel93QCCkQUjx3aZPFidthDoSratHKTKQTk07cfHJiYH4LoPowP62+wTXdMlo/KQcD+TOzlHA+WP03Qd4hgxRRTQSrWL42fsQALsM9qAez0Z+YIvLMa6tigLlwZNfaeMIkPLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hne2rbCe; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hne2rbCe"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c2940d16190so214868266b.3
        for <ecryptfs@vger.kernel.org>; Thu, 10 Sep 2026 04:17:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789039035; cv=none;
        d=google.com; s=arc-20260327;
        b=ImC0Q85P5sq5f2AM5Ke+Vkb9n5PTcqGf+PyMItstXqyHkCxJDPZZ/HnjH4uzzB7Fh9
         ENEADoFT8Ud9ZCyUSN5wSQJrSq9EthFLKd5RU/0YC2WCQ+ujVTYxovrN5ka+flWuzD4G
         qAbtjWwmgsv7pDvgfXzcEfb+J9VLTLubeSB58/V42db9f8uLH7yCY2//zNzPDVzZPwXp
         /eUDnwdN1r2Qn2IvD930ajXCGWMocNNvJq4FlfRNsQirm7jHgdQrZspENL1rn7U0d4F9
         kZEQOw+0QnNpb+QNxebadvKxR8QGSMBdDEGGeqrEupNhEbwj42g2auvZAuh29FqwZpuA
         sgtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O8wrxnj4OMvMbiSwJsqwkcf28whDxJ7CnUQ3M8VzxBM=;
        fh=Jrc8xtg//SBXjLUyWnQn5qUE4IJuqhYZ0UH0s1XnG2s=;
        b=brV+96Mfiq16lpFZOhZ1OdapTjIcS+eRO6Cx4f99K2lGNxjnc8u1k79vNwVWevrZDL
         mrfQy4Lk6rcRnSGwitV3nlmIrVNQbyPmvY6VFRfPJWMMQJVmMJs8KRRSOk6jHiVIWGln
         UPY7blehAdiUuvROecWwxclVdOWUKNRcRM8OQCbvlMMpKGBr0JytzA6ABfGIKkGUxYNy
         zI2xVgqiQzNC+JpjeXF/XcUBv6jdcSKO/EqvNiamnkzSlJJuCaf2uWsFUJlLt6Ky1fY6
         L5jiISK8LY2bA1RLl05qKelQBSNXsiYg6xi7mDLbuE0TNPqT2bRiUzZ8El6vVaza3Yf4
         B95A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789039035; x=1789643835; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O8wrxnj4OMvMbiSwJsqwkcf28whDxJ7CnUQ3M8VzxBM=;
        b=Hne2rbCe2H8hXYnuwNgnUcQhC9nlHWZSoSJvCV4Y/RBoGRaJUC5x2YMtTGNPBB+Vdw
         eRtbpSLlbsQvbVQvPwbbmleEq1svCzyNLzBj7jPEHS/EzbqQKUYhozk0IqXxOzF7UEOG
         dxTnTBoSdSNG2bLf32xNi1TdQy63sMSEguH5/TVGceMiU0RDLU/CBx4J7AGb3jr8ncc8
         5xrcRBSikuEnIBJ94ntR2/dz2Eok/jzE/i8VuruZdI9yUiCDiEJcTxH1Sz1/3iyoMTiv
         ZDJY0WbtnhU/6e/TupIfo6alK1BPgfuWR+VexCN+n92VXBs5IFVsgME81R7ugNCd567p
         Ifng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789039035; x=1789643835;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O8wrxnj4OMvMbiSwJsqwkcf28whDxJ7CnUQ3M8VzxBM=;
        b=hrZOk70gMm3QLA8nhxfvAEwH3XFv+oa1bHNUAx5jxvqAxryunzCqX5kUMu396bpibm
         r2ZRdfIYGdBfnoWNW8q+1tggR2Mbr5+3JuD8PSMvS9aMVolOwbxvH2x14H/1JlsDsbNQ
         aRAe1ugB7pyFLuKP08P65iGATueg02h8H0GlpV/cBLgwzxml2FOS2+eNUsIqmfdsfOKk
         2h2oRX2yRVNfEbXtbBgylAykLbooGH9nPfNvfDfPkN1QSyX3sKgA8a5Ez6PhQyAnR2CL
         6/Zl63RZzs9X6cLtZrVlwfPKOQ7fI4hhBytjRBpqNRUOGRQ9BMbvNdHoJsFI8qyM9pc1
         ZHSQ==
X-Forwarded-Encrypted: i=1; AKwUvBzJ7HBNvL2UrL76MO1BZM/rEzimFP+9Ud3FYmmID19kJLEJxiHR0w9wzKuJT45zoXvZcURMufAyYA==@vger.kernel.org
X-Gm-Message-State: AFuF++lCIIfnLhUHXXuSX9rwbZe49wdJ0sdiPPSLv0iZhmolURbgL+Ov
	bnxsn2poaBEm+pNb8Y9VJvlZZtcEpmyiyEB5yQ7bhA0YChfaO3KG9597H8zgbJkB+PBFE7gocBP
	IhXKlX5FhjqV2BP8d2NCdtxfpWYpUtpIxLwsNOXI=
X-Gm-Gg: AYBFou0uT7NYbsRgR+Uh3RVKb8TCTGLlyWEcaceeXGMdWk4FL8VJPhuW/K4oP5P4IqV
	yPByQKbD3K35V5/DCYN3G+1lAdB1yuC+PoG5YAr3CeURypOAA1xyZHLHN4G5Jczou00iH6aI9j0
	v4EoOinZzM9VGtVypnzEjCsRIpUiI7uYiFLnts27i3I2rnJkyH+cOMnvVlOYMH+LJTG4ILnuKRI
	V/YybzczQuPgtl/EZ3Tovg6and1e88zBqvOyqZlmkSGNsUEuc68LPRMuWe3/6PfGyfoOA68C5/F
	T9YP0DwIpAM+CyUS8xG1q7/BnQqakXbn76luWytm0rAtyAWKq9YdijW/blQzsLo=
X-Received: by 2002:a17:907:5cb:b0:c25:afb6:2d91 with SMTP id
 a640c23a62f3a-c260c65c15amr1681216466b.2.1789039035136; Thu, 10 Sep 2026
 04:17:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260829194528.5652-1-drifabdelmalekmohamedsaid@gmail.com>
In-Reply-To: <20260829194528.5652-1-drifabdelmalekmohamedsaid@gmail.com>
From: DRIF ABDELMALEK MOHAMED SAID <drifabdelmalekmohamedsaid@gmail.com>
Date: Thu, 10 Sep 2026 12:17:03 +0100
X-Gm-Features: AcwNN1XvJGPKxPZRv4cwqSlHsRRpfczT2zZPhhAg0zo53rIir_AxYRQBpcV8EbA
Message-ID: <CA+xk8n8v_fR2ockBgGL-Q7QWjHZ8i_AALux98WphJigvv9zbhQ@mail.gmail.com>
Subject: Re: [PATCH] ecryptfs: replace ecryptfs_from_hex() with hex2bin()
To: Tyler Hicks <code@tyhicks.com>
Cc: Thorsten Blum <blum@kernel.org>, Eric Biggers <ebiggers@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Gentle ping on this one =E2=80=94 seems to have gotten buried during the me=
rge window.

Thanks,

On Sat, Aug 29, 2026 at 8:45=E2=80=AFPM Drif Abdelmalek Mohamed Said
<drifabdelmalekmohamedsaid@gmail.com> wrote:
>
> ecryptfs_from_hex() relied on the deprecated simple_strtoul(). Rather
> than patching it to use kstrtoul(), its intended replacement, remove it
> entirely and switch all call sites to the generic hex2bin() helper
> from <linux/hex.h>, which already provides the same functionality.
>
> Update call sites with the (u8 *) casts required by hex2bin()'s
> signature.
>
> All call sites guarantee src is composed only of valid hex characters
> and that src is at least 2*dst_size bytes, so hex2bin()'s stricter
> error handling is never triggered here.
>
> Signed-off-by: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gm=
ail.com>
> ---
>  fs/ecryptfs/crypto.c          | 18 ------------------
>  fs/ecryptfs/ecryptfs_kernel.h |  1 -
>  fs/ecryptfs/keystore.c        |  7 ++++---
>  3 files changed, 4 insertions(+), 22 deletions(-)
>
> diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
> index e67119b6029c..7e802fd631a6 100644
> --- a/fs/ecryptfs/crypto.c
> +++ b/fs/ecryptfs/crypto.c
> @@ -29,24 +29,6 @@
>  #define DECRYPT                0
>  #define ENCRYPT                1
>
> -/**
> - * ecryptfs_from_hex
> - * @dst: Buffer to take the bytes from src hex; must be at least of
> - *       size (src_size / 2)
> - * @src: Buffer to be converted from a hex string representation to raw =
value
> - * @dst_size: size of dst buffer, or number of hex characters pairs to c=
onvert
> - */
> -void ecryptfs_from_hex(char *dst, char *src, int dst_size)
> -{
> -       int x;
> -       char tmp[3] =3D { 0, };
> -
> -       for (x =3D 0; x < dst_size; x++) {
> -               tmp[0] =3D src[x * 2];
> -               tmp[1] =3D src[x * 2 + 1];
> -               dst[x] =3D (unsigned char)simple_strtol(tmp, NULL, 16);
> -       }
> -}
>
>  static int ecryptfs_crypto_api_algify_cipher_name(char **algified_name,
>                                                   const char *cipher_name=
,
> diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.=
h
> index 58165928ed1e..be91f7c3fc58 100644
> --- a/fs/ecryptfs/ecryptfs_kernel.h
> +++ b/fs/ecryptfs/ecryptfs_kernel.h
> @@ -47,7 +47,6 @@ ecryptfs_to_hex(char *dst, char *src, size_t src_size)
>         *end =3D '\0';
>  }
>
> -extern void ecryptfs_from_hex(char *dst, char *src, int dst_size);
>
>  struct ecryptfs_key_record {
>         unsigned char type;
> diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
> index 51651314b7a6..dcfb2e5fa88e 100644
> --- a/fs/ecryptfs/keystore.c
> +++ b/fs/ecryptfs/keystore.c
> @@ -18,6 +18,7 @@
>  #include <linux/random.h>
>  #include <linux/scatterlist.h>
>  #include <linux/slab.h>
> +#include <linux/hex.h>
>  #include "ecryptfs_kernel.h"
>
>  /*
> @@ -713,7 +714,7 @@ ecryptfs_write_tag_70_packet(char *dest, size_t *rema=
ining_bytes,
>                 goto out_free_unlock;
>         }
>         s->i +=3D s->packet_size_len;
> -       ecryptfs_from_hex(&dest[s->i],
> +       hex2bin((u8 *)&dest[s->i],
>                           mount_crypt_stat->global_default_fnek_sig,
>                           ECRYPTFS_SIG_SIZE);
>         s->i +=3D ECRYPTFS_SIG_SIZE;
> @@ -2015,7 +2016,7 @@ write_tag_1_packet(char *dest, size_t *remaining_by=
tes,
>         int rc =3D 0;
>
>         (*packet_size) =3D 0;
> -       ecryptfs_from_hex(key_rec->sig, auth_tok->token.private_key.signa=
ture,
> +       hex2bin((u8 *)key_rec->sig, auth_tok->token.private_key.signature=
,
>                           ECRYPTFS_SIG_SIZE);
>         encrypted_session_key_valid =3D 0;
>         for (i =3D 0; i < crypt_stat->key_size; i++)
> @@ -2179,7 +2180,7 @@ write_tag_3_packet(char *dest, size_t *remaining_by=
tes,
>         int rc =3D 0;
>
>         (*packet_size) =3D 0;
> -       ecryptfs_from_hex(key_rec->sig, auth_tok->token.password.signatur=
e,
> +       hex2bin((u8 *)key_rec->sig, auth_tok->token.password.signature,
>                           ECRYPTFS_SIG_SIZE);
>         rc =3D ecryptfs_get_tfm_and_mutex_for_cipher_name(&tfm, &tfm_mute=
x,
>                                                         crypt_stat->ciphe=
r);
> --
> 2.43.0
>
