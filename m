From: Zameer Manji <zmanji@gmail.com>
Subject: Inserting extra extents in lower file
Date: Thu, 18 Jul 2013 16:08:43 -0400
Message-ID: <CABtXzjQ5E0b+G++x8AmtSXJ7Nmns4j+f6cDNzzr4kfxmY=reWw@mail.gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-vc0-f182.google.com ([209.85.220.182]:58030 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933442Ab3GRUJE (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Thu, 18 Jul 2013 16:09:04 -0400
Received: by mail-vc0-f182.google.com with SMTP id id13so2693761vcb.13
        for <ecryptfs@vger.kernel.org>; Thu, 18 Jul 2013 13:09:03 -0700 (PDT)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org

Hello,

I've been working with Will Morrison to add the GCM cipher mode to
eCryptfs. GCM adds integrity protection to eCryptfs by also computing
a hash of the data. This hash is 16 bytes in size. We were thinking
about modifying how the lower file is structured to store these
hashes.

Currently the layout of the lower file is:

[Header Extent][Data Extent][Data Extent] ....

We would like to change it to
[Header Extent][Hash Extent][Data Extent] ... (256 data
extents)...[Hash Extent]...

Where [Hash Extent] stores 256 16 byte hashes, one for each of the
following data extents.

Where in the code base is the offset in the lower file calculated?
Currently we know that ecryptfs_write and ecryptfs_decrypt_page do
this and we were looking if any other parts of the code do that.

--
Zameer Manji
