Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685187;
	b=fK5hb9VM18GjNnd+vWm0WOxvw1S3VVOI2KwWl4mcC02QXeuLCdOeQja4Fs1+1zcGuWBu
	 rsrmS6U2baKmMLlOqrzbTAp6995WVqo+17EOzAhSJCOP8G4jD9ydDj7ur/qGQKQH1Daxy
	 Iv8qmfXtRQ0z5DQyk/+4ToQk6L/IvH8n+D5nU5YNEfm8OP1q0enxfbkPS0r5+UJzUYJJ/
	 JvrMSArV8FeZ+u4Krpc2U0vmhWktUTNFkWXPDe6hLmhOLb1tRL5bIGsN0WwxeCSxywUbN
	 4QtHJgCuns3LNAdyb3FXe4cbEjR8eNjz8WjUacU/J888BGK0Txq7f1bnxQueJFZUy9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685187;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=QExCyscQiBpYtGq9U5DYyILBNvVQzlq3lEvTCoEEpok=;
	b=zBfX4yC7cSwQ0f6I6S9YlHs8Zst4+MMXCJV7/gVKDUOzVXhEaWUpUWpUvJHm3tpchciY
	 MclxvoVAce6oKmYOJUzxLpTZ2la/03Q/a7VREk8I1cLujQEOLuuisx1fYH+oDtXEWKdh8
	 LL+Qt+xUS/8I+XPuWyPYBdOTszwXXT72Vm8zzjImke3WZDkt3lbzxNNGVfDdwAJ0jOREb
	 gVPPnJgbP6jDZUl7SmlAMuztdJx7f/MCkt4eP5YqtT50Ej007FmthLwd2Ga3E92kZbIgF
	 UWe/jgvGoo0yubziT4giC91TYSGvnhzbzDtTDk+RHhIe9AK089+BLYNcrY2ZbrMLDGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tyhicks.com;
	spf=pass smtp.mailfrom=tyhicks.com;
	dkim=pass header.d=tyhicks.com header.i=@tyhicks.com header.a=rsa-sha256 header.s=fm1 header.b=LIpYU3cd;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=kr+hexmF;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D18606A31E
	for <ecryptfs@vger.kernel.org>; Thu, 22 Oct 2026 16:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6D18606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tyhicks.com header.i=@tyhicks.com header.a=rsa-sha256 header.s=fm1 header.b=LIpYU3cd;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=kr+hexmF
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id EA563EC00E0
	for <ecryptfs@vger.kernel.org>; Thu, 22 Oct 2026 12:06:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 22 Oct 2026 12:06:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792685185; x=1792771585; bh=QExCyscQiB
	pYtGq9U5DYyILBNvVQzlq3lEvTCoEEpok=; b=LIpYU3cdYPXrdQP9qOWT6MSrTS
	DBGH9VS6lZ6gwId2PYqnSLL3Sn52dLcqwrj4tU7EYiZW5w5zt5alRgaLBPyeSeld
	n1/o8OA+WrdNONkr7uklcALUoYNGufcw3iFuln3J0R5qflDCl7SP4ypaBqtR5o5k
	jWekeIig3cr2Q9InAyw8bH9QqBlI4Iz/Z0pwqHMAV1y+GOnXXrXVJdJTynGDvH3l
	sDnTvkgvQK2vvcdFDijucGMO1ahz7TWO0Oe+bSg1PW4QQWz9E8kM/ARhRc52jy/Z
	BTLcDOUcgQmgdDnSHZTzoQn0a27sKWyNltOXcwmXXa2h15KLVu8d8iI4030g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792685185; x=1792771585; bh=QExCyscQiBpYtGq9U5DYyILBNvVQzlq3lEv
	TCoEEpok=; b=kr+hexmFCFDuh5wufayRC5G8wCN9lAxGJFQYuRa74kyoa0YyNnq
	ZMILrw413wCZcsFOk4iKEwFJpYFZ9ckzwy7ehiMSlo6r+GjE7VozHxtWdVQiomqA
	yavoBoH0EFpW0cExtWafH491ouMXaAUUDFp6CtPgCH2wj+NdJbM54OOD/Hi4YVwm
	oEjtKPRBPDsYTY629kCT2/rsb1TPUlBc/UYupGpjKqd3Jhkp08B1Nw0Yy9spUn03
	ST8K6SMZVCIDLpmx8io4neqmVqpi31UHqdhusKYDSOu6i8sHZ6Hz8HfJ8eV/jWbT
	aR+MXYL0dV4fv+C00C3bt+G5EJsKnh9neOQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=tyhicks.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792685185; d=tyhicks.com;
	mf=PGNvZGVAdHloaWNrcy5jb20+;
	rt=PGVjcnlwdGZzQHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:rbFWqj6pwugd6SIkD8juCQeCWUdWYQt+WjlhZXLD3nbXV+f
	6qd/JiSj7+EhJ0xp9MHR1lvNDXDa2D80Kqxa4nS3V4x0qHQgZG5vrwy89gX7dP+U
	EFOx4YM0mV5wTsYAkuZL4capBilcprjgOuxKQBKtazBuDVD+zDFxzZYi7MbaiAaE
	zUfOXVs3pZhMS38tsWtYlfi/H8VYiwM4hKk3qZQo6h4Zb/+PBSmDku8rxrq9eT6e
	LMOZkC4hc757iE6ceg5TsrVUBLLu2n2RuAC7Rh9VPJKrzE3ZwmE9qewd0uRvO7IN
	o7+znH1gg5+DifdG6LJbUZG2Ao/w8mMOjcJ3OkQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:tgn4ibvdS0EBVO0lJEKvIjwRQvUDlflCYNC+QTYihpk=:4h/Ps8qAn41v60iM2u0/HN41xSrwZY/BxA2bQXQb9I0=;
