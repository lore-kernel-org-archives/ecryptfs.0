From: Tyler Hicks <tyhicks@canonical.com>
Subject: [PATCH 0/4] eCryptfs: Combine similar encrypt and decrypt functions
Date: Fri, 24 May 2013 17:05:07 -0700
Message-ID: <1369440311-10351-1-git-send-email-tyhicks@canonical.com>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:36700 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753641Ab3EYAFZ (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 24 May 2013 20:05:25 -0400
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org

This set of patches merges crypto code that does the same thing except for the
final action of either encrypting or decrypting. This makes maintenance a
little easier since, for example, there will just be one function that does the
crypto operations of extents.

Tyler
