Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AFA48423D
	for <ecryptfs@vger.kernel.org>; Tue, 13 Oct 2026 05:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791870325; cv=none; b=qJDXg/w8vmXT1pmbJ1KonCR2JeUWTdAsecAERRuLfA70TIWUihGA0YDumE3fue2/IkGLBwsgphrUK/qpTJGV5OizLi11/OY7mNdTLNwKvTsxLP/bRfS/T5dpaSLBAn5l7Tu8LD0dQF4d4cviPtT8bcT22wn/fJZ3R1L36bs/+CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791870325; c=relaxed/simple;
	bh=wV7FhRlEjhTf3ISX54Fesi0bceDxrcfOuLUheo4X1fA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRLDVMIAiXj37WoAsDh5gacMj8SESK55IH9H//AT6XgWE75bVQ+7GT6in2mzL1cGXyKDDdHlTABZ1zukQV4u3J20bjnK6IhCYCsnmRTBae/DNfTq663ALfsY1Sij04ZLfozdAm2hoLO8AALLUZTj6KYyIyLa4eov93Yn/yQogBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com; spf=pass smtp.mailfrom=tyhicks.com; dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b=bXzBIRgG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E6MAvCJb; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b="bXzBIRgG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E6MAvCJb"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E16797A016B
	for <ecryptfs@vger.kernel.org>; Tue, 13 Oct 2026 01:45:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 13 Oct 2026 01:45:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1791870321;
	 x=1791956721; bh=NoaNV0nM/PsGcw4H0EAUZvKAAmwB0FknruDGkw3KrU4=; b=
	bXzBIRgGCLCS8SNlmCM9PmfCUH7FUDPxh81Sctt/5D3vyLn7bP9IBRHwyAr6qemt
	MwrQS6+/tISFuu7EN7DUrQ5qwjhtsN+VOUhAK+q8/umzxIYJ0GSk4wHjLnyunAjY
	8mgvVHU1ge34690Cq4M2/4qgSCMu+6xzrKwApQVZgQTuN6IoKkMPDPyFZgk0+EpL
	ie8QWW4DuGICoR0iki79y6/OiM8rO+4zS5amWRF6Mlo1D8n7KvqcZGFwbt3m0cI/
	cm4tiLCImprmifeRUeq7iIJ/ve9NaYNjRCXSxW1ME7qJESJwyOtP6xWEgkKbX+6C
	LQB04MXy37XFf/JcQaQGNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791870321; x=
	1791956721; bh=NoaNV0nM/PsGcw4H0EAUZvKAAmwB0FknruDGkw3KrU4=; b=E
	6MAvCJbdNwUM7zwYRJFsDzJQujftbV8mDScwCxl4rDBOT61isLcbb0L+3WXOh1CW
	822bt3GesWyh1iyQTuPG2XNM35qQyueRP1fLQRR9k29A3dD70WJtY0rbbe1DxCi4
	B3+dkq/RE3l5tDIS570axG5ECzakhLJYtPgzuipaUOftekdxibUmPzHCKsqlf4jn
	98GT7ptG/HGAmNMxLJtCHZ2DfSkFUVnBwSV31sdEpagCs91Mx7fbT+ifqji5KSNb
	InqaLdq1cBQibkqCslsuWW1EWnvqCGY8C+7cyc52ibbkzi7hzBYrYyddh9JqaTtS
	a4KjOnRm/ArwJF6v+sR9Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=tyhicks.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791870321; d=tyhicks.com;
	mf=PGNvZGVAdHloaWNrcy5jb20+;
	rt=PGVjcnlwdGZzQHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:SWttSDlBeUc2SIha4YI/edz0FwCicyn17lWBikDCUxPw0CR
	lovFUyRvemhYCLNpReR/NlVV9YDCVKt8MAfdH2Yt1V6pSUXBW7z55lJiqMQWbX3k
	wkg3QUnQ966l/pKk7b2lDHWuYAfeM1yyl0Ltfm8ne104aiYwXZ6GL1cbDDRZWi03
	PQV+dHXv0i1mKL7Zj7KHEUV2hib+mjTJ7lbtGaojwMWiZ3Rlmujc8bqgS7Lx0T7W
	YBtgGwITnee2//7g/y5jHAwVEAdhwYsoiUkTxKkZR5kmfChGqv7kagpCygB6om06
	VYXqZbog+/PmC7xLkn7d9w/xmsaz0GTH5cJqo9Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:2vrpf0zd9oFJZTU95fOScM7nUGhLDbYykYev7yVJm4w=:wV7FhRlEjhTf3ISX54Fesi0bceDxrcfOuLUheo4X1fA=;
