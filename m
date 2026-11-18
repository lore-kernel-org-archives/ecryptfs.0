Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795013245;
	b=j2/8rhNYAWquy1Pu7QX39wrOIn0Lr4KuvyqTyPffbpgH6q77DkfsYZmJ8IaXLTUSqpSr
	 prz6hKM6cmI0DMB5zhTKDOBAIa7P5IY7/v5SbGIT6m7tlVq78V67fGkdRN7SF1aQ6qVsx
	 QRralYER/U5FZsqR29bxO4vZlp3bAH/68/B92ii4yWPDD5oA/2ZkDku6X4Ou2GmyXtnfB
	 VOJT70SjQ1VutJfFKSl0cY2N6aahrJNXaxUwL4GTA5Qf9i2Uy/Myqoe2XLZvuLa11T3CW
	 /ejkAQVzH7EG1HwBvjwImnJaY1OiTHJVNw4jfVyjUDxa8DvAgHs0/vV79WDx2BrWgIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795013245;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=QjtwjAXLzVAkeUI468sdOh4Ry+JYmNENgammdBk2UjQ=;
	b=q4xe8NVLyvrVOpVW6Xg7hihala/poTOUyAzY/G0G2MVzqVRTVNFA0UorAMsDIIX9x/2k
	 Vy8bPlfFS/uB/oaPpIzTOwkAuowUGbyz4z4MLlGQFxWX8+7LG5rlzCTNahcELc/MkD1yf
	 N0Fx2ox7aZkhtp5m0WgMuh1+9HSxT0rCqcnuO5dumlq9BwOPu9vPrQkEY19To3m4dHAbF
	 o+0ZcCNMXI4sva0pfo0LPCR587r0UTrU9wckWEFASfe932iGhqtxu3J4ovs8PFO8jv90y
	 S3LMD0eZWvaCW58JDeZP4vRKlQRpYDf+B5D0pUQjuh4M9seXxNWe9aDsQP1USQR88Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kJM+pDoD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78C060A2613;
	Wed, 18 Nov 2026 14:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kJM+pDoD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 937D21F000CE;
	Wed, 18 Nov 2026 14:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795013245;
	bh=QjtwjAXLzVAkeUI468sdOh4Ry+JYmNENgammdBk2UjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kJM+pDoDRxgtwhCzQfXQ5UC4NnnmGnykkXnPnBnRMH+yWktHrQeyZ1+MeFTt6+TqP
	 mPumtkOYklH0RtSVnti2HuvgK6WEnByxXkFJYAdev53hdwg1Ku9ctOw2TaOclzJzdi
	 LMonSQ2XoD7Luwrj8BKJvorTW5u9wy2LCGEbzG0BZ21PaO1+LKx4+rQbR97zMQycFL
	 w2F55Jbu4plFJIZIhocCYgCSs2m3TIqvbO0KL6gtZ+0WN1O6dK1bwK/Dby7VNs45FQ
	 BhDZnWYPt+XZGq76PDlIFHPzHtwjw80TuTlweNKWSG2WiKnmVog+Ul1txctjEh5Pmf
	 pHH25Sl+HFQ1A==
Date: Wed, 18 Nov 2026 15:47:20 +0100
From: Christian Brauner <brauner@kernel.org>
To: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
Cc: Tyler Hicks <code@tyhicks.com>, Jan Kara <jack@suse.cz>, 
	ecryptfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ecryptfs: the lower filesystem gets modified while it is frozen
Message-ID: <20261118-irrwitzig-siegreich-linken-2d4d5fb446eb@brauner>
References: <20261114-kranich-banknoten-anheuern-5d0a2354a51d@brauner>
 <20261118130557.374-1-drifabdelmalekmohamedsaid@gmail.com>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261118130557.374-1-drifabdelmalekmohamedsaid@gmail.com>

On Wed, Nov 18, 2026 at 02:05:56PM +0100, Drif Abdelmalek Mohamed Said wrote:
> Hello everyone, I’d like to take this one unless one of you is already working
> on it.

Fine by me. Please make sure to de-slop commit messages though.
