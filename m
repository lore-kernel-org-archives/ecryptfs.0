From: Henry Jensen <hjensen@gmx.de>
Subject: Re: Can't list directories with kernel 4.4.14 and ecryptfs
Date: Mon, 27 Jun 2016 23:21:46 +0200
Message-ID: <0A028742-6B46-49DB-900F-86CE85F320F4@gmx.de>
References: <20160627182738.08737a6d@subnote.jensen.local> <57717C2C.4010708@canonical.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:51607 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752063AbcF0VVv convert rfc822-to-8bit (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 27 Jun 2016 17:21:51 -0400
Received: from android-48520ac0686b0ebf ([84.172.166.114]) by mail.gmx.com
 (mrgmx102) with ESMTPSA (Nemesis) id 0MIhDo-1bJppb2mQC-002DWV for
 <ecryptfs@vger.kernel.org>; Mon, 27 Jun 2016 23:21:47 +0200
In-Reply-To: <57717C2C.4010708@canonical.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: ecryptfs@vger.kernel.org

Hi Tyler,

Am 27. Juni 2016 21:19:08 MESZ, schrieb Tyler Hicks <tyhicks@canonical.com>:
>On 06/27/2016 11:27 AM, Henry Jensen wrote:
>> Greetings,
>> 
>> I'm using ecryptfs with Slackware current and kernel 4.4.14. In
>kernel
>> 4.4.14 was a patch introduced which make it impossilble to list the
>> contents of a directory.[0]
>> 
>> The mount itself works, but listing a directory results in an error
>> "wrong medium type". Showing the contents and the file itself
>(presumed
>> the name of the file is known) works.
>
>Hi Henry - sorry for the trouble. What filesystem are you mounting
>eCryptfs on top of?


I use ext4. With 'ecryptfs-mount-private' $HOME/.Private is mounted on $HOME/Private. 

ecryptfs worked perfectly until I upgraded to kernel 4.4.14. I tested it on another machine with Slackware64 and a 64bit kernel now - same result.

Regards,
Henry
