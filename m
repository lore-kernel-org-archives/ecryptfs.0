Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE8D38DC7F
	for <ecryptfs@vger.kernel.org>; Sat,  3 Oct 2026 17:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791047721; cv=none; b=A95Fa1QFzCrGGbrpWGDEJYzgbm1Q7xcqwLge+kypH8lp+FPauv6/3vHew+Or2pGSFvUJeQoY3ypwHtoixo/R5CQlM3qhiMPg0/EHnnRW1msIA00FXtzAQXVXyWcwcs8OLPLVsh1cQn5JCBzkxo66pcwSC3rFvjDObBLMIu0DisM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791047721; c=relaxed/simple;
	bh=AXUMRRZoPMPFxEpSNvNWVsESjh1oYmMGz3UfImx+sQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sr2NtPojpP1UZDDDV/RcdH0QFQdDWr1ljpt9r5riXMeAtgYgluWa6dCU/BGDSSMnGyiYR/ePdNyoltNvEMmTwMFY88ef3jfwZHdJEjKm99j1wTRp5xS+o84SbMAlKt1z9Ph75LloZfO7Z+I+JPj2I0oxUV55l/FLwjmLoAXgEYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pWFRMzj3; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pWFRMzj3"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-398a5aad413so251903a91.3
        for <ecryptfs@vger.kernel.org>; Sat, 03 Oct 2026 10:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791047720; x=1791652520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uKKIWNoUfZgNMr9RhsbAI6Qq26Nyd/284yBj3K33Njw=;
        b=pWFRMzj3DWEAhma5JXm6sQzQQ55z2JF/fAqT0Bh8deSMembyo08yQGZq3pGIyKLP4D
         TyWK+yGPTTKEuziYPxiV0GkZuB9stn5JX5dOJmqmDZChoUi8RL6bw8NPZwaN9lwwtiCA
         04NnuoHKe4PcG6AaruHzCIm10/1pArUZXEr3zynZI+kfBtnhYVL+d9nwyACyWgpZNK33
         bQLmCuhxaQa5UNyttrrCdrtCKRPr/+790TYOxZtqQHE9oI5wgViLOKePMuytK0Yh7T8a
         ShnE3VOg0Yfsmty728vnPkI6EUlxhPf/GK4kvPYNsd2UUbAe4WaV/OdEc0XWu5bzsGJh
         rM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791047720; x=1791652520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uKKIWNoUfZgNMr9RhsbAI6Qq26Nyd/284yBj3K33Njw=;
        b=ki5k7rnT3nNbzNTQQ6thorJ35F5NweKgE7KlxuOZKFSue2Oo8ZluQ0o6Nity+5vjnV
         E5NGEz/vWX4R/ev2zItmae+lNr8zDdIU3ScrFKJ+MmlZp6vv6lrzsBkjoEvAiMp59uul
         pQ+s+NylkgXNL/giAbFOzdRLXcXc5LEHi0UKnG43luHdGVG2Ocl4hBapWcTZBqUZPS9q
         Ih1/D+N+hC97kQ3Jf1WTMnxhoqPOe66Kf6rVKtDLenuGdWpHwM7Y+vl2xi5bS2wJDTEF
         SoZAIPMQo2ULGDbgy4M745BYqjBIbJhtHUkuGjFpKkDcyVzUcLrOwkElA3MzZlgHiADi
         8OXA==
X-Forwarded-Encrypted: i=1; AKwUvBw6myA6qaLvX0gI6dAnkgAJ10xI+7ql2Pf7XG90B7OrLmh1dDqseDeLvkdffphbz7OQ1CX17Rkz4A==@vger.kernel.org
X-Gm-Message-State: AFq9FYIHt0kxKVxnx33dbLTkREpelDBo6Ah2gyfgDxtKE7yFqBRO6rSQ
	GQYVgc/dcKJLTQfVpzqCR/oC7f9YtczDuUzVSaEFmB85wq7lQG07AqlB
X-Gm-Gg: AYBFou0w0JkSj/GW7Po1FMKpVnVt13C9jqRHD3nI2Zg2o5+G5ZtDoZ3on2d/eWWtprY
	jLA/9LY/IcTWCwA1uOvw/17INCiciZEuYmYWVdvsCoSZ01YZriVv1F1PlCnr9hXn8LuAxQVpOES
	FOhMjLPpKy1HsaREsEAG9fnKOdZCmvKbfHLW6egjLjPOIOqyHvDNXQh9KVZLWu5M3aWnS6MEYxY
	EUpS3jA3ThibmGVTZ9jbmeWEikAVvT8NUBYaj9fWunp8R+HQmmMCmCvxVr2jZiE0U9bQtpMKa+o
	gVb1VF5pU8m8811g9Cboi9t3cO9Ax/uXAMIGwV0A9SaC0nhfAcqaUFbNIX3FmzxRH00SsTuNron
	jemj6Q9dvXxy1GhQydjcGIJQeWA6hBeYudTt8ncfO2djHMLZrpR8GU6GTNVywEIjBWbfWVOjC2a
	+e9GXg2LQz/m06s9L3FtJoJPsxcXkHH/kx4YjVWkUSyZLYwQsLCft9sZUk5BJj5V9859iFRaNWd
	Oum8tBycuYrc8cF2DT3pwAOcplZbiswOLcWQaHn9cL0wPUnjhpO
X-Received: by 2002:a17:90b:3ec1:b0:39e:6a81:f34b with SMTP id 98e67ed59e1d1-3a7873dc91amr2356347a91.37.1791047719604;
        Sat, 03 Oct 2026 10:15:19 -0700 (PDT)
Received: from casta ([2401:d800:1f1:cd06:9f1f:eeb6:21ad:cee5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78d4a5150sm3587419a91.1.2026.10.03.10.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 10:15:18 -0700 (PDT)
From: Nguyen Duy Nhat Anh <neganhat@gmail.com>
To: adrianox@gmail.com
Cc: code@tyhicks.com,
	ecryptfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+03c68e42ce4b33f7ce9b@syzkaller.appspotmail.com
Subject: Re: ecryptfs: validate auth tok payload size
Date: Sun,  4 Oct 2026 00:13:52 +0700
Message-ID: <20261003171352.10244-1-neganhat@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001213915.1326602-1-adrianox@gmail.com>
References: <20261001213915.1326602-1-adrianox@gmail.com>
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Adriano,

I noticed this patch touches the exact same lines as a bug fix I submitted 
earlier for ecryptfs (the ecryptfs_get_key_payload_data fix):
https://lore.kernel.org/all/20260917044558.41677-1-neganhat@gmail.com/T/

Since your patch expands on this area, could you please add my 
Co-developed-by or Reported-by tag to this series?

Thanks,
Anh
