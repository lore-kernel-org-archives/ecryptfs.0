Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794928129;
	b=ZWRazh401fDYoDS4T7OhVKxgrP4mbccxSJfT5eu35RH6fFVHyDgm6lLC0gA9xdTO7dTA
	 PZI4E4cokjqHpOt3LHEnsVal/3v5AvoHTEAOx53AS6bnRr2xtGiMY7W34OP+Yxg9iwqWt
	 ljdgCcX67Y4K+QDLjfL5el1hWvrrHvNyaAA5sUn5SgjlA5q9YdPv5h4ZFbAaLve/6Q5aM
	 DTh8+wg84XohPvdsbPHJl5gb7n+Oc1w/75YcYq+v84jFcjK3CTMkrjCGRj8FnHt8qT156
	 UnYpDyzFMz0evB+6ozAWujP07wYnyoc8ODbzNcRCjWBun7j++ulJynbRXYcqJBfXF5w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794928129;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=v4Gs94GpTkxbjUbZUukHPH6DHGGtLaeS/v6KOvCkTt0=;
	b=hpabIygtTerNU8vu3+IheK7omG+caarQtTtNGygySUTLhlEJQ8c8jMs/AhIsNz4JztwO
	 YdBfVazJd6Xb5B8qRIGCV82EEuLyajGFHR5YS7yl1/m6PKfl1Jfs6xNZKjM/d2QH6RerR
	 cXCM9kVB6Xgn/gMrzrwprx2K7C1nTYrXlMudhbmHStPBnQRclCSWlPymonkpmI0I/6+IS
	 0j1Iw/8F/eRtJFDrK1px3zCM6jN3vYSdZenxbZ+s1AF/YIR6biSIfo7INMs95ZNrE5unE
	 Brs3DbehCZCk8Asadtpwycpkbwi3Oznn7DwGUv/hktxYymlY/4/A/RCAdDq1aS9rayw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dEvQU3tq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6ED606A31C
	for <ecryptfs@vger.kernel.org>; Tue, 17 Nov 2026 15:08:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A6ED606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dEvQU3tq
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c445c95d553so701382366b.1
        for <ecryptfs@vger.kernel.org>; Tue, 17 Nov 2026 07:08:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794928126; cv=none;
        d=google.com; s=arc-20260327;
        b=aw/kfaqjIWDSNQ9iO2z5Y2EM5Mcx9eHEpRTofJ8zbdu/+UKNayK5L4ldi7RQ4I+2+E
         Tw3PWrCLi1j3l00iPcWC9x7LdaHH2kN+sMXGr3kq77bSNULlV3+/gFdJQbnMVNZAzpv9
         wDCpsYR7FiF5lZLtfRXmElqU5+ZlVAvr6WMFmaRtqGxEPZu06ZNLJtdxoTVmcfgmLqle
         L7kG7EYiGM5Tca9A5bvvg5IoUGSKz5Xmv2+trgEp1DceqNFKyrUp1yDDV7E2ogaC2qo3
         XcVOexooCS9nJNAidpMSPyR+EwMauQ51ERsbzpPMiHlmGp1G6omHP9oVnKYNGIhyLYC4
         U7uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v4Gs94GpTkxbjUbZUukHPH6DHGGtLaeS/v6KOvCkTt0=;
        fh=NJdaI4bPRBwqM5dMBZQclvLBDOE9Sj1+X/AJBO+lqLI=;
        b=SdJzB1zAEop9/SMt6C39F2AWK+sgcPa1RDEH7uQYAM2+F3quvdAjZ/4Bj3NWOC7k/V
         PQHYSfMRpEAFI0LgCR5jV03/ETlm8FZWeoZAET622hCodZQgt2dGDIIhl7FhNdj8x9so
         LkaN+3ZxhJZGZ3vKJxpfvzDJDERuev3OfDvxn+sr56bh/tCmBdYs2Wn3ZklOXR7NRiZR
         yMWc5TWzoO8d+SJdo/zs8dmvYN4ehmXlekjZmllVbw9j1FpXIIIBug05W6RBeAgoPwAx
         nm0Orev07hNOfTahTE8/8CbZjs7SmzevuyhdkQ5sxhR+0N77dtr8//v9sCgLDF0osVh9
         vJkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794928126; x=1795532926; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v4Gs94GpTkxbjUbZUukHPH6DHGGtLaeS/v6KOvCkTt0=;
        b=dEvQU3tqdmjUvLfiamBjgY5jLxARmhlHuB64p2TSsU0eR+7qe07bMzMLm/Npkw4HX5
         LeT3Aek+Xu0LzWxz3PBUrhOhcDmt4dK9LR4FvvFwIDuxqnKpdlT78S++skdUSXcRwNwT
         E2c0Hb813wSZ3lOsPD2GuUsXdxJ372qNxDIu2qCZXN1gjfeOSfCx8+BYxCNhI4HjuRj3
         lQW3vYXMrlIruR5wd6tjtuxMCs1zcvcfvCf1vjOcSFyLAFlpctAii8iRCNs/ZNX3ik4x
         SxrVo5mNFGuNlPcunuuAOt9YZnXnQ/hke+rbmtDE2c8xm4bYFeZR3qIAa3dRYv4S76bq
         2tIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794928126; x=1795532926;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v4Gs94GpTkxbjUbZUukHPH6DHGGtLaeS/v6KOvCkTt0=;
        b=Y/yMm+U5oWbkYBnFpqlatDTmX5MobPVO+/PmH1ms6ZEmQ9UgwRtzO9XVdSvYjZZ/+l
         8KmYRLx9CRfLoHy3IHDF3JGXUo1OrTKXPrAQwAeeuWvsqaqvPG7YaJygOrFXsh1lRWN1
         nnunbbK/JYEueolKwzlF2HBRB2ix+pl2tJek16P8qrW2LfoH9gFZqRlluTl6ZEDiK1Qr
         Ye458FBnowQRH6j6lov+n0W9B1tGnF+SvZ9/MrrAMmB0f6IFmsFxWs2urefD23oku+LV
         iQ7wnM3VNGTUS9mgXaRAve5scV+34j3MqRuWf9V/4r4F7f0N2iEm/59BIshG3OgErNNt
         8R2A==
