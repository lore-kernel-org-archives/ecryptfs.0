From: Ivan Yosifov <iyosifov@gmail.com>
Subject: Ecryptfs over sshfs and timestamps
Date: Sun, 21 Apr 2013 13:30:33 +0300
Message-ID: <CAHHtCV9kvjbmUnH584HUaDLtVktjcP7fB1myWBx-kcsErF7zZw@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-vb0-f54.google.com ([209.85.212.54]:54782 "EHLO
	mail-vb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752964Ab3DUKae convert rfc822-to-8bit (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Sun, 21 Apr 2013 06:30:34 -0400
Received: by mail-vb0-f54.google.com with SMTP id w16so5018350vbf.13
        for <ecryptfs@vger.kernel.org>; Sun, 21 Apr 2013 03:30:33 -0700 (PDT)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: ecryptfs@vger.kernel.org

Hi all,

I'm trying to use ecrypts on top of an sshfs mount for remote backup
to an untrusted machine. I'm having a problem with timestamps however:

$ cp -a file.txt bak/
cp: preserving times for =91bak/file.txt=92: Operation not permitted

rsync -a is giving a similar error too, but cp -a to the underlying
sshfs works. Any help would be much appreciated.

Thanks,
Ivan Yosifov
