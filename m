Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AB648F84D
	for <ecryptfs@vger.kernel.org>; Tue, 13 Oct 2026 06:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791871503; cv=none; b=t78gPLQOkpVcyLO0sIwXB6Z6VSSbAro4n+DZAEKkN4b5AXked9iUL+7SsFeIsFIFyO4SWqKb3RP7Ikc/wLm/PdpmTPmgT6HelOmb9s6sDfS+eU6+orreAgmYcP+Ouh0OWk9EtkUL25fr5yI94gcKKDRhEYB6mPSuaOkkec84V6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791871503; c=relaxed/simple;
	bh=viqZW+BW8+aUZcrv1Za0cw6q2eFNj4tmzZDo73Zko6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqbQ7mps1D+LwJbGA2I9xetdzY/f8NBvZAxcUdHvyyeAsUbN/AKR6jBaul17X7WrYjwLGGwwSviT3bXg3MD1/Zt46QZQcdz5TkFkWRVcHevPJtU+gJ5QHzyPHAcARw8BQjbcCjGJTw4eS7sut2zWtV2Jny7ca2u4BICZSq6MbB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com; spf=pass smtp.mailfrom=tyhicks.com; dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b=r0b1Omdv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DLfcmRBI; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b="r0b1Omdv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DLfcmRBI"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 281FC140014C
	for <ecryptfs@vger.kernel.org>; Tue, 13 Oct 2026 02:05:00 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 13 Oct 2026 02:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791871500; x=1791957900; bh=dJ3QQ/AUDN
	q2K1mdApU4CdYI/tyF2gyK4GPNBRr2D+I=; b=r0b1Omdvshw70FM9bW4q1NXM7n
	ZV9Rf0yZEf/B1me0Bn/mpdi2pAKsg2nguEhbxqhyVE42ECS6tQdYksG5VUf+Rdr1
	/Vxeq4Y3uY095Q+GeSXhD3j8qqy6Lexa4WB7ZsIWtS7/IGa7ARdu5WuU59oNvxbA
	UMqzbcScIi7t1YsSeuXv+TYRmGUalx5BF2MdH6X9qvGv1W4imA/GHoyPPb82Nrxo
	4lGx5NiRND1XdySLDvYGbjQzWzAV7KJKLTm6cA24lSC00jbMg5m+CPzjVPa+DoDq
	lDuTO3THpCQ76e4qN4Bpt+51T1LcYsPuoMlr8pzHTkPUkS1koCXO0cEDrgeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791871500; x=1791957900; bh=dJ3QQ/AUDNq2K1mdApU4CdYI/tyF2gyK4GP
	NBRr2D+I=; b=DLfcmRBII/ER5SSzDuxEgZGON3Ur/3klKDOEbu5XSEIXKYTMM7+
	ggEQAuMx1m0KdIz+BNOCikv1YDI9DJYBaad9Km9W7xAhGzjR5a/H7tMyI0w3ofMb
	+A0T0V5WtyKYS4T+Nn0AZ16E420I4jYx97f1AEXYqZf2cCpq4Qx0boMecAQ/FnKr
	g2ECMUhFuxq+oNyoNjhAOzkqCbfNpVp01LF/4eGEQ/OIX4hCHleSSYpxKotC2iK7
	Ew22nAcrQlkYTd1bXBt+gvvmGnKXhsqpm4wVtI+wJwJbWqOrthCU/Iq94gmYh+A5
	5qKluQxgtcF/2du7PQFz2BHGEnOJAcsjHZg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=tyhicks.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791871500; d=tyhicks.com;
	mf=PGNvZGVAdHloaWNrcy5jb20+;
	rt=PGVjcnlwdGZzQHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:Y6MtHSPvBZwzMVSZj0QaZQkGRCoId+AqtOs8+wR1AbFlcH/
	IBRxE4YZthitviyJ/ExnFsq2BFB4biMqat5LfThqYmajzNONB7si4D2HJpOY4nFi
	4WR1ujkA1CsBwh7BQGd4PxP+ygijLbuz4JX25kdQUu9BJ6Qz/3SaXUaeujT57V74
	VuLGI7BE+7BVXmhOCu3lrbpqA7C0DjHM8uuuHSDJirUJ1YGslHmA3vAG0syMufb/
	8ua6vRTDxJGx1voDdcSpRcJyR49zKx55sbd/LasGq4SkeH+NScWl4JKiG/DF+uh0
	V1RLWrUbs2OCsTvo4lA5TCGSn71MxjSQ5+UzBzA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:i79Wi+dJiKYvL8zgMZocEvLLxodKDNetc/3niFvZsOY=:viqZW+BW8+aUZcrv1Za0cw6q2eFNj4tmzZDo73Zko6A=;
