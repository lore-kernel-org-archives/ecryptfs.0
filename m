From: Tyler Hicks <tyhicks@canonical.com>
Subject: [RFC 0/1] eCryptfs: Use the ablkcipher crypto API
Date: Fri,  5 Apr 2013 16:42:54 -0700
Message-ID: <1365205375-15921-1-git-send-email-tyhicks@canonical.com>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:55578 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760311Ab3DEXna (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 5 Apr 2013 19:43:30 -0400
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org
Cc: Colin King <colin.king@canonical.com>, Dustin Kirkland <dustin.kirkland@gazzang.com>, Tim Chen <tim.c.chen@intel.com>, Ying Huang <ying.huang@intel.com>, Thieu Le <thieule@google.com>, Li Wang <dragonylffly@163.com>, Zeev Zilberman <zeev@annapurnaLabs.com>, Jarkko Sakkinen <jarkko.sakkinen@iki.fi>

I've written an alternative patch to address the AES-NI performance issues
discussed at various times on this list. I'll refer to this new patch as the
"ablkcipher patch" because it is the most simple way that we could move to the
ablkcipher interface.

The older patches, written by Thieue (ecryptfs: Migrate to ablkcipher API) and
Zeev (eCryptfs: ablkcipher support - add workqueue) are nicely designed but
much more complex. I'll refer to those two patches as the "async patches". My
intent was to come up with a patch that has the same performance benefits as
those patches but with a more straightforward implementation.

The async patches offload the write-to-lower-filesystem work to the crypto API
callback function which then offloads it to a workqueue. The async patches also
include multiple completion functions for page crypto operations and extent
crypto operations. The async patches are well designed but, IMO, a bit more
complex than what is needed. They end up modifying most of the eCryptfs I/O
paths. I've never been comfortable merging them and feeling certain that all
the bugs would be caught by the time the next kernel was released.

So after looking at the performance results of the async patches, some analysis
of the crypto API using the tcrypt module, and some numbers from Colin, it hit
me that I could probably get similar numbers to the async patches by simply
using the ablkcipher interface and then waiting for the results. All of those
changes could be contained inside of crypto.c and the higher level page I/O
functions don't even have to know about the changes to how we're using the
crypto API. I've done some testing on my laptop and it looks like my hunch may
be correct.

If I had to give a quick summary of the ablkcipher patch vs the async patches,
I'd say that the ablkcipher patch accentuates the performance changes found in
the async patches. If the async patches improved throughput for a certain
workload, the ablkcipher patch improves it a little more. If the async patches
decrease performance in a certain case, the ablkcipher patch decrease
performance a little more for that case.

As far as the complexity of changes involved, the ablkcipher patch is much more
simple. The ablkcipher patch diffstat:

 crypto.c          |  141 ++++++++++++++++++++++++++++++++++++----------------
 ecryptfs_kernel.h |    3 -
 2 files changed, 102 insertions(+), 42 deletions(-)

The async patches diffstat:

 crypto.c          |  722 ++++++++++++++++++++++++++++++++++++++++------------
 ecryptfs_kernel.h |   39 ++
 main.c            |   10 
 mmap.c            |   88 +++++-
 4 files changed, 683 insertions(+), 176 deletions(-)

I also plan on collapsing the encrypt_scatterlist() and decrypt_scatterlist()
functions into a single function since the only difference is whether
crypto_ablkcipher_encrypt() or crypto_ablkcipher_decrypt() is called.


Alright, enough about the async patches and ablkcipher patch comparisons. In
comparison to the unpatched kernel, on AES-NI hardware, the ablkcipher patch
shows considerable performance improvements, along with a some important
performance decreases.

I did the testing on my Thinkpad X220, with an i5-2520M, which has AES-NI
support. I tested on the spinning disk (HITACHI HTS723232A7A364), a slow mSATA
SSD (INTEL SSDMAEMC080G2), and eCryptfs mounted on top of tmpfs, using
tiobench.

The situations where performance drops are noticeable are while doing single
and dual threaded sequential reads and writes on slower spinning media (laptop
hard drive). I measure these decreases to be between 8% and 20%. Four and eight
threaded tests start to see increases, especially eight thread sequential reads
and writes (30% to 35%).

When using a SSD, all tests show improvements in performance. The
improvements are much more apparent in single and dual thread tests but
not as apparent in four and eight thread tests. The biggest improvement,
a 139% increase, happens in single-threaded random writes. In other
single and dual thread SSD tests, 15% to 55% improvements can be seen,
except for sequential reads which show minimal improvements.

When mounting eCryptfs on top of tmpfs, improvements over 100% are seen
across the board but tiobench prints ###### on some of the read tests
when testing with this patch because the results are too large, I
believe.

So what's missing? I'd like to see some numbers on a faster SSD than what I
have, numbers on non-AES-NI hardware, and maybe some numbers when using another
cipher such as 3DES. I can do the 3DES testing, but I could use some help with
the first two. Also, I'd appreciate opinions on the bad performance of single
and dual threaded sequential reads and writes on an HDD (maybe other folks'
testing will show better results?).

I'd say that we're still potentially on track for the 3.10 merge window, but I
don't expect anyone to have much time to devote to this between now and then so
we'll have to see.

Tyler
