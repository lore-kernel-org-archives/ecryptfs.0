Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4413B5311;
	Mon, 20 Jul 2026 09:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540265; cv=none; b=nXKut5gFF0ILDfKdBjak/o4hlwG5UmX0y2/DM3WT7tzGYDwtc0Apnq8+yJ1sWtjZsxNDoAWT38oWjoA1IpUWqfffD0jj35cd9EAX71nbBXBhuro512J5aWGt76HgEvO+TXwqdLniZm0V8dQD3brX7mrmPtWC7nb4hmHMxJWbE08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540265; c=relaxed/simple;
	bh=cfGVbgZ8NUZIYiMTVNTF4XLdnC8rVmGIsuTJ4zdgnR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J1ab9qIvgFAOAJ4Y2Wj4f99nbS70gfrpccOFDcE4rXn67XkJEd05hpj6SdZVzBzGuK9LjdTGGC2uDi+P5QEJ3gCWTN0JCu6OrqVCYQaqpWShIHqY4glxmb0CZ2PKKOCs3WItwe2g+zIFT2/Fp4bDfnHUrIbebztYM748tC74iPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=LExLsdeT; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="LExLsdeT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1784540220;
	bh=v8f5NKx4BiaUdR4GrADqdqycRxj0QuWqW92wsJ7QUho=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=LExLsdeTWiu0Q78phHPR+XNI5dPP+h0/Fzyw5xGx0gFbWQqoc8gc0aFDlQcNTxMPJ
	 f4F+WAw41hiJ9ZDju90FwQaNKHiisGI4yGfeOXT3+LJkp0i+MXNoJHSGKJm8DusvBX
	 7KJoT94cY1fI9rc7pco02h1PCOFIOXX+9P9NghWY=
X-QQ-mid: esmtpsz11t1784540203t6df4d501
X-QQ-Originating-IP: 0nf/Zr7f8VzX6AeDDwWmg+gRd6t6LaDxNUYgRiPxr0E=
Received: from uniontech.com ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 20 Jul 2026 17:36:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9917064477034960057
EX-QQ-RecipientCnt: 8
From: Yichong Chen <chenyichong@uniontech.com>
To: code@tyhicks.com
Cc: chenyichong@uniontech.com,
	akpm@linux-foundation.org,
	ecryptfs@vger.kernel.org,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	mhalcrow@us.ibm.com,
	thorsten.blum@linux.dev
Subject: Re: [PATCH] ecryptfs: hold msg ctx list lock when cleaning daemon queue
Date: Mon, 20 Jul 2026 17:36:40 +0800
Message-Id: <20260720093640.1394203-1-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <4C38E7F6BF114337+20260628033725.11296-1-chenyichong@uniontech.com>
References: <4C38E7F6BF114337+20260628033725.11296-1-chenyichong@uniontech.com>
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NKv2G1wnhDBnRQpaMn2htVWT4T0m/inbEc8VHovNkx6Fi44nCQOkUlJP
	+tVrpx9NqzrDyGEO4YDu0pPr267aIDN2CaJSdpBdtEYfEOhK5JtQ/JV7QwNugZONCN/Ipg9
	GoFV1YwLA3zXyMjIh1Y/6G/e099mvUOB2+Ed2ah9OpbRf578nqD9wH05SO8qo6wE8MKpErY
	FxcYUP/g8Gg/QlbQVRPldW9XuaCTiRgLyWMmmjoVQ9l0jkOdyHx41h4+gKK5QPvC7l/EbR9
	aaq1Nx0zDI9VbCPtGCiX645knSSS9mTDEFGRBTk4MJMwCHqQgMDQ6YNYwwCcD92+WA/GCbe
	Itf3bRd4anrMCUHoeqbZGSLjv5RkVDtT65Age8oJ5S2xWJqb8VbWY8Uu7XBF3yAVBkknjes
	nO9q2bMzlUAB/+9zPya51dR6MmUwbTrdAWhbDZlBmFZpFO1qHrnR9gxRCMPorMJmKPf4S7n
	Lb/dHfux/7t6zlpCddw3o9ht/3D0OVeGwhYqU4CG5j35eazlV1/ah4Mng4tt3Im7bscMA+g
	d89cyijhmSPNDJCrJZFM4wZKTrj0vY9q/auvlTdeASjk71G5Kcnc4k4JX/g7masDkfpVra7
	KUnHgrxJIbziVy0fNMnvZml9Xll7GKPH9sgCr2EXgJDvvAYMBgWkWqpwlET/NUkUFc4tF5S
	ADhmaVaro1v4GxPPl63U+yJPYgeJJBAWO2Om6bqyAwQm2kKvIZV2OHi3qjIQVz96YdIMww6
	hrj5ZvqGR7Lx+cWrvAYrsp6h0rX3YBhvXzKfI5JR0FdoXpOo8yrW2c1QzxeDZmEvv3ocgNZ
	CXGoVZM3/CT0uw+8c5te5fJNeb9iO2mqqGuNQAPhBPJbmHSoesYq3c4qjL/IZkGjNNv1xLZ
	9GHKye1iork+I1tloV6C0aM89urfkfXn9qIwv8aQrsp/0qPV4iBH9Zo0di2vI9gOjiZwuSl
	TZqjg3z3qWuH3BsWyXqxr3sCUOaA1gqcXavujOgI4Ka10DrbTdj+tuNMTM5Zbayc2paUsZ8
	e0m02AkJMOtN4JoSczA1JZuHRU6FC4pprfVGCmjA==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

Ping.

Could anyone take a look at this patch?  It fixes a missing
ecryptfs_msg_ctx_lists_mux lock on an eCryptfs daemon cleanup path.

Thanks,
Yichong
