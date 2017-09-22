From: Martin Steigerwald <martin@lichtvoll.de>
Subject: Re: Re-use SSD
Date: Fri, 22 Sep 2017 13:27:37 +0200
Message-ID: <3513783.r4zieL0AEN@merkaba>
References: <opdsrr$7vn$1@blaine.gmane.org> <1882558.NIKn6SUjoV@merkaba> <oq2pgm$jkv$1@blaine.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mondschein.lichtvoll.de ([194.150.191.11]:56783 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751931AbdIVL1j (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Fri, 22 Sep 2017 07:27:39 -0400
In-Reply-To: <oq2pgm$jkv$1@blaine.gmane.org>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Paul van der Vlis <paul@vandervlis.nl>
Cc: ecryptfs@vger.kernel.org

Paul van der Vlis - 22.09.17, 12:43:
> Op 14-09-17 om 15:21 schreef Martin Steigerwald:
> > Hello Paul.
> > 
> > Paul van der Vlis - 14.09.17, 14:32:
> >> I have bought many laptops with privacy-sensitive data on /home in
> >> ecryptfs on the SSD. And I have promised to carefull remove the data
> >> before re-using.
> >> 
> >> What would you advice to do? Is it possible to overwrite the master key
> >> for example? Or is it a good idea to change the passphrase in a very
> >> long one?
> > 
> > Technically you can´t really overwrite it. SSDs use Copy on Write.
> > 
> > Also I think the passphrase in Ecryptfs just encrypts a key used to
> > encrypt
> > the data… not the data itself.
> > 
> > 
> > Generic hint for securely erasing SSDs.
> > 
> > https://ata.wiki.kernel.org/index.php/ATA_Secure_Erase
> 
> This is what I am doing now. The SSD's I've tried are normally freezed,
> but after awaking from suspend-to-ram not anymore.
> 
> It looks complex, but it's fast and doable. But indeed not nice to rely
> on the firmware of the SSD...
> 
> What I would like are stupid-SSD's without a controller, where the
> filesystem does everything. Or a SSD with open source controller firmware.

Yep.

Open Channel SSDs. But well, I never seen anything like that for laptops or 
other kind of consumer hardware.

Then add to it Coreboot or even Libreboot.

This ThinkPad T520 still has Intel Crapware^W Management Engine on it. I 
disabled it in the firmware settings… but… I know it can be removed meanwhile… 
but as it is not my laptop, I just update the BIOS/UEFI firmware once in a 
while. But there are rarely any new updates. So I bet that TCP/IP stack in IME 
has a ton of unfixed security issues by now.

Free hardware… thats the next revolution!

Thanks,
-- 
Martin
