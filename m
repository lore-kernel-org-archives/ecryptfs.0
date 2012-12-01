From: CACook@quantum-sci.com
Subject: Encrypting BTRFS Volume
Date: Sat, 1 Dec 2012 13:06:59 -0800
Message-ID: <201212011306.59255.CACook@quantum-sci.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from gateway15.websitewelcome.com ([69.93.82.23]:36399 "EHLO
	gateway15.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751251Ab2LAVec (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Sat, 1 Dec 2012 16:34:32 -0500
Received: from getz.websitewelcome.com (getz.websitewelcome.com [174.121.36.226])
	by gateway15.websitewelcome.com (Postfix) with ESMTP id 2E6E3C7E0C7A1
	for <ecryptfs@vger.kernel.org>; Sat,  1 Dec 2012 15:07:00 -0600 (CST)
Received: from [67.183.170.11] (port=44221 helo=hydra.localnet)
	by getz.websitewelcome.com with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.80)
	(envelope-from <CACook@quantum-sci.com>)
	id 1TeuH5-0000b8-Vw
	for ecryptfs@vger.kernel.org; Sat, 01 Dec 2012 15:07:00 -0600
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: ecryptfs@vger.kernel.org


My backups server has a 4 drive BTRFS array (2TB each), and is mounted on /media/backups.  Under that are BTRFS subvolumes named for the LAN systems they back up, such as hex, droog, etc.  Also under backups is where the snapshots are made, such as hex-snap-2012-10-15, droog-snap-2012-10-15, and so on.
 
So where can I encrypt?  Do I have to go in to each subvolume and make private directories for each of those subdirs like bin, etc, lib, and so on?  If so, how would I update the new snapshots which are created, for encryption?
 
It doesn't seem possible to encrypt a BTRFS subvolume, and certainly not an array?
 
 
