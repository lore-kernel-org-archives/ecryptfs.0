From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2/2] ecryptfs: don't allow mmap when the lower fs doesn't
 support it
Date: Wed, 3 Aug 2016 05:49:27 +0200
Message-ID: <20160803034927.GA31125@kroah.com>
References: <1467754350-8995-1-git-send-email-jeffm@suse.com>
 <1467754350-8995-2-git-send-email-jeffm@suse.com>
 <577EE3A8.4030106@canonical.com>
 <06093b3e-1364-715d-4db1-c9b4756ae2bf@suse.com>
 <20160802145005.3a7ed0f6@pc-198.iww-online.de>
 <2d10394e-b255-92b0-f378-a164cd731b9e@suse.com>
Mime-Version: 1.0
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2d10394e-b255-92b0-f378-a164cd731b9e@suse.com>
Sender: stable-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeff Mahoney <jeffm@suse.com>
Cc: Henry Jensen <hjensen@gmx.de>, Tyler Hicks <tyhicks@canonical.com>, ecryptfs@vger.kernel.org, Jann Horn <jann@thejh.net>, stable@vger.kernel.org

On Tue, Aug 02, 2016 at 09:05:04AM -0400, Jeff Mahoney wrote:
> On 8/2/16 8:50 AM, Henry Jensen wrote:
> > Hello,
> > 
> > is there any new status? We are meanwhile at kernel 4.4.16 LTS and
> > ecryptfs is still broken there.
> 
> The revert and the fix below, plus Tyler's cleanup, landed in 4.7.  Both
> were tagged for inclusion in -stable but haven't landed there yet.  I'm
> afraid that's the limit of my tracking of it.

Yes, that's all you need to do.  I'll be queueing these up soon, I have
200+ stable patches to process at this point in time.

Henry, there's nothing preventing you from adding these to your local
trees if you need them.

thanks,

greg k-h
