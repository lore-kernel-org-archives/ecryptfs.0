From: James Muir <james.muir@graphitesoftware.com>
Subject: bug: msm8998, ecryptfs, cannot create files due to invalid keysize
Date: Fri, 27 Oct 2017 16:43:12 -0400
Message-ID: <CAL=R1-=TT+A4cW+y7uNHZrPpK+47pQ_z74ZZzHW=zCgJtBsYOA@mail.gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:48395 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932307AbdJ0UnO (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Fri, 27 Oct 2017 16:43:14 -0400
Received: by mail-lf0-f53.google.com with SMTP id a69so8676936lfe.5
        for <ecryptfs@vger.kernel.org>; Fri, 27 Oct 2017 13:43:14 -0700 (PDT)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-msm@vger.kernel.org
Cc: ecryptfs@vger.kernel.org

There were some changes made in the msm linux kernel (msm8998) to add
hw support to ecryptfs.

Unfortunately, those changes break basic ecryptfs usage; e.g.:

  maple:/data/local/tmp # dd if=/dev/urandom of=mykey.txt bs=1 count=64
  64+0 records in
  64+0 records out
  64 bytes transferred in 0.003 secs (21333 bytes/sec)
  maple:/data/local/tmp # cat mykey.txt | keyctl padd user mykey @us
  409613533
  maple:/data/local/tmp # keyctl add encrypted 1000000000000000 "new
ecryptfs user:mykey 64" @us
  522453367
  maple:/data/local/tmp # mkdir Private
  maple:/data/local/tmp # mount -t ecryptfs -o
ecryptfs_sig=1000000000000000,ecryptfs_cipher=aes,ecryptfs_key_bytes=32
Private Private                               maple:/data/local/tmp #
touch Private/foo.txt
  touch: 'Private/foo.txt': Invalid argument

It is not possible to create any files inside the ecryptfs mounted directory.

This regression was introduced in the following commit:

  https://github.com/sonyxperiadev/kernel/commit/8928f8683bcd0236f5653963deee3bc225fb2206

That commit is also present in aosp (e.g. the Pixel 2 uses the
msm8998; but note that the aosp kernels do not enable ecryptfs).

The msm gerrit id is I453dea289b01bdf49352d5209255966052f5dc1b (sorry
-- I can't seem to find a way to point to the msm gerrit server)

The commit modified several keysize parameters.  The problem now is
that an invalid keysize (64 bytes) is passed into an aes setkey
operation (64 is too large).  The setkey operation happens in
fs/ecryptfs/keystore.c.  The value 64 is a default value set in the
function ecryptfs_fill_auth_tok() in
security/keys/encrypted-keys/ecryptfs_format.c

-James M
