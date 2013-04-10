From: Colin Ian King <colin.king@canonical.com>
Subject: Re: [RFC v3 1/1] eCryptfs: Use the ablkcipher crypto API
Date: Wed, 10 Apr 2013 18:26:57 +0100
Message-ID: <5165A0E1.3000306@canonical.com>
References: <1365482389-4949-1-git-send-email-tyhicks@canonical.com> <1365534479-13202-1-git-send-email-tyhicks@canonical.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:36691 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934793Ab3DJR1D (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Wed, 10 Apr 2013 13:27:03 -0400
In-Reply-To: <1365534479-13202-1-git-send-email-tyhicks@canonical.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Tyler Hicks <tyhicks@canonical.com>
Cc: ecryptfs@vger.kernel.org, Dustin Kirkland <dustin.kirkland@gazzang.com>, Tim Chen <tim.c.chen@intel.com>, Ying Huang <ying.huang@intel.com>, Thieu Le <thieule@google.com>, Li Wang <dragonylffly@163.com>, Zeev Zilberman <zeev@annapurnaLabs.com>, Jarkko Sakkinen <jarkko.sakkinen@iki.fi>

On 09/04/13 20:07, Tyler Hicks wrote:
> Make the switch from the blkcipher kernel crypto interface to the
> ablkcipher interface.
>
> encrypt_scatterlist() and decrypt_scatterlist() now use the ablkcipher
> interface but, from the eCryptfs standpoint, still treat the crypto
> operation as a synchronous operation. They submit the async request and
> then wait until the operation is finished before they return. Most of
> the changes are contained inside those two functions.
>
> Despite waiting for the completion of the crypto operation, the
> ablkcipher interface provides performance increases in most cases when
> used on AES-NI capable hardware. However, sequential I/O with one or two
> threads on slow storage media does exhibit a sizeable decrease in
> performance.
>

With the testing I've run with the ablkcipher patch I observe a 
noticeable performance win with fast media such as SSD or tmpfs and a 
slight improvement with fast 7200 rpm HDDs. With slower HDDs, I don't 
see any negative performance impact with ablkcipher.  Exercised on a 
recent AES-NI capable Intel 4 core server with 7200 rpm HDD and Intel 
330 SSD and also with a Intel i3-2350M Lenovo X220i laptop with a 5400 
rpm HDD and Intel 330 SSD.

I have also given this patch considerable amount of soak testing 
overnight with continuous parallel kernel builds while also running the 
eCryptfs tests without any issues.

As it stands, I am happy with v3 of this patch.
