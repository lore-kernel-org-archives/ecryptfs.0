Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793753734;
	b=ssIgM7UxMK0sFe/B+tFzYLbDaJTkAeovBMCZECA6dcBXfKXs1WSRyA23tvLMn/6ZUkAs
	 ZbF1rS110QnObiEs5KkORRyL0wKpmHd5X+72AneS9PuVsV1SeZQ8qN52+3NswoXZiL/aw
	 80vkElcq8WESlP6YUzLa/tyEdypDZLpl2f1Nk5K6BF2NYRQcurasr3h8wm4wwr3BXuGGT
	 cKs/qFhN5hKL1Rfmy59jYvhVCVgBHSeqpZS19SLhpe6EHUajBONLtx7F7tDV+lH2VSiGz
	 hPjDfikixTBwqqUAafnThku3U+TKi6VR3mZynjEIJQFDiJchPCRCvLGTczwRtVt/zfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793753734;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=xG5t3xikeZrgWEXDIQ9E66WF0APj2TRUKkrk3j8LkpE=;
	b=vfbQWxz00wFdFxu4F+YJB2gdJQWmo+soMQGHqU+Xgkf/wZILZx185UK4ZtH1uetmw7gt
	 VLgCVVMJO63A6mklimK0HAQ3VLngnNL+W/aYG7Neufgos2c86+h5Ll0vVrxtTh5ZZzAOe
	 woomNgZ52o9lblfOLzDrpujcZOoZWgDhcbZlkSO1D8uJJ1cyKIMGSU9gC3iPfzSoh6w1X
	 +8omRILWdb42GgfSERW8ed+yjL1uCbjxzCoFOe5RDJzNCQYopzuRLbP2gNPu84j+xTshl
	 iqR1JQeDrFsGtIQd+awDU0vFvzFPRKS59Qhd6v1DKFWtrnUs0yAvLMhccLK4v8oyY8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sudo5wuz;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD3B606A31B
	for <ecryptfs@vger.kernel.org>; Wed,  4 Nov 2026 00:55:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CD3B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sudo5wuz
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cdb2dfcca94so73472a12.1
        for <ecryptfs@vger.kernel.org>; Tue, 03 Nov 2026 16:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793753734; x=1794358534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xG5t3xikeZrgWEXDIQ9E66WF0APj2TRUKkrk3j8LkpE=;
        b=sudo5wuzf8me28sIhbntLBwUiKNWuwSV6wtIncQpUBbsN4Zu1yMj1uOdtNMULS+qse
         p10GSTbsQZQej+RmcaRVIPfYXpiJc7DVP332tBPCeYi6iIxYHtw/pCGnwu6pUZaiYkuu
         1jzqj0fIApJI24vXlIZRW+4LFyo/2rv7mV5cIr8Gch74DjfIbhBYVLv8/dyYnqAxTrWw
         7/Kxsv4asQfbrP6PWPBOlk/xWVzyI0hLDQrJy+RjayW+oFANYAqhfVZpq60HUf6srI5f
         LvFF0LRAtEUesVRTlzKq8hIDxyh050q8ogJnunYhdFI0Mss29VGLQmid0PHrrP/vhgJw
         FudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793753734; x=1794358534;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xG5t3xikeZrgWEXDIQ9E66WF0APj2TRUKkrk3j8LkpE=;
        b=hqF+TUe5OJVDjXborEiCGhXo7v8O3P2wouRv8Ot4t57bOLinae/1vwGZN0gh9JYcTS
         jqycZcUXyfZB1tXhvPY1ZOgwkiOM+80qJ0sjRIwZGgtplhi8OL29yfMIQUtstf5afcHD
         bjbN5gNdhNSCIowgcQvytacrahmKhFq6CRNqn0ukUXNHb/7RQGkR8lWdtzHC/3VZzHAa
         UGBI1sCn4EnBV+h4D9X1U31NsbDvgNsoaOltIwZomesTILt0ied6pURnx/8xV5zOg/RG
         8GdsQ4Fqt5NjhGTAq5ETt/6KHa5WJmDVtg7ybYYIL25BtuWM6NLEvbpX9w+8xtBKI+fo
         xyaQ==
