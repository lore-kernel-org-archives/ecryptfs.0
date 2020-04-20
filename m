From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 00/33] Documentation fixes for Kernel 5.8
Date: Mon, 20 Apr 2020 15:43:16 -0600
Message-ID: <20200420154316.28e42905@lwn.net>
References: <cover.1586881715.git.mchehab+huawei@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from ms.lwn.net ([45.79.88.28]:53958 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbgDTVnT (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
        Mon, 20 Apr 2020 17:43:19 -0400
In-Reply-To: <cover.1586881715.git.mchehab+huawei@kernel.org>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, Maxime Ripard <maxime@cerno.tech>, Linus Walleij <linus.walleij@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Kishon Vijay Abraham I <kishon@ti.com>, Yuti Amonkar <yamonkar@cadence.com>, devicetree@vger.kernel.org, linux-arch@vger.kernel.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, linux-mm@kvack.org, linux-rdma@vger.kernel.org, kvmarm@lists.cs.columbia.edu, linux-crypto@vger.kernel.org, linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, linux

On Tue, 14 Apr 2020 18:48:26 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Patches 1 to 5 contain changes to the documentation toolset:
> 
> - The first 3 patches help to reduce a lot the number of reported
>   kernel-doc issues, by making the tool more smart.
> 
> - Patches 4 and 5 are meant to partially address the PDF
>   build, with now requires Sphinx version 2.4 or upper.
> 
> The remaining patches fix broken references detected by
> this tool:
> 
>         ./scripts/documentation-file-ref-check
> 
> and address other random errors due to tags being mis-interpreted
> or mis-used.
> 
> They are independent each other, but some may depend on
> the kernel-doc improvements.
> 
> PS.: Due to the large number of C/C, I opted to keep a smaller
> set of C/C at this first e-mail (only e-mails with "L:" tag from
> MAINTAINERS file).

OK, I've applied this set, minus #17 which was applied elsewhere.

Thanks,

jon
