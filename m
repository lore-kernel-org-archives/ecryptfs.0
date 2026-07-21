Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3FA11CBA;
	Tue, 21 Jul 2026 07:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784618985; cv=none; b=RWNIIBkGxADJa5m+ERvGfba2bmwgUyyVcsZ98Mhagt+0FjNn7a2fZkzVG0mPsRbGYE3ADdvOx9AdL6G7De5RHnaSdAlXZ0V98PqUYTfeQdv7Nj64vT2Njh5QvK9Cit/iLH/5GsfvRX9WLiGYigkjtk5066SbHxYjU3g/mGyXn7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784618985; c=relaxed/simple;
	bh=IgGdqLfl+x5adjoZE1tQ7U0YxQbyGzU9ZVc5thzbuyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxEKIzaMFHR5+KxxvalkoMEgsfx/VYDAeA1xQy0gHuXD/F809XruleArXPETgj/qvUd/SUWmMCGDQXC/g+jboYtPKt2rOyJ7ia0u5O83N2yRnn1Tt4LtDm6Tmh14aHnclqoCCEqEeSoaNRZKq2kUdVOSaWCZObJbljFv/AmScwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com; spf=pass smtp.mailfrom=tyhicks.com; dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b=pdEvipbw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ewifRoO2; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b="pdEvipbw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ewifRoO2"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id A9A271D000AA;
	Tue, 21 Jul 2026 03:29:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 21 Jul 2026 03:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784618983; x=1784705383; bh=ERuKVpjJeb
	yXom0velq/c0uFwX4akCilJf4GU4F3Ndc=; b=pdEvipbwv8Ez0/IZi5lltnsJzg
	0WczH6gupHxaabAP8g0nQFldB3tk8nJX7ik4/ywq9wITS+EGSP/BmNZ3GRqDRx22
	HSvXj1k/XJulVB+MnitsWlrQ5CQAVpIncXS8uRl85CgSUYpEWSpZ7HuMDk9YH7T1
	5mDZK2bM6l71772ioxIM7Wy0zxPz0QfCD6ktk5izVskXLRoUI+67d51tOuy8eQAr
	OfXguFpszpoYEIG3v9c1mE/+k7yoFrYhCwIiQb/daGQehnGqkPkMff6HV8BuCVjp
	5UUZfJ4IK6iXoBoaZlQuO4T9Gau0HtJnR1a+9VJ4VxkSTNydBD60EjuFaVXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784618983; x=1784705383; bh=ERuKVpjJebyXom0velq/c0uFwX4akCilJf4
	GU4F3Ndc=; b=ewifRoO2V64MeEyqnnnLfBq0120oYvLDEfnef8TPAL3jJoSKQia
	Gf1NO+kDNWI3djneypIMJrrT0UKC18W+D/qCJjJAPk19xPvihwOOkF96IGXI0OVI
	rI7XJY7JS1KXRzZUvdlVRq1H1WvbKXTc/8ok/Vixxy20Uj8nzmB2T75FGQzYFKiE
	sxxFbceWwrKftMoiebxld3zxE+V3d6tldZ/ObQt3AWtU66J8KhyhYo9rve0RImOx
	xTPLqIwfcOimPdErGqxgav3P9OocinuxIp+IeZAd9q/4pARqYJd8GG2tR6euUHC1
	Cnt6ZMqogWykFVuWM/PGQvGTtP56Brhj0/Q==
X-ME-Sender: <xms:5x9fakME1Rv-0fPC3YbgB8Sq4bA5GdruPRqGJtj74ob40_HLv0VJiQ>
    <xme:5x9fak8gNLj2YywTEgAGHmBpBuO8cJjj6yPIJ5Tfl1bUIy_mS-KXSAGc-RB-CMeOd
    ujWsxyTL1P5t4HvcFSGY1sbNMjpkhCh19CVkDme6Z0tQqtM_isfCw>
