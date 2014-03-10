From: zero <zero923@yahoo.com>
Subject: Erasing keys in ram
Date: Mon, 10 Mar 2014 13:03:51 +0000 (UTC)
Message-ID: <loom.20140310T134842-921@post.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:57173 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752698AbaCJNKG (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
	Mon, 10 Mar 2014 09:10:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfe-ecryptfs@m.gmane.org>)
	id 1WMzxz-00033m-JD
	for ecryptfs@vger.kernel.org; Mon, 10 Mar 2014 14:10:03 +0100
Received: from c193-14-110-229.cust.tele2.se ([193.14.110.229])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ecryptfs@vger.kernel.org>; Mon, 10 Mar 2014 14:10:03 +0100
Received: from zero923 by c193-14-110-229.cust.tele2.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ecryptfs@vger.kernel.org>; Mon, 10 Mar 2014 14:10:03 +0100
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: ecryptfs@vger.kernel.org

I'm thinking about using ecryptfs, to get encryption on top of zfs in linux.
I have a question about security though. I want to make sure that my files
are protected if someone gets to my computer after I have unmounted
ecryptfs, but before rebooting. I've read about the possibility of dumping
keys in memory to swap. But I think that this could be fixed by simply
running without swap.

I also know that other programs can write open encrypted files to /tmp, but
I'm not so worried about that since this can be avoided if you know how the
programs accessing your opened files work. What I am worried about is the
key somehow being around after unmounting. 

In an answer on crypto.stackexchange, Mike Halcrow says this: 
"eCryptfs makes no special effort to prevent key proliferation in memory.
You can see how bad that problem is by running eCryptfs in a VM, saving
state, and searching for your key material in the memory image."
But I'm not sure if this only applies when ecryptfs is mounted.

It might seem obvious that the key in ram will be erased after unmounting,
but it would be nice to get confirmation on this, and about possible leaks.
For example in the truecrypt documentation they explicitly say that: "When a
non-system TrueCrypt volume is dismounted, TrueCrypt erases its master keys
(stored in RAM)."

(I've also asked this question on crypto.stackexchange, with no answer so I
thought I should come here.)
