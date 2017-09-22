From: Paul van der Vlis <paul@vandervlis.nl>
Subject: Re: Re-use SSD
Date: Fri, 22 Sep 2017 12:43:42 +0200
Message-ID: <oq2pgm$jkv$1@blaine.gmane.org>
References: <opdsrr$7vn$1@blaine.gmane.org> <1882558.NIKn6SUjoV@merkaba>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from [195.159.176.226] ([195.159.176.226]:37920 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1751903AbdIVKny (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Fri, 22 Sep 2017 06:43:54 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcfe-ecryptfs@m.gmane.org>)
        id 1dvLQt-0005jw-8J
        for ecryptfs@vger.kernel.org; Fri, 22 Sep 2017 12:43:43 +0200
In-Reply-To: <1882558.NIKn6SUjoV@merkaba>
Content-Language: nl
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: ecryptfs@vger.kernel.org

Op 14-09-17 om 15:21 schreef Martin Steigerwald:
> Hello Paul.
> 
> Paul van der Vlis - 14.09.17, 14:32:
>> I have bought many laptops with privacy-sensitive data on /home in
>> ecryptfs on the SSD. And I have promised to carefull remove the data
>> before re-using.
>>
>> What would you advice to do? Is it possible to overwrite the master key
>> for example? Or is it a good idea to change the passphrase in a very
>> long one?
> 
> Technically you can´t really overwrite it. SSDs use Copy on Write.
> 
> Also I think the passphrase in Ecryptfs just encrypts a key used to encrypt 
> the data… not the data itself.
> 
> 
> Generic hint for securely erasing SSDs.
> 
> https://ata.wiki.kernel.org/index.php/ATA_Secure_Erase

This is what I am doing now. The SSD's I've tried are normally freezed,
but after awaking from suspend-to-ram not anymore.

It looks complex, but it's fast and doable. But indeed not nice to rely
on the firmware of the SSD...

What I would like are stupid-SSD's without a controller, where the
filesystem does everything. Or a SSD with open source controller firmware.

With regards,
Paul





-- 
Paul van der Vlis Linux systeembeheer Groningen
https://www.vandervlis.nl/