X-ME-Sender: <xms:ccXNak8NHpwuv4qnGOn5LtBaTt04bQTyUMxBlRBflmSyVu9r-4UT9w>
    <xme:ccXNamAUgiP8qDmHYtoiFNnzhkH8nsgh_GmQK6nVekNW-_dpb_iwoCZ9gyJQmzTo_
    FbEpovbnbZAYlGvpPIO17nnjMbOQdRQfvLs8xuVUElqmrU0gS54JYA>
X-ME-Received: <xmr:ccXNahS8pmt26cOrLGeg1iBZ0_RixHWPIcDRLxtFcPSQe5sA_1_a1w>
X-ME-Proxy-Cause: dmFkZTFQMmnHYPkDcZKHQ4Z7CKfzl9J4sCnLdeM6pyEMXn3c9PjPdV9qbUkJL5TAcho++b
    X7OkBDR1MlIDSrq2fHqEyjVyiwBzDUJVCb6xY878fivlR0lWSjXZZJyAHe3JIBKsSEuw8B
    8F0UwXFXAbytWOiaYJw98X7Vx20e+bIUsRXMw8crc8c80UTLwtdeU4KUMlLKuq66wvSp6j
    7C/wlKZoZ6ZGdxE502tqePcVTjZgF9KtYubpaPmqhw+hQmG1Wz9fyzVxbOPbDK5jNNBolg
    5VIBw6lEg9/xLh0ERzh23E+l1jStw6Vf/7JOGzvoqXyLaC5Vu/gvOvR51Z32e0dGGYO6m7
    S8Jwk7v3hDaV6oTvFz6UGE6TRThfz1FI961jfMQVe5I64RnRBjDrcc+DcfRXhL6g2bDseF
    bT1OAgMqTeUBUVLD0024GhuUdZ2t+EUuo2gGuJUYxgH2RN/j9oObccxrqahHeabWEdHBxE
    GxxJFTN6EbjZbblVZ3qeKASFJeLTrXhDHRZnx+KcSVfIj6a9oiNRsflDBU2+R8Pee8MrZN
    mW8bX3eCBPkXsngW22CLu7I+0GF04oC6cIpUWuBI3RlUEYpYscGhqAxd8QOOav66b8XoHT
    CXJYZZb+cHwsGmWL7YizmRHrBA4loEjm2COWh6VHnKGm7/GoY8oHt+ddRhqA
X-ME-Proxy: <xmx:ccXNalsrmOxrhWacRG5mni5bVkS3l5Z2hFUOcvM3Gcw6I_4HV0F5CA>
    <xmx:ccXNal2uqmMPqeI-XjBusCk6uBI4zFWesLBOsxZIEj20DeId6Hwqhg>
    <xmx:ccXNauXP3SopfoFBPgsWgO-odWwX_HdjWPkFFrvGc1t-jypaLnhUtQ>
    <xmx:ccXNaoIembHCecBNla4mhWzrI_B5MdLZOZPZzb1vq8LAU2Tm4P1xyA>
    <xmx:ccXNav0_jWSm5DTEkKEbfgbFZpcEnmJmgCRkCPXHNOt730Z6BpHujwp7>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 01:45:20 -0400 (EDT)
Date: Tue, 13 Oct 2026 00:45:13 -0500
From: Tyler Hicks <code@tyhicks.com>
To: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
Cc: Thorsten Blum <blum@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
	Christian Brauner <brauner@kernel.org>, ecryptfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ecryptfs: replace ecryptfs_from_hex() with hex2bin()
Message-ID: <as3FaQ8JLWmxrj6T@elm>
References: <20260829194528.5652-1-drifabdelmalekmohamedsaid@gmail.com>
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260829194528.5652-1-drifabdelmalekmohamedsaid@gmail.com>

Hello - Thanks for the patch!

On 2026-08-29 20:45:28, Drif Abdelmalek Mohamed Said wrote:
> ecryptfs_from_hex() relied on the deprecated simple_strtoul(). Rather
> than patching it to use kstrtoul(), its intended replacement, remove it
> entirely and switch all call sites to the generic hex2bin() helper
> from <linux/hex.h>, which already provides the same functionality.

This breaks the build, as none of the callers check the return code yet
hex2bin() is marked as __must_check in include/linux/hex.h:

  CC [M]  keystore.o
keystore.c: In function ‘ecryptfs_write_tag_70_packet’:
keystore.c:717:9: error: ignoring return value of ‘hex2bin’ declared with attribute ‘warn_unused_result’ [-Werror=unused-result]
  717 |         hex2bin((u8 *)&dest[s->i],
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
  718 |                           mount_crypt_stat->global_default_fnek_sig,
      |                           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  719 |                           ECRYPTFS_SIG_SIZE);
      |                           ~~~~~~~~~~~~~~~~~~
