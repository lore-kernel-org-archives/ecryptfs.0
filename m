From: CACook@quantum-sci.com
Subject: Re: Encrypting BTRFS Volume
Date: Wed, 5 Dec 2012 07:48:36 -0800
Message-ID: <201212050748.36206.CACook@quantum-sci.com>
References: <201212011306.59255.CACook@quantum-sci.com> <201212041005.10715.CACook@quantum-sci.com> <CACDOv80NnYPfy23JXLK9_RhdHw5_z+SC7bWhuy_B-FscGQEY4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from gateway08.websitewelcome.com ([69.56.224.29]:56719 "EHLO
	gateway08.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753796Ab2LEP5A (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Wed, 5 Dec 2012 10:57:00 -0500
Received: from getz.websitewelcome.com (getz.websitewelcome.com [174.121.36.226])
	by gateway08.websitewelcome.com (Postfix) with ESMTP id 6F1D1A7CD3CB2
	for <ecryptfs@vger.kernel.org>; Wed,  5 Dec 2012 09:48:37 -0600 (CST)
Received: from [67.183.170.11] (port=54344 helo=hydra.localnet)
	by getz.websitewelcome.com with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.80)
	(envelope-from <CACook@quantum-sci.com>)
	id 1TgHDA-0006FZ-PJ
	for ecryptfs@vger.kernel.org; Wed, 05 Dec 2012 09:48:36 -0600
In-Reply-To: <CACDOv80NnYPfy23JXLK9_RhdHw5_z+SC7bWhuy_B-FscGQEY4Q@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: ecryptfs@vger.kernel.org

On Tuesday, December 04, 2012 06:46:11 PM B. J. Potter wrote:
> I don't understand your situation well enough to say (I lack the btrfs
> subvolume knowledge). The encrypted part of ecryptfs is just a folder
> of files on your filesystem. You then mount the folder on your system
> and read/write to that mounted location. The encrypted files are
> transparently updated as you write to the mounted location. You'll
> have to apply that information on how ecryptfs works to your
> situation.

A BTRFS subvolume just looks like a subdirectory, except it has special properties to allow BTRFS snapshotting.  So I do a backup to /media/backups/droog/root and home, of droog's /root and /home.  The first of the month I snapshot the backed-up droog to /media/backups/droog-root-snap-2012-10-01 of the state of the backup on that date, and then I can always go back to that snap for a complete set of backups as of that date.  Files aren't duplicated, but are kept track of in a special way by BTRFS.
 
So /media/backups is my BTRFS volume set of four drives.  In order to make snaps, /media/backups/droog (and hex and so on, for my LAN machines) is a subvolume. (which just looks like a subdir)  Under backups is droog (current saveset), droog-root-snap-2012-10-01, droog-root-snap-2012-11-01, and so on.    So since droog is a subvolume it cannot be encrypted, nor can droog-root-snap-2012-10-01 and so on, because according to the BTRFS FAQ ecryptfs and volumes and subvolumes don't mix.  Below droog is root and home, which are regular subdirs and can be encrypted, but they are always snapped to a snap subvolume, and that doesn't seem possible since it would be bridging over BTRFS accounting.
 
 
