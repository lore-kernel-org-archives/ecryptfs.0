From: Tyler Hicks <tyhicks@canonical.com>
Subject: [PATCH 0/5] eCryptfs: Clean up usage of helper page for crypto ops
Date: Fri, 24 May 2013 16:55:53 -0700
Message-ID: <1369439758-10261-1-git-send-email-tyhicks@canonical.com>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:36646 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514Ab3EXX4W (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 24 May 2013 19:56:22 -0400
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org

This is a somewhat related set of patches that scratch some itches that I had
after working on the migration to the ablkcipher API. They all relate to how
eCryptfs is using the "helper page" during crypto operations. The helper page
is the intermediary page between the lower encrypted page and the decrypted
eCryptfs page.

When decrypting, eCryptfs reads from the lower filesystem into a helper page.
Then the helper page is decrypted and the result is stored in the eCryptfs
page.

When encrypting, eCryptfs encrypts its page and the result is stored in a
helper page. Then the contents of the helper page are written to the lower
filesystem.

It is slightly more complex, as crypto operations aren't done across the entire
page (that's where eCryptfs "extents" come into play). But the focus of these
patches is how we're utilizing the helper pages.

Tyler
