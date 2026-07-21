Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE85434409;
	Tue, 21 Jul 2026 07:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784619333; cv=none; b=acUzA3a3wisvZXtOBAr42918qHpLvK4rjFA3wK9ZBcftIsvAvOD5dZ+Hmsxs8+njHmlIPxE33N0xiPIUCi2/UX6KSRY8MHuRqPTWVs7iulskHZez7QGAUWYci4CLbCeL87fLA1Vi/8kjM59hqdmBZ2lMZ1jrNG90J5N/yf9tTGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784619333; c=relaxed/simple;
	bh=g1NGzMnJm99C0uPmgPrc1CqEKvaEq1bSwewVCeCoy1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mbcc7yM4BawdeBigbluKbAGozE6qkxRgRaNrqj0unvCW40CgFIQKoE6vjL7OJBffii1p3J3cTciUxLsacav3EPM5f23suK/OfVelW22L7PSJbkZdZjLhlV01NCqF72CbF4Kjo83aZOeRYmW6VkgskNmzg8ro8cVni1iscDjvQOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com; spf=pass smtp.mailfrom=tyhicks.com; dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b=wWE7N7e3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nnuhS/3T; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b="wWE7N7e3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nnuhS/3T"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id D28391D000AA;
	Tue, 21 Jul 2026 03:35:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 21 Jul 2026 03:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784619331; x=1784705731; bh=im2rFGJQvz
	y7plV0Nw/aDeWcRdmqHimw9ukJk6ge0h4=; b=wWE7N7e3AcSl51czORFvKlbpvT
	WnSm+LPQcMPRVe9QorVudFPU1AKte4+OB0GuAtcLqoU1lpqH4XGwRUHkDbzHMvNq
	TPF8INCv//xlad5CxNsDaTT+nBu0aUvyI8OG84vTGf0LkaW+6WcI0ClgW21edZ0C
	VuCZOhLMV7EiiHz0NvupLfo+wZrhgPRj4wQJIwK1rVAZisl2+Cw+yFSOAFV5Mrgf
	ppxn3iaA38SAOa/2Vgom64p/1AVw3GftAtcLtVUPiZ2KxdkKWbIFJiY2rfN+R9x+
	PF6Ewby6VfHp8Tfoa7bQjGi042F307ReqpM7IBp8+wklMjBMfPFexJUJoZZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784619331; x=1784705731; bh=im2rFGJQvzy7plV0Nw/aDeWcRdmqHimw9uk
	Jk6ge0h4=; b=nnuhS/3T1PVXPekzMme8et4yzBtR8pC0R2Wzh+oUlyT0K0El9tw
	reiW8nJWbKmMyFissiC2orgEA+O2gkUQ4Jon05o3rYQLLr3XHIUQEcFQNd+uk0aJ
	u3FpOoh/r/QVmKnu/D9nozejNKSPa9H8GnVEqJ/QeHYLeoAxOms25kmpGt764i7M
	FrzywUyxRnE4dG246Tkq7XFBdtJ91bjYx6t08C5ERd+6QMCH1u30w9Di3c57tnjj
	dmGbtmP0mJirW5FAQxukm7Iku4zWJkEwg74VLZwFt/jynhcxXq4CPU/G3/L7FbQR
	s41R3eZn/BWLY1yVc1rcI4fOMpkmf+6e1HQ==
X-ME-Sender: <xms:QyFfask_2s2QWBVgTQ77Q1Bd_8qo_s-yPlKB_rme95c9UzFDwa4lOA>
    <xme:QyFfaprMp6-JcuPWRvKyQcxnpzvFKxsBzA86a3sdi3J3Ff4anHJT0XZOrHJAcJQaE
    HPLdmkCqhsfRwOEQM01g3YEx0IqbGYMtGIfxT5lNFTq8LCTsCU3wKo>
X-ME-Received: <xmr:QyFfalGvfWMzTZrsvugVHMDn8o7lC_609ZqbnCYg9jCCd_1pCiz7Pg>
X-ME-Proxy-Cause: dmFkZTGCQVWqPdYJpPzbxkQqCEECCmTQdGzUTAP7fzOqaC7Ckl44PTnD7C8rlE812keHzK
    RxPDTOyo/OHzR0EyLvlM1FJSg6oNFDhkY9pSVwJlbYTIXkfABenT+tWGALkd5R0T2qcFTZ
    YwAZWV775tiU1C09xhh0dtJgDYq/3vxwxoIxiAPXrk/dhJl/MWtUN7PARaXw0JS7UydC4M
    wcoaCXleTjII0eoqEiK9xvQZmiSLsfYXdVOIRjrDFA/DuMtHTOmzrr6xF6nNUUPs/mTgBz
    yPYbewTEQrt5HgbZyPo+1M2mmLHdSF2mbFt4GOA3F2mx0G5ZU8uXrxiHHsun40g+a3x2C0
    49wzqGnO/OlVr4z7vmTAYy3adDUpXowXV8T5jHezE4ekqNAcUfaUMqZax8vGgPwoKRc5hX
    3fSGHDngOFsnHCBvVqE0njPikTeTWmOQuBTuWeEhbEqzkSgSqTpZqlHFrhqK+EJHysFvnV
    eBN+1f7ufTAONBTYk4LzaEk00akQWJtGDSW772XiJz8FbuLa03Em/MhApl9Iuedaz2ll5z
    OSiJxsO9nITTuqd5m53cYe6EmrnHAMrHqrUHRb4/i7igD0sNApL3DWbs/EP6d2gA/mF2da
    7nXTyPo+IzQaYRV6zYYFsN/NONg8hIEzRJ7/sdjPOCP6uue6l/yHoZMd2zqA
