From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: eCryptfs: Truncate path improvements
Date: Mon, 23 Jan 2012 08:49:40 -0800
Message-ID: <CA+55aFzpM-c9FWdC8+7sV0GOXqvFNvxPsrV42rvXJHXnKsDoZg@mail.gmail.com>
References: <1327098907-28963-1-git-send-email-tyhicks@canonical.com>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1327098907-28963-1-git-send-email-tyhicks@canonical.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tyler Hicks <tyhicks@canonical.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, john.johansen@canonical.com, dustin.kirkland@gazzang.com, Cong Wang <xiyou.wangcong@gmail.com>, Li Wang <liwang@nudt.edu.cn>

On Fri, Jan 20, 2012 at 2:35 PM, Tyler Hicks <tyhicks@canonical.com> wrote:
> As Linus pointed out[1], eCryptfs needs more checks around its truncate path.
> The first patch in this series makes it possible for an eCryptfs truncate
> operation to be gracefully interrupted by a fatal signal. The second adds
> checks for eCryptfs inode changes in setattr. The third is simply removal of
> an old, unused function.

Tyler, should I take these patches directly? Or are these just for
review and I should wait for a pull request?

                        Linus
