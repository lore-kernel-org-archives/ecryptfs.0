From: Thiago Padilha <tpadilha84@gmail.com>
Subject: Storing the executable bit along with the rest of cryptographic metadata
Date: Thu, 31 Jan 2013 09:58:01 -0300
Message-ID: <CAAq2XdoN6E0xGyn-cVBTvVjmXZ7i2bpfDrdhC9FjB60_DPerWw@mail.gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:52998 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751766Ab3AaM6C (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Thu, 31 Jan 2013 07:58:02 -0500
Received: by mail-ie0-f182.google.com with SMTP id k14so2243823iea.41
        for <ecryptfs@vger.kernel.org>; Thu, 31 Jan 2013 04:58:01 -0800 (PST)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org

I'm trying to use a directory in a NTFS external drive as the lower
mount for ecryptfs, but since ntfs doesn't understand the concept of
executable files, every file is treated as executable by ntfs-3g

Is there a mount option to override the lower encrypted file
permissions by permissions stored elsewhere(perhaps in the encrypted
file header) ?
