Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F943A3E7C
	for <ecryptfs@vger.kernel.org>; Tue, 13 Oct 2026 05:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791868618; cv=none; b=tfRx3XH17fej3jQ/nGtXzkODDicrlhNdtw99ZKjQWD2lfwF4h0XRanGVI9XWkxv9cnSVhaxw1yBCn1W9KlyphwLG2PBqSKatrapk81FsLjluQTrqLsjngntrZrVduPOs7MJjhsDXGVACnt+FRuxvNTxji5kFwb+Rqa5AqCJXGSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791868618; c=relaxed/simple;
	bh=4X9OtfPcEj6Yp8ofM0F5YIxm52oAcRrzxhWRqA4gExo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XoWXx/p1nkUnHCd1GEpXfXDup/rKEeD61u0jwuijOKBm9dq8aIyO/gj8zzE6AQkAS65dU1sWQqqlwBTVaL8RT6Dc1NNfjo5rsJ74uf1ZGHVXjBxzCjm6QIGdsR9qP2KnEi8GDHTHH+XD7EAZLzc6AEC7+D93njs7W0MDEhDyyU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com; spf=pass smtp.mailfrom=tyhicks.com; dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b=D1cV5Ggt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vF84WylI; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b="D1cV5Ggt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vF84WylI"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4077D7A0157
	for <ecryptfs@vger.kernel.org>; Tue, 13 Oct 2026 01:16:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 13 Oct 2026 01:16:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791868614; x=1791955014; bh=g7ci0E+ONT
	Hc3tjsgx5n82qd5rNcB/VzzZXjndImmyk=; b=D1cV5GgtGfKtNkREaEEGls8NQe
	TDKlErjziNNONLrdbvgNL5OsZ//88a9a3t2xDAdwU4OT4ZfwcImbmG8bPhsNO48M
	90nKBxXV4pjTnnkKBNEBLUIkTVNWywocNvrGI4AZta/gzRC5qGE0VN9+Ai5fQeiU
	eLczVKqjmbWMpb0grMrRGaRjI47iQBPnWP7IEnBSL9F/4ggTK6ZKv//jlcuq7A8V
	po3pO1xcQjoVpLngme4z6DQj8iltF9tBzkBKK9pyogEeYlDS4szp48fTvRBFO+yf
	GLSN5CW6D8D37ZO6HXLbnYdJ34JFs95LksRPNDr0kYsEx5G1D3R+Mva3ykMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791868614; x=1791955014; bh=g7ci0E+ONTHc3tjsgx5n82qd5rNcB/VzzZX
	jndImmyk=; b=vF84WylIqjJyHQ6ciu3t4CnEaPzVvWpTS1TrM4vIVDNFoAkif04
	3enjng7LfZJZxLwXYcL/ruuOL4Jsb5XITGtomf55AaX2aHCDaFOQj1ueMLMSsHse
	oEP4q2hHVcjOAA80XbXZHMrTVMRoAIMTerE4Rx9kS5OjC6NwOGx1K33+Fkqp8WX4
	mAWgNF2OPKmBLrl9UC4DJCwA5sz/BEffyq0hw1DumHMmnxn9Hr5xag4vYh4OiXKp
	S8u73W+6rh9TjAI5NP+3U4Rl2FfCrQGg4op9l8ei5oOlx72l+pDQUc4qWZZvezak
	xAWu9aGA37+JGjw2aRtFViYdmxFMEO7uRxA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=tyhicks.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791868614; d=tyhicks.com;
	mf=PGNvZGVAdHloaWNrcy5jb20+;
	rt=PGVjcnlwdGZzQHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:AJjZuMX9CGBYqJSCrCtUFLzh5mNqhLYjgxqIB9GyrD7O/+q
	msg8xfr8Gq9tXsWQ1uqwOXg6HsfvTFdCK3KokWkc3Pr6+uzKEL0M56HpKnfoRZwG
	Aed90jcZi6nJGpo6Rva6OzRnoggP028AojpSg00mqBmPZCYcpfIpJK4rXPmjc8Lq
	glTYGYxlvQHz4nqAFY9RiwdTnXtYwNgwaXGAT4qIsh7WCgdUfAFGUVqlUv/zlqG3
	rktg9L65+4J5tJoRomLL6WYKgCuXjgLzercMKG/7ZEYvXWoxJqn6V9/E8Bk8cWsu
	mvc1VIfKEro7eDJfU6PmqAcxzrkZEy80LmXksmw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:9D0GS4Py/nWx3n4welxtWrTskGaTiUsWrf9Uys6W6ck=:4X9OtfPcEj6Yp8ofM0F5YIxm52oAcRrzxhWRqA4gExo=;
X-ME-Sender: <xms:xb7NagW4dhfih14FfIhS5bI_yKb_R-4qLGPLRPDm3CMs4VEy7P0S6w>
    <xme:xb7Nasupe8ykMyF6g95y05OM5izIkBdj594M6g5oiJnOL8_JR_Kqp3g76ooaI2DqS
    y_CIP2gJ6ou3JAnBQblh8k7Sk5BzSr4oNPB1WU8eCG1khO1iZJCabFt>
