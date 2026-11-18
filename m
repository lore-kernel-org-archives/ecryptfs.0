Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795007163;
	b=LFjEDC12C+HK9AdWBkk1B+vXEVCbYzjqF4iani04qIlZn4CO5zf+gj54HpWcKPmpK1WE
	 ZRX4XDUqKq/7L6m3DiU5ZyUOrJjcdUUWo8qtm/HR4S4OuTKZyqd/foyozJnROaMhbtXZL
	 mpcLMGgLe56R9Dn2KMZMg3TYbJZ0jA0ypfwNrcNRCuMMqTpJDhOGAqJA+LrtDmjLbLjPM
	 ytn+K5gSHdOK4ZmVeLGWFCUe6XFZxc/1Njluzc56W7HWO2JJCc5f3rmzgGXPLDhdVSWSB
	 ezBRzq7QvkmKNOarhqAO2YwFuMGX6nTxcBIc/nFkj4hH8ZSbfVrgY0mhz9h+MV2cRoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795007163;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=tP8QKRJpZigGHJKGRqvFEzv+St6vv1COCqEtNwoaz7I=;
	b=kfSewf95TpcYWY8NxAu8zMtsNcwRRRT1mP3cKfmgjsVl29B2O1T4LehUByLzw7NPWmJa
	 z3Mf5m2CPtQiy2SF2YD7S/iqLwMUWjsJQCD5PAQ4mar1SceRu/Ergo6oZksPXK9b0fbCN
	 xWNZZ6cCOyD8iEnjj/HpuvudX5iHB92MEXdp+FkkAAHrf+rNyeq9QRGMpSFGLJkJhV3XS
	 iDAcDPC6Qc6iRLeQ8zMcvXrhBgLDPo4BE+EAD03uxU/vZ5PbXi073JooMrCL9MlsOmcaW
	 oJhl2I9RieVpt5Wkw++w13x3FD4DX8ZCFzOOfeaQ9KIXlopopG53HHbF9TKLLX4UK5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BWR73Gp8;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1EE606A335
	for <ecryptfs@vger.kernel.org>; Wed, 18 Nov 2026 13:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C1EE606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BWR73Gp8
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4bb6adaf0f1so8601455e9.0
        for <ecryptfs@vger.kernel.org>; Wed, 18 Nov 2026 05:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795007162; x=1795611962; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tP8QKRJpZigGHJKGRqvFEzv+St6vv1COCqEtNwoaz7I=;
        b=BWR73Gp8ur1TqAXGpsO4UaQ9kojgP0l25Y9EsOwJN9jJ29SmPg+0OkAG4NDidExD/4
         Hr1v5u5i25ZD9WY0qFfn7FzJe/uDztuJnPpwRtc/Q+nsXf9pcfOEdDXZSne+QoQJJMfN
         q+E0URIEcdy/rBlRwVSWZ7R6IOx7WYyULuZYfHBxrolLmPPPrlNF8fZ3GP5q3amWfH+s
         DIOD/Cb8vK70lK3NnN+qEVPVJ+NsCd8cFWRYolIdGwP/CyqXmLO99a7S+zjjJqLVtl1N
         v0HxxanTuFQx0iElx2nuj1YSc/O7m7zBy1cKYmElYBwKWIh0OgiSiuPjowps6/nW6c9Q
         32PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795007162; x=1795611962;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tP8QKRJpZigGHJKGRqvFEzv+St6vv1COCqEtNwoaz7I=;
        b=pW7Tj7QDr+8b3MT/2ZlxzdkqXp1BYvwstLfvheqdIi/cqlBVlgmJ5ZT5zVEuX1x95p
         HT6M4OaOcaeyBGiGgTlpAlhN/5jiaCpQjXvQ+vpfWF3sDnY9vQJmVJyPt/qz/OlrKrzI
         7e8PO1fK42aGjH+e0XH12fFo7QNL0+GANgdLKx+d8VOziymo3RqoeHzXCfFm2kXzsN4D
         Z2WJxfhjgPKCwnnaczN26Tx8CIxGRRopaCG36w7/hZ3slxMlyWov0VMcPp9vxB427SSc
         S8HHMZmtXZWqdsvOyelcJC6fuZs9vjZOffqFBgOrSRipCZxnatwBFHmET/2P7ot07LDJ
         A4Xw==
