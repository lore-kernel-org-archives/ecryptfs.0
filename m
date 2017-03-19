From: Wanli Xing <wlxing1996@gmail.com>
Subject: About hmac verification in eCryptfs
Date: Sun, 19 Mar 2017 21:53:59 +0800
Message-ID: <CAG5w+xJ1XdYGtvtzPs3bc5JqHbi596XEUOEnsBeR3CLF69GcpQ@mail.gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-ot0-f178.google.com ([74.125.82.178]:34805 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751369AbdCSNyB (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Sun, 19 Mar 2017 09:54:01 -0400
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org, Tyler Hicks <tyhicks@canonical.com>, linux-kernel@vger.kernel.org

Hi everyone,
    I'm a junior student from China and this is the first time to
write such email. Thank you everyone. Any advice are welcome !
    I have implemented hmac verification in eCryptfs based on the
Linux-kernel 3.3.8. I referred to Michael Halcrow's hmac patch(based
on 2.6.24 kernel).
    This is how I did to eCryptfs hmac calculation:
    1. I calculated every 128 extent and I get hmac value which will
be stored in second-hmac-extent. Every extent can save 128 hmac value.
So if we calculated 128*128 extent, then we got a second-hmac-extent
full of hmac value.
    2. Also, the same calculation goes with second-hmac-extent: we
will calculated 128 second-hmac-extent and save the value in another
extent called first-hmac-extent.
    3. We calculated all the first-hmac-extent and stored in the
metadata(header). The disk layout of this format is: ext4-metadata,
ecryptfs-metadata(including root hmac), 1st and 2nd hmac extent and
the real data.
    This is how I did to eCryptfs hmac verification:
    1. Every time I open a file, it will verify the hmac value as I
talked before (It consumes too much time, I think). But there are
still 2 exceptions which are copying a file to the directory mounted
already and delete all the data in an existing file that is stored in
the directory already.
    2. If we close the file, all the 1st and 2nd hmac extents will be
flushed into the disk. The root hmac value will be stored in header
only if we call ecryptfs_writepage() function, which means every time
I write one page, I will update the root hmac.

So...do you all have any suggestions or comments. Thank you all.

Cheers,
Jason Xing
