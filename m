From: Michael Chang <m9chang@uwaterloo.ca>
Subject: Re: Encrypting BTRFS Volume
Date: Mon, 10 Dec 2012 20:51:22 -0500
Message-ID: <CAHcyQ+4TP7V-Lj8zOb9iT4hcxpSA3mCH1nm9WRugr8_jyePQxA@mail.gmail.com>
References: <201212011306.59255.CACook@quantum-sci.com> <201212030956.52866.CACook@quantum-sci.com>
 <201212041004.18477.CACook@quantum-sci.com> <201212101423.08361.CACook@quantum-sci.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:52599 "EHLO
	mailchk-m01.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751523Ab2LKBwH (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 10 Dec 2012 20:52:07 -0500
Received: from mail-ia0-f174.google.com (mail-ia0-f174.google.com [209.85.210.174])
	(authenticated bits=0)
	by mailchk-m01.uwaterloo.ca (8.14.4/8.14.4) with ESMTP id qBB1q3XH023941
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <ecryptfs@vger.kernel.org>; Mon, 10 Dec 2012 20:52:04 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so5374820iay.19
        for <ecryptfs@vger.kernel.org>; Mon, 10 Dec 2012 17:52:03 -0800 (PST)
In-Reply-To: <201212101423.08361.CACook@quantum-sci.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: CACook@quantum-sci.com
Cc: ecryptfs@vger.kernel.org

I don't think that is true _per se_.

I do believe encryption can be theoretically done with snapshots, I'm
just not sure how to do so in a way that's meaningfully safe.

I'm still of the impression that btrfs on top of whole-disk encryption
(dm-crypt) is the best way to go here.

On Mon, Dec 10, 2012 at 5:23 PM,  <CACook@quantum-sci.com> wrote:
> On Tuesday, December 04, 2012 10:04:18 AM CACook@quantum-sci.com wrote:
>>
>> So ecryptfs cannot be applied in my situation, practically.
>
> I get it.  encryption cannot be done if snapshots.
>
> Disappointing.
> --
> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thanks,

Michael Chang
3B Software Engineering (Class of 2014)
University of Waterloo