X-ME-Sender: <xms:DMrNau9YXI8msWj2ipb8BCKuCyz8i5SV0IoAabyTRbaNNiN4fzMOxA>
    <xme:DMrNaqLlIo_8y70b20DnxagLclcJB9Pf5uDON1IOhO4Wn4vqP1eB-2yutsT7aXYCL
    BjlDc6pYQpINmBONbKDOFNoofMfsiHNWvJWtM1swfuP0cMaxuiDxgOf>
X-ME-Received: <xmr:DMrNanhlbgH4UuZLrqm9-NPUsksdNiEiLUpT_fClVkaEIomhSLmPcQ>
X-ME-Proxy-Cause: dmFkZTElX5oqfZTkvmVbevczNiVRrdnFT+gNTWcM/SQ80Gtw0fKUZ0M8raayoaNOcjyBJR
    75xk2Wk21Cg5gF8eb7d5jIcA/bcCdwLaBpdxj9RacezDOMpJwSr8FwTf5WJ1lpWo7g2Evz
    aWM47vFgEsnR/NPO2rM1FO+mo8mhV+YMs0rzVuBicmw04Tzc7znMhxyRXJMmEKj9pD5DBU
    W7cCxNRcHO+PDchRMw4FEeCWIdcMD9Lvkw6hajAEhTHVAXQwt6/ZZ1pMtrr+0M8HL8QKAn
    qamhWr97T9WbPPFDfk/ADMoolskjbxwZtbm/xsDk8eSoEdLC0M0k05Gi2Oc/cfU8XPCmYY
    wubG5hZRx0REZLdL3/Z489E8j2ci28mu9xU7staST0qztNpEXPau7FcG+svZCW8BXi8fjY
    /Nlaa/FPSVMWFzlegZVyRgoRsmEmJaJSI0Is4RVbWq6ELxykHAp/T037RRdmF8uC1JEnyY
    l8V+NfHPZ4yPokDcSkHbZfsIANDMr13TXITKFGQdz99pUultuO9mWdL1eVxvigoAZxOCKp
    qiHPIEzkp+jSlByL/BAP/azGlWBK1+UJJIhpntFAt49nN7sd0fByWQj+Y4i2xm0a/2egPX
    vmXYUj8hZ237SPTgGJts9D+iloRVjohwZHqw8E/ZgINcXnF2a5hVkqw9PhKw
X-ME-Proxy: <xmx:DMrNaq7q94BqhFRAxCXpraVLhXpFJeVsAkT16oC0nf1NM9GA5sDbTg>
    <xmx:DMrNavbS4YWR7TEuI27ImbCZPwSJ7w9qEKnYhvcqU1LznWzZGXqpZg>
    <xmx:DMrNav4AGTknXWWSgC3zevvKbKZ_0_eR1xXhumvRf1-He_K0gD2y7A>
    <xmx:DMrNaiBdxykTBGDqnW-35cmeRNNijo1YBtxn8XX4h0qlRlF4gJyE1A>
    <xmx:DMrNausPqmr3UUI72IItuWYpfHB-1Tkr6O1F0aePFeKFR9co-3s8VjLX>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 02:04:59 -0400 (EDT)
Date: Tue, 13 Oct 2026 01:04:58 -0500
From: Tyler Hicks <code@tyhicks.com>
To: syzbot <syzbot+dc50906b100ac7a1c34d@syzkaller.appspotmail.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ecryptfs?] KASAN: slab-out-of-bounds Read in
 ecryptfs_from_hex
Message-ID: <as3KCmgfQJQnPIkK@elm>
References: <6acb17ba.a150a118.27e199.0035.GAE@google.com>
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6acb17ba.a150a118.27e199.0035.GAE@google.com>

On 2026-10-10 21:59:38, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    a5ebb76233b7 Merge tag 'edac_urgent_for_v7.3_rc7' of git:/..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> console output: https://syzkaller.appspot.com/x/log.txt?x=15b396d1580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=129d675874dbf896
> dashboard link: https://syzkaller.appspot.com/bug?extid=dc50906b100ac7a1c34d
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=117119a9580000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+dc50906b100ac7a1c34d@syzkaller.appspotmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs.git next
