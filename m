Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F03F3B47CA;
	Wed, 15 Jul 2026 05:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784092877; cv=none; b=B44e7++w/+ZGmhiD4sYWArl2Fy9D3ME6qaq2wI2ammanpdmhcv0L340T+Z2gHBzvAQmIM4lBS09y/SIStEcascy15lO/7nyB7fDpY7F3kVj0lD/alVYNg16xwKhO9EoT5ls80UYuLnOredms0ktJfNwIGEUsmNNuHdmONxYvSV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784092877; c=relaxed/simple;
	bh=BW5l8JpwZ/fWzV8p1IcqMsDg3sy0nSdKcXpg5QNhl+o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Oxen3ylyc60/+1Wokm+f91zFtuaQGuBakPbRsoS8EEv9EfooipDek1/tFkd74ZHfq4WfCEdRkE0queKP3k+HY6Qj/SAz9pEoTSDCnZsGHouGbgrh81grf2au/vecwPvUMOZaquaBMJoiE0EjupthEfZZZ2m9+akDmOW3KsjNTt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=LsTPYDsA; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="LsTPYDsA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1784092828;
	bh=II1aUV74alZoNEi5sVDRjYv7/nIjyT/iW48HG4bjPnc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=LsTPYDsA0xH53f3SdJCcJsMWMyh2XtEJlruqAq5NmQwU+qony4Z+JEn+PT8RG4NRd
	 EtDZgIR8cAsQRqNaSM6bvxRD2IYIdhIy29Aja4UgGdqDNmp676QaPDeBUN6tLIHYFo
	 klVc9xLuNmbQajoSJ/xYYfYJzcnfuootzTd4uqPo=
X-QQ-mid: esmtpsz16t1784092810tc4803d5b
X-QQ-Originating-IP: t/7pzFmBTuNJbN+MMlrA5dse+PcNCjWBjrEWxepTFe4=
Received: from uniontech.com ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 15 Jul 2026 13:20:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10520566569480479763
EX-QQ-RecipientCnt: 9
From: Yichong Chen <chenyichong@uniontech.com>
To: ecryptfs@vger.kernel.org
Cc: Tyler Hicks <code@tyhicks.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Christian Brauner <brauner@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Yichong Chen <chenyichong@uniontech.com>
Subject: [PATCH v2 0/3] ecryptfs: split packet parser length fixes
Date: Wed, 15 Jul 2026 13:20:03 +0800
Message-Id: <cover.1784081896.git.chenyichong@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MShfLn39PbN2L4cz+vAK2f6dyOec+zdd4GuPKRMkIugK80VI3p2oHkZ0
	lChA60EJvmH/rO9LZnl1KWT86sDK8tr853/37pbKV6OuLUU8OWoRH4Wn+uTK2+qN31v7Eea
	egY/0JYSreg4E9sSc68vsVvIt+Nbh5ws3SOc5qaNqTnG0K5niI65n15oQXAeSw6TPeiu0bi
	hg6sZRMf4gm2u6iWom0HiMOfMjOVSvTSNidsBkcFAfIAWyiE3tC8ibilGqxVSfC9Bz9uc//
	Igx9dXYgYvI8pQI/7rvmX/dJz144De3lFTlpmZDJA1nrzueEa7J0MlVJSPn5pVX3MQYwnwa
	Mc/D1nOhWf/P3e2OABmG7Iap4Xn96OYzxr4+0RVc46NJ7CH7EYinecB5oBmRpG+WxARU7dF
	SW77+aVTaE2zfWrSJ7GOwgOzdBkIKeoll47SOWYojtgy/+704luHOKijUoehkVdJ7cDdocp
	AkxJ2O6jUElTRFNBwg0iw0Ha0MBN4uXfyNw4eKWqrvkB52tJepm2yJ/siA2i8sgQ5lhWpQ6
	Nhrbj5vgWYkw10MggIE2Fh55fSmQl0U+w8az0Xv20sWOoKG14CfhNEnSlOsiO3RBS+YyD+L
	UiWy9HLIr1kTCLFyuRJlmfNdGkVWzfmyRUNd1Hybtsksuof2aeVguwk+NfsLJqrld1cmSTN
	zK5fnYcQWtgzpym9zBYzTg9TKa5U94hjNTe4Ctqtg+euweJZBFhGrdlvqYav/af/SdSeNsd
	/CBR7G5CSSDuFuKXkpIEKu3Z0JkySpbFnkqeovk+rnzWIGq5rgVoCLaX5gTzH6o3NkYDFbu
	9S3+qyFuXqfHr0d+PrH6aykZMvOzgDouAUY/oLEeWlc7jA+BIzL/hVicfVIEo3STmBu819J
	fvZQWy3cAXP/vSCJw81WgJVTY4rhVi8uZWhDn3YjP9wH4nE1RZukjA/Q7kz93TCOn2URTDE
	EJ9W+dWB4Gw7rpEi0FhSJWKhMV7qg1ZkxSuE0dBDBtyGI/aQgqcSFsS59a43ca0meoGcLsE
	bz5sjlgL8tK39WsFT+8xwmVDHOGhAvx2dQzK0AsQSWXNcxTj4F
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

This v2 splits the packet parser hardening into three separate fixes as
requested by Tyler Hicks:

  1. pass the actual packet set buffer size into ecryptfs_parse_packet_set()
  2. fix the tag 11 exact-fit size check
  3. reject too-small tag 70 packet bodies before size subtraction

Changes in v2:
- Split the original patch into three independent fixes.
- Dropped the unrelated trailing blank line removal in keystore.c.


Yichong Chen (3):
  ecryptfs: pass packet set buffer size to parser
  ecryptfs: fix tag 11 packet exact-fit size check
  ecryptfs: reject too-small tag 70 packets

 fs/ecryptfs/crypto.c          |  2 +-
 fs/ecryptfs/ecryptfs_kernel.h |  3 ++-
 fs/ecryptfs/keystore.c        | 31 +++++++++++++++++++++++++++----
 3 files changed, 30 insertions(+), 6 deletions(-)

-- 
2.51.0
