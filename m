From: Henry Jensen <hjensen@gmx.de>
Subject: Can't list directories with kernel 4.4.14 and ecryptfs
Date: Mon, 27 Jun 2016 18:27:38 +0200
Message-ID: <20160627182738.08737a6d@subnote.jensen.local>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:57080 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751639AbcF0Q1m (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
	Mon, 27 Jun 2016 12:27:42 -0400
Received: from subnote.jensen.local ([84.172.166.114]) by mail.gmx.com
 (mrgmx001) with ESMTPSA (Nemesis) id 0MWCgz-1aoeUF2ZWz-00XJad for
 <ecryptfs@vger.kernel.org>; Mon, 27 Jun 2016 18:27:38 +0200
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: ecryptfs@vger.kernel.org

Greetings,

I'm using ecryptfs with Slackware current and kernel 4.4.14. In kernel
4.4.14 was a patch introduced which make it impossilble to list the
contents of a directory.[0]

The mount itself works, but listing a directory results in an error
"wrong medium type". Showing the contents and the file itself (presumed
the name of the file is known) works.


Example:

henry@subnote:~$ ecryptfs-mount-private 
henry@subnote:~$ echo "foo bar" >Private/foobar
henry@subnote:~$ ls -l Private/foobar
-rw-r--r-- 1 henry users 8 Jun 27 18:13 Private/foobar
henry@subnote:~$ cat Private/foobar
foo bar
henry@subnote:~$ ls Private/
ls: cannot open directory 'Private/': Wrong medium type
henry@subnote:~$ cat Private/foo*  
cat: 'Private/foo*': No such file or directory

henry@subnote:~$ ls .Private/      
ECRYPTFS_FNEK_ENCRYPTED.FWZL6yY3cgf9JkRRDnGzSkFOIUQir-xo2KY6u52Ft53bpb4SnqMhgeIIl---

Output of dmesg:

[  946.181961] Error opening lower file for lower_dentry [0xffff88008d532180] and lower_mnt [0xffff8800bbf90f20]; rc = [-124]
[  946.181973] ecryptfs_open: Error attempting to initialize the lower file for the dentry with name [/]; rc = [-124]


See also [1]
[0] https://www.kernel.org/pub/linux/kernel/v4.x/ChangeLog-4.4.14
[1] http://www.linuxquestions.org/questions/slackware-14/can%27t-access-ecryptfs-with-kernel-4-4-14-a-4175583163/

Regards,
Henry
