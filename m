From: Hans-Joachim Kliemeck <info@kliemeck.de>
Subject: combination of cifs and ecryptfs
Date: Mon, 28 Mar 2016 22:06:14 +0200
Message-ID: <56F98EB6.30707@kliemeck.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail.normalesvieh.de ([5.9.208.126]:41930 "EHLO
	mail.normalesvieh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752314AbcC1Uii (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 28 Mar 2016 16:38:38 -0400
Received: from p54b9aaf2.dip0.t-ipconnect.de ([84.185.170.242] helo=[192.168.0.196])
	by mail.normalesvieh.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.84)
	(envelope-from <info@kliemeck.de>)
	id 1akdQR-0004ss-Oi
	for ecryptfs@vger.kernel.org; Mon, 28 Mar 2016 22:06:12 +0200
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: ecryptfs@vger.kernel.org

Dear List,

i'm experiencing problems related to the combination of ecryptfs and
cifs. Due to the lack of encryption on cifs, i decided to mount a remote
share and encrypt the traffic with ecryptfs.

my setup:

systems:
Ubuntu 14.04 (3.13.0-83-generic) / 16.04 (4.4.0-15-generic)

folders:
/opt/backup/remote/ - ecryptfs main folder
/opt/backup/remote-encrypted/ - cifs folder

fstab:
//XXXXXXX/backup /opt/backup/remote-encrypted/ cifs
defaults,_netdev,username=XXXXX,password=XXXXXX 0 0
/opt/backup/remote-encrypted/ /opt/backup/remote/ ecryptfs
defaults,noatime,nodiratime,_netdev,ecryptfs_cipher=aes,ecryptfs_key_bytes=32,ecryptfs_enable_filename_crypto=n,ecryptfs_passthrough=n,ecryptfs_sig=XXXXXX,no_sig_cache,key=passphrase:passphrase_passwd=XXXXXXXXXXXXXX
0 0

remote cifs server:
seems to be a proftpd with mod_sftp (with CIFS Unix Extensions), but i
can not determine its version. Its the backup server from my ISP (Hetzner)


The reason i post this to the ecryptfs mailing list: I took a deep look
at whats going on and it seems that ecryptfs is opening a readonly file
with read-write access. Therefore cifs issues a read-write request
against the server and the server will always deny it, because the file
is marked as readonly. If the ecryptfs mointpoint is mounted readonly,
the read access to the corresponding file will succeed. It looks like
ecryptfs does not care about the permissions of the encrypted file and
it will open it with read-write regardless which mode is requested.

steps to reproduce this (FYI, sudoers permissions are 0440)

root@backuptest:~# rsync /etc/sudoers /opt/backup/remote/rsnapshot/ &&
umount /opt/backup/remote* && mount -a
root@backuptest:~# cat /opt/backup/remote/rsnapshot/sudoers
[14144.024849] Error opening lower file for lower_dentry
[0xffff880078086480] and lower_mnt [0xffff880078882320]; rc = [-13]
[14144.024873] ecryptfs_i_size_read: Error attempting to initialize the
lower file for the dentry with name [sudoers]; rc = [-13]
cat: /opt/backup/remote/rsnapshot/sudoers: Permission denied

I found a similar problem, maybe its related:
http://askubuntu.com/questions/609533/cannot-access-file-on-ecryptfs-on-cifs-permission-denied

any idea whats wrong with ecryptfs or with my settings?

Thank you in advance,
Hans-Joachim
