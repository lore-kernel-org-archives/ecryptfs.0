From: "Jaroslav Fojtik" <jafojtik@seznam.cz>
Subject: Please patch key_mod.c
Date: Sat, 10 May 2014 19:33:17 +0200
Message-ID: <536E62DD.8156.E36EA@jafojtik.seznam.cz>
Mime-Version: 1.0
Content-Type: Multipart/Mixed; boundary=Message-Boundary-1497
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from server.heaven-czfree.net ([78.108.102.201]:39342 "EHLO
	mail.heaven-czfree.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318AbaEJSDR (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Sat, 10 May 2014 14:03:17 -0400
Received: from [10.23.202.44] (unknown [10.23.202.44])
	by mail.heaven-czfree.net (Postfix) with ESMTP id AFC87147CAC
	for <ecryptfs@vger.kernel.org>; Sat, 10 May 2014 19:33:21 +0200 (CEST)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: ecryptfs@vger.kernel.org


--Message-Boundary-1497
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body

Dears,

Please patch key_mod.c.

If you receive following message, it is totally frustrating because you do not know which
directory attempted to open. The path at least gives some info about it.

======================================================================================

mount.ecryptfs /DATA/.BACKUP /DATA/BACKUP -o 
key=passphrase,ecryptfs_cipher=aes,ecryptfs_key_bytes=16,ecryptfs_passthrough=no,ecryptfs_
enable_filename_crypto=yes,ecryptfs_fnek_sig=87f8f52c6f46cfca
Error attempting to evaluate mount options: [-1] Operation not permitted
Check your system logs for details on why this happened.
Try updating your ecryptfs-utils package, and/or
submit a bug report on https://bugs.launchpad.net/ecryptfs

2 keys in keyring:
620524981: --alswrv     0     0 user: 87f8f52C6f46cfcA
1017206571: --alswrv     0     0 user: 87f8f52c6f46cfca

Mar 30 18:40:39 ESC_router mount.ecryptfs: ERROR: Could not open key_mod directory 
Mar 30 18:40:39 ESC_router mount.ecryptfs: Error attempting to get key module list; rc = 
[-1] 


best regards
   Jara

---------------------------------------------------

*** key_mod.c.old	Sat May 10 17:57:51 2014
--- key_mod.c	Sat May 10 17:58:31 2014
***************
*** 252,258 ****
  	}
  	if (!(dp = opendir(dir_name))) {
  		syslog(LOG_WARNING,
! 		       "ERROR: Could not open key_mod directory\n");
  		rc = -EPERM;
  		goto out;
  	}
--- 252,258 ----
  	}
  	if (!(dp = opendir(dir_name))) {
  		syslog(LOG_WARNING,
! 		       "ERROR: Could not open key_mod directory [%s]\n", dir_name);
  		rc = -EPERM;
  		goto out;
  	}






--Message-Boundary-1497
Content-type: Application/Octet-stream; name="key_mod.c.diff"; type=Unknown
Content-disposition: attachment; filename="key_mod.c.diff"
Content-transfer-encoding: BASE64

KioqIGtleV9tb2QuYy5vbGQJU2F0IE1heSAxMCAxNzo1Nzo1MSAyMDE0Ci0tLSBrZXlfbW9k
LmMJU2F0IE1heSAxMCAxNzo1ODozMSAyMDE0CioqKioqKioqKioqKioqKgoqKiogMjUyLDI1
OCAqKioqCiAgCX0KICAJaWYgKCEoZHAgPSBvcGVuZGlyKGRpcl9uYW1lKSkpIHsKICAJCXN5
c2xvZyhMT0dfV0FSTklORywKISAJCSAgICAgICAiRVJST1I6IENvdWxkIG5vdCBvcGVuIGtl
eV9tb2QgZGlyZWN0b3J5XG4iKTsKICAJCXJjID0gLUVQRVJNOwogIAkJZ290byBvdXQ7CiAg
CX0KLS0tIDI1MiwyNTggLS0tLQogIAl9CiAgCWlmICghKGRwID0gb3BlbmRpcihkaXJfbmFt
ZSkpKSB7CiAgCQlzeXNsb2coTE9HX1dBUk5JTkcsCiEgCQkgICAgICAgIkVSUk9SOiBDb3Vs
ZCBub3Qgb3BlbiBrZXlfbW9kIGRpcmVjdG9yeSBbJXNdXG4iLCBkaXJfbmFtZSk7CiAgCQly
YyA9IC1FUEVSTTsKICAJCWdvdG8gb3V0OwogIAl9Cg==

--Message-Boundary-1497--
