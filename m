From: Ray Van Dolson <rvandolson@esri.com>
Subject: Active Directory Integration?
Date: Tue, 29 May 2012 15:51:04 -0700
Message-ID: <20120529225104.GA4091@esri.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from dwp.esri.com ([198.102.62.250]:35728 "EHLO bash.esri.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755995Ab2E2Xhs (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
	Tue, 29 May 2012 19:37:48 -0400
Received: from bash.esri.com (localhost [127.0.0.1])
	by bash.esri.com (8.14.4/8.14.4) with ESMTP id q4TMp4qU004142
	for <ecryptfs@vger.kernel.org>; Tue, 29 May 2012 15:51:04 -0700
Received: (from ray5147@localhost)
	by bash.esri.com (8.14.4/8.14.4/Submit) id q4TMp4f3004140
	for ecryptfs@vger.kernel.org; Tue, 29 May 2012 15:51:04 -0700
Content-Disposition: inline
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org

Hello;

I'm exploring using eCryptfs in tandem with Samba, winbindd and Active
Directory to automount eCryptfs-encrypted directores automatically
based on the AD user accessing it.

Is anyone out there doing something similar or am I barking up the
wrong tree here?

In addition, this conceptually makes sense to me from a 1:1 user to
directory or share perspective, but when multiple users are allowed
access to a file system it's not quite so clear how the implementation
would look (or even if it would be doable).

Thanks,
Ray
