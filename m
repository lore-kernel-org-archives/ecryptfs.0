Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874DC3988E3
	for <ecryptfs@vger.kernel.org>; Tue, 13 Oct 2026 06:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791871395; cv=none; b=LaUHBj+lc2H6gTVxWc8j5wZHKZhcBe4j9w/ymbd6TjfIBpnCbpVtdr615nBtCS/GBnTGVNecfNvXfbyHnwKENZUFrMqmluzWzB7tqmB0eedwkzGIIYyDwC4m6Lc1wEE2sJrU6Fn2DArID77uZNvliBPgoic6u4X/vm1dKUcEaNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791871395; c=relaxed/simple;
	bh=hfTIJ+ysqnotUXS8MBkAYtPSSdxqsImvfLZgwWwZ6dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gnGfb1hgj6NZ4o76gZdetLCeVmqunFSFfpE8WkGOTWWhEjIBa6if95sLDa/Q+y0SQfMW60INxph0rQcbuqJh0UEzX++sdEBGTlM4g4Ba2sO20wQAWjRL37e6WW4siop3pkIpr3Zu89+hlNUmvYjiM9XN/DbiKOu/IqmmAE0rR+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com; spf=pass smtp.mailfrom=tyhicks.com; dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b=avcQaImC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vff3+nDx; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b="avcQaImC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vff3+nDx"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C297D140009B
	for <ecryptfs@vger.kernel.org>; Tue, 13 Oct 2026 02:03:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 13 Oct 2026 02:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791871391; x=1791957791; bh=1PBP3ZJT4q
	jEQEGQoSE0qSqRyXGfxXMQspi2NB86o8A=; b=avcQaImCDnqKdj+AfUNHqw3QTT
	reprTckaiE0HGbxf2guuDV00ph5XOIlllL4lzRIhPkwwaDwClwoqGOEY/jsIN1b0
	L0SQLuSE8p8B/SwRT4u5Z7dXQy+uBZJaMvQJQOnMkO/vw/6D6K/PZ1R2bN+h1bzl
	pOgAPNDgmU06jkuU94tD+ENAnNB3HtstCkXUHP2CrPoA/Ak1YbKGvW+ZUjjBe+eI
	aVAZKRJdZczipCv1Xp/p3P42a8sl5/jS+CQNlQgW9DPiUM2FmdqPIaS5ivkd1PHE
	hLUcFobXs/qbFDucpaIQigSLeoDkI6TXIz7OckFuEHp58N55A6obOOCqZKmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791871391; x=1791957791; bh=1PBP3ZJT4qjEQEGQoSE0qSqRyXGfxXMQspi
	2NB86o8A=; b=vff3+nDxJSzbYlYUKwAqd2m+mU912FAKs8fBLehRJrZQCroi2fP
	AYLkmTmSW60lk6cJhcf6xEdQ/IXHOKmF08dLSLmdMdAhta3/nM+SQgy/LEPB0KO/
	TwLnSkC3e0EHdX5gVdL2Tj1K6B9kAl37sekeHdPtrodi0Zv2/slm1Tv9Y6i+XC4B
	dQNBd9VBMJNNNiNxCBSJJE4983wlQypkvjZN1k4FEAKrgSDvLM2K44sfgHjZZCLS
	8+T708x3CXDSCavM2dxb1Y66HbkNLONEWK5mQeatwh6vHVJbCQt4DXKZJ97zB7SU
	B5d0iWzM6RsAz9CCOeIcqe8BOn8JYvVyhTQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=tyhicks.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791871391; d=tyhicks.com;
	mf=PGNvZGVAdHloaWNrcy5jb20+;
	rt=PGVjcnlwdGZzQHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:BnfAMp9OZIW15mRDkwY9dv2t/jhrxtZnhRVfedvjr7wZcia
	70Nse4KYxjd80h2mKp6dDfDbXSE7r5dUe2A7GDIjNEgz7Slw1sbHCAjziZ6sqVcB
	Agrr34NVjgSOd9OsLgNfS7lRsdCllf1n1LUPgQ/DDs/9UMp6HfXHRdziC86Zu8Nr
	pUBZDcJf2FhoQqvjoAlktFHt6k8sao9n1kij7t6VOmCbWtFiFd62APotWgxMjuQt
	rhmshD4fZD3qSOn/QwmDZ56wzh2sJs6ryX1k4Lq2CXn79P7VRzRsyNepQVpOGmw8
	67h3NXo8dXZZFccTWn8AWRhH0HAstAx0AQo3QOQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:eRQuns61mxrkt1rE6slyrxMtzD9+fa6bXZQSCOUpPF4=:hfTIJ+ysqnotUXS8MBkAYtPSSdxqsImvfLZgwWwZ6dY=;
