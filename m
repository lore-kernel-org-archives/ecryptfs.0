From: Dustin Kirkland <dustin.kirkland@gazzang.com>
Subject: Re: dumb question or not?
Date: Mon, 6 Feb 2012 11:51:31 -0600
Message-ID: <CANT6BaMt48S5dE0Sm+fK_aJt=qm=bSzWSCTNCcUgmPNPH-ekjQ@mail.gmail.com>
References: <4F2C1AE4.2040104@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:42850 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844Ab2BFRvc convert rfc822-to-8bit (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 6 Feb 2012 12:51:32 -0500
Received: by pbdu11 with SMTP id u11so5154168pbd.19
        for <ecryptfs@vger.kernel.org>; Mon, 06 Feb 2012 09:51:31 -0800 (PST)
In-Reply-To: <4F2C1AE4.2040104@gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Space Cake <spacecakex@gmail.com>
Cc: ecryptfs@vger.kernel.org

On Fri, Feb 3, 2012 at 11:35 AM, Space Cake <spacecakex@gmail.com> wrot=
e:
> After some kernel update and I've got the following error when I try =
to
> mount .private
>
> setreuid: Operation not permitted
> ERROR: =A0Could not mount private ecryptfs directory
>
> same error when I try to re-create encrypted directory... what's wron=
g?

What are the permissions of /sbin/mount.ecryptfs_private?  It should
look like this, 4755.

$ ls -alF /sbin/mount.ecryptfs_private
-rwsr-xr-x 1 root root 18784 2011-12-13 15:11 /sbin/mount.ecryptfs_priv=
ate*

--=20
:-Dustin

Dustin Kirkland
Chief Architect
Gazzang, Inc.
www.gazzang.com
