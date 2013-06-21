From: Leam Hall <leamhall@gmail.com>
Subject: ecryptfs on sub-directory?
Date: Fri, 21 Jun 2013 07:51:27 -0400
Message-ID: <51C43E3F.4030806@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:49479 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965513Ab3FULva (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 21 Jun 2013 07:51:30 -0400
Received: by mail-qc0-f177.google.com with SMTP id n1so4487886qcx.22
        for <ecryptfs@vger.kernel.org>; Fri, 21 Jun 2013 04:51:29 -0700 (PDT)
Received: from [192.168.1.55] (pool-108-44-69-203.ronkva.east.verizon.net. [108.44.69.203])
        by mx.google.com with ESMTPSA id 11sm5580993qek.1.2013.06.21.04.51.28
        for <ecryptfs@vger.kernel.org>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 21 Jun 2013 04:51:29 -0700 (PDT)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: ecryptfs@vger.kernel.org

Hey all, sorry for the newbie question. I didn't find the answer in the 
docs I found.

If I mount a filessystem on Linux, say /dev/sda4 as /opt, and create a 
directory under /opt; like /opt/backup. Can I use ecryptfs to mount 
/opt/backup onto itself so that just that portion of the file system is 
encrypted?

Thanks!

Leam
