From: Ivan Yosifov <iyosifov@gmail.com>
Subject: Re: Ecryptfs over sshfs and timestamps
Date: Fri, 3 May 2013 09:55:41 +0300
Message-ID: <CAHHtCV9YZCeuWaBpoSPBAKOg2RQBCWXOf4PhOQdsRjGtjh+s0w@mail.gmail.com>
References: <CAHHtCV9kvjbmUnH584HUaDLtVktjcP7fB1myWBx-kcsErF7zZw@mail.gmail.com>
	<alpine.DEB.2.10.1304211324450.13746@trent.utfs.org>
	<CAM-DUcOrs3vws+Vt9BWw29da8M_1LRwkrPHPF_eUc3Mz2a7ZaQ@mail.gmail.com>
	<alpine.DEB.2.10.1304211546110.13746@trent.utfs.org>
	<CAHHtCV8Efp+OJ3Rx54_d_dMcSvZnNxdodBK96hSj9=1iLUSB7g@mail.gmail.com>
	<20130423193016.GB7389@boyd>
	<CAHHtCV-1kwcXESyYLgm9-quTiZJ0XRZXqXcFgMT9pURB0Vw0Ug@mail.gmail.com>
	<CAHHtCV8PCU0v=96Oj8pP3seyh-out_2F=24ekBFio1k1zTwK6g@mail.gmail.com>
	<20130429012711.GA4925@boyd>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-vb0-f51.google.com ([209.85.212.51]:62146 "EHLO
	mail-vb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752537Ab3ECGzm (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 3 May 2013 02:55:42 -0400
Received: by mail-vb0-f51.google.com with SMTP id x16so1141037vbf.10
        for <ecryptfs@vger.kernel.org>; Thu, 02 May 2013 23:55:41 -0700 (PDT)
In-Reply-To: <20130429012711.GA4925@boyd>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tyler Hicks <tyhicks@canonical.com>
Cc: Christian Kujau <lists@nerdbynature.de>, Mike Reinstein <reinstein.mike@gmail.com>, ecryptfs@vger.kernel.org

Thanks, it works now. I was calling just "mount" as a user and not
"mount -i", it works with "mount -i".

I ultimately tracked down the utimensat(...) = EPERM problem to a
UID/GID mismatch between my machine and the remote one.
My local user is 1000:1000, the remote one is 1001:1001. When I just
mount the sshfs, I see all remote files as 1001:1001.
I can still access all of them, including the -rw------- (600) ones,
but apparently ecryptfs doesn't like this setup.

When I mount the ecryptfs lower dir with sshfs ... -o uid=1000 -o
gid=1000, cp --preserve=timestamps works, it doesn't matter
if I mount the ecryptfs on top as root (mounting as root requries
sshfs ... -o allow_root) or as the user.