X-Forwarded-Encrypted: i=1; AL+hErFO1QFO7rqo5fz+pYlIcId13LpPbX3rkw9m9DeDIRgy0zA5qe/S1DLBbvnGbrXsdg/2UDXAxKgOWQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z95xy78nOlKAfVF4zdK+jP/MU3XsRZ/Y3gJfLja+K9QGAzeY84W
	+lTLJctt9oBoEj78/ZrWqGteUWogT+GN6yWGmeVBC5HdKxAyXWaDXrG6vmL2xL/ihCPVxxaHYAq
	FJfsEWGqFsN/yJUBWpqMIHy6ne2rmV7MBDZn+
X-Gm-Gg: AYBFou01JDJxi9zRbFk8REriCa8ND7uDoHXvLwL2PFqaDN3GXJvqNSpG1MY6XE09R/m
	VDvQLP5pdVTTcv4e0+b9qoTBy9t6iFD+WTeXdYR9cia3cO1ngglznnLyKE+zSDxGAIhONO83JE/
	uoU3ttP7qIli8O4zKqlCOhPa1lu0ZP3cLVs72Tb7hlA0LY54AViblQxC7gv7BMN8SqegHFmhWZu
	DjXe7qdXmvC5SuONYScE9HHDUHuHVQKY7A/qv2Zdxqg96F5iMvYD16bJMAdpiTAeWxSXoRP3691
	rAuocTSqWzESpiNbrIgmXZ7zWEnv87iXg68TQ6zxL+Fg+Srro/mZD7l41LtXqzxDI4YEeLdu5yw
	DLG9i0f7X/PrcKqUmfflU7JOxxv5CrfZC8hXza5jmRKXuCq7nhLoXm2e1+xzEpjFrN7TETBn9e8
	9Jg8L++xJsbWKOvRqkodeC26VV2h1DTk3Qx7V48paH
X-Received: by 2002:a17:906:dc91:b0:c50:5a93:3bd7 with SMTP id
 a640c23a62f3a-c509614d52cmr1147920566b.3.1794928126422; Tue, 17 Nov 2026
 07:08:46 -0800 (PST)
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Post: <mailto:ecryptfs@vger.kernel.org>
List-Help: <mailto:ecryptfs+help@vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ecryptfs+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261014105634.2858-1-drifabdelmalekmohamedsaid@gmail.com>
In-Reply-To: <20261014105634.2858-1-drifabdelmalekmohamedsaid@gmail.com>
From: DRIF ABDELMALEK MOHAMED SAID <drifabdelmalekmohamedsaid@gmail.com>
Date: Tue, 17 Nov 2026 16:08:35 +0100
X-Gm-Features: AclHuK-Wos_gDpN0o1jIpvUQldbdrLIdgnnM6UyMd4PsAN4jwtTwU9QU0WtH-1M
Message-ID: <CA+xk8n8M7uAf5xuJMoZ2w3fDyp8DtJBVf1O8UdodaG4OSEc85A@mail.gmail.com>
Subject: Re: [PATCH v2] ecryptfs: replace ecryptfs_from_hex() with hex2bin()
To: Tyler Hicks <code@tyhicks.com>
Cc: Thorsten Blum <blum@kernel.org>, Eric Biggers <ebiggers@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,
Just following up on this patch to see if anyone has had a chance to
review it or if any changes are needed.
Thanks,
Drif Abdelmalek Mohamed Said

