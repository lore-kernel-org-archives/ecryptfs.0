Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B370C48B385
	for <ecryptfs@vger.kernel.org>; Tue, 13 Oct 2026 05:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791868304; cv=none; b=ncIaNfkKp8ouoBxD5U1q4g5nloU6Qn9kWu0KO3UW367TZw1o1a2Pv5HUspKbSp/brxn8TajEZoYgWdVECCd4hK0BjntOrhA/iUgHoJaViw5cuJiJ9wYmaQ2P3baEYI+22URrByODQT7BDhUdBJqYUoUP2QSkBq3sHXVqpowuAaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791868304; c=relaxed/simple;
	bh=y+EavCaHl23MRDx2AZnxfZez+cY8JZgaSzYKsCokhco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLTHXCLqwfEIyGXSWzgSKURZgKPRuPbN3WvXUoJeqMjdOg+T5+kyt8I/jjQCEilZzpxushK4rMtMHY+lP8y/fX/MEZ/rc3f+BMeIkBwa2LaNRXpm1tulK8hTlEGunAtCY/txpSZXsYeFQJAqVyWhjtNZo6qBBnaHXQbDnNQJIDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com; spf=pass smtp.mailfrom=tyhicks.com; dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b=aa12xkN/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fuDQQ9ws; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b="aa12xkN/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fuDQQ9ws"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0879C7A0173
	for <ecryptfs@vger.kernel.org>; Tue, 13 Oct 2026 01:11:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 13 Oct 2026 01:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791868299; x=1791954699; bh=YESU3LtujK
	JFTqUdUayQefNp+XnAEzJCQc+rSjeH9J0=; b=aa12xkN/I5uYkXFBhpEy0ePEne
	l9ioBlqd1Bv0CBiF3xwVMFsO3tYQlf6EnArhvuTFtJGia69flajY9awSY5JhBNS1
	CXA+JNipLxfuJNYvy1LaOC6QpG0NqNyNALdhSPOR7bAFy9dvyy622M2l5sHN7feW
	8TTQhZZDP86K17/hlQfhwX4YFfdY82wlik48m8mNxtgzFs+SOxtuw6ocW2ECzxii
	2kk4PmLGhA1nMZNoPJFOkyEbBsbsgi/JyrOeyTx0xXVE78pnbEoa68CyvOHPc2KI
	f3+zdgbdh3ePOEWOPeeCOOHju7SAh0EMm2BMRXxqMEeiGFxbpSUQfgu/jw4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791868299; x=1791954699; bh=YESU3LtujKJFTqUdUayQefNp+XnAEzJCQc+
	rSjeH9J0=; b=fuDQQ9wsRKKyFjJKxw8ACmkp+vUUfV33n4IfG+dv870stUf5aRg
	yZp3fill2JEOSdzbEDPCQbQz025H0KdBymRgSiUwJpe+yiCk3L2r4CIxKURjnKxs
	nN8olZhSriG8UI46XjQj4/lOWQnxRQ85E/Z6pn46OuYv66zVVNT3kFH5qNDa4+WN
	v38KkzrnJMdXzB1XPcqWntxXbLIZ9KKLZiDcHlAf0arKdZVNChFNuNsy07vScw1X
	m2PwdQuO3mU6gWwv1wNsTxGaVnAU3umiXAvzMFcvm0TTDLCiE379mwUzXeixY6Nf
	rTB4MeJheVLcCp5SROKbYU2YZEQs9cCU8vg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=tyhicks.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791868299; d=tyhicks.com;
	mf=PGNvZGVAdHloaWNrcy5jb20+;
	rt=PGVjcnlwdGZzQHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:L1Lk8Rjefas3HZAgLbSE9BcP3+Ew//lC9W1eSU7Dyg+SpKy
	6fKggcHLpkzIQHy7v1lhJ9IHfMX/TH0fKObavhYbDy2or4amPAJ5EbDb9hpD9DJm
	8xMUZGrx7mFq/VgoX4Hj5BirRoxB4DMIDJZ5dqsO8axXBiSY3LzcojZVikK1twCn
	ZkKomPrQAHUF35jM3y7IxoE+oH8HdH1axHfTOMikVBXe5rOa58BisfQeDZrF6ffX
	GKJ7U0+1WNTo5p12ZQdiECJgfoTHfskSbOpdNqDDO9c3gRY/65IjLjHLXcMW5D7J
	hsRpOAiaF7uxRfPlMF4aJUG20hz9y2uvTMivgkQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:qdMEtmCLIOc+wpT2woytuiUuXdk4Si23/P6694O5lvg=:y+EavCaHl23MRDx2AZnxfZez+cY8JZgaSzYKsCokhco=;
X-ME-Sender: <xms:ir3Naj_hGKsU8L-phhDQE7ujQHX_MPskNVpMrq2zR3EZa-T8TxosHw>
    <xme:ir3NagI4rI3-vJH3Ft_gyu46OhU9NscTi5P7FtIao7VHP850vw7Nq5zWkbwGprh6z
    -MEeWUUZR8XX_uoH8zQ92b6DOGnIb3AYtju2IVDiAJAL9c-6ZU9Yqc3>