X-ME-Received: <xmr:5x9fah5KS7aM6R03Fh-w1sIxoRBd7-3CEhmlIeRjKzR-A9u3Iko3ng>
X-ME-Proxy-Cause: dmFkZTF9MoZDb1Ndu6a63oM0QMIElyfsdCseRDaq+6Su2Bm3fZAbqZDIfVfHWH5lLN/bXo
    W8hsb3zlSgkQATiQN6VfFfntWV9FpYDnud4WE66cdqWuYCt3cdcuvoaGpJhf5QTE/AEgLC
    KdF1x4tcuwImVUDA1mDh64eHFfxXGu2DVcrTfmzNV1ptN5LkY5N3SERaP8EdT5pyJhwJtf
    W8V8Rer7Br4EpMhCqaQ94+3U79q1YgwZLYZwPXlfeVMueEHo8SSRll+XBsA/ORsWCcXSXr
    xqGD2LVMDYaQAkp+Jn8P3DlX6j8crYk6i0cz6h4FLpJQdWLMGfoA1y+GRHTzBToAE476l2
    a8iGsOKtHYlkYcyWbXcVbZGGES3rib0nRLuMD98F9bqj6SSnrlo4WOnAPrW2SuAO3DRe9O
    EplqXf2hqxwx8AMC8R7TLuTd4gUMVygrN5PX4SQCFK1UTf7/LYTcJu7q5f35uRRvtZlULe
    kix4tDm4yMkC1cD7UMxmasJOYpbz7MW83dQp/MnKFj18Cd49efFV+pPnqLC5MTc0/BlJ+z
    gDh3sMmbaPcoS0Igsr9TzLc+BlsKqha7w67wlzi2PzFF4QDhDGvoMIn2PLBQhZl4MogU5v
    xm28g/oTt+Valp9fAPXUYxpEnkyg9dhEkQqXDJJTXW9XWmcGV1oHapLx7FYQ
X-ME-Proxy: <xmx:5x9faq6ABXvhH0gDmtpw_sgMytytR8sPqlqJvbDEoGsE5lxL4O6veA>
    <xmx:5x9faqpuH1rNZG3khul0QEb1LiC3thPyStK6LYazb8pj--oJkPokpQ>
    <xmx:5x9farO6OkA5JXQ_TgQHDNbrrMFoJswVRDM8kuaoxAKmC2A2Q1iG_g>
    <xmx:5x9fai0l4Ppk5FJ46NCswCGJUCD0KlsnGWUzGAwfD5oyroE0bajbXw>
    <xmx:5x9faqpionu2Qrqxsm-MyJnEE5viAHvMlHA16I-iKbjfy_8A4wHoaQwt>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jul 2026 03:29:42 -0400 (EDT)
Date: Tue, 21 Jul 2026 02:29:38 -0500
From: Tyler Hicks <code@tyhicks.com>
To: Yichong Chen <chenyichong@uniontech.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Christian Brauner <brauner@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>, Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, ecryptfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] ecryptfs: split packet parser length fixes
Message-ID: <178461835000.30963.1159903948163576972.b4-ty@b4>
References: <cover.1784081896.git.chenyichong@uniontech.com>
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1784081896.git.chenyichong@uniontech.com>

On Wed, 15 Jul 2026 13:20:03 +0800, Yichong Chen wrote:
> This v2 splits the packet parser hardening into three separate fixes as
> requested by Tyler Hicks:
> 
>   1. pass the actual packet set buffer size into ecryptfs_parse_packet_set()
>   2. fix the tag 11 exact-fit size check
>   3. reject too-small tag 70 packet bodies before size subtraction
> 
> [...]

Thank you! They've been applied to the next branch of the tyhicks/ecryptfs.git tree.

You can find a direct link below but please be aware that the commit hash is
unstable and, therefore, the URL may not be valid in the future.

[1/3] ecryptfs: pass packet set buffer size to parser
      https://git.kernel.org/tyhicks/ecryptfs/c/2602b79c5b3e2f6fce12e38a670f8e3fda4e46a2
[2/3] ecryptfs: fix tag 11 packet exact-fit size check
      https://git.kernel.org/tyhicks/ecryptfs/c/8b2ec0f56f55477f547d332526c9ae2a8fabc0a5
[3/3] ecryptfs: reject too-small tag 70 packets
      https://git.kernel.org/tyhicks/ecryptfs/c/e97bbe1b2bd82ec2ae37ad2e4965b4d3e78bbf7f

Tyler
