Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC470490BEA
	for <ecryptfs@vger.kernel.org>; Tue, 13 Oct 2026 06:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791871470; cv=none; b=F2t8idvAUC6VuaDr33Ofyc5Uq6WVlLsB1jpPRAn7ndfCu/pqefjfOp2UMIwjGt5UJiKZXiVgSGfMY52Tfg54s3VcRIh02MqKcM3D6ABMVdbIlFt9ggD5divKgOmbMBodWhCzM9+UbzSWKG6dCFJPwrN28OQMMoIfTmZgTMjh4hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791871470; c=relaxed/simple;
	bh=/GcmAYDK5wL1XhmTAdpTBXowDwSgyF/0xtR7hRDKYus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OxvE5vgf6wsDFzEKwBVGZz4UKqazgMeQTGJt66kN6tjG7ZJq+FzuIXN3sIQnnzo0wRrsk3B/37ivnlwYpVcbUfyZhKzW3GAfKXLN0PUj9ksnfqfVaj1/0RwMoRdQTiRg8FT+qB8nyiQbyLTqOg+6jDp3nBQTat2ymjSsuBNhqyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com; spf=pass smtp.mailfrom=tyhicks.com; dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b=WO7a8LDP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HeKDEmsg; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b="WO7a8LDP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HeKDEmsg"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F3F7E140013C
	for <ecryptfs@vger.kernel.org>; Tue, 13 Oct 2026 02:04:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 13 Oct 2026 02:04:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791871467; x=1791957867; bh=4DriwNVYMZ
	WY7vbH3ttBAHXAnJyW0W1thNNddn0x8vk=; b=WO7a8LDPmVLwoHuTLEqjopFvrx
	Qp2YkFQeWs1bEj3csEeNQaY3z2PAp1Lwde74Hz3csbdfp/m1laXtocqWtDs97gKf
	AUQVFAnnKDVclY7vrA+FkMsUWH2qZAmYks3oHlfkGqrtOFpoBzBAkQ0+4Q1ASQfV
	nA7o20SAUiXNEOmRPtzwSjRErbLHFXA3ShUIDfTe3H/YevA2z4yk+GDyCI7mU2iY
	WBRBIoYqqIQ3+OLzsbW5ebQ1pS7DZNTrYfPX4KgdXiKS7Z+lrHojrWEfYxomSusk
	KORpZwv9b2P2wBPH5/16pFq30BnzRRp3kr7hIQt+pIQ0kyXdF65R0QJ8wX4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791871467; x=1791957867; bh=4DriwNVYMZWY7vbH3ttBAHXAnJyW0W1thNN
	ddn0x8vk=; b=HeKDEmsgJYxoYv8Q8uLw3DL9vt6uTRNxBIuc7rm4TyVaYv6dogQ
	GtPbV1aniXa87UHjVIEBgucmlO1Uj0bho5yWSyDQ7fRUHqOgDTE2ze/4tEYsI13D
	a1R2ZhC0nuNg0le/U1tlvQ8hcwEpNl4VlZUHTVRBgbZIjsjelVsHjTFZS8Vlp/YL
	TJF0BBITh+UM44755ozo1vbHqaMNPNR0bSG2AHUMdB1xASc9BmLfkafuUxMC3xsx
	B/cyXjSl/p1uuAn4vHSUeRNeoEkh8JheyNAwXo4UEhAsIWHHoXILYqLNy8MjPgxj
	qARFaPw3+qRJ+GI6fofFucApeM3FpY7wDqg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=tyhicks.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791871467; d=tyhicks.com;
	mf=PGNvZGVAdHloaWNrcy5jb20+;
	rt=PGVjcnlwdGZzQHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:TcWEMXtDGvXNArp6c3BAFH7Yce31RCTa2G9Fe4E8yTofboN
	L77XYmld5T5T7WVTCsXz8ShAr6VGaaEa7cLjd/nagemwO8zTYehjZFAn6pCy2bIG
	FAXGistcKB87xKvluSN0jDNUqJXc6gGun/3yQoSoSrHavob8B03LG2/56Kr0MaIL
	QNyPUzTMPmv8UCB3ONRBF/xua7lZ+5slfKpVKeX8I6v0RP4xWxenMMbJXfvEJk9o
	jZey8xnI+XP62JdkdqO0g5KTXrmIviEqO54SNRAyR82wiDsDq7wGnUuhc52Mkj5f
	AB5WtIeYxdo4GJUOxdwDl2XoBWvtRZ2d0+JMgZg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:TJvoFdFxiGHiRzNLSSyBbmE8BkDG6CdQarPY0/FhhOM=:/GcmAYDK5wL1XhmTAdpTBXowDwSgyF/0xtR7hRDKYus=;