X-ME-Received: <xmr:ir3NahuhhDPXxHQIK-Wzv2RNpVeEmU5ASSinKZZWsao7AjFP6_ezcg>
X-ME-Proxy-Cause: dmFkZTFvR+6nU+lQuvvxdhP0LcyIeo3zhYElxg5mYFOdFG1BWfolR61Nf2B6RghDwqB/yK
    dn5ukq70+jSJN1LLV+6mfiFe69rI0MITIDMYIKEMlBSzCXfrvbgEm088RsvLyl7c52bsCf
    KygHKFEH7MOWaoGI5ALSexCwDT7Tpeys74s/wbF0LYMo4vmdXUCTxvcbfZJm/vj9OtH3zU
    R1ezYwzx8Pl41S0h9fxguuCcHH2FZY7vHVoFDG4nun4/pADtyhMnvJl+RoL2kFkMIE/NQB
    1yCDy3Qw3v2U/UN6JlKPzQFh7XqOyQcwU2/7UxCfDhgVkoF6q+Z4JzQ+lBq10YVbm2qbm2
    gwA5kSasC1L2HsdMbhXb2T+reUGl+rIv4/oGmJT86R5jXMdJ5YY6kCstBNO00V4kJpBZlX
    WSmQhqtmOQYEcOVjZkJtLquPdW1mkBVWDdgu3dcnT9LM2UmEFs6nuFBQjHWd/1rzO6W7Tf
    1SIF1/jgI7BlXeBTZynzURsPjdV4eqAPOX0WcVlmim+/ozxtFwiuXtJtbpSadSImiFFElx
    eXF9nu7aWTvqLgpoQjyKBefY8hDSnnj9oDn+mraLEHuLcyE+kVx8txm7bFYo0z3vQFA8P5
    qCLnSFbF/xIqOgRgjc9z0L2TaZyu8xJCRJjI2MK/16Gp9chf4LTIn4IVy1rg
X-ME-Proxy: <xmx:ir3NanDB5n4576ddBa-lNyXTF1qP1oltWYRHARCFvb5YRd_lx0NUCw>
    <xmx:ir3NapM18UDZfp7wznOfdYcKe_Ev72U6IH3bqBCh1wkUY0L7GJsGIg>
    <xmx:ir3NavDizmqQiT_t4zf9bIpt4Ccw9h4u52cKV9K0SWVKNKxaAnvJhg>
    <xmx:ir3Nai4YWAs0gZ31ssjzFWLlXCc0UYRRjWF2dYZHdk_N-WCNnJX0GA>
    <xmx:i73NakINNIrC9bgPuTemE3EU3UTagW_56cwwZMeKttF4PIXhyusMvagA>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 01:11:37 -0400 (EDT)
Date: Tue, 13 Oct 2026 00:11:25 -0500
From: Tyler Hicks <code@tyhicks.com>
To: Nguyen Duy Nhat Anh <neganhat@gmail.com>
Cc: blum@kernel.org, rdunlap@infradead.org, chenyichong@uniontech.com,
	zhangzekun@huwawei.com, ebiggers@kernel.org,
	ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+b9529ebe6a9394ddf825@syzkaller.appspotmail.com
Subject: Re: [PATCH] fs/ecryptfs: fix slab-out-of-bounds read in
 ecryptfs_verify_auth_tok_from_key
Message-ID: <179186806831.432963.1818838326518741656.b4-ty@b4>
References: <20260917044558.41677-1-neganhat@gmail.com>
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917044558.41677-1-neganhat@gmail.com>

On Thu, 17 Sep 2026 11:45:58 +0700, Nguyen Duy Nhat Anh wrote:
> Add a bounds check in ecryptfs_get_key_payload_data() to ensure the
> key payload datalen is at least sizeof(struct ecryptfs_auth_tok) before
> returning the pointer. This prevents out-of-bounds reads when userspace
> supplies a short payload via add_key().

Thank you! This has been applied to the next branch of the tyhicks/ecryptfs.git tree.

I added a handful of additional git commit tags, such as:

  Fixes: 237fead61998 ("[PATCH] ecryptfs: fs/Makefile and fs/Kconfig")
  Cc: stable@vger.kernel.org
  ...
  Reported-by: syzbot+e4391e0d6e7c89b8c84e@syzkaller.appspotmail.com
  Closes: https://syzkaller.appspot.com/bug?extid=e4391e0d6e7c89b8c84e
  Reported-by: syzbot+dc50906b100ac7a1c34d@syzkaller.appspotmail.com
  Closes: https://syzkaller.appspot.com/bug?extid=dc50906b100ac7a1c34d

You can find a direct link below but please be aware that the commit hash is
unstable and, therefore, the URL may not be valid in the future.

[1/1] fs/ecryptfs: fix slab-out-of-bounds read in ecryptfs_verify_auth_tok_from_key
      https://git.kernel.org/tyhicks/ecryptfs/c/5b00bf0f3b7ad05eff79b84e3bacf3f98ac67dc6

Tyler