X-ME-Proxy: <xmx:QyFfaly5SHNYmX4UmVijRauu6tiju73vNaXOxenBWwY7Se25QS6PKQ>
    <xmx:QyFfaqqnOp3IsX-vm5L1sVL_hq5kFFoj16ZcZxG5nE3g7Xj4MQNqig>
    <xmx:QyFfavgFgbxN1KQx2cszgCCf17OuJTgkbZwgFzvLcA60kdL2bIyz5w>
    <xmx:QyFfanjt_mF3bUU5rCUoG8tsCD9ghf8Px22sEV6-rR06ZbWuoqvM0A>
    <xmx:QyFfavbgAS5nYiynMrcWnal1kgJ3v29TwH167y7ZeiolprgbFsagoNzB>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jul 2026 03:35:31 -0400 (EDT)
Date: Tue, 21 Jul 2026 02:35:26 -0500
From: Tyler Hicks <code@tyhicks.com>
To: Jay Vadayath <jay@artiphishell.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	HanQuan <eilaimemedsnaimel@gmail.com>
Subject: Re: [PATCH] fs/ecryptfs: fix slab-out-of-bounds write when
 decrypting session key
Message-ID: <al8hPqCTYlYAkiPP@elm>
References: <20260720181140.8512-1-jay@artiphishell.com>
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720181140.8512-1-jay@artiphishell.com>

On 2026-07-20 11:11:39, Jay Vadayath wrote:
> parse_tag_3_packet() only bounds the Tag 3 encrypted key size against
> ECRYPTFS_MAX_ENCRYPTED_KEY_BYTES (512), but
> decrypt_passphrase_encrypted_session_key() decrypts that many bytes
> straight into the fixed-size auth_tok->session_key.decrypted_key buffer,
> which is only ECRYPTFS_MAX_KEY_BYTES (64) bytes long. A crafted lower
> file whose Tag 3 packet advertises an encrypted key larger than 64 bytes
> therefore causes the cipher to write past the end of the decrypted_key
> buffer (and past the ecryptfs_auth_tok_list_item slab object).
> 
> KASAN report from opening a crafted eCryptfs file as an unprivileged
> user:
> 
>   BUG: KASAN: slab-out-of-bounds in aes_decrypt+0x1587/0x1640
>   Write of size 4 at addr ffff88800616af38 by task poc/115
>   Call Trace:
>    dump_stack_lvl+0x64/0x80
>    print_report+0xce/0x620
>    kasan_report+0xec/0x120
>    aes_decrypt+0x1587/0x1640
>    crypto_ecb_decrypt2+0xe9/0x150
>    crypto_lskcipher_crypt_sg+0x233/0x360
>    decrypt_passphrase_encrypted_session_key+0x4b9/0xb00
>    ecryptfs_parse_packet_set+0x5d6/0x1d70
>    ecryptfs_read_metadata+0x102/0x430
>    ecryptfs_open+0x274/0x5f0
>    do_dentry_open+0x401/0x1280
>    vfs_open+0x74/0x350
>    path_openat+0x23e7/0x3eb0
>    do_file_open+0x1ef/0x450
>    do_sys_openat2+0xd7/0x170
>    __x64_sys_openat+0x133/0x1d0
>    do_syscall_64+0x107/0x5a0
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Reject encrypted key sizes that exceed the size of the decrypted_key
> buffer before performing the decryption.
> 
> This bug was discovered by Artiphishell's vTriage pipeline, which
> generated a userspace reproducer (opening a crafted lower file) that
> reliably triggers the KASAN report on an unpatched kernel. The fix
> below was drafted with the Claude coding assistant; a userspace
> reproducer is available on request.
> 
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Jay Vadayath <jay@artiphishell.com>

Hello Jay - thank you for the report and fix! This issue has already
been reported by HanQuan and I've pushed the fix to the ecryptfs next
branch:

 ecryptfs: reject oversized encrypted_key_size in parse_tag_3_packet
 https://git.kernel.org/tyhicks/ecryptfs/c/5babe9c177c364521e3e682b949c5a8c47f4a441

We opted to fix it a little bit different than your patch. Please take a
look at it to see if you spot any issues. Thanks!

Tyler

> 
> ---
>  fs/ecryptfs/keystore.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> --- a/fs/ecryptfs/keystore.c
> +++ b/fs/ecryptfs/keystore.c
> @@ -1615,6 +1615,14 @@ decrypt_passphrase_encrypted_session_key(struct ecryptfs_auth_tok *auth_tok,
>  	struct skcipher_request *req = NULL;
>  	int rc = 0;
> 
> +	if (auth_tok->session_key.encrypted_key_size > ECRYPTFS_MAX_KEY_BYTES) {
> +		printk(KERN_WARNING "%s: Encrypted key size [%d] is larger than "
> +		       "the maximum decrypted key size [%d]\n", __func__,
> +		       auth_tok->session_key.encrypted_key_size,
> +		       ECRYPTFS_MAX_KEY_BYTES);
> +		rc = -EINVAL;
> +		goto out;
> +	}
>  	if (unlikely(ecryptfs_verbosity > 0)) {
>  		ecryptfs_printk(
>  			KERN_DEBUG, "Session key encryption key (size [%d]):\n",
