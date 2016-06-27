From: Kenneth Tan <gmane@way-of-the-blade.com>
Subject: Re: Can't list directories with kernel 4.4.14 and ecryptfs
Date: Mon, 27 Jun 2016 22:46:56 +0000 (UTC)
Message-ID: <loom.20160628T004414-759@post.gmane.org>
References: <20160627182738.08737a6d@subnote.jensen.local> <57717C2C.4010708@canonical.com> <0A028742-6B46-49DB-900F-86CE85F320F4@gmx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:51985 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751888AbcF0WuI (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
	Mon, 27 Jun 2016 18:50:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfe-ecryptfs@m.gmane.org>)
	id 1bHfLy-00066a-A8
	for ecryptfs@vger.kernel.org; Tue, 28 Jun 2016 00:50:06 +0200
Received: from slackbox.way-of-the-blade.com ([192.81.129.220])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ecryptfs@vger.kernel.org>; Tue, 28 Jun 2016 00:50:06 +0200
Received: from gmane by slackbox.way-of-the-blade.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ecryptfs@vger.kernel.org>; Tue, 28 Jun 2016 00:50:06 +0200
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: ecryptfs@vger.kernel.org

I'm using BTRFS under, but same environment, when I upgraded to 4.4.14,
ecryptfs broke with the exact same response. Running Slackware64 (-current tree)

