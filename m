From: Thiago Padilha <tpadilha84@gmail.com>
Subject: Re: Storing the executable bit along with the rest of cryptographic metadata
Date: Fri, 1 Feb 2013 09:40:53 -0300
Message-ID: <CAAq2XdqGibY50mkFs8AqJL0BJHFfn_hT_3U-ewEM20p_a+u8DQ@mail.gmail.com>
References: <CAAq2XdoN6E0xGyn-cVBTvVjmXZ7i2bpfDrdhC9FjB60_DPerWw@mail.gmail.com>
	<20130131172907.GA3422@boyd>
	<CAPv9ZmndfGvgdEhHaie9Sm81pZ+mPfTRX67EGRPN8B4r96RKHQ@mail.gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-ia0-f182.google.com ([209.85.210.182]:51105 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753471Ab3BAMky (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 1 Feb 2013 07:40:54 -0500
Received: by mail-ia0-f182.google.com with SMTP id w33so5294949iag.27
        for <ecryptfs@vger.kernel.org>; Fri, 01 Feb 2013 04:40:53 -0800 (PST)
In-Reply-To: <CAPv9ZmndfGvgdEhHaie9Sm81pZ+mPfTRX67EGRPN8B4r96RKHQ@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jakob Unterwurzacher <jakobunt@gmail.com>
Cc: Tyler Hicks <tyhicks@canonical.com>, ecryptfs@vger.kernel.org

Jakob, thanks for the tip

On Fri, Feb 1, 2013 at 9:37 AM, Jakob Unterwurzacher <jakobunt@gmail.com> wrote:
> ntfs-3g fully supports linux permissions, including the executable bit (
> stated on
> http://tuxera.com/forum/viewtopic.php?p=7807&sid=72532fa76a378c4c8ffe378da4fb2809#p7807
> ).
> You have to mount with "-o permissions" and probably create the file
> mentioned in the link above.
