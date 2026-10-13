Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA973E51CB
	for <ecryptfs@vger.kernel.org>; Tue, 13 Oct 2026 06:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791872886; cv=none; b=CXHTVBGelfGXVZTmlA+wybKoYFziXGHPB5UbT2R5UElvQoI+wPT8XaOJkg7q0BEC1a4JDVaIoeU2BVS4Q9uIezoUa0tmfdj+dbimGi+I1NhHzu2GJi1xTVcv5gWLgRF8Zle09NuAskbAdThhIsyz8jlnXouP1OzmRSUFYZGNGPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791872886; c=relaxed/simple;
	bh=yIwD86rcbO0Vr528api+9GjzHDDOT2zWtfi3cYbhzuQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KAT4Fpi5hOlXEWgOA7yk2cpYCU3EpHJQIwnoE2JXyyfodYrydoPyrKLK8ovJhzpaUCNrHR+UOrMKBAza+ZOpOWu9w5LjqpVLRHkiPTgliSC/rxLY79NWGMz+KtUTrUTEFEnGXtrjlq2rtUGUdAUUJY6vyw1mhxmVvZlghpd8OEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4cc89e86e9eso3820556b6e.3
        for <ecryptfs@vger.kernel.org>; Mon, 12 Oct 2026 23:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791872882; x=1792477682;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yMb8whsbLP5fo37Jx1sYYrwzD3gyyWSm8kpaQ9zatK8=;
        b=PrJEbtVCD1GhPqB1UT7ABPWtlYhGl17NdMY/NKB/SmH0/j/j14BIxhwiOwTKe8i3ar
         FIQEu5juuZrVbR6R4egJHduBSokafYzQxnGBaiCRhkASBhvH81P9B3krguDfkJjOGQDV
         a919AmsDGCvQ+WKjRxdyMznjzOUcFmHnbSvmqtL/kwNxJileK1MmaZx1CKvjJQqXisWY
         pJaw+BopIex8x7LLMW+LuV1Y271z8/5Z9K1n28W9Uu58RMaczVBtwQukoflOq8PXirTy
         0AvnrUsonn8dJhC1QFDWQNdP+2FJ56e+YCKgZv1G9lRGGzIKcCep3GNEIoTb6tQRcw5P
         pLlg==
X-Forwarded-Encrypted: i=1; AKwUvByYroLLHIPcPu/X45Nob7eR6JCrXZTxLqcX/TjVrwOnlyg+PcEoWtlCyTas/loe93Ml+KQaeQINzg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJYLw7qE0SnUlxJgHGSks45VWbA3G6BSuNBqg/D9vdeo7JHdklb
	hJINalB9j6aKIGvG9TL8UN3TJTwtg/Oc+uZdv0zfBVges2BhpYMylH6TDzzsXvoi3vCoiDpLImM
	FRAxLPCo+MQqk5wr5gg9mM7qXbOY3fkmaMxVfHwbzxYWlq68pfZwje0sLfEQ=
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:f04:b0:4e9:3412:14ac with SMTP id
 5614622812f47-50c516f087amr13552903b6e.33.1791872882524; Mon, 12 Oct 2026
 23:28:02 -0700 (PDT)
Date: Mon, 12 Oct 2026 23:28:02 -0700
In-Reply-To: <as3J6RH4QPNIl-b0@elm>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6acdcf72.8cdf6287.1eb53.0153.GAE@google.com>
Subject: Re: [syzbot] [ecryptfs?] KASAN: slab-out-of-bounds Read in ecryptfs_write_tag_70_packet
From: syzbot <syzbot+e4391e0d6e7c89b8c84e@syzkaller.appspotmail.com>
To: code@tyhicks.com, ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+e4391e0d6e7c89b8c84e@syzkaller.appspotmail.com
Tested-by: syzbot+e4391e0d6e7c89b8c84e@syzkaller.appspotmail.com

Tested on:

commit:         5b00bf0f fs/ecryptfs: fix slab-out-of-bounds read in e..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs.git next
console output: https://syzkaller.appspot.com/x/log.txt?x=11c0a999580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2b924f079099ba6e
dashboard link: https://syzkaller.appspot.com/bug?extid=e4391e0d6e7c89b8c84e
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