keystore.c: In function ‘write_tag_3_packet’:
keystore.c:2183:9: error: ignoring return value of ‘hex2bin’ declared with attribute ‘warn_unused_result’ [-Werror=unused-result]
 2183 |         hex2bin((u8 *)key_rec->sig, auth_tok->token.password.signature,
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 2184 |                           ECRYPTFS_SIG_SIZE);
      |                           ~~~~~~~~~~~~~~~~~~
keystore.c: In function ‘write_tag_1_packet’:
keystore.c:2019:9: error: ignoring return value of ‘hex2bin’ declared with attribute ‘warn_unused_result’ [-Werror=unused-result]
 2019 |         hex2bin((u8 *)key_rec->sig, auth_tok->token.private_key.signature,
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 2020 |                           ECRYPTFS_SIG_SIZE);
      |                           ~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

> 
> Update call sites with the (u8 *) casts required by hex2bin()'s
> signature.
> 
> All call sites guarantee src is composed only of valid hex characters

I don't think that's true. The first call site I looked at,
ecryptfs_write_tag_70_packet(), is using a src of global_default_fnek_sig
that's initialized from a mount option that ecryptfs_parse_param() only
verifies is a string. There's no hex character check that I could see.

I didn't look at the other call sites.

> and that src is at least 2*dst_size bytes, so hex2bin()'s stricter
> error handling is never triggered here.
> 
> Signed-off-by: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
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
>  #define DECRYPT		0
>  #define ENCRYPT		1
>  
> -/**
> - * ecryptfs_from_hex
> - * @dst: Buffer to take the bytes from src hex; must be at least of
> - *       size (src_size / 2)
> - * @src: Buffer to be converted from a hex string representation to raw value
> - * @dst_size: size of dst buffer, or number of hex characters pairs to convert
> - */
> -void ecryptfs_from_hex(char *dst, char *src, int dst_size)
> -{
> -	int x;
> -	char tmp[3] = { 0, };
> -
> -	for (x = 0; x < dst_size; x++) {
> -		tmp[0] = src[x * 2];
> -		tmp[1] = src[x * 2 + 1];
> -		dst[x] = (unsigned char)simple_strtol(tmp, NULL, 16);
> -	}
> -}
>  

Please don't leave two empty lines next to each other.

>  static int ecryptfs_crypto_api_algify_cipher_name(char **algified_name,
>  						  const char *cipher_name,
> diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
> index 58165928ed1e..be91f7c3fc58 100644
> --- a/fs/ecryptfs/ecryptfs_kernel.h
> +++ b/fs/ecryptfs/ecryptfs_kernel.h
> @@ -47,7 +47,6 @@ ecryptfs_to_hex(char *dst, char *src, size_t src_size)
>  	*end = '\0';
>  }
>  
> -extern void ecryptfs_from_hex(char *dst, char *src, int dst_size);
>  

Same here.

Tyler

>  struct ecryptfs_key_record {
>  	unsigned char type;
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
> @@ -713,7 +714,7 @@ ecryptfs_write_tag_70_packet(char *dest, size_t *remaining_bytes,
>  		goto out_free_unlock;
>  	}
>  	s->i += s->packet_size_len;
> -	ecryptfs_from_hex(&dest[s->i],
> +	hex2bin((u8 *)&dest[s->i],
>  			  mount_crypt_stat->global_default_fnek_sig,
>  			  ECRYPTFS_SIG_SIZE);
>  	s->i += ECRYPTFS_SIG_SIZE;
> @@ -2015,7 +2016,7 @@ write_tag_1_packet(char *dest, size_t *remaining_bytes,
>  	int rc = 0;
>  
>  	(*packet_size) = 0;
> -	ecryptfs_from_hex(key_rec->sig, auth_tok->token.private_key.signature,
> +	hex2bin((u8 *)key_rec->sig, auth_tok->token.private_key.signature,
>  			  ECRYPTFS_SIG_SIZE);
>  	encrypted_session_key_valid = 0;
>  	for (i = 0; i < crypt_stat->key_size; i++)
> @@ -2179,7 +2180,7 @@ write_tag_3_packet(char *dest, size_t *remaining_bytes,
>  	int rc = 0;
>  
>  	(*packet_size) = 0;
> -	ecryptfs_from_hex(key_rec->sig, auth_tok->token.password.signature,
> +	hex2bin((u8 *)key_rec->sig, auth_tok->token.password.signature,
>  			  ECRYPTFS_SIG_SIZE);
>  	rc = ecryptfs_get_tfm_and_mutex_for_cipher_name(&tfm, &tfm_mutex,
>  							crypt_stat->cipher);
> -- 
> 2.43.0
> 
