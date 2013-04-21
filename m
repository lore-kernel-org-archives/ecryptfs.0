From: Christian Kujau <lists@nerdbynature.de>
Subject: Re: Ecryptfs over sshfs and timestamps
Date: Sun, 21 Apr 2013 16:29:08 -0700 (PDT)
Message-ID: <alpine.DEB.2.10.1304211546110.13746@trent.utfs.org>
References: <CAHHtCV9kvjbmUnH584HUaDLtVktjcP7fB1myWBx-kcsErF7zZw@mail.gmail.com> <alpine.DEB.2.10.1304211324450.13746@trent.utfs.org> <CAM-DUcOrs3vws+Vt9BWw29da8M_1LRwkrPHPF_eUc3Mz2a7ZaQ@mail.gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from trent.utfs.org ([94.185.90.103]:46727 "EHLO trent.utfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752146Ab3DUX3S (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
	Sun, 21 Apr 2013 19:29:18 -0400
In-Reply-To: <CAM-DUcOrs3vws+Vt9BWw29da8M_1LRwkrPHPF_eUc3Mz2a7ZaQ@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Reinstein <reinstein.mike@gmail.com>
Cc: Ivan Yosifov <iyosifov@gmail.com>, ecryptfs@vger.kernel.org

On Sun, 21 Apr 2013 at 13:54, Mike Reinstein wrote:
> Maybe I'm just misunderstanding the problem. Is it being suggested that the
> unencrypted copy of the data should be backed up over sshfs to an untrusted
> machine?

No, I think the untrusted machine would hold the encrypted data, which is 
mounted to a trusted machine, where it's then decrypted via ecryptfs. In 
my example:

>> sid0# sshfs root@localhost:/mnt/disk/enc /mnt/disk/sshfs
>> root@localhost's password:

Here, localhost (untrusted) will hold the encrypted content in 
/mnt/disk/enc, which is now mounted on a trusted machine, still encryted:

sid0# ls -go /mnt/disk/sshfs/
total 32
drwx------ 1 12288 Apr 21 13:16 ECRYPTFS_FNEK_ENCRYPTED.FWYIx22XUxYW1kS.8RBEqYi.2ckHIID6ncewGoCHUK9KZiv5Ci99Q9LW3E--

>> sid0# mount -t ecryptfs /mnt/disk/sshfs /mnt/disk/dec

The decryption is done on the trusted machine. Maybe my example is kinda 
confusing because I'm using "localhost" as the "untrusted remote machine". 
But if you replace "localhost" with "evilhost", it should be clearer.

C.
-- 
BOFH excuse #353:

Second-system effect.
