Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9CF39EF2E;
	Fri, 21 Aug 2026 20:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787344049; cv=none; b=pPndxjNMgNKDcKoS9tOaf5F8KZzRArpWzgLqDtDKs8R/Lbb5haMQC3nyCVdnQH4Q7QRllzNUDokYdCiU5v5m0hoUDordJREPTneVjGORVJIxilIoA0IQjdwaFFUvr0ciYZJK2lz61naKJ+jY+uT3Ui79AY2qpOwfL0nLaODd4Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787344049; c=relaxed/simple;
	bh=l/8KVJQuLdG+c/F4TiL3p+kmSAMKFe2QEfKB8wYWhF4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=O7cehTvFf15G7SK9jd4n4ZO3zYt7VODzhlruq8/WkdtLgfNxfHsYTZxMx42SGnsPvmqQdg5FplhRvn0sNtkLBMNrzxhwm0IdAmTcXn5dLYVJ9/eNXfGTxZjovVky5iCkps2dUqj/RsV5E2kWk2JCDI6wL2Nl2pkZZRiViDGGLPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsgdxSwG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsgdxSwG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D1B51F000E9;
	Fri, 21 Aug 2026 20:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787344048;
	bh=+SpoTjZZuQ4mQMpYoGdrqNgNxjU+5DwWNLM7PL6Tq0g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=EsgdxSwGX2Mel0EMtxnuZqsnSKSl86dNW6jspV+5g5YuXDsQjrQjlHtRZDOXSbLAE
	 KuqQNg+PCO9wRcIQB8WnpHSE+c6CQlXPm17EAggg+CNYJ3ixi1zjc1KrOzuoZn8djB
	 zSQieE6jnMqIw1SWe/VuI1izx7aXHslGc2DfguEPOaWwtaTsUVU1sGd7lWnV0ooBXv
	 BZo38hKsU/ZPARgboiyuLm+4kwbglYsrSZImdfPZza9V7JLslFb/IU1the8OSR0mcw
	 ccCnWvRi98ya0i4TWVNDkawhiu7E0lMpFEOASbZMvem4zmbQs4pBraUAEFICpObJ3Z
	 8UBFZYOkO452g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19893380CEC4;
	Fri, 21 Aug 2026 20:26:39 +0000 (UTC)
Subject: Re: [GIT PULL] eCryptfs fixes for 7.3-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aoeaX-Z7eSZuYP1A@elm>
References: <aoeaX-Z7eSZuYP1A@elm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aoeaX-Z7eSZuYP1A@elm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs.git tags/ecryptfs-7.3-rc1
X-PR-Tracked-Commit-Id: f81cb44f9a4b88d73ee5dec4a1ccdb0232fd2e3f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: af33c5a2a9fd52f07ffb428255b7f060da1de49d
Message-Id: <178734399770.1471056.5294871781122668736.pr-tracker-bot@kernel.org>
Date: Fri, 21 Aug 2026 20:26:37 +0000
To: Tyler Hicks <code@tyhicks.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, ecryptfs@vger.kernel.org
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 20 Aug 2026 19:22:55 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs.git tags/ecryptfs-7.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/af33c5a2a9fd52f07ffb428255b7f060da1de49d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
