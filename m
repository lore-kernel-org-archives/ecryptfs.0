Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792686603;
	b=hNcpr7G01a1pEq+Yq1ET3IwwYbjYRWPoo5d/j9/9gGVa946kBKu8hpS5aaNn6XMuZN+i
	 TlJAnlwOo1EK/V/P0h/rVEUeHzUNDIcmar4Vj+K+9y/2V53oJNILij3pOBNyhDW2gxlcl
	 VNxQtIs6GKznMVxn9kt9L09TkCQuiplJk9JQk6x/sVB70MxtUq06p1X7bImbOSn2LH5Se
	 2/5mjvRbEz9yO58QIg6qTS5L/eJTgkayjg9rAJeb7E+Ye+VD7IEDMLYk5d2oSuKf+Q+oR
	 m6Wd2QMYLRli/F7oQ0klJchFOxlvkb8qN5CjP82Ksz+aQT22D+aiLotjEechRGSJnyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792686603;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=p5kRDgeTvfe+gU89RQp3snPJsQI6aii5+oQzcmqDjd4=;
	b=jS+5UwwthHk7TMEJwnbMYtl2A88LWoFI0JW0+SFdJ9rhcgg5fTfljAp5ljX+3r6qmIZw
	 4fWXvuc/8kP7mANMNbgMYEQ0ncTD2vqjBVYh1REVyz8+CTm2rYh4Y2HaTn10sARu4uUBP
	 310ZUGV99wkA8ZTxxdVrGL3L2fIGXqHYTmBa2+8WeD0jqUUnBseIB6ksxGeZ2M25jIWyt
	 xEAaNwejoqpxHyhumtR0T/kN/0VGsCSz4KXbv0Jmuq4Tq+y3fSXbu9szO5EDIOGI2E9tY
	 FJ34b3hpuZup4tt8nj0C/QJaFmHwDby3PodXo4A+t2cPMXkQm4/TOeKovYGwQqQb8BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06E0606A32C
	for <ecryptfs@vger.kernel.org>; Thu, 22 Oct 2026 16:30:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D06E0606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4e778acdbc6so82294b6e.3
        for <ecryptfs@vger.kernel.org>; Thu, 22 Oct 2026 09:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792686602; x=1793291402;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=p5kRDgeTvfe+gU89RQp3snPJsQI6aii5+oQzcmqDjd4=;
        b=TszApdTY1jW5HKoWi3LppicgbypTWooElt5rqcpSVgD8L0YLHQaWM1C5aaBMMScTy8
         ljfDrDFODU6E09mqoYjBs3mxS4L/11XB/j89hlZMsFrRAgg31Q21yBi3MJopCgb489oL
         ibZSneOcbokFd+tbpSmYQI6Yrw9Wy5eYmzdKiyUaOVcRhEDDL7ykyAvHWa670RNXHUSF
         JTpVvE+u0UwOm6do1RT0u+BhnkaRm5jYsvwToegYna25thqNwe3zAziViO8nlp4BO8Io
         FBUa1Umml49TqWA3v8ovSDYuBZlcNjIYs7BGKNqEUgrI1kanZ2DcZoAaxaT9ecI6qTf9
         QtVg==
X-Forwarded-Encrypted: i=1; AKwUvBz1SBth83ZNZZhrUlvtufJ15fT5o9BA77hGhKYl0pW+CLROGj4Xqqoa+/NGIFkXykUcCBoRKDUVxg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKJM1hxE2i8IxvG97QbF3qcc2Jk92YKnH9r02RHSYyF2lB4uKq8
	2ZRKtjTpISa7vDbdXIdcGTcQyoDv2q6LoQGDmaJbnTfsyIWj0yXqBtwo64bSxdAFNkw1AJtUHtB
	QdYt71Ne02PhnOomA8vOjZXLOawB3cqgoXFyENhnwo4BtAsWfx9AG7AUD9LY=
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Post: <mailto:ecryptfs@vger.kernel.org>
List-Help: <mailto:ecryptfs+help@vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ecryptfs+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:5147:b0:4f5:97bf:e56b with SMTP id
 5614622812f47-5535a767efemr3861350b6e.17.1792686601788; Thu, 22 Oct 2026
 09:30:01 -0700 (PDT)
Date: Thu, 22 Oct 2026 09:30:01 -0700
In-Reply-To: <ato0f6AUVyixt40U@elm>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ada3a09.297debc7.3b379c.0009.GAE@google.com>
Subject: Re: [syzbot] [ecryptfs?] KASAN: slab-out-of-bounds Read in md5_block
From: syzbot <syzbot+03c68e42ce4b33f7ce9b@syzkaller.appspotmail.com>
To: code@tyhicks.com, ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+03c68e42ce4b33f7ce9b@syzkaller.appspotmail.com
Tested-by: syzbot+03c68e42ce4b33f7ce9b@syzkaller.appspotmail.com

Tested on:

commit:         8f6626bd ecryptfs: bound session_key_encryption_key_by..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs.git next
console output: https://syzkaller.appspot.com/x/log.txt?x=1793caa5580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba82fafeb7f9e7f0
dashboard link: https://syzkaller.appspot.com/bug?extid=03c68e42ce4b33f7ce9b
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
