Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898F7155C97
	for <ecryptfs@vger.kernel.org>; Tue, 13 Oct 2026 05:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791869191; cv=none; b=qlA7412w9NkCmxA0n+9Ip+EyWmfxg5WYp0pgP3pRDPSTaW0tJh5MthVldmFFprC9fS8FfxDP0crVXR8saEJZGeGrN07VGXj3z8GEtgmH7p56BXbIk0v6dFe6aE5IK+j9saHqx7jt+Gt47+fK1VsonMec5K/znpbUgkqEnWCK0h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791869191; c=relaxed/simple;
	bh=Fj/7Rau5jbwsHnvIEc0kLXj+5yvxtMNia0ExsvNF6Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jon1pYdxFFkkZkDFT2DAhVjkgKOaFHnD6fJqZv2IMdDMZYcWk8XbUpevcSrhiW9w2N9eZzVFGoj6UwsoGXgP3Fy9/mxux/C918J+C6rqRXij0WZODuv5DpDNqgCKtzzdW1+OyYIQV3mxUZG5dxighBBUEqlkajcbYXc9gggLrK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com; spf=pass smtp.mailfrom=tyhicks.com; dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b=bIQ+wEix; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RdTQmrRS; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b="bIQ+wEix";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RdTQmrRS"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id E109E1D0011A
	for <ecryptfs@vger.kernel.org>; Tue, 13 Oct 2026 01:26:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 13 Oct 2026 01:26:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791869188; x=1791955588; bh=HxHiT242ry
	B+neHrDHoZM7GXKE+Q1by0dpdtYnNYS4U=; b=bIQ+wEixgneiE4t/YwBHgNDBpq
	TG03Rr1dnIyl/gqKLkmeGu4fO4SLIAGtUwX5fANZb0qR3PZh/DGXlPZvGa4xEb02
	n2QX6wDWMsTBNDX5nZPpJsDyQ7o1ths7icvbumCjMuHXjd07PgTT1z/9Nze0/CVm
	sO+qm6bl/c9cLvKwkNz+mjpTZFDftG1gzlrA0tNqAmg6CAzk8uxQoCvrbrIU2oUr
	lHB/OFwUsrCiW9LsvExGW+ARzxoq7czfCZx7py1SUCjSS5QZxETud9IqUpM2Odd1
	Mo4lWD1JmeuLhFXhoU5RelyjfO64omgEQuR82dAZfCbqZfXZqsAbAjqxwUUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791869188; x=1791955588; bh=HxHiT242ryB+neHrDHoZM7GXKE+Q1by0dpd
	tYnNYS4U=; b=RdTQmrRSO5l4ZYcZbf4uuF+QyZYzhHNpZ02iq1HAZnUxxV0ahk/
	Ji5R15sZZMbijDAy6J1YvuSbQtZZYsUmsPQH0qMAu2NeV9Q9vztKgvyVqzipwkNZ
	50W6AUJAH2pjM1/wFw87TT3c4ZglOcI0Pb1MDuw3R6QyAbHWCPVeTRqIJ0cM6Z8T
	4eoEDmaexNhG853Valkjn0/DXd2yyNXfry71Ix9q+piIvLDEaSIY5wNQ2P/ckxmK
	WUEVK08Q1YnaS/aumIyCe4eaLVo3s7cOjmC23rNLvGhhOOxU7uSTNN5diPHRVgGQ
	Ls5r7XO9uE9ODgG5ydwR6q5Ael+m6cuFfGQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=tyhicks.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791869188; d=tyhicks.com;
	mf=PGNvZGVAdHloaWNrcy5jb20+;
	rt=PGVjcnlwdGZzQHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:lOSKdde0DLGAtDNxZ9hpAL0iUv+x7JaP3fWGdLy4xhTkL+J
	N4pWQuLSDoNbRNKQTGN4P/LXW9UvqFF2zjABN27zyqNY764GUcaxJQVSVSuyfVXh
	LjxL7ypKFLqdlY1//oPRlhFppzBWjezNocIhzKU8UTkeimaMXks73phr3XRgk3QL
	RmAD1ePOGe2IpTg43Zl4rr9Jvzy7oJdo3DZ6KyQ7ENHqN9H3ntQTRVJWJUpfzl8/
	ViYjqWRJmRZ1T1cxO0bIwiodVb32XHd6Y6XkXU2gtvs4xpcxMJEfYTIQpYt2/WE/
	4IwQ41U5vhq5j+NKs/XRO6GOB/KkeXrXvSD5d5A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:L7Ap2vi4MBTf6/6U3jDncGdIwM6YoD5s3gYQ2E8fr6Q=:Fj/7Rau5jbwsHnvIEc0kLXj+5yvxtMNia0ExsvNF6Ls=;
