From: Chris Dunlop <chris-s239Etu9j1dPR4JQBCEnsQ@public.gmane.org>
Subject: Re: [PATCH 1/1] fix d_revalidate oopsen on NFS exports
Date: Thu, 1 Dec 2011 18:23:08 +1100
Message-ID: <20111201072308.GA10932@onthe.net.au>
References: <1321861008-20611-1-git-send-email-chris@onthe.net.au>
 <20111129082501.GA569@onthe.net.au>
 <20111201065024.GB495@boyd>
Mime-Version: 1.0
Return-path: <linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20111201065024.GB495@boyd>
Sender: linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tyler Hicks <tyhicks-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Cc: linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Eric Van Hensbergen <ericvh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ron Minnich <rminnich-4OHPYypu0djtX7QSmKvirg@public.gmane.org>, Latchesar Ionkov <lucho-OnYtXJJ0/fesTnJN9+BGXg@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jan Harkes <jaharkes-ETDLCGt7PQU3uPMLIKxrzw@public.gmane.org>, "maintainer:CODA FILE SYSTEM" <coda-ETDLCGt7PQU3uPMLIKxrzw@public.gmane.org>, Dave Kleikamp <shaggy-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Petr Vandrovec <petr-vPk2MGR0e28uaRcfnNAh7A@public.gmane.org>, Trond Myklebust <Trond.Myklebust-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, v9fs-developer-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-afs-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, codalist-OCorLXSLWn+MVn35/9/JlcWGCVk0P7UB@public.gmane.org, jfs-discussion-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ecryptfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, Dec 01, 2011 at 12:50:25AM -0600, Tyler Hicks wrote:
> On 2011-11-29 19:25:01, Chris Dunlop wrote:
>> I haven't seen any response to this patch which fixes an Oops in
>> d_revalidate. I hit this using NFS, but various other file
>> systems look to be likewise vulnerable, hence the broadness of
>> the patch. The sequence leading to the Oops is:
>> 
>> lookup_one_len() [fs/namei.c]
>>    calls __lookup_hash() [fs/namei.c] with nd == NULL,
>>       which can then call the file system specific d_revalidate(), passing in nd == NULL
>>          which will then Oops if nd is used without checking
> 
> Hey Chris - Can you share what you were trying to do when you hit this?
> Were you stacking eCryptfs on top of NFS? Another stacked filesystem on
> top of NFS?
>
> Do you *need* a stacked filesystem to work on top of NFS? If so, we'll
> need to discuss a way forward. Al has previously shown a dislike of
> eCryptfs passing around nameidata (for good reason), but that is what
> NFS currently requires. I looked at doing this a few months back, but
> never got to the implementation stage.

Actually, no, it wasn't eCryptfs or another stacked filesystem.
It seems my dirty little secret must come out: I hit the problem
when trying to use the (necessarily) out-of-tree zfsonlinux
(ZoL) [1], on an NFS root machine.

I don't know exactly what ZoL is using lookup_one_len() for, nor
how to fix it so it isn't, but I've given them the heads up that
it's not supposed to be used outside of original file system [2].

Chris.

[1] http://zfsonlinux.org/
[2] https://github.com/zfsonlinux/zfs/issues/456
--
To unsubscribe from this list: send the line "unsubscribe linux-nfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
