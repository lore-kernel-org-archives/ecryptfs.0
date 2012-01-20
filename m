From: Tyler Hicks <tyhicks@canonical.com>
Subject: eCryptfs: Truncate path improvements
Date: Fri, 20 Jan 2012 16:35:04 -0600
Message-ID: <1327098907-28963-1-git-send-email-tyhicks@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, john.johansen@canonical.com, dustin.kirkland@gazzang.com, Cong Wang <xiyou.wangcong@gmail.com>, Li Wang <liwang@nudt.edu.cn>

As Linus pointed out[1], eCryptfs needs more checks around its truncate path.
The first patch in this series makes it possible for an eCryptfs truncate
operation to be gracefully interrupted by a fatal signal. The second adds
checks for eCryptfs inode changes in setattr. The third is simply removal of
an old, unused function.

Tyler

[1] https://lkml.org/lkml/2012/1/18/356

