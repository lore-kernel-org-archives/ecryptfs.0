From: Paul van der Vlis <paul@vandervlis.nl>
Subject: Re: Re-use SSD
Date: Thu, 14 Sep 2017 15:03:44 +0200
Message-ID: <267b05f1-4369-4fcb-d1d6-fc924b298f33@vandervlis.nl>
References: <opdsrr$7vn$1@blaine.gmane.org>
 <f34084a3-159d-e580-d199-ecf6acf345ff@aron.ws>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail.vandervlis.nl ([91.198.178.50]:39414 "EHLO
        mail.vandervlis.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751131AbdINNMl (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Thu, 14 Sep 2017 09:12:41 -0400
In-Reply-To: <f34084a3-159d-e580-d199-ecf6acf345ff@aron.ws>
Content-Language: nl
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Aron Szabo <aron@aron.ws>, ecryptfs@vger.kernel.org

Hello Aron and others,

Your information is about wiping like there was no encryption, what
takes much time.

In many cases I use encryption so I don't have to wipe the disks when
they are old! But I don't know so much about ecryptfs, normally I use
dmcrypt/LUKS, where I can overwrite the volume header.

With regards,
Paul van der Vlis


Op 14-09-17 om 14:47 schreef Aron Szabo:
> Hi!
> 
> Take a look at this presentation:
> http://cseweb.ucsd.edu/~m3wei/assets/pdf/FMS-2010-Secure-Erase.pdf
> 
> And here: https://wiki.archlinux.org/index.php/Securely_wipe_disk
> 
> I would sleep well after doing this two times:
> 
>     dd if=/dev/urandom of=/dev/<drive> status=progress
> 
> After that zeroing out:
> 
>     dd if=/dev/zero of=/dev/<drive> status=progress
> 
> Yours:
> Aron
> 
> On 09/14/2017 02:32 PM, Paul van der Vlis wrote:
>> Hello,
>>
>> I have bought many laptops with privacy-sensitive data on /home in
>> ecryptfs on the SSD. And I have promised to carefull remove the data
>> before re-using.
>>
>> What would you advice to do? Is it possible to overwrite the master key
>> for example? Or is it a good idea to change the passphrase in a very
>> long one?
>>
>> With regards,
>> Paul van der Vlis
>>
>>
> 



-- 
Paul van der Vlis Linux systeembeheer Groningen
https://www.vandervlis.nl/
