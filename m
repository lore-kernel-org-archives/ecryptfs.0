From: Ruben Gaspar <gasparuben@gmail.com>
Subject: Problem using ecryptfs on top of NFS
Date: Sun, 4 Aug 2013 21:20:01 +0200
Message-ID: <CAF_v8EnuFajjQ3BDTYQnqWpKdJbUh+APS51WyY09TNvzjkD=Xw@mail.gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-vb0-f42.google.com ([209.85.212.42]:38385 "EHLO
	mail-vb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753590Ab3HDTUC (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Sun, 4 Aug 2013 15:20:02 -0400
Received: by mail-vb0-f42.google.com with SMTP id e12so2157701vbg.15
        for <ecryptfs@vger.kernel.org>; Sun, 04 Aug 2013 12:20:02 -0700 (PDT)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org

Hi,

Sorry in advanced if this is not the list, please let me know where I
should post in that case.

I am trying to mount ecryptfs on top of an NFS mount, but I get following error:

Error mounting eCryptfs: [-22] Invalid argument
Check your system logs; visit <http://launchpad.net/ecryptfs>


Checking my /var/log/messages I found:

Mount request on top of filesystem type [nfs]
Mount on filesystem of type [nfs] explicitly disallowed due to known
incompatibilities
Invalid lower filesystem type

I am working on a redhat server:

[root@dbvrts1029 .ecryptfs]# uname -a
Linux 2.6.18-348.el5 #1 SMP Wed Nov 28 21:22:00 EST 2012 x86_64 x86_64
x86_64 GNU/Linux


This is one of the mounts I was trying:
 mount -t ecryptfs /ORA/dbs03/TESTINSTANCE/mysql /tmp/toto


Mount point:
dbnasg405:/vol/dodtest03 on /ORA/dbs03/TESTINSTANCE type nfs
(rw,hard,nointr,rsize=32768,wsize=32768,tcp,actimeo=0,timeo=600,addr=172.31.132.3)

And libs:
[root@ .ecryptfs]#  rpm -qa | grep  ecryptfs
ecryptfs-utils-75-8.el5
ecryptfs-utils-75-8.el5

Thanks for your support,
Ruben