X-ME-Sender: <xms:n8nNagoRXkuc9Su-ZzyAlUoxcl0uFOQLbKUFFUZLGaiheg3agvxIEQ>
    <xme:n8nNaiGLKkrtOyKqI5CGet5RVYnj0KCpZ6oPS35EQpJ4t22E4fIzw7Z4tF8ukr4u5
    Ni5u0YtwEir4A7xRkbT_Nm7BlMEg3UKbjpkSQ33A7tj7CNXfD9TFz8K>
X-ME-Received: <xmr:n8nNaov2czXgeJkAYWsYW2DuQnnpZAfXP0ULo6DsuEZGeVXNUKodhg>
X-ME-Proxy-Cause: dmFkZTGpaCSCPHwgV4zbns6Mt8TON45fYleJpX3rsxPvA5MMeQCedpdFaLr1i3UEgsLtVn
    2cPFS7ri3dRaYfQV5Wurwy9ZEa7PociIpLtbQ0HBbeyMPkCdV/ZcCkUR/ZpanO+CCWOnTs
    HN1RPFukcRKrAHKZ9L/zjRtbktyDEsB7C8yqhNY5GVbQbZDIcW7ChOIsEpDute3b8Bul7N
    tEcLvEq2gib5cHnolF0gZTYWWiERI+mEOB/YEacPUS4sysdCFR8mZbG8zGe17ZzOTsnnWR
    JtTmd3sJFuMo61j39NCAP5swCcHn1YHdHEGwjjxwgiSEGKKC9JrQC94sefDz7v9+NdYkDK
    bqFVPLY/BzCzggEZl+AQhfnOC8ayXCsH6RqCNz0GLgQsxdEJwRf4fIisO9uVaoGmoDg4BB
    sAPOwBkVFntuvgjwe3fO8Zz8PMsWDEf91pv/EBIY7Gkk2U40/WHy4WDQ34aA8dF8OM5+lD
    +EwVA9bow6n3k9/lRpkBp5/Ebe4pYXm5OneZv6AFaHSVjAL4bDgOWr8oce5Z2pZAuXelPt
    flvwYRi7dkuddJtw4cibkJp0WKQUC9h+J0sCQQh45zrVR4DTu9rNPSedX3KsH8t53oDGS0
    nG+l227JZgw7bHBdQ9TBbvpzhbmsTzzm6ODz0vMvRbMDknvbGY4qS3Z9eHzA
X-ME-Proxy: <xmx:n8nNasXBMd8t0k0OK6eF9fevXlAtrFje00vQtyqNCrc1QBm4NnSePA>
    <xmx:n8nNasER9dZJkoSdvlemBHedpnnYruuUpZHRKeK-kRkWWo_vEucDVQ>
    <xmx:n8nNam0f2fW_Vsj2lKegHq9yvKZsR51OYjcufVekodM-Whn-Nlndbg>
    <xmx:n8nNamMMQHPAtd7OGUU0yLHwiIC7FWIvaDr-fGirqatcE78IFHMHoQ>
    <xmx:n8nNai46_xqVpbEwXDLwVYN1vyfkYVCgZnZDofTxuxIrZSzv5nSA6hBC>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 02:03:11 -0400 (EDT)
Date: Tue, 13 Oct 2026 01:03:09 -0500
From: Tyler Hicks <code@tyhicks.com>
To: syzbot <syzbot+b9529ebe6a9394ddf825@syzkaller.appspotmail.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ecryptfs?] KASAN: slab-out-of-bounds Read in
 ecryptfs_verify_auth_tok_from_key
Message-ID: <as3JnatMRsNYq4bR@elm>
References: <6aaabb70.86093f18.33004f.0003.GAE@google.com>
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6aaabb70.86093f18.33004f.0003.GAE@google.com>

On 2026-09-16 08:53:20, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    f6e7b42bf05b Merge tag 'sysctl-7.03-fixes-rc4' of git://gi..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=148603f9580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e909ffe6b35dddb7
> dashboard link: https://syzkaller.appspot.com/bug?extid=b9529ebe6a9394ddf825
> compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=119813f9580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=174acdf9580000

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs.git next
