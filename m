From: Martin Steigerwald <Martin@lichtvoll.de>
Subject: Re: ecryptfs =?utf-8?q?doesn=C2=B4t_like_noauto_and?= noatime
Date: Tue, 17 Jan 2012 09:35:31 +0100
Message-ID: <201201170935.32281.Martin@lichtvoll.de>
References: <201201161044.21718.Martin@lichtvoll.de> <20120117065536.GB4262@boyd> (sfid-20120117_093141_103357_DC22DFD5)
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mondschein.lichtvoll.de ([194.150.191.11]:48153 "EHLO
	mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366Ab2AQIfd (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 17 Jan 2012 03:35:33 -0500
In-Reply-To: <20120117065536.GB4262@boyd>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: Tyler Hicks <tyhicks@canonical.com>
Cc: ecryptfs@vger.kernel.org

Am Dienstag, 17. Januar 2012 schrieb Tyler Hicks:
> On 2012-01-16 10:44:21, Martin Steigerwald wrote:
> > Hi!
> > 
> > I have
> > 
> > merkaba:~> grep ecrypt /etc/fstab
> > /home/.ms               /home/ms                ecryptfs
> > noatime,noauto  0       0
> > 
> > And get:
> > 
> > merkaba:~> mount /home/ms
> 
> Is this the *exact* mount command that you're running? You're not
> invoking /sbin/mount.ecryptfs directly, using mount -t ecryptfs, or
> anything else?

Yes, this is copied-and-pasted.

> > Passphrase:
> > 
> > Attempting to mount with the following options:
> >   ecryptfs_unlink_sigs
> >   ecryptfs_fnek_sig=0408d19ec184c207
> >   ecryptfs_key_bytes=32
> >   ecryptfs_cipher=aes
> >   ecryptfs_sig=0408d19ec184c207
> > 
> > Error mounting eCryptfs: [-5] Input/output error
> > Check your system logs; visit <http://launchpad.net/ecryptfs>
> > 
> > 
> > Still it works.
> > 
> > 
> > In dmesg I see:
> > 
> > [ 2657.888355] ecryptfs_parse_options: eCryptfs: unrecognized option
> > [noauto]
> > [ 2657.888359] ecryptfs_parse_options: eCryptfs: unrecognized option
> > [noatime]
> 
> Neither of these options should be making their way to the kernel in
> the string form. noauto is consumed by the mount utility and should be
> stripped out entirely before constructing the final mount options
> string for the kernel. noatime should be stripped out and converted
> into a mountflags bit (see man 2 mount).
> 
> It looks like ecryptfs_generate_mount_flags() is incomplete since it
> forgets to handle some options (at least noatime and noauto). I created
> bug #917509 to track this:
> 
> https://launchpad.net/bugs/917509

Thanks.

Ciao,
-- 
Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7