X-ME-Sender: <xms:gTTaam3MXosFyuCmqpHrms1NE922UXrQfM0j0Z_CGIeo2aztwYseeA>
    <xme:gTTaakhGGcwLxboCsWdospx_my9fcULecn6Vz_0UiXrRm9Xcdii0D3hu4XkdZzGwd
    zc_W9rZVFeX-r5LJbTQeVcUCuDkHOoQLLrXTmupM_5rSekC0ges_fAW>
X-ME-Received: <xmr:gTTaaiawMl7M-QMwriU37yv5Psrdl_1oEFi8MV3KU0l6-Xp4lSw1DQ>
X-ME-Proxy-Cause: dmFkZTFhdwpjuLQ6mcLNPFLTfHEZbMvTZWojMowugQkJdB7V9bzLxSS4OZz1ztMtRFGCft
    /tpMWrldycJwnvbda48/JoeGKk1XlRXivL/lZAOYcoumP8hXyk8umgYkCOKNlaSeoPQAfe
    OAIAAagpN+eHnrMxeNCIkDcH2fzbGIcQDtqFXv05OtN74sAD6piniZP+zmZ6Xw27HnsMXB
    tkSUVXBUQjm4d9YROLS8usf6UwfzGnOk4ybInha+kgr1BXsRhCC23hFzs9s41ZzMT5qqkX
    F6zW+8wSV5eexp3vLGnndiKZz5NePXjSDChEA5pGxH0N6yOkfySKdsH0U5+jTVnUTMCmiy
    hjB2Epka3ZnAhEYyLMXVqYK3d1yWwXdoD2WvuVVAtAXQtrcPeSI9OfihNyWQ1XGFyJG0CL
    /0uxrBquZiE1PKusSeDHwGENZrOsCqT0IwVHYC1AXvB31cdLzEcA6kgD2tiYXX3qUgudQu
    0hrwTErwnEn6BRQLoUUYurpcKnkQVAWKDHLMZLizqFh5V9FbsczWwLoR8J53j8ONk6sLQ/
    Fa64fQOBbJCJmMI2Omf/AHvE2yIZ9lpCgafjoG3Iua2mN33D0MiTNtgHGLwOvglzD/s+Z3
    ZcjYue8hepVjmv/vBF1oTIZB9k5eeEiyJDg3BprIH84grrPpvvFrYt5lrEoQ
X-ME-Proxy: <xmx:gTTaasQKDBiA_TQE0orsjLG_deH-FqCQWu7l8gyItqPYck5JLfGYfg>
    <xmx:gTTaalRAj5bTT5MHwgvAK1T9JrisyLydbz0LDHvKULq-es9hrJKeOg>
    <xmx:gTTaagQG23mHYMHun9GRZJvj9tFg0Hc-mgXXCPqRFPMiAX1cclU_8A>
    <xmx:gTTaaq7kbuLoLHNe6qFOeEPDX-m0-IDq9n9NyodrtbH0uR1VzPdSsg>
    <xmx:gTTaannVzjnVVErf_8kUZpxNi1drYcFW3rnaf9xyoqSiLi4-Ze8cNW8_>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Oct 2026 12:06:25 -0400 (EDT)
Date: Thu, 22 Oct 2026 11:06:23 -0500
From: Tyler Hicks <code@tyhicks.com>
To: syzbot <syzbot+03c68e42ce4b33f7ce9b@syzkaller.appspotmail.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ecryptfs?] KASAN: slab-out-of-bounds Read in md5_block
Message-ID: <ato0f6AUVyixt40U@elm>
References: <6abebdfe.7503fbd6.2d3f6.0009.GAE@google.com>
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Post: <mailto:ecryptfs@vger.kernel.org>
List-Help: <mailto:ecryptfs+help@vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ecryptfs+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6abebdfe.7503fbd6.2d3f6.0009.GAE@google.com>

On 2026-10-01 13:09:34, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    551c722f4080 Merge tag 'rtc-7.3-fixes' of git://git.kernel..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> console output: https://syzkaller.appspot.com/x/log.txt?x=15154035580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7d012d9c67977ee4
> dashboard link: https://syzkaller.appspot.com/bug?extid=03c68e42ce4b33f7ce9b
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13154035580000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+03c68e42ce4b33f7ce9b@syzkaller.appspotmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs.git next

