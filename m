Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793903045;
	b=jExYuJiMeSZDuXndfy7Oqeo29nWytTm79YdQ98W68BSZo1eZ562WkEAjKlpdamKohdHD
	 RZ+7fdnA4Tmdw+BYN5I2IalyePD5L9XbLMljqeQ0ncEnjzihwPUuqD20vottRfLl/9RLb
	 URhfXMZrtKdLrgFH0kJH2p8SgA3uibZlz2tGSrLcb5jOMrkdBSDnYY1Q3P5rftSLEFPkO
	 j9m+OCgA1h70DNDmZqdnMspn3PDY6suO0z15bTnhwUU5KG8WuSmPXUzPiYenRydzKjc3e
	 o0INMxT/VgxxVjzD5b1dD/vDaumGxtysXVn6J/ZeHCznMK86D5QTbb9KqH6vXVi9upQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793903045;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=FZYaPiXF5uqkd9py2yyYx1geKocgOLas510kMd12DD4=;
	b=FXBzDoxdzLYt2aZ34g2mUAK1YmT/bd3LrSlqimveOYS9ybkdft+5du5kwsN1+yI/Xmqw
	 MKe3kJfm+LPbE8gg3kQUB0q166538qdLVy2ite2ZcK7Dp48oIrWPcxhr7iMchWR0YM9SD
	 DB3Yu9jTgCwGTZLWwxYp8S3sWAmveS3OtkoUzwM0tZdo5uQ/FFzM9SFzt9A9cBQFPVRjM
	 WDEtyL3tMtrECY3SaLm0B+17VP1Q/fISfmqRuAD2vbqdSZSGSY6GoTi/r7okJsH87Os4r
	 28/11wGHDy+U3ROCf5GwvrrCXekFHXZbwOkUNDKm5DJB+tF30BIPxBGbkO5Ia82ppuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.198
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB9B606A31B
	for <ecryptfs@vger.kernel.org>; Thu,  5 Nov 2026 18:24:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EB9B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4cc89e86e4dso2962976b6e.2
        for <ecryptfs@vger.kernel.org>; Thu, 05 Nov 2026 10:24:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793903043; x=1794507843;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FZYaPiXF5uqkd9py2yyYx1geKocgOLas510kMd12DD4=;
        b=xbDqkwB9YokZLCZeoV3Nu8hYGvUnnlwPPspOmPlRf5uaOnL3G1VGfPK09/c4/34PxP
         DugSmev8kQyqlX1EB8REHjOoptBRZa8Hlnb/6Zd5H07r2E47QJqLIJBi4w7IiUIhMyTg
         wFGRnOi96NoJxo29ekARcbih724XuVOA27JhDZtfxdkZaKuN/ScbnNTe9uvTODNWlR3Z
         LrJomP0pmGSX/VHFdU5LEMjZutNUpuvXKTJq5PJy7tqq1B1iHnfDyLQS9U3xCUvZvJOW
         oJvJZN5v7OHj1feZ0gwUHY7PFv4fX5XEqK9+vw555DNeLeNkSWD6FM4W7Z0PewOKaKIf
         SyzA==
X-Forwarded-Encrypted: i=1; AKwUvBwgTUdTOA2cf5ANzjc2OnciUaxdKFJWk2VawaGJg2Vf1DxZkz7CJ0+fSbIX/46W/rWcqANZ2deswQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/aTFjgAKlmlA6HneZn8Fm11N6BBPGJt3176znZ8hiHuZNAzfAJ
	At0p2Op+dxjvua3sjhgBdKM9OeoJd/ObcXf749T7TeT5UVLca4NTCXq0PO7n25KC1HI4P8FDkmQ
	rESxIuQGWy2BQOmwVdlxHOZsidB1DxYB4RgyW/2BApqLe8PiO0rRFo/kmMNA=
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Post: <mailto:ecryptfs@vger.kernel.org>
List-Help: <mailto:ecryptfs+help@vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ecryptfs+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3c48:b0:4f4:d7:b16d with SMTP id
 5614622812f47-5640de8713amr14198871b6e.60.1793903043331; Thu, 05 Nov 2026
 10:24:03 -0800 (PST)
Date: Thu, 05 Nov 2026 10:24:03 -0800
In-Reply-To: <20261105180403.675338-1-diasyzhangqing@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aecc9c3.ab333cca.1deac.0002.GAE@google.com>
Subject: Re: [syzbot] [ecryptfs?] KASAN: slab-out-of-bounds Read in write_tag_3_packet
From: syzbot <syzbot+2e8c4ecc07730b29ae27@syzkaller.appspotmail.com>
To: code@tyhicks.com, diasyzhang@tencent.com, diasyzhangqing@gmail.com, 
	ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	roberto.sassu@polito.it, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+2e8c4ecc07730b29ae27@syzkaller.appspotmail.com
Tested-by: syzbot+2e8c4ecc07730b29ae27@syzkaller.appspotmail.com

Tested on:

commit:         05441d69 Merge tag 'cocci-7.4-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11a70cfd580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c210800cfc8f61e
dashboard link: https://syzkaller.appspot.com/bug?extid=2e8c4ecc07730b29ae27
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
userspace arch: i386
patch:          https://syzkaller.appspot.com/x/patch.diff?x=102ba969580000

Note: testing is done by a robot and is best-effort only.
