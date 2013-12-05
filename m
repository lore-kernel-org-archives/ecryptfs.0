From: Catalin Ionita <io.catalin@gmail.com>
Subject: Looking for volunteers to test and review ecryptfs integration with Android
Date: Thu, 5 Dec 2013 19:32:11 +0200
Message-ID: <CAGE04zTe4VP_hDju9E9m8ONbTPZyv_pZ=9CPkd5Ke8aOK9Ddyg@mail.gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-qe0-f47.google.com ([209.85.128.47]:43725 "EHLO
	mail-qe0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756938Ab3LERcL (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Thu, 5 Dec 2013 12:32:11 -0500
Received: by mail-qe0-f47.google.com with SMTP id t7so17906480qeb.34
        for <ecryptfs@vger.kernel.org>; Thu, 05 Dec 2013 09:32:11 -0800 (PST)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org

Hi,

I've been working for some time on a solution to integrate ecryptfs
in Android. Due to some Android specifics and license problems I had
to rewrite the userspace tools. Also, for a nice finish touch, I have
implemented Android user data encryption from top (including a minimal
GUI) to bottom on a Nexus 4 running latest AOSP kitkat.

I'm looking for volunteers to test, review or contribute to Android
userspace tools that I've built. The project is stored at
https://github.com/catalinionita/Ecryptfs-Tools-for-Android

--Catalin