X-ME-Received: <xmr:xb7Naj678IW0b8yFg7iAc32U-tlIC4njDIgRAmFtWdHBDKZgY1EzXw>
X-ME-Proxy-Cause: dmFkZTEkfxmaP70pAWGYONETfCGPyGWkRZlmC7rfrtaWwEap3e8570RpWiMtyDt5mfk3E5
    kmdietFpHIwpWDJ5/SxlslKaMhwfZzCOUAnoEV1cc8odxK6ZodiPVNr63wjjtfYc+X2hmQ
    nnK6TSBewYdosfdqb6oiVeRTwKgzvt8USz1UaH5f/V6Qi0wf7/R2WtuG3E+UEUf27ZQjzQ
    +CwM6+uBWtigby1YClaoNbjZ+BhZ2G+KySQErj6Oihq7i8czIDLVGVpXYpCz5QgW1SHDRv
    6+FtKraU0UkjKUv5ulv0L8JMIsywHXoMXY+EcVB7fQ0z0F2H8d9cJR92XLFeQPvh5ZUhKE
    k6QPdlsZvbpzegqX4Rj+4RF/qmwvB2NeIRUsoVPzBcbOkjq8VLAeGbwuSyD/rERN0emcQm
    7GDcQR9I0SAUYf1iqVNuDxyYTZYgXSPnPgC4sX228ijpkVKuCvKXa3gSJpXrKrbQ/TobxQ
    WoNZnVjvjN+05vomcr8BOF9kX/ikXwODXwLoPBvdVX5QFZ+4UA+UkOtoka2m+Qz8cNxOJT
    td9rEDiGPnozXLfmfA+GUOOq37O8RgOxeoaqguQpwnyOQNG9r+fVnhtr2xYQZ++Iiaex73
    5aacU3POBpeTvcOUXpCfSmpNiNUs+l2W2PaDxBbGjzSntH6s0D4jI7Y4tXrg
X-ME-Proxy: <xmx:xb7NavTrSwOO0RVDU9Cpu7BgvRrhGZiuozvM4ehQ4CRPnyiW0wZ2wQ>
    <xmx:xb7NamvQMDd9PpvNx5fOXYjQv3SUm1eLvaO_JCZM_7C_W7y2cTm5jg>
    <xmx:xb7Nah9_Gq3uK12EY16rDzjSs8LV7oN-uUW4Ozifu-1JE3l1NyC3Nw>
    <xmx:xb7NavwE_C3EvfU6gwFVKEol4rANqq-ZR1H_Rfti8H18FJA5Oqz3Xw>
    <xmx:xr7Nakrry2O5Y24hukYKcLuG3CfDMbZyoscO6uGT8WLkFPLiAFOgTrkk>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 01:16:52 -0400 (EDT)
Date: Tue, 13 Oct 2026 00:16:50 -0500
From: Tyler Hicks <code@tyhicks.com>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: blum@kernel.org, chenyichong@uniontech.com, a.velichayshiy@ispras.ru,
	kees@kernel.org, liubaolin@kylinos.cn, eilaimemedsnaimel@gmail.com,
	ebiggers@kernel.org, roberto.sassu@polito.it,
	ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+e4391e0d6e7c89b8c84e@syzkaller.appspotmail.com
Subject: Re: [PATCH] ecryptfs: validate auth_tok key payload size before use
Message-ID: <as2-wsk8sBuwOUWO@elm>
References: <20260922044400.14078-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922044400.14078-1-kartikey406@gmail.com>

On 2026-09-22 10:14:00, Deepanshu Kartikey wrote:
> ecryptfs_verify_auth_tok_from_key() casts a "user" type key's raw
> payload directly to struct ecryptfs_auth_tok without checking that
> the key actually holds enough data to back that struct. Since a
> user-type key's payload length is fully attacker-controlled via
> add_key(2), an undersized key whose description matches
> global_default_fnek_sig lets later code (e.g.
> ecryptfs_write_tag_70_packet()) read fields such as
> session_key_encryption_key/session_key_encryption_key_bytes past the
> end of the actual allocation, causing a slab-out-of-bounds read.
> 
> Reject the key up front if its datalen is smaller than
> sizeof(struct ecryptfs_auth_tok).
> 
> Fixes: 0e1fc5ef470cc ("eCryptfs: verify authentication tokens before their use")
> Reported-by: syzbot+e4391e0d6e7c89b8c84e@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=e4391e0d6e7c89b8c84e
> Tested-by: syzbot+e4391e0d6e7c89b8c84e@syzkaller.appspotmail.com
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>

Hello and thank you for the patch. Unfortunately, someone else sent a
fix for the same bug before you and I've applied their patch. You can
see that email thread here:

  https://lore.kernel.org/ecryptfs/20260917044558.41677-1-neganhat@gmail.com/

Thanks again!

Tyler

> ---
>  fs/ecryptfs/keystore.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
> index 51651314b7a6..81768a0e43b1 100644
> --- a/fs/ecryptfs/keystore.c
> +++ b/fs/ecryptfs/keystore.c
> @@ -462,6 +461,14 @@ ecryptfs_verify_auth_tok_from_key(struct key *auth_tok_key,
>  		goto out;
>  	}
>  
> +	if (auth_tok_key->datalen < sizeof(struct ecryptfs_auth_tok)) {
> +		printk(KERN_ERR "Auth tok key payload too small (have %d bytes; need %zu)\n",
> +		       auth_tok_key->datalen, sizeof(struct ecryptfs_auth_tok));
> +		rc = -EINVAL;
> +		*auth_tok = NULL;
> +		goto out;
> +	}
> +
>  	if (ecryptfs_verify_version((*auth_tok)->version)) {
>  		printk(KERN_ERR "Data structure version mismatch. Userspace "
>  		       "tools must match eCryptfs kernel module with major "
> -- 
> 2.43.0
> 
