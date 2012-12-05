From: Michael Chang <m9chang@uwaterloo.ca>
Subject: Re: Encrypting BTRFS Volume
Date: Wed, 5 Dec 2012 18:39:03 -0500
Message-ID: <CAHcyQ+7N2-NEG4wbMK_QhzMdow4NnvVKukYx=FNzeOJx6rKExw@mail.gmail.com>
References: <201212011306.59255.CACook@quantum-sci.com> <201212041005.10715.CACook@quantum-sci.com>
 <CACDOv80NnYPfy23JXLK9_RhdHw5_z+SC7bWhuy_B-FscGQEY4Q@mail.gmail.com> <201212050748.36206.CACook@quantum-sci.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:46892 "EHLO
	mailchk-m05.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753105Ab2LFAgL convert rfc822-to-8bit
	(ORCPT <rfc822;ecryptfs@vger.kernel.org>);
	Wed, 5 Dec 2012 19:36:11 -0500
Received: from mail-ia0-f174.google.com (mail-ia0-f174.google.com [209.85.210.174])
	(authenticated bits=0)
	by mailchk-m05.uwaterloo.ca (8.14.4/8.14.4) with ESMTP id qB5NdhgM021749
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <ecryptfs@vger.kernel.org>; Wed, 5 Dec 2012 18:39:44 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so4466151iay.19
        for <ecryptfs@vger.kernel.org>; Wed, 05 Dec 2012 15:39:43 -0800 (PST)
In-Reply-To: <201212050748.36206.CACook@quantum-sci.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: CACook@quantum-sci.com
Cc: ecryptfs@vger.kernel.org

If the only use of subvolumes is for snapshotting, it seems to me that
you could make one subvolume contain the encrypted directory, and then
take snapshots of the encrypted directory/subvolume instead of taking
snapshots of the unencrypted volume.

Otherwise, it appears that you're going to lose one of {encryption,
BTRFS RAID and snapshotting}, which suggests to me that you should
evaluate the trade-offs between this approach and just using
ext4+dm-crypt+lvm.

On Wed, Dec 5, 2012 at 10:48 AM,  <CACook@quantum-sci.com> wrote:
> On Tuesday, December 04, 2012 06:46:11 PM B. J. Potter wrote:
>> I don't understand your situation well enough to say (I lack the btrfs
>> subvolume knowledge). The encrypted part of ecryptfs is just a folder
>> of files on your filesystem. You then mount the folder on your system
>> and read/write to that mounted location. The encrypted files are
>> transparently updated as you write to the mounted location. You'll
>> have to apply that information on how ecryptfs works to your
>> situation.
>
> A BTRFS subvolume just looks like a subdirectory, except it has special properties to allow BTRFS snapshotting.  So I do a backup to /media/backups/droog/root and home, of droog's /root and /home.  The first of the month I snapshot the backed-up droog to /media/backups/droog-root-snap-2012-10-01 of the state of the backup on that date, and then I can always go back to that snap for a complete set of backups as of that date.  Files aren't duplicated, but are kept track of in a special way by BTRFS.
>
> So /media/backups is my BTRFS volume set of four drives.  In order to make snaps, /media/backups/droog (and hex and so on, for my LAN machines) is a subvolume. (which just looks like a subdir)  Under backups is droog (current saveset), droog-root-snap-2012-10-01, droog-root-snap-2012-11-01, and so on.    So since droog is a subvolume it cannot be encrypted, nor can droog-root-snap-2012-10-01 and so on, because according to the BTRFS FAQ ecryptfs and volumes and subvolumes don't mix.  Below droog is root and home, which are regular subdirs and can be encrypted, but they are always snapped to a snap subvolume, and that doesn't seem possible since it would be bridging over BTRFS accounting.
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thanks,

Michael Chang
3B Software Engineering (Class of 2014)
University of Waterloo
