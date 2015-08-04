From: Richard Weinberger <richard@nod.at>
Subject: Re: [RFC][PATCH] ecryptfs: Allow only one instance per lower path
Date: Tue, 4 Aug 2015 07:46:50 +0200
Message-ID: <55C051CA.60009@nod.at>
References: <1438338190-22518-1-git-send-email-richard@nod.at>
 <20150802010259.GA19522@boyd> <55BDCBF4.1050305@nod.at>
 <20150803052758.GA24915@boyd> <55BFB39D.5070702@nod.at>
 <20150803230754.GB2342@boyd>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20150803230754.GB2342@boyd>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Tyler Hicks <tyhicks@canonical.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>

Tyler,

Am 04.08.2015 um 01:07 schrieb Tyler Hicks:
>> Okay, then I'd argument to give my patch a try although it is not the solution
>> to the problem I've reported. :-)
>> If you don't mind I'll resend with a proper changelog.
> 
> That patch isn't correct since it assumes that all eCryptfs super blocks
> are equal if the lower paths (and, ultimately, the lower inode) are
> equal. However, the lower path is only one of many properties of an
> eCryptfs superblock. For example, the second mount may have been
> configured to use a different file encryption key.

How would this work if I mount /foo using AES to /mnt_a
and /foo again using 3DES to /mnt_b?
Wouldn't both ecrytpfs instances kill each other's files?

Thanks,
//richard
