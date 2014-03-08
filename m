From: Jon Skarpeteig <jon.skarpeteig@gmail.com>
Subject: NFS -> eCryptfs -> Samba = files disappearing
Date: Sat, 8 Mar 2014 12:18:02 +0100
Message-ID: <CAF9utUuXXvZwz=1bD+zAz=_QoKgj2o2m4U+1shMB=jdcGXjUqw@mail.gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-oa0-f42.google.com ([209.85.219.42]:64862 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880AbaCHLSW (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Sat, 8 Mar 2014 06:18:22 -0500
Received: by mail-oa0-f42.google.com with SMTP id i4so5302295oah.29
        for <ecryptfs@vger.kernel.org>; Sat, 08 Mar 2014 03:18:22 -0800 (PST)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs <ecryptfs@vger.kernel.org>

I have a NAS server exposing data stores over NFS. Then I have an
Ubuntu 12.04 machine running eCryptfs with filename encryption (rest
is default from using mount command). The 'decrypted' folder is
exposed to my Windows machine using Samba.

This all seems to work at first (create, read, update, delete) - but
when accessing large files, and doing seek - the entire folder in
which the file exists disappears. When listing the folder (both samba
and locally), it's displayed as completely empty.

If I remount the 'decrypted' folder again, the files re-appear

How to further debug (and fix) this issue?

- Jon Skarpeteig
