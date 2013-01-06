From: Zeev Zilberman <zeev@annapurnaLabs.com>
Subject: eCryptfs ablkcipher patch
Date: Sun, 6 Jan 2013 15:36:38 +0000
Message-ID: <068EA2D22589DD4FBD9A55E6FF1EA0B50F1BF7B0@SIXPRD0211MB419.apcprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from co9ehsobe002.messaging.microsoft.com ([207.46.163.25]:53050
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756039Ab3AFPgo convert rfc822-to-8bit
	(ORCPT <rfc822;ecryptfs@vger.kernel.org>);
	Sun, 6 Jan 2013 10:36:44 -0500
Received: from mail179-co9 (localhost [127.0.0.1])	by
 mail179-co9-R.bigfish.com (Postfix) with ESMTP id 62BED900126	for
 <ecryptfs@vger.kernel.org>; Sun,  6 Jan 2013 15:36:43 +0000 (UTC)
Received: from CO9EHSMHS001.bigfish.com (unknown [10.236.132.227])	by
 mail179-co9.bigfish.com (Postfix) with ESMTP id E5C8BA80047	for
 <ecryptfs@vger.kernel.org>; Sun,  6 Jan 2013 15:36:40 +0000 (UTC)
Content-Language: en-US
Content-ID: <30FE97DC124F58448475403794353E49@apcprd02.prod.outlook.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: "ecryptfs@vger.kernel.org" <ecryptfs@vger.kernel.org>

Hello,

I've seen earlier discussions about ecryptfs ablkcipher patch, but I see
it was not merged.
Are you planning to apply this patch in the future, or did you decide to
drop it?

I tried to apply the patch locally and saw the following issues:

1. I've encountered a problem with ecryptfs_encrypt_extent_done that is
calling functions
that can sleep (kmap/kunmap). It fails with ablkcipher crypto drivers that
invoke the
callback from interrupt handler bh (tasklet).
Moving the write part to a work queue (using queue_work) seems to solve it.


2. I saw that ecryptfs was reverted from writeback to writethrough cache
mode.
This seems to be problematic in regard to performance while using async
interfaces.
The original change to writepage (that uses ecryptfs_encrypt_page_async)
allowed
submitting async crypto operations and continuing without waiting for the
result.
write_end uses ecryptfs_encrypt_page (and needs its return value), so
we'll have to wait
for encryption (and write) to complete before continuing to the next
operation.
Are you planning to return ecryptfs cache to writeback mode?


Thank you,
Zeev.