On Wed, Oct 14, 2026 at 11:56=E2=80=AFAM Drif Abdelmalek Mohamed Said
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
> All call sites guarantee that src is at least 2*dst_size bytes,
> but nothing guarantees that src is valid hex, and also hex2bin's return
> value needs to be checked, so we add a fail early check to call sites.
>
> Signed-off-by: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gm=
ail.com>
> ---
> v2:
>  - Added fail early check for hex2bin's return value
>  - Fixed doubline empty lines
> v1:https://lore.kernel.org/ecryptfs/20260829194528.5652-1-drifabdelmalekm=
ohamedsaid@gmail.com/
>  fs/ecryptfs/crypto.c          | 19 -------------------
>  fs/ecryptfs/ecryptfs_kernel.h |  2 --
>  fs/ecryptfs/keystore.c        | 20 +++++++++++++++++---
>  3 files changed, 17 insertions(+), 24 deletions(-)
>
> diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
> index e67119b6029c..059294df4b38 100644
> --- a/fs/ecryptfs/crypto.c
> +++ b/fs/ecryptfs/crypto.c
> @@ -29,25 +29,6 @@
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
> -
>  static int ecryptfs_crypto_api_algify_cipher_name(char **algified_name,
>                                                   const char *cipher_name=
,
>                                                   const char *chaining_mo=
difier)
> diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.=
h
> index 58165928ed1e..0efda4cea71d 100644
> --- a/fs/ecryptfs/ecryptfs_kernel.h
> +++ b/fs/ecryptfs/ecryptfs_kernel.h
> @@ -47,8 +47,6 @@ ecryptfs_to_hex(char *dst, char *src, size_t src_size)
>         *end =3D '\0';
>  }
>
> -extern void ecryptfs_from_hex(char *dst, char *src, int dst_size);
> -
>  struct ecryptfs_key_record {
>         unsigned char type;
>         size_t enc_key_size;
> diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
> index 51651314b7a6..4aaf62e61f3a 100644
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
> @@ -713,9 +714,14 @@ ecryptfs_write_tag_70_packet(char *dest, size_t *rem=
aining_bytes,
>                 goto out_free_unlock;
>         }
>         s->i +=3D s->packet_size_len;
> -       ecryptfs_from_hex(&dest[s->i],
> +       rc =3D hex2bin((u8 *)&dest[s->i],
>                           mount_crypt_stat->global_default_fnek_sig,
>                           ECRYPTFS_SIG_SIZE);
> +       if (rc) {
> +               printk(KERN_ERR "%s: Invalid fnek sig [%s]; rc =3D [%d]\n=
",
> +                          __func__, mount_crypt_stat->global_default_fne=
k_sig, rc);
> +               goto out_free_unlock;
> +       }
>         s->i +=3D ECRYPTFS_SIG_SIZE;
>         s->cipher_code =3D ecryptfs_code_for_cipher_string(
>                 mount_crypt_stat->global_default_fn_cipher_name,
> @@ -2015,8 +2021,12 @@ write_tag_1_packet(char *dest, size_t *remaining_b=
ytes,
>         int rc =3D 0;
>
>         (*packet_size) =3D 0;
> -       ecryptfs_from_hex(key_rec->sig, auth_tok->token.private_key.signa=
ture,
> +       rc =3D hex2bin((u8 *)key_rec->sig, auth_tok->token.private_key.si=
gnature,
>                           ECRYPTFS_SIG_SIZE);
> +       if (rc) {
> +               printk(KERN_ERR "Invalid token private key signature; rc =
=3D [%d]\n", rc);
> +               goto out;
> +       }
>         encrypted_session_key_valid =3D 0;
>         for (i =3D 0; i < crypt_stat->key_size; i++)
>                 encrypted_session_key_valid |=3D
> @@ -2179,8 +2189,12 @@ write_tag_3_packet(char *dest, size_t *remaining_b=
ytes,
>         int rc =3D 0;
>
>         (*packet_size) =3D 0;
> -       ecryptfs_from_hex(key_rec->sig, auth_tok->token.password.signatur=
e,
> +       rc =3D hex2bin((u8 *)key_rec->sig, auth_tok->token.password.signa=
ture,
>                           ECRYPTFS_SIG_SIZE);
> +       if (rc) {
> +               printk(KERN_ERR "Invalid token password signature; rc =3D=
 [%d]\n", rc);
> +               goto out;
> +       }
>         rc =3D ecryptfs_get_tfm_and_mutex_for_cipher_name(&tfm, &tfm_mute=
x,
>                                                         crypt_stat->ciphe=
r);
>         if (unlikely(rc)) {
> --
> 2.43.0
>
