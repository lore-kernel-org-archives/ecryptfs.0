From: "B. J. Potter" <bjpotter@gmail.com>
Subject: Re: Encrypting BTRFS Volume
Date: Mon, 3 Dec 2012 09:41:09 -0600
Message-ID: <CACDOv81k0-jji9Jkz=pSQt9kc7GmPx7dLDoYSMzDxgCdf=J5kQ@mail.gmail.com>
References: <201212011306.59255.CACook@quantum-sci.com>
	<201212030701.38614.CACook@quantum-sci.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:33389 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753172Ab2LCPlK convert rfc822-to-8bit (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 3 Dec 2012 10:41:10 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so1123656bkw.19
        for <ecryptfs@vger.kernel.org>; Mon, 03 Dec 2012 07:41:09 -0800 (PST)
In-Reply-To: <201212030701.38614.CACook@quantum-sci.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: CACook@quantum-sci.com
Cc: ecryptfs@vger.kernel.org

Ecryptfs is not made for volumes. You make a folder that holds your
encrypted files. Then you mount it at another location that's in the
clear. Perhaps your looking for full-disk encryption instead of
filesystem-level encryption. Here's a note from the btrfs wikipedia
page:

The current recommendation for encryption with btrfs is to use a
full-disk encryption mechanism such as dm-crypt or LUKS on the
underlying devices, and to create the btrfs filesystem on top of that
layer (and that if a RAID is to be used with encryption, encrypting a
dm-raid device or a hardware-RAID device gives much faster disk
performance than dm-crypt overlaid by btrfs's own filesystem-level
RAID features)

B. J.

On Mon, Dec 3, 2012 at 9:01 AM,  <CACook@quantum-sci.com> wrote:
> On Saturday, December 01, 2012 01:06:59 PM CACook@quantum-sci.com wrote:
>>
>> My backups server has a 4 drive BTRFS array (2TB each), and is mounted on /media/backups.  Under that are BTRFS subvolumes named for the LAN systems they back up, such as hex, droog, etc.  Also under backups is where the snapshots are made, such as hex-snap-2012-10-15, droog-snap-2012-10-15, and so on.
>>
>> So where can I encrypt?  Do I have to go in to each subvolume and make private directories for each of those subdirs like bin, etc, lib, and so on?  If so, how would I update the new snapshots which are created, for encryption?
>>
>> It doesn't seem possible to encrypt a BTRFS subvolume, and certainly not an array?
>
> Anyone here?
>
> --
> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
