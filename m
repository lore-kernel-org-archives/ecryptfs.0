From: otherthan company <otherthancompany@gmail.com>
Subject: ecryptfs access restrictions
Date: Sat, 16 May 2015 17:42:22 -0700
Message-ID: <CAF-Y8yC6xWWiJGjR5vQgY9Um7OH2Fgf91VOUHjgEL_TdUL_7KQ@mail.gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:33032 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441AbbEQAmX (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Sat, 16 May 2015 20:42:23 -0400
Received: by iebgx4 with SMTP id gx4so147585145ieb.0
        for <ecryptfs@vger.kernel.org>; Sat, 16 May 2015 17:42:22 -0700 (PDT)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org

Hi All,
First, am a newbie for linux and ecryptfs, am just trying to restrict
the app to access the file even after the correct passphase was
provided.
i.e. even after file was decrypted I wanted the file to have multi
factor concern to restrict the file access.

say suppose, while creating/setting up the ecryptfs partition/backend
folder I wanted to define a timeout, for each file access after which
any application would be denied to access his file.

can you guys set some light on the forest.

Thank you