X-ME-Sender: <xms:AsHNar2DTF71n9kwMD2Sc95L8DDILKCATQd4AZJWpjCn3JMdEKxvvA>
    <xme:AsHNamwx1kqvNX2NbOKxf4p94klxdIL2v4YVPsLklX2UYVhPYF1fxL8X48dciUtYj
    eF_J3YH2A9FzF0UKFN4g-FgwDpn_vLNjVBg0554f4kQtXN9FDQVM44e>
X-ME-Received: <xmr:AsHNavz1F__jX1M8wgVCf08KQXkCQwJJTm2R96I4HAREwaaXZeax7w>
X-ME-Proxy-Cause: dmFkZTEU8cOu75UOGJa3dXc99dwCB9/WXFzyrFPclruqkG21GWxn5JNdhO5upaOJoYEZON
    6C2eE61gUf6re+invMPZuC4lbZHc5J3q738kiDXgP1UrRvandh75j7bL58i7U6I04dsePe
    LUyHnNYuG+SwGWtBWeoOWy6s+IJdRYnYrIhXDz6ORbCMhDQy9D35LmxlqzcbVuIVDbI4cc
    kCQrYjYE6M+SObfkwFQ2xh2vvYcTMbQqI/iSiiJN78myf+48+XHgpMdmRGqQgH+pugjs8D
    gVZtICRQIbwZzKhlz5G1M134P+6ER7WMToFla9R/iCamECJTaSce6EvwTzV/H4pjguDdpJ
    0Nk/H2wzRoLmyZtxq515tpwa+3dPMyQ/bpkSUKRCwsiumURPeMrfpVEZkS9V6dw1m4GVAP
    I44rABDCWIqHpszeRvm6t8FG9Fp357kM1T2SQimScg0m2rapQ7mD85O354yC58ij4UxOt2
    Q4VAvyUxZZ6WVtTb9A77TbUdxH7zuE5w5HFt7crZO4USF0ey/Q+SUcy4E3tLy2zHGxRTqQ
    uxBsH8XUSZ8IvNRokf4AjutW+2T/FFPnQ758AvCsEGz9Fj1foMfhjRgABRaFKFiniN8K9a
    hNSxYqfIvK012IMjMbXDANFr7xlT14SLo9WqHxzykCZRKla+2USiMY0zWIgA
X-ME-Proxy: <xmx:AsHNaq8XSg6cZFMpO8ZUtWNvTib_IN7R8SV65-1DulqrKNk1hNEJiQ>
    <xmx:AsHNah-dngWL7GuhiXMx7-RsRWs5dvqBYWOxy3wLTAGetxjVimnDIw>
    <xmx:AsHNaq4Hx9D-tixK-xNsH_71SLdTVzpAFjV6RFyPhb5LkhgEUMOwzg>
    <xmx:AsHNaiYhd82oqsQOSaiR8QPsfLHwEnjnT3BRgWrkUde8S44uth62lQ>
    <xmx:BMHNauY04xsB0m_wCw2MXYFDIrLHyJX2I3BJwV0O-bKStb4NqKMDTAcU>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 01:26:25 -0400 (EDT)
Date: Tue, 13 Oct 2026 00:26:24 -0500
From: Tyler Hicks <code@tyhicks.com>
To: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
Cc: blum@kernel.org, chenyichong@uniontech.com, liubaolin@kylinos.cn,
	slark_xiao@163.com, eilaimemedsnaimel@gmail.com,
	ebiggers@kernel.org, a.velichayshiy@ispras.ru, brauner@kernel.org,
	ardb@kernel.org, ecryptfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+46bbbe175b7eea8036b8@syzkaller.appspotmail.com
