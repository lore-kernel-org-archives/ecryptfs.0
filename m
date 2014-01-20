From: Tom Vaughan <thomas.david.vaughan@gmail.com>
Subject: Re: How best to crack wrapped-passphrase?
Date: Mon, 20 Jan 2014 14:38:40 -0300
Message-ID: <CAH7xHdjdh-hzdvLqX46H77ZPcG2JWDrgdRH6CZj301xooparbA@mail.gmail.com>
References: <CACO3_sAgbSWb_JbZrCWZNbmJuPkmkimt9-oMOhwiCgaoROXrwQ@mail.gmail.com>
	<CACO3_sAKEg0ScQnd4fyis5r4g9teGO3VEhU-iYmdfa1cCAE1QQ@mail.gmail.com>
	<CACO3_sDAGU52BPpONLfdmOSF4ij+mGxVib_6WgRhYPbcTgbdvw@mail.gmail.com>
	<CACO3_sAmQFu0raHhd3Mc60dCWUuzE4Z_u4dG_F06x8G5Qh4g2Q@mail.gmail.com>
	<CAH7xHdjS4RRk4vTa2-MBjR_WGJ3+KfNk9k6w1Tby5g75g1Ejpw@mail.gmail.com>
	<CACO3_sBQz_2uevZO-6-6rv2Z4M1ZH2VZJ54VvjikvBw_hUXJqA@mail.gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:47245 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbaATRil (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 20 Jan 2014 12:38:41 -0500
Received: by mail-wg0-f44.google.com with SMTP id l18so7174698wgh.35
        for <ecryptfs@vger.kernel.org>; Mon, 20 Jan 2014 09:38:40 -0800 (PST)
In-Reply-To: <CACO3_sBQz_2uevZO-6-6rv2Z4M1ZH2VZJ54VvjikvBw_hUXJqA@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Artur Rataj <arturrataj@gmail.com>
Cc: ecryptfs <ecryptfs@vger.kernel.org>

On Mon, Jan 20, 2014 at 2:34 PM, Artur Rataj <arturrataj@gmail.com> wrote:
> I guess a better "mutator" would be something more complex, taking
> into account your personal habits of writing passwords, likely
> misspellings like "O" vs "0" if you wrote the characters off the
> screen, swapped pairs etc. If unsuccessful, the program would increase
> the number of mutations (breadth first search).

Yup. Did that.

>
> Also, it might be worth checking if the 0.5 sec delay is not mostly a
> loop for preventing attacks. System load might reveal an idle loop,
> source analysis (profiling?) might reveal a busy loop.

Yup. In the process of doing this now.

>
> Modifying the source of ecryptfs-unwrap-passphrase to directly include
> your code might help too, as you would save on starting a process each
> time.

Yup. This is what I started with. But a trivial update, like hard-code
the known passphrase for the control wrapped-passphrase, fails.
