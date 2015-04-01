From: Marc de Verdelhan <mdeverdelhan@gmail.com>
Subject: Way to decrypt an encrypted /home
Date: Wed, 1 Apr 2015 09:52:49 +0200
Message-ID: <CAHTahaZZetDg8=X=G4rTRJJWJBRXrN4N1dK86kUqwOXXKhh7bQ@mail.gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:33137 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117AbbDAHwv (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Wed, 1 Apr 2015 03:52:51 -0400
Received: by lbbzk7 with SMTP id zk7so13779689lbb.0
        for <ecryptfs@vger.kernel.org>; Wed, 01 Apr 2015 00:52:49 -0700 (PDT)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org

Hi there,

I made a huge mistake and I need some help.

I was running Linux Mint 17 (based on Ubuntu 14.04) with an encrypted
home directory (using eCryptfs). /home and / were on separated
partitions.
Last week I replaced Mint by Debian. I formatted the / partition and
kept the /home one. Now I can't decrypt my data. :/

So I installed the ecryptfs-utils package.

"ecryptfs-mount-private" returns:
Error: Unwrapping passphrase and inserting into the user session
keyring failed [-5]
Info: Check the system log for more information from libecryptfs
ERROR: Your passphrase is incorrect

"/var/log/syslog" contains:
ecryptfs-insert-wrapped-passphrase-into-keyring: Incorrect wrapping
key for file [/home/login/.ecryptfs/wrapped-passphrase]
ecryptfs-insert-wrapped-passphrase-into-keyring: Error attempting to
unwrap passphrase from file
[/home/login/.ecryptfs/wrapped-passphrase]; rc = [-5]

"ecryptfs-unwrap-passphrase
/home/.ecryptfs/login/.ecryptfs/wrapped-passphrase" returns:
Error: Unwrapping passphrase and inserting into the user session
keyring failed [-5]
Info: Check the system log for more information from libecryptfs

To be sure I reinstalled the original Linux Mint on the / partition,
using the same login:password as before my misfortune. Same results.
I'm ABSOLUTELY sure that I'm using the same login and password than
last week. I installed Linux Mint 17 on June 2014; the ecryptfs-utils
version should have been "104-0ubuntu1".

So questions are:
1) What happened? Did I erase a configuration file I shouldn't? I
would like to understand what operation occurred to be in that
unpleasant situation?

2) What are my options? It may involve some C development if needed.
According to you, is there a way to brute force something? Or a more
intelligent solution, starting with sit down, have a tea and think.

Any help will be greatly appreciated. Thank you for reading.

Marc
