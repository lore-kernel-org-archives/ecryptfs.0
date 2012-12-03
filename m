From: "B. J. Potter" <bjpotter@gmail.com>
Subject: Re: Encrypting BTRFS Volume
Date: Mon, 3 Dec 2012 11:04:38 -0600
Message-ID: <CACDOv81f5YRbrYCwLOMggoHCz9qy0z41DQEDDEqRQbTRJZ7oPg@mail.gmail.com>
References: <201212011306.59255.CACook@quantum-sci.com>
	<201212030701.38614.CACook@quantum-sci.com>
	<CACDOv81k0-jji9Jkz=pSQt9kc7GmPx7dLDoYSMzDxgCdf=J5kQ@mail.gmail.com>
	<201212030839.12613.CACook@quantum-sci.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:46551 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754000Ab2LCREk convert rfc822-to-8bit (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 3 Dec 2012 12:04:40 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so1176938bkw.19
        for <ecryptfs@vger.kernel.org>; Mon, 03 Dec 2012 09:04:38 -0800 (PST)
In-Reply-To: <201212030839.12613.CACook@quantum-sci.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: CACook@quantum-sci.com
Cc: ecryptfs@vger.kernel.org

OK. Here's an option. Rename your mount /media/encrypted. Make the
ecryptfs directory there. Then mount that through ecryptfs as
/media/backups.  You are necessarily going to lose some btrfs
features, here you lose subvolumes. You could set it up differently
depending on what features you care about. You might also consider
ZFS, which I think is better designed/implemented than BTRFS (but
comes with other problems).

As far as ecryptfs goes though. You just make a folder on some device
(be it a subvolume, normal filesystem, whatever) and then mount it.
Use that wherever you see fit.

On Mon, Dec 3, 2012 at 10:39 AM,  <CACook@quantum-sci.com> wrote:
> On Monday, December 03, 2012 07:41:09 AM B. J. Potter wrote:
>> Ecryptfs is not made for volumes. You make a folder that holds your
>> encrypted files. Then you mount it at another location that's in the
>> clear. Perhaps your looking for full-disk encryption instead of
>> filesystem-level encryption. Here's a note from the btrfs wikipedia
>> page:
>>
>> The current recommendation for encryption with btrfs is to use a
>> full-disk encryption mechanism such as dm-crypt or LUKS on the
>> underlying devices, and to create the btrfs filesystem on top of that
>> layer (and that if a RAID is to be used with encryption, encrypting a
>> dm-raid device or a hardware-RAID device gives much faster disk
>> performance than dm-crypt overlaid by btrfs's own filesystem-level
>> RAID features)
>
> That may be on the Wikipedia page, but here's what's in the BTRFS FAQ:
> https://btrfs.wiki.kernel.org/index.php/FAQ#Does_btrfs_support_encryption.3F
> --------------------------------------------------------------------
> Does btrfs support encryption?
>
> No. This is a hard task and easy to do wrong (on a filesystem level). There's nobody actively working on it, although you may have heard it's planned (year 2009), try to understand it like not impossible. Instead, you should use available whole-disk encryption solutions such as dm-crypt or LUKS.
>
> This pretty much forbids you to use btrfs' cool RAID features if you need encryption. Using a RAID implementation on top of several encrypted disks is much slower than using encryption on top of a RAID device. So the RAID implementation must be on a lower layer than the encryption, which is not possible using btrfs' RAID support.
>
> Note: there is an option to use a btrfs internal raid1 for data and metadata: create the filesystem with --mixed option (and DUP profiles), but this may impact performace for volume sizes > 15G (or so).
>
> Another solution is to use stacked encrypting layer like ecryptfs. This does not have the disadvantage mentioned in the paragraph above.
>
> Last but not least it the fuse-based filesystem encfs working as a encrypting layer on top of normal filesystem. Note that the performance may be impacted (dive into fuse details for more). --------------------------------------------------------------------
>
> And this is why I'm here.
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