X-Forwarded-Encrypted: i=1; AL+hErGpGhhPwUGegV2D37IcypIlfsQ0qprM16WBiGPXaKuIttLvf2dD9EdCIIZouPsfz+6rSu/2utdVJQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8WFvNFRYduumgmIQKPq0k4OSb/QzKQjOXda+tQcN4s6VyNA61p
	08Mvb9loUcxYMlVYhQmfcrg6eulmf0xYaBv/Qk5TEew9nWvWdEeFH3a9
X-Gm-Gg: AYBFou2Qf34JeabDium2i8bV8hcWNmKBuqopRHRHmKHg55KDgTaZitEz2V3oUPGi0Ng
	s2JEQIAKbDcCoXc+0pXtAubi50IKTy6YCnP81AIltZzDqP8+90DM4yaiBvZzs0BO53ZSMjRNTyJ
	4AxLYMiGAOTVds8WQkd2IkdyS6XHsDeOLez9peWb+HXk5Qke3wyaA/H4wyzk/62tqPigr6tUeBy
	j1dUT6Tbm5aKnkaifHiCtzWE7aaof/rOKr/io25mtWvDJaqPJblm/fb84p4oy7JGaaDtTjJuf+E
	iQnil87KnFKPig4/Tw9/8VoyLL9dOeXvB4AxNwc6g3WqloJVswctRgq49mjpqRdlUs/7vzL28eC
	BHT6GOLBEnJlk1l3OJ4Dru+j3twPIpOabqJ9RittwOR6C07GBh50UE9Ar2kqn2mTqGMmHxTzeLI
	9qGANorsuk6S/gMPgGbl8+ApLQqVFQrm52IBCcLWH23euC2YQZQtM8+dtUNKAaisVlQiNgwEB5r
	PQIec8DNOY4IOoJCw0VreT6DBim4dhNuIS6NEm5wNeFYvQ0+Y2+ADLjGUWl2pAkoxVOFwlNN31+
	gsPmSE0f/O/CnavC+aCOzX9SXPUbdIu2Y/OyFIWC5XRw+aWT5tq1VLwXsH6tljfIaGtxGS7YSM0
	iprNb6Oq439JZBdKoLBaDeq/dK4DEnZtzxzypawwoQnilXKJvngQ6
X-Received: by 2002:a05:600c:3556:b0:4a1:dda8:eb73 with SMTP id 5b1f17b1804b1-4bb7da26d70mr47037875e9.27.1795007161548;
        Wed, 18 Nov 2026 05:06:01 -0800 (PST)
Received: from DESKTOP-IR7J1S9.localdomain ([41.111.247.111])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7d2c3c93sm95218535e9.13.2026.11.18.05.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 05:06:01 -0800 (PST)
From: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Tyler Hicks <code@tyhicks.com>
Cc: Jan Kara <jack@suse.cz>,
	ecryptfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: ecryptfs: the lower filesystem gets modified while it is frozen
Date: Wed, 18 Nov 2026 14:05:56 +0100
Message-ID: <20261118130557.374-1-drifabdelmalekmohamedsaid@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261114-kranich-banknoten-anheuern-5d0a2354a51d@brauner>
References: <20261114-kranich-banknoten-anheuern-5d0a2354a51d@brauner>
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Post: <mailto:ecryptfs@vger.kernel.org>
List-Help: <mailto:ecryptfs+help@vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ecryptfs+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone, I’d like to take this one unless one of you is already working
on it.
Cordially,
