From: Artur Rataj <arturrataj@gmail.com>
Subject: Re: Did I lost an encrypted folder?
Date: Sun, 15 Dec 2013 15:51:02 +0100
Message-ID: <CACO3_sA4TP1whFdJTLi_up2DUua5ZKRNum=e5FqUA5xqbaxURQ@mail.gmail.com>
References: <CACO3_sCk-hX=-eoyHs3CFkqNMHAnvrOhi-r5CFyDS0=xWQdPGg@mail.gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:61849 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834Ab3LOOvD (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Sun, 15 Dec 2013 09:51:03 -0500
Received: by mail-qc0-f182.google.com with SMTP id e16so2933399qcx.41
        for <ecryptfs@vger.kernel.org>; Sun, 15 Dec 2013 06:51:02 -0800 (PST)
In-Reply-To: <CACO3_sCk-hX=-eoyHs3CFkqNMHAnvrOhi-r5CFyDS0=xWQdPGg@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs <ecryptfs@vger.kernel.org>

PS. The tool turned out to work: ecryptfs-recover-private. Thanks, Dustin!


On Sun, Dec 15, 2013 at 3:20 PM, Artur Rataj <arturrataj@gmail.com> wrote:
> I have a .Private folder in my home directory. It worked ok after I
> logged in, until I reinstalled the system. The same folder, user,
> password, .ecryptfs with wrapped-passphrase. Yet, the contents of the
> mounted .Private folder is scrambled.
>
> ecryptfs-unwrap-passphrase returns some of my old passwords. What can
> I do? If the folder can not be decrypted anymore, what was
> modified/deleted by the installation process so that it is not
> possible?
>
> I am sorry if questions like that were already asked, the list's
> archive does not work now.
>
> Best regards,
> Artur