X-ME-Sender: <xms:68nNahaY5DGlUWh6iVOxQAiysVeKi91KcSm5Z_T2lVFWqNLubr3m-Q>
    <xme:68nNaj3T1jWh1UyVEbfUka5EId2kLRuBXN5w38Gl2FwkIybc2NnVKsb2k3LJulplZ
    j3r8YUQRFHb-a17kpnol3DVcr3vzGZ57RWAMtJ0iIXMSpVQSw0En2jn>
X-ME-Received: <xmr:68nNanfSZxhpUHLu5cAwYebmXgWY9RdSOTjn0jGQF-i7xrhsXqJ7hw>
X-ME-Proxy-Cause: dmFkZTEOXKhrMJJY6a0IAErbCsJr74e03FrSXF5dfwYePwqhWGJUT58wtgJPEYb0w5OxqA
    lmZkI9acsqzoEai6lUcecBS2/qbgoQ9HY4RcEUMhvLeGgZGXg0K1qB2O2KOUQkI8+Fp02Y
    8Gh9RT3Zuh/IT0pRYf7dWbv8JIn4dCmXtQxHf+6crVJa7P69JxCbLyggEdoA+MOP2d5wJ/
    aUpEhrgANJE5DxVmQyxBcQIxYbOk/7kppobeyZqaDrnCvjVR5IvjBKsi202XZi8Ouai4n/
    Mkck9EYSHnc2DrUQxgoYrQL6sK3T/NAJrguiDyAmNTBZ6qft/MIrk9RlKyO1AwalVLpZVD
    /wK0OEuZ/Tna00grSUKkPo/wC2O71oEIAFlCgbprhs7423/vw3/JXsubX5H0WOwc7CUKWC
    DCLVuiD7taEjv2RlaRBeuiC7N4LgIXxqz4a6g9FAH2QykFuYUDdeP11TrqgBjmG4IVwyXS
    QxMzeNVt/w0ZZMl5uvI9viSt2bbbVvZSV8GW95ypbi1ph93xgPNT8uiatI1lNoR7ln81Ip
    uXY95O8mk929jOAzSOyWPuWyq26TfYFbvlosHA6nO0TRyscnZzvXRGAMBaUyCWVn+y1fcb
    RE5CTP94xVMyZfHpUZHj6nuZzMPs/wFuf1uWncB5baP4S7a1WxVvMoNPK+Mw
X-ME-Proxy: <xmx:68nNakFtLP4G5SEvA_TxT3VuJuczmxaDGzZm1D_62GI7my6W2_e7GA>
    <xmx:68nNao19EdxQsSRmjTWzSRf6aRaRcqtRIWFKsEqth0S6BgS0vBZ15w>
    <xmx:68nNaklN3PMvfIwXmsdEOtjEVZwG2vwDPF7fpHR7ErfJCrQXPLWv6Q>
    <xmx:68nNag87noS2aO8pYzpKfiIddBLITYAkqKr5kDat5SJEq7XBSOPsbQ>
    <xmx:68nNanPsYv2RNtsmDBomt4FjAV8iW8PcvNk0n2jq2SZ3A7kAMr1UipfR>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 02:04:27 -0400 (EDT)
Date: Tue, 13 Oct 2026 01:04:25 -0500
From: Tyler Hicks <code@tyhicks.com>
To: syzbot <syzbot+e4391e0d6e7c89b8c84e@syzkaller.appspotmail.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ecryptfs?] KASAN: slab-out-of-bounds Read in
 ecryptfs_write_tag_70_packet
Message-ID: <as3J6RH4QPNIl-b0@elm>
References: <6ab152fc.71f81b7d.15fa6d.0030.GAE@google.com>
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ab152fc.71f81b7d.15fa6d.0030.GAE@google.com>

On 2026-09-21 08:53:32, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    518e5b794c06 Merge tag 'for-7.3-rc3-tag' of git://git.kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17e5fff9580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c3bddd52b22c2498
> dashboard link: https://syzkaller.appspot.com/bug?extid=e4391e0d6e7c89b8c84e
> compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1015fff9580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10b73915580000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-518e5b79.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/5307a29f916b/vmlinux-518e5b79.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/7d4c698a99b1/bzImage-518e5b79.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/4a20c8843682/mount_0.gz
>   fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=13e5fff9580000)
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+e4391e0d6e7c89b8c84e@syzkaller.appspotmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs.git next
