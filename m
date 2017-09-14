From: Martin Steigerwald <martin@lichtvoll.de>
Subject: Re: Re-use SSD
Date: Thu, 14 Sep 2017 15:21:13 +0200
Message-ID: <1882558.NIKn6SUjoV@merkaba>
References: <opdsrr$7vn$1@blaine.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mondschein.lichtvoll.de ([194.150.191.11]:43511 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751335AbdINNVP (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Thu, 14 Sep 2017 09:21:15 -0400
In-Reply-To: <opdsrr$7vn$1@blaine.gmane.org>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: ecryptfs@vger.kernel.org
Cc: Paul van der Vlis <paul@vandervlis.nl>

Hello Paul.

Paul van der Vlis - 14.09.17, 14:32:
> I have bought many laptops with privacy-sensitive data on /home in
> ecryptfs on the SSD. And I have promised to carefull remove the data
> before re-using.
> 
> What would you advice to do? Is it possible to overwrite the master key
> for example? Or is it a good idea to change the passphrase in a very
> long one?

Technically you can´t really overwrite it. SSDs use Copy on Write.

Also I think the passphrase in Ecryptfs just encrypts a key used to encrypt 
the data… not the data itself.


Generic hint for securely erasing SSDs.

https://ata.wiki.kernel.org/index.php/ATA_Secure_Erase

You rely on the SSD firmware tough. But I am not aware of another way to 
securely delete data of an SSD other than ATA Secure Erase. However ATA Secure 
Erase only is really safe for SSDs that use encryption like Intel SSD 320 (and 
many newer SSDs) as the SSD will overwrite the encryption keys. Many SSDs use 
encryption by default, without change using some default key (ideally randomly 
generated key that the manufacture then forgets… but manufacturers may just 
use same key for all SSDs with a certain firmware) key and no password for it.

Just deleting files doesn´t do much. At least run fstrim after deleting files. 
Thats still not as safe as Secure Erasing the whole device tough.

Thanks,
-- 
Martin
