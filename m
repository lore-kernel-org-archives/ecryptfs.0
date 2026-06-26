Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E2C72617;
	Fri, 26 Jun 2026 15:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782488756; cv=none; b=l05++obeKrZ789mgZS5/AzjP9/s4XJv9T+boO4jAwKd2agf2ULS1z5WjC0UzpAqpsMDf/qyZNqUvygkqAI2lSfNf6+YjL/3ENLYZB8+bWvlq+nQUBM14FrDLEqEI9iNLOw4HPE1VK0xlZk7a4yZulwA2qE9jy2kAOi2HNj7joTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782488756; c=relaxed/simple;
	bh=lZ0qGT8ycdrerRQQyPFM2rLjJgpkPORXxs5kFP0mVyE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EFx0IFX3A4Wb69MOFJh5rbz863r1cZHDzlmq73ktgJJSG3mB2T/NfYMifDjUcgXKg8t6ulsMkbyU1YFQwkNIRORQNIitgc1QDE4QusyLoS8qxaknPI+wH26kINJLVCpHBwJG74NMwriFpKUdwsoWAJ8bhE/zcqoOjTSzbOEsOKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsRCvcpT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsRCvcpT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167211F00A3A;
	Fri, 26 Jun 2026 15:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782488751;
	bh=8hSbtc28PUOiQrnJlOpaCH8H9EVFwcp777PmMYdmODk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=NsRCvcpTH/7goJl91Mo1ZQKeDYEBE+Jws7KYMZls5efl0LHMgRA0c98g5uSaFmG3w
	 osxJP2dD74VLb8ytJ2G+Sv3kCHLaDIQ9YA077Bh9bqNmoHkeGKKNLoR61/u7VTEHhx
	 glTcLPXMYrdmG4IESsOTrYJq2AFHTOiqdYnsKPqZZFc1QCHXG2Fk1Ld2LIRVHWQdxn
	 5YnBEDX9EOAuq04JDKZhbZg10SEhjOwUVZUBWL3PwilhhcT2UF5F52MbqnjHXdBSmC
	 /Qn2zmboZ9pjCGlyL+CJzJi16gCiN6htxB1J0VGnCYGCjuiWqWTgQ/J0rLwrJE6rUt
	 SOVAGxFMZN5cA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198603938C49;
	Fri, 26 Jun 2026 15:45:39 +0000 (UTC)
Subject: Re: [GIT PULL] eCryptfs updates for 7.2-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aj3p8nYWZPTbkUWW@yaupon>
References: <aj3p8nYWZPTbkUWW@yaupon>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aj3p8nYWZPTbkUWW@yaupon>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs.git tags/ecryptfs-7.2-rc1-updates
X-PR-Tracked-Commit-Id: 95ce5ffd54cf66098f91892f98606c3bd33846fe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c292ea294dde77ae442d3d764f53c251d2d6df90
Message-Id: <178248873773.1001923.6407573170334196525.pr-tracker-bot@kernel.org>
Date: Fri, 26 Jun 2026 15:45:37 +0000
To: Tyler Hicks <code@tyhicks.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, ecryptfs@vger.kernel.org
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 25 Jun 2026 21:54:42 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs.git tags/ecryptfs-7.2-rc1-updates

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c292ea294dde77ae442d3d764f53c251d2d6df90

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
