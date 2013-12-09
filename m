From: "cc chen" <cheanchaeng.chen@b2b.com.my>
Subject: eCryptfs using openssl encountered "Transport endpoint is not connected" when writting file into the mounted folder
Date: Mon, 9 Dec 2013 18:32:54 +0800
Message-ID: <0f6d01cef4ca$06b35430$1419fc90$@b2b.com.my>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:42049 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412Ab3LIKdC (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 9 Dec 2013 05:33:02 -0500
Received: by mail-pd0-f170.google.com with SMTP id g10so5031935pdj.1
        for <ecryptfs@vger.kernel.org>; Mon, 09 Dec 2013 02:33:00 -0800 (PST)
Received: from LTBI01 ([210.19.254.139])
        by mx.google.com with ESMTPSA id ju10sm17008744pbd.33.2013.12.09.02.32.59
        for <ecryptfs@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Dec 2013 02:33:00 -0800 (PST)
Content-Language: en-my
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org

Greetings, 


I am having the error as per subject when I am using the openssl
(passphrase) key type, the thing is I don't get this error when using the
passphrase as key type.

Below is the steps using openssl as key type, appreciate someone can help to
advise what are the mistake:

(A) Create test.pem public/private cert using using "ecryptfs-manager"
(B) List of commands to mount the disk and result output:

# mount -t ecryptfs  /secure/.s3 /secure/s3
Select key type to use for newly created files:
 1) openssl
 2) passphrase
 3) tspi
Selection: 1
PEM key file [/root/.ecryptfs/pki/openssl/key.pem]: test.pem
Method of providing the passphrase:
 1) openssl_passwd: Enter on Console
 2) openssl_passwd_file: File Containing Passphrase
 3) openssl_passwd_fd: File Descriptor for File Containing Passphrase
Selection [openssl_passwd]: 1
Passphrase:
Select cipher:
 1) aes: blocksize = 16; min keysize = 16; max keysize = 32 (not loaded)
 2) blowfish: blocksize = 16; min keysize = 16; max keysize = 56 (not
loaded)
 3) des3_ede: blocksize = 8; min keysize = 24; max keysize = 24 (not loaded)
 4) cast6: blocksize = 16; min keysize = 16; max keysize = 32 (not loaded)
 5) cast5: blocksize = 8; min keysize = 5; max keysize = 16 (not loaded)
Selection [aes]:
Select key bytes:
 1) 16
 2) 32
 3) 24
Selection [16]:
Enable plaintext passthrough (y/n) [n]:
Enable filename encryption (y/n) [n]:
Attempting to mount with the following options:
  ecryptfs_unlink_sigs
  ecryptfs_key_bytes=16
  ecryptfs_cipher=aes
  ecryptfs_sig=74c90d4c6548e015
WARNING: Based on the contents of [/root/.ecryptfs/sig-cache.txt],
it looks like you have never mounted with this key
before. This could mean that you have typed your
passphrase wrong.

Would you like to proceed with the mount (yes/no)? : yes
Would you like to append sig [74c90d4c6548e015] to
[/root/.ecryptfs/sig-cache.txt]
in order to avoid this warning in the future (yes/no)? : no
Not adding sig to user sig cache file; continuing with mount.
Mounted eCryptfs

# cd s3
# touch test1
touch: cannot touch `test1': Input/output error




Thank you very much.




-- 
Disclaimer : This E-mail is intended only for the use of the individual or 
entity named above and may contain information that is confidential. If you 
are not the intended recipients, please immediately notify us by return 
email and delete it from your system. Any unauthorised dissemination, 
distribution or copying of this email is strictly prohibited. Thank You.
