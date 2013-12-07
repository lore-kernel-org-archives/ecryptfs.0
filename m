From: "imagenesis@gmail.com" <imagenesis@gmail.com>
Subject: How to enable crypttab to run at boot
Date: Sat, 7 Dec 2013 09:29:35 -0500
Message-ID: <CABxodt8ecVShoPqoXQpQX-AxJ3HkVO2VM=ibyEkw7j+N+gJpHQ@mail.gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:55014 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754580Ab3LGO3g (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Sat, 7 Dec 2013 09:29:36 -0500
Received: by mail-wi0-f169.google.com with SMTP id hn6so2119625wib.4
        for <ecryptfs@vger.kernel.org>; Sat, 07 Dec 2013 06:29:35 -0800 (PST)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org

    /root/.crypt /root/crypt ecryptfs
ecryptfs_check_dev_ruid,ecryptfs_cipher=aes,ecryptfs_key_bytes=16,ecryptfs_unlink_sigs,ecryptfs_sig=d395309aaad4de06,ecryptfs_fnek_sig=d395309aaad4de06
0 0

I have the above entry in fstab. It is specifying that the
`/root/crypt` disk is not available (notice not `/root/.crypt`).
However, it does not offer the option to wait or resolve manually. It
simply continues on with the boot. In addition there is no mention of
this occurring in /var/log/boot.log.

The permissions of both `.crypt` and `crypt` are `root:root:775`

My intention is to decrypt ecryptfs at boot (not dm_crypt), not pam
login as provided by the ecryptfs private utils. I am aware of the
functionality provided by dm_crypt/ecryptfs at user login.

/root/crypt is on a mount that is specified before in /etc/fstab and
is successfully mounted at the conclusion of boot.
