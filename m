From: Martin Steigerwald <ms@teamix.de>
Subject: encryption metadata not stored with filesystem
Date: Mon, 19 Dec 2011 13:36:04 +0100
Message-ID: <201112191336.05938.ms@teamix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from postman.teamix.net ([194.150.191.120]:54684 "EHLO
	rproxy.teamix.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751858Ab1LSMgK convert rfc822-to-8bit (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 19 Dec 2011 07:36:10 -0500
Received: from zimbra.of.teamix.net (unknown [172.21.242.23])
	by rproxy.teamix.net (Postfix) with ESMTP id 583187F39
	for <ecryptfs@vger.kernel.org>; Mon, 19 Dec 2011 13:36:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.of.teamix.net (Postfix) with ESMTP id 4C094146C9D
	for <ecryptfs@vger.kernel.org>; Mon, 19 Dec 2011 13:36:09 +0100 (CET)
Received: from zimbra.of.teamix.net ([127.0.0.1])
	by localhost (zimbra.of.teamix.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y0Y0p6rPwpEX for <ecryptfs@vger.kernel.org>;
	Mon, 19 Dec 2011 13:36:08 +0100 (CET)
Received: from mango.localnet (mango.of.teamix.net [172.21.123.1])
	by zimbra.of.teamix.net (Postfix) with ESMTPSA id F00B7146C74
	for <ecryptfs@vger.kernel.org>; Mon, 19 Dec 2011 13:36:08 +0100 (CET)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: Text/Plain; charset="utf-8"
To: ecryptfs@vger.kernel.org

Hi!

On trying to work with ecryptfs I have found that I have to store ecryp=
tfs=20
configuration in an undocumented file ~/.ecryptfsrc like:

merkaba:~> cat .ecryptfsrc=20
ecryptfs_unlink_sigs
ecryptfs_sig=3D[=E2=80=A6]
ecryptfs_fnek_sig=3D[=E2=80=A6]
ecryptfs_xattr
ecryptfs_key_bytes=3D32
ecryptfs_cipher=3Daes
ecryptfs_passthrough=3Dn

in order to mount ecryptfs without mount options.

This makes handling of ecryptfs filesystem more complicated than encfs,=
 since=20
encfs seems to store encryption metadata in the encrypted directory its=
elf:

merkaba:~> ls -l /home/.ms2/.encfs5
-rw-r----- 1 root root 241 Mai 19  2008 /home/.ms2/.encfs5

Thus with ecryptfs I have to save the encrypted directory and the files=
ystem=20
settings for a backup while with encfs its enough to copy the encrypted=
=20
directory.

Please consider to add this feature in ecryptfs.

It will also make setting up ecryptfs easier.

Thanks,
--=20
Martin Steigerwald - teamix GmbH - http://www.teamix.de
gpg: 19E3 8D42 896F D004 08AC A0CA 1E10 C593 0399 AE90