X-Forwarded-Encrypted: i=1; AKwUvBzZa8SuTRyhRtiC2hXNjbIpoH9JzgH2gvY7hfGkULreB1Pme2QEFHuapIT/q6GTt9i7InCKjOEdCw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+nuCDpGW3L4azS2D224qkSlidD5NqtNCXng/YnFtQ5I75un2FZ
	jkqN/orwq7H/r+3rcBQwPV71d8hqJjeoIy35/2amZBFyVIgxZ9DMs7IO
X-Gm-Gg: AYBFou2rJLBZrT4uKXlwhb3fDsX/wq4iR6e4yL/90Lp9LNbbcm+zymTvn11GetxYu3E
	lTORcxnWbtzPyLseIjcSZFaOYfufstHO1xuW8Z51meBJtdG4xBbLBQvIrqr+jSep56ATMSgUJpt
	ODV6zTMPNytvQ1cjoETP+1lG84lQO9Aapa5KL86a1sn4derenBiaAwlh9ki8hbO8C8ksLBZSztZ
	6hgNa7oNDCqJmmiRmIe5djRFQqAcmX198nkyCvXJlY5XfUzMQinkQ25XTSsLDAfGiU3jDPIbe5N
	g7aZCEWUtlFEIIeqg6Y+EENjM+kzlmWzlzWQHhUm1cLZ+PFm8pXiQrLy4GUx+pu9DjnJVtYuqdT
	8iwRL8PjeJRn7XvhhzsIQUtDWZHlwZLJcQ1y4rWwQ2CwQAgiJj/Gw+YuiEgDtNX1Qck2g4WShDs
	dYiGNQzD1KgRf14m+MwRDX7EMC3yN64IcjVR4OYfqaih6s6GYp8i/rsYogW4QpCosE0vkqXW20V
	1B3wBcInz9TG6J3ktqUvgfCFvi5ZwSmPbREFrK+UzP/n20DXgfF7NSMJwxepTELo2FTqUFmIpbj
	cj3JgLufo70P0hO6+Q==
X-Received: by 2002:a17:90b:184f:b0:3ac:83c1:2c0 with SMTP id 98e67ed59e1d1-3ae897e06efmr11479861a91.64.1793753733906;
        Tue, 03 Nov 2026 16:55:33 -0800 (PST)
Received: from localhost ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b09445f7b3sm1222403a91.5.2026.11.03.16.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 16:55:33 -0800 (PST)
Date: Wed, 4 Nov 2026 09:55:30 +0900
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, ecryptfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
	linux-nilfs@vger.kernel.org, exfat@lists.linux.dev,
	linux-mm@kvack.org, ntfs@lists.linux.dev,
	ocfs2-devel@lists.linux.dev, linux-btrfs@vger.kernel.org,
	gfs2@lists.linux.dev, linux-efi@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 18/34] ntfs: use the generic emergency read-only state
Message-ID: <auqCgguXEsKCq9p2@hyunchul-PC02>
References: <20261029-work-fs-sb_rdonly-v2-0-2f44f64f0b66@kernel.org>
 <20261029-work-fs-sb_rdonly-v2-18-2f44f64f0b66@kernel.org>
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Post: <mailto:ecryptfs@vger.kernel.org>
List-Help: <mailto:ecryptfs+help@vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ecryptfs+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261029-work-fs-sb_rdonly-v2-18-2f44f64f0b66@kernel.org>

On Thu, Oct 29, 2026 at 05:07:09PM +0100, Christian Brauner wrote:
> Set SB_STATE_EMERGENCY_RO instead of the NV_EmergencyRO volume flag when
> an error makes the volume read-only. ntfs_emergency_state() keeps
> telling a shutdown (EIO) and the emergency state (EROFS) apart so all of
> its callers stay as they are. /proc/mounts shows the volume read-only
> again.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

-- 
Thanks,
Hyunchul
