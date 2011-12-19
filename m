From: Dustin Kirkland <dustin.kirkland@gazzang.com>
Subject: Re: encryption metadata not stored with filesystem
Date: Mon, 19 Dec 2011 15:53:38 -0600
Message-ID: <CANT6BaOtumjj+kJTsDD92YPBKXqnw0Nw8s24B05Wo2agi2oV1A@mail.gmail.com>
References: <201112191336.05938.ms@teamix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64274 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752325Ab1LSVxj convert rfc822-to-8bit (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 19 Dec 2011 16:53:39 -0500
Received: by pbdu13 with SMTP id u13so2071492pbd.19
        for <ecryptfs@vger.kernel.org>; Mon, 19 Dec 2011 13:53:39 -0800 (PST)
In-Reply-To: <201112191336.05938.ms@teamix.de>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: Martin Steigerwald <ms@teamix.de>
Cc: ecryptfs@vger.kernel.org

On Mon, Dec 19, 2011 at 6:36 AM, Martin Steigerwald <ms@teamix.de> wrot=
e:
> On trying to work with ecryptfs I have found that I have to store ecr=
yptfs
> configuration in an undocumented file ~/.ecryptfsrc like:
>
> merkaba:~> cat .ecryptfsrc
> ecryptfs_unlink_sigs
> ecryptfs_sig=3D[=85]
> ecryptfs_fnek_sig=3D[=85]
> ecryptfs_xattr
> ecryptfs_key_bytes=3D32
> ecryptfs_cipher=3Daes
> ecryptfs_passthrough=3Dn
>
> in order to mount ecryptfs without mount options.

Thanks for that suggestion.  I've actually just created a bug to track
this.  I'll try to get this working better this week:
 * https://bugs.launchpad.net/ecryptfs/+bug/906550

Cheers!
--=20
:-Dustin

Dustin Kirkland
Chief Architect
Gazzang, Inc.
www.gazzang.com
