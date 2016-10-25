From: Felix Rubio <felix@kngnt.org>
Subject: =?UTF-8?Q?strange=28=3F=29=20situation=20with=20ecryptfs?=
Date: Tue, 25 Oct 2016 14:55:31 +0200
Message-ID: <835a71b6c961cc7ce2353a333ea3db08@kngnt.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from smtpq4.tb.mail.iss.as9143.net ([212.54.42.167]:38006 "EHLO
        smtpq4.tb.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932474AbcJYNbp (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Tue, 25 Oct 2016 09:31:45 -0400
Received: from [212.54.42.137] (helo=smtp6.tb.mail.iss.as9143.net)
        by smtpq4.tb.mail.iss.as9143.net with esmtp (Exim 4.86_2)
        (envelope-from <felix@kngnt.org>)
        id 1bz1GO-0005tY-Ry
        for ecryptfs@vger.kernel.org; Tue, 25 Oct 2016 14:55:32 +0200
Received: from 2.152.8.254.dyn.user.ono.com ([2.152.8.254] helo=mail.kngnt.org)
        by smtp6.tb.mail.iss.as9143.net with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.82)
        (envelope-from <felix@kngnt.org>)
        id 1bz1GO-0008Nn-OY
        for ecryptfs@vger.kernel.org; Tue, 25 Oct 2016 14:55:32 +0200
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: ecryptfs@vger.kernel.org

Hi,

    I have a set of folders encrypted with encfs (over zfs) and I get an 
error when trying to mount them. What I do is:

    register the key on the keyring:
       <binary which produces the passphrase on stdout> | 
ecryptfs-add-passphrase -

    check the key is, indeed, there:
       keyctl list @u
          1 key in keyring:
          <#id>: --alswrv     0     0 user: <sig>

    mount the FS:
       mount -i -t ecryptfs -o 
ecryptfs_sig=<sig>,ecryptfs_fnek_sig=<sig>,ecryptfs_cipher=aes,ecryptfs_key_bytes=16 
<mount point> <mount point>
       mount: mount(2) failed: <mount point>: No such file or directory

    but <mount point> exists. Also, I see in the logs:
       kernel: Could not find key with description: [<sig>]
       kernel: process_request_key_err: No key
       kernel: Could not find valid key in user session keyring for sig 
specified in mount option: [<sig>]
       kernel: One or more global auth toks could not properly register; 
rc = [-2]
       kernel: Error parsing options; rc = [-2]

    However, if first try to mount it without the -i AND I kill it when 
asking for the passphrase:
       mount -i -t ecryptfs -o 
ecryptfs_sig=<sig>,ecryptfs_fnek_sig=<sig>,ecryptfs_cipher=aes,ecryptfs_key_bytes=16 
<mount point> <mount point>
       Select key type to use for newly created files:
        1) tspi
        2) passphrase
       Selection: ^C

    And the repeat the mount with the -i
       mount -i -t ecryptfs -o 
ecryptfs_sig=<sig>,ecryptfs_fnek_sig=<sig>,ecryptfs_cipher=aes,ecryptfs_key_bytes=16 
<mount point> <mount point>

    it succeeds, and the kernel reports no errors at all.

    This happens only for the first folder being decrypted. After this 
first has succeeded, I can mount any other folder encrypted with the 
same key just by issuing
       mount -i -t ecryptfs -o 
ecryptfs_sig=<sig>,ecryptfs_fnek_sig=<sig>,ecryptfs_cipher=aes,ecryptfs_key_bytes=16 
<other mount point> <other mount point>

    Am I doing something wrong? Is this a bug?
    Thank you!

-- 
Felix Rubio
"Don't believe what you're told. Double check."
