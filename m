From: Will Morrison <camocrazed@gmail.com>
Subject: Adding cipher mode as a mount option
Date: Fri, 17 May 2013 22:10:18 -0400
Message-ID: <5196E30A.7040503@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:35405 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340Ab3ERCKA (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 17 May 2013 22:10:00 -0400
Received: by mail-ie0-f182.google.com with SMTP id a14so10827189iee.27
        for <ecryptfs@vger.kernel.org>; Fri, 17 May 2013 19:10:00 -0700 (PDT)
Received: from [10.2.2.141] ([69.166.23.176])
        by mx.google.com with ESMTPSA id wn10sm386277igb.2.2013.05.17.19.09.58
        for <ecryptfs@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 17 May 2013 19:09:58 -0700 (PDT)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: ecryptfs@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

As part of implementing GCM integrity checking for eCryptfs, we
thought that a good first step would be to take the currently
hardcoded mode (cbc) and turn it into a mount option. Once a
filesystem can be created and mounted using arbitrary block modes, we
can work on allowing integrity protection via GCM.

This should also provide a solution to
https://bugs.launchpad.net/ecryptfs/+bug/1176448

Does this sound like a reasonable first step? If not, what issues are
we missing?

In addition, does anyone have tips on speeding up the
develop/compile/test cycle?

- -Will, on behalf Will, Zameer, Michael, and Alvin
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJRluMJAAoJEH8zVN2+6bAceKkP/3q0dlVYTO2iPmntmwCrEOwx
6aiejnK4z+U64b1fj+yg006mpeg6eLVXLeGj8kL17r5J26wVx43VRZwNS9ZzQ17P
fVKMgAcr4VzOyU/zvrjTC55/mAv62IJSclVRK2SxWwMZt+6aw3tWVFUi0q1DDQrA
3Q4rioEe06wYqmGbPF0J1dy10jLhhtzncDy/Y/M0reUPSfQhq2sgJEBTihY+wPzW
wnEEs2IIt9DQu3d1PJgOQoF6UP2jhSGraQgzYiUu9IN3RqIMENG8X9OgkIYonxlH
q7ASQg5sZfLEiSLvYq4jZD48zyeXQF262WTSiW2q2mWxo1OMAj13UEgejyPLj518
NQO23mQAnD4qkL6EqXOb547Bh6BQvd1C6qI2sQU7/ZJp8WukpLmHKEYOILKl5pDq
+8HFHW2fWx6E8xKG9LoXDFp+nLd9LxLCv+zWm7s+xwXxnABR1ZO4C+1hZ5wTQip5
b7vkiAARSiYYNnALxsc/PWzb0DZsEZPev51ay9xH74ed/9Crt4jrV5WLy5MlTjoU
SZJ7IF2x4eoOibfmjpCkCUC7x7vknyLI8uFNOkbnpC0puNHDNX2pdrzJ5dhN7W3B
yTN/hkMc7LSEH9pb7OuynmRV4tmXMf6VuJ+rCzxpcv8/XR0XwZiL0Y1kz/bdExGb
ZSrxFIJdZtzu68Xj6nHe
=LCBo
-----END PGP SIGNATURE-----
