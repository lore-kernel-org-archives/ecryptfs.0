From: Tom Vaughan <thomas.david.vaughan@gmail.com>
Subject: Re: How best to crack wrapped-passphrase?
Date: Mon, 20 Jan 2014 14:19:39 -0300
Message-ID: <CAH7xHdjS4RRk4vTa2-MBjR_WGJ3+KfNk9k6w1Tby5g75g1Ejpw@mail.gmail.com>
References: <CACO3_sAgbSWb_JbZrCWZNbmJuPkmkimt9-oMOhwiCgaoROXrwQ@mail.gmail.com>
	<CACO3_sAKEg0ScQnd4fyis5r4g9teGO3VEhU-iYmdfa1cCAE1QQ@mail.gmail.com>
	<CACO3_sDAGU52BPpONLfdmOSF4ij+mGxVib_6WgRhYPbcTgbdvw@mail.gmail.com>
	<CACO3_sAmQFu0raHhd3Mc60dCWUuzE4Z_u4dG_F06x8G5Qh4g2Q@mail.gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:46344 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbaATRTk (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 20 Jan 2014 12:19:40 -0500
Received: by mail-wi0-f182.google.com with SMTP id ex4so3423751wid.3
        for <ecryptfs@vger.kernel.org>; Mon, 20 Jan 2014 09:19:39 -0800 (PST)
In-Reply-To: <CACO3_sAmQFu0raHhd3Mc60dCWUuzE4Z_u4dG_F06x8G5Qh4g2Q@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Artur Rataj <arturrataj@gmail.com>
Cc: ecryptfs <ecryptfs@vger.kernel.org>

On Mon, Jan 20, 2014 at 2:08 PM, Artur Rataj <arturrataj@gmail.com> wrote:
> And if the passphrase is really mispelled, perhaps the best approach
> is to "mutate" it. I would wrote some simple looping program that
> would do some resonable insertions/deletions/replacements over the
> original passphrase and would use the result to brute-force the
> decryption. If there are some fixed time delays anywhere, removing
> them and re-compiling some kernel module or tool would likely be
> needed too.

I'm in the process of doing this now. I wrote a script to try various
mutations of the password I think it should be. See below. This ran
over the weekend, nearly melted my laptop, and didn't unwrap the
passphrase. Each iteration takes maybe half a second. At this rate
it's not feasible to try a brute force for all possible character
permutations. My next step is to create an optimised compiled version
that does this, and run it on a cloud instance somewhere. I happen to
have another wrapped-passphrase for a different encrypted directory. I
know that passphrase, and I can unwrap it (in the script below too).
Right now my compiled version cannot unwrap the control
wrapped-passhrase.

Thanks.

-Tom


#!/bin/bash

WRAPPED_PASSPHRASE="/path/to/wrapped-passphrase"
test ! -f "${WRAPPED_PASSPHRASE}" && echo "${WRAPPED_PASSPHRASE}" does
not exist. && exit 1

function unwrap() {
    echo "$@".
    printf "%s" "$@" | ecryptfs-unwrap-passphrase
"${WRAPPED_PASSPHRASE}" - 2>/dev/null
    test $? = 0 && exit 0
}

for x1 in some pattern 1;  do
  for x2 in some pattern 2;  do
    for x3 in some pattern 3;  do
      for x4 in some pattern 4;  do
        unwrap "${x1}${x2}${x3}${x4}"
      done
    done
  done
done

exit 1
