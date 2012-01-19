From: Cong Wang <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH] eCryptfs: infinite loop due to overflow in ecryptfs_write()
Date: Thu, 19 Jan 2012 23:09:49 +0800
Message-ID: <4F18323D.2000109@gmail.com>
References: <12011909443668a7a65ff897afc93db177848236f08f@nudt.edu.cn> <1326964413-8529-1-git-send-email-tyhicks@canonical.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1326964413-8529-1-git-send-email-tyhicks@canonical.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Tyler Hicks <tyhicks@canonical.com>
Cc: Li Wang <liwang@nudt.edu.cn>, ecryptfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Yunchuan Wen <wenyunchuan@kylinos.com.cn>

On 01/19/2012 05:13 PM, Tyler Hicks wrote:
> From: Li Wang<liwang@nudt.edu.cn>
>
> ecryptfs_write() can enter an infinite loop when truncating a file to a
> size larger than 4G. This only happens on architectures where size_t is
> represented by 32 bits.
>
> This was caused by a size_t overflow due to it incorrectly being used to
> store the result of a calculation which uses potentially large values of
> type loff_t.
>
> [tyhicks@canonical.com: rewrite subject and commit message]
> Signed-off-by: Li Wang<liwang@nudt.edu.cn>
> Signed-off-by: Yunchuan Wen<wenyunchuan@kylinos.com.cn>
> Cc: Cong Wang<xiyou.wangcong@gmail.com>
> Cc:<stable@vger.kernel.org>
> Signed-off-by: Tyler Hicks<tyhicks@canonical.com>


Tyler, thanks for cleaning this up! Looks pretty good now.
