From: Lance Reed <reed.r.lance@gmail.com>
Subject: Can anyone confirm or deny if ecryptfs will work with a glusterfs backend?
Date: Wed, 26 Feb 2014 16:06:20 +0000 (UTC)
Message-ID: <loom.20140226T165932-775@post.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:53032 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751981AbaBZQKS (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
	Wed, 26 Feb 2014 11:10:18 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfe-ecryptfs@m.gmane.org>)
	id 1WIh3c-0005zJ-Bc
	for ecryptfs@vger.kernel.org; Wed, 26 Feb 2014 17:10:04 +0100
Received: from 173-14-158-249-NewEngland.hfc.comcastbusiness.net ([173.14.158.249])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ecryptfs@vger.kernel.org>; Wed, 26 Feb 2014 17:10:04 +0100
Received: from reed.r.lance by 173-14-158-249-NewEngland.hfc.comcastbusiness.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ecryptfs@vger.kernel.org>; Wed, 26 Feb 2014 17:10:04 +0100
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: ecryptfs@vger.kernel.org

I am attempting to setup encrypted user home directories via eCryptfs using
gluster as a backend.

Very simple setup currently has a small two node gluster cluster mounted by
a separate client.  Normal gluster client and NFS mount / file options are
working fine.


e.g. https://wiki.archlinux.org/index.php/ECryptfs#Encrypting_a_home_directory

In my attempts lay ecryptfs on top of the mounted native gluster setup, I am
unable to edit a file, write etc.  I either get zero length or fixed sizes.

Only log messages I get are:
"Either the lower file is not in a valid eCryptfs format, or the key could
not be retrieved. Plaintext passthrough mode is not enabled; returning -EIO"

I am posting in this forum to see if anyone knows of any reason why this may
be failing from the ecryptfs side and I should stop banging my head against
the wall...

I am trying Centos / RHEL.
See these bugs:
Bug 762976 - (GLUSTER-1244) ecryptfs does not work when the directory to be
encrypted is on gluster mount
https://bugzilla.redhat.com/show_bug.cgi?id=762976

A non-empty file created on glusterfs with ecryptfs reports as a file of
size zero
https://bugzilla.redhat.com/show_bug.cgi?id=989702#c1

These look to be issues with O_DIRECT usage in fuse but are suppose to be
fixed now.

I was hoping someone might have an idea or remember some of this to help me
figure out if using glusterfs for a backend with  eCryptfs is even an option.

Is it possible that this bug is still the core problem?
"ecryptfs does not work properly over nfs, cifs, samba, WebDAV, or aufs"
https://bugs.launchpad.net/ecryptfs/+bug/277578
It is old but still seems to be open..

versions of the code I am using:
glusterfs-cli-3.4.2-1.el6.x86_64
glusterfs-libs-3.4.2-1.el6.x86_64
glusterfs-fuse-3.4.2-1.el6.x86_64
glusterfs-server-3.4.2-1.el6.x86_64
ecryptfs-utils-82-6.el6_1.3.x86_64
glusterfs-3.4.2-1.el6.x86_64


Thanks very much in advance for any ideas on the problem.


