From: Space Cake <spacecakex@gmail.com>
Subject: ecryptfs / aladdin token
Date: Tue, 17 Jan 2012 17:43:00 +0100
Message-ID: <4F15A514.8050106@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:53678 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755086Ab2AQQng (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 17 Jan 2012 11:43:36 -0500
Received: by werb14 with SMTP id b14so1263657wer.19
        for <ecryptfs@vger.kernel.org>; Tue, 17 Jan 2012 08:43:35 -0800 (PST)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: ecryptfs@vger.kernel.org

Hi,

I'm trying to use an aladdin token to access some sensitive information.
Unfortunately I'm getting the following error message

vlad@brutal ~ $ ecryptfs-manager

eCryptfs key management menu
-------------------------------
    1. Add passphrase key to keyring
    2. Add public key to keyring
    3. Generate new public/private keypair
    4. Exit

Make selection: 2
[opensc-pkcs11] reader-pcsc.c:896:pcsc_detect_readers: SCardListReaders
failed: 0x8010002e
[opensc-pkcs11] reader-pcsc.c:1015:pcsc_detect_readers: returning with:
No readers found
Select key type to use for newly created files:
 1) tspi
 2) passphrase
 3) openssl
 4) pkcs11-helper
Selection: 4
[opensc-pkcs11] reader-pcsc.c:896:pcsc_detect_readers: SCardListReaders
failed: 0x8010002e
[opensc-pkcs11] reader-pcsc.c:1015:pcsc_detect_readers: returning with:
No readers found
[opensc-pkcs11] reader-pcsc.c:896:pcsc_detect_readers: SCardListReaders
failed: 0x8010002e
[opensc-pkcs11] reader-pcsc.c:1015:pcsc_detect_readers: returning with:
No readers found
PKCS#11 Serialized ID:
Passphrase (empty for interactive):
Optional X.509 Certificate PEM file:
Error processing key generation decision graph; rc = [-5]

I can see the card from pkcs11-tool

vlad@brutal ~ $ pkcs11-tool -L
[opensc-pkcs11] reader-pcsc.c:896:pcsc_detect_readers: SCardListReaders
failed: 0x8010002e
[opensc-pkcs11] reader-pcsc.c:1015:pcsc_detect_readers: returning with:
No readers found
[opensc-pkcs11] reader-pcsc.c:896:pcsc_detect_readers: SCardListReaders
failed: 0x8010002e
[opensc-pkcs11] reader-pcsc.c:1015:pcsc_detect_readers: returning with:
No readers found
Available slots:
Slot 0           Aladdin eToken PRO
  token label:   OpenSC Card (vlad)
  token manuf:   OpenSC Project
  token model:   PKCS#15
  token flags:   login required, PIN initialized, token initialized
  serial num  :  262119072909

any idea? same token is working for ssh login

Thank you
L:
