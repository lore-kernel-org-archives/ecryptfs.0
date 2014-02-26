From: Wilson <wilson.ubuntu@gmail.com>
Subject: Automated home encryption and noexec mount option
Date: Wed, 26 Feb 2014 21:07:12 +0100
Message-ID: <1393445232.14817.0.camel@sen>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:59917 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243AbaBZUNF (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Wed, 26 Feb 2014 15:13:05 -0500
Received: by mail-pa0-f48.google.com with SMTP id kx10so1444337pab.7
        for <ecryptfs@vger.kernel.org>; Wed, 26 Feb 2014 12:13:05 -0800 (PST)
Received: from [127.0.0.1] (manning1.torservers.net. [96.44.189.100])
        by mx.google.com with ESMTPSA id qs1sm6163536pbb.18.2014.02.26.12.06.21
        for <ecryptfs@vger.kernel.org>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Wed, 26 Feb 2014 12:06:23 -0800 (PST)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: ecryptfs <ecryptfs@vger.kernel.org>

I'm using Ubuntu 13.10 and the integrate home encription via pam and
eCryptfs.

For security reason I've mounted /home with the noexec mount option, but
that don't affect users with encrypted home (since it's mounted
separately at the user's login): how can I set the automatic mount and
add the "noexec" option?

I've googled a lot and searched the system for a config file or a script
to edit, but to no result, so asking here is my last resource.


Thanks very much in advance

Wilson