Subject: Re: [PATCH v1] ecryptfs: validate key payload size and session key
 length
Message-ID: <as3BAJj0HOKQNjWG@elm>
References: <20261003174609.2834-1-nsvatoslav515@gmail.com>
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261003174609.2834-1-nsvatoslav515@gmail.com>

On 2026-10-03 20:46:08, Svyatoslav Nikolenko wrote:
> Syzkaller reported an out-of-bounds read, which sometimes manifests as a
> slab-use-after-free, in ecryptfs_write_tag_70_packet(). This is caused by
> two structural validation failures when handling malformed user keys.
> 
> First, eCryptfs blindly casts the user key payload into a
> `struct ecryptfs_auth_tok` without verifying the physical size of the
> allocation. If a user provides a key that is significantly smaller than
> sizeof(struct ecryptfs_auth_tok), accessing struct fields located deep
> within the memory layout (such as `session_key_encryption_key_bytes`)
> forces the kernel to read past the end of the allocated slab object. If
> the adjacent slab object was recently freed, KASAN reports this as a
> use-after-free.
> 
> Second, eCryptfs does not validate the internal length field
> `session_key_encryption_key_bytes` before passing it to md5().
> A maliciously large value causes md5() to read out of bounds.
> 
> Fix this by explicitly checking the user_key_payload `datalen` to ensure
> the physical memory is large enough to hold the expected structure, and
> subsequently bounding `session_key_encryption_key_bytes` to the actual
> size of the `session_key_encryption_key` array.
> 
> Reported-by: syzbot+46bbbe175b7eea8036b8@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=46bbbe175b7eea8036b8
> Tested-by: syzbot+46bbbe175b7eea8036b8@syzkaller.appspotmail.com
> Fixes: 0bbb838f385a ("ecryptfs: Use MD5 library instead of crypto_shash")
> Signed-off-by: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>

Hello and thank you for the patch! Unfortunately, these checks are added
in the wrong place to protect other packet types (like tag 3). I've
already taken the user key payload fix from another contributor and will
take the session key encryption key check from a separate contributor.
You can find the links here:

 * https://lore.kernel.org/ecryptfs/20260917044558.41677-1-neganhat@gmail.com/
 * https://lore.kernel.org/ecryptfs/20261004123755.14642-1-adrianox@gmail.com/

Thanks again for taking the time to submit a patch!

Tyler

> ---
>  fs/ecryptfs/keystore.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
> index 51651314b7a6..b2fd238bcd97 100644
> --- a/fs/ecryptfs/keystore.c
> +++ b/fs/ecryptfs/keystore.c
> @@ -621,6 +621,7 @@ ecryptfs_write_tag_70_packet(char *dest, size_t *remaining_bytes,
>  {
>  	struct ecryptfs_write_tag_70_packet_silly_stack *s;
>  	struct key *auth_tok_key = NULL;
> +	struct user_key_payload *ukp;
>  	int rc = 0;
>  
>  	s = kzalloc_obj(*s);
> @@ -738,6 +739,20 @@ ecryptfs_write_tag_70_packet(char *dest, size_t *remaining_bytes,
>  		goto out_free_unlock;
>  	}
>  
> +	ukp = user_key_payload_locked(auth_tok_key);
> +	if (!ukp || ukp->datalen < sizeof(struct ecryptfs_auth_tok)) {
> +		printk(KERN_ERR "Error key payload too small\n");
> +		rc = -EINVAL;
> +		goto out_free_unlock;
> +	}
> +
> +	if (s->auth_tok->token.password.session_key_encryption_key_bytes >
> +			sizeof(s->auth_tok->token.password.session_key_encryption_key)) {
> +		printk(KERN_ERR "Error FNEK key size too large\n");
> +		rc = -EINVAL;
> +		goto out_free_unlock;
> +	}
> +
>  	md5(s->auth_tok->token.password.session_key_encryption_key,
>  	    s->auth_tok->token.password.session_key_encryption_key_bytes,
>  	    s->hash);
> -- 
> 2.47.3
> 
