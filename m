Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8734B1D1A
	for <ecryptfs@vger.kernel.org>; Tue, 13 Oct 2026 06:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791872586; cv=none; b=W7HQzlQkaxFr6PSX3wJbUBBFZ6UMyFtTPDECbqf2V7uH+vbWpgHcoyDlX3dS6gnRJrda70+WEwZltwNmZLq7M8XwCPA5XLA7JXuu4l0AyqS+DXnaUJXxY6zRFxCh4ZEQPdtfkRcw6geb/cY6e2sfyHabTG1NGuR30ElUhhFBeaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791872586; c=relaxed/simple;
	bh=Msi8iQuh7aqP3QaqRPE5s4sNnL+X/c5Nvnh76lk6zlU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FT/95NU4FRuW1x2bA/uvQy7fSdo3Z0eBELvmLJqF8/Twpa07xqEe9z/Rc4fWdVHnbC7i8VE+FH9bai8dzcAA2TaEL5xF48MYg9fMYF4Y4y/iF/7QzmzpOKPZSegkUM+HYmkPrjPOKR3Rphe5SJrAjYi6aKni7132a4pcBHU4Mnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4db3db8687fso4318212b6e.0
        for <ecryptfs@vger.kernel.org>; Mon, 12 Oct 2026 23:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791872582; x=1792477382;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1TL9hKKQXNbiZtQId+/EL5khR5gMHNTwDz1p6GsfGso=;
        b=Avo3Cw71BiKeI7omqvNzM97sjWPo2JHQPylNZUKLUwUszL0RHa/SHqnT9PK9gQ5kCl
         B3oBtfZ4PSbqRCYM3qTI7EuzptJrrn9fsLiuKQIIVdUmgHYDRBeUClybU5LmarDuheTD
         Qp804xcSeH+l/V2Vx22CGW6CtKtAkuq1dmzyYCjLiCavm59LxoBHtWpB2hff33PCtsMw
         rUNRswIPD0EitjIqpWq78vo7BVgn4IX7sCsxpa+pI6kIGixDAs2q2lhwhGVYLlDrQDsz
         ablE9TCrT92Rk43fRgfOwn0ZrdjTlr2PIioXFVVgHzTLYRfRCrG8BOcUD3o24Pqnb8JG
         qJ3A==
X-Forwarded-Encrypted: i=1; AKwUvBwUcYeywu57aLkO9sMSWdYr/QqN7FI632nlEL3T3AY5TH9xvxevVfMbX7KCaE5I3nPQCPJlodLqig==@vger.kernel.org
X-Gm-Message-State: AFq9FYKBhRY+vniy/ghGSCVZmebVvvbSjVfYflkNu9N6xgKgxYupwGTq
	YDw79iQvHDKVEmDabVnHdGm3O1skyESJWCPYEzDx8XS7L3JSgHx7f+oQZ1b+hykkvuJEqSOpwce
	nvJlzlqakblNMZw12dFDyd/MlP1yYhy5IBM3gS2KJ+jiIrU8zXZ9mm3Fz+Vk=
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:670d:b0:4d6:90f3:74a2 with SMTP id
 5614622812f47-50c582326damr9608434b6e.45.1791872582224; Mon, 12 Oct 2026
 23:23:02 -0700 (PDT)
Date: Mon, 12 Oct 2026 23:23:02 -0700
In-Reply-To: <as3JnatMRsNYq4bR@elm>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6acdce46.a150a118.27e199.0056.GAE@google.com>
Subject: Re: [syzbot] [ecryptfs?] KASAN: slab-out-of-bounds Read in ecryptfs_verify_auth_tok_from_key
From: syzbot <syzbot+b9529ebe6a9394ddf825@syzkaller.appspotmail.com>
To: code@tyhicks.com, ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b9529ebe6a9394ddf825@syzkaller.appspotmail.com
Tested-by: syzbot+b9529ebe6a9394ddf825@syzkaller.appspotmail.com

Tested on:

commit:         5b00bf0f fs/ecryptfs: fix slab-out-of-bounds read in e..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs.git next
console output: https://syzkaller.appspot.com/x/log.txt?x=11c599a9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b0a4310419d2cd7c
dashboard link: https://syzkaller.appspot.com/bug?extid=b9529ebe6a9394ddf825
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
