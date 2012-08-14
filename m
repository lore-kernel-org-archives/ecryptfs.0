From: Douglas Leeder <douglas.leeder@sophos.com>
Subject: Re: ecryptfs and fanotify
Date: Tue, 14 Aug 2012 17:01:14 +0100
Message-ID: <94863d0d-4a43-427e-8c75-a6f8ced15ffa@ABN-EXCH1A.green.sophos>
References: <5d3d0cdc-50db-4d60-8f9d-701acdbb86b0@ABN-EXCH1A.green.sophos> <CANT6BaPhaAOv3hg9CgoDa9JTp9vN60zf8bdAQX+dFp6YLSUwnA@mail.gmail.com> <F85176E33E12BA45BD553324E7858B300CE0A5@abn-exch1b.green.sophos> <20120814093124.GA12898@astaro.com> <502A2D77.50805@sophos.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mx3.sophos.com ([216.47.234.212]:38500 "EHLO mx3.sophos.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755540Ab2HNQBW convert rfc822-to-8bit (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 14 Aug 2012 12:01:22 -0400
In-Reply-To: <502A2D77.50805@sophos.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Florian Westphal <Florian.Westphal@Sophos.com>
Cc: Dustin Kirkland <dustin.kirkland@gazzang.com>, Tyler C Hicks <tyhicks@canonical.com>, Eric Paris <eparis@redhat.com>, "malware-list@dmesg.printk.net" <malware-list@dmesg.printk.net>, Eddie Garcia <eddie.garcia@gazzang.com>, Sergio Pena <sergio.pena@gazzang.com>, "ecryptfs@vger.kernel.org" <ecryptfs@vger.kernel.org>

On 14/08/12 11:50, Douglas Leeder wrote:
> On 14/08/12 10:31, Florian Westphal wrote:
>> Douglas Leeder <douglas.leeder@sophos.com> wrote:
>>> So as, I sent later, making fanotify only return one file event per
>>> fanotify read(), So that suggests that the request is getting stuck
>>> in a cycle or adding a request.
>>>
>>> Florian has also been looking at this problem, and has pointed out
>>> that FMODE_NONOTIFY should prevent the loop seen in the backtrace, so
>>> I'm wondering if it's getting lost somewhere in ecryptfs. Or perhaps
>>> it needs to be explicitly propagated to the open request for the
>>> lower file?
>>
>> Douglas, can you reproduce the problem with this patch applied?
>>
>> diff --git a/fs/ecryptfs/kthread.c b/fs/ecryptfs/kthread.c
>> index 809e67d..1d8a53b 100644
>> --- a/fs/ecryptfs/kthread.c
>> +++ b/fs/ecryptfs/kthread.c
>> @@ -74,7 +74,7 @@ static int ecryptfs_threadfn(void *ignored)
>>                              kthread_ctl_list);
>>               list_del(&req->kthread_ctl_list);
>>               *req->lower_file = dentry_open(&req->path,
>> -                (O_RDWR | O_LARGEFILE), current_cred());
>> +                (O_RDWR | O_LARGEFILE | FMODE_NONOTIFY),
>> current_cred());
>>               complete(&req->done);
>>           }
>>           mutex_unlock(&ecryptfs_kthread_ctl.mux);
>> @@ -133,7 +133,7 @@ int ecryptfs_privileged_open(struct file
>> **lower_file,
>>                    const struct cred *cred)
>>   {
>>       struct ecryptfs_open_req req;
>> -    int flags = O_LARGEFILE;
>> +    int flags = O_LARGEFILE|FMODE_NONOTIFY;
>>       int rc = 0;
>>
>>       init_completion(&req.done);
>>
>
> That patch also seems to fix the problem - at least for AV scanning:
> 1) The encrypted files don't show up in the user-space test program.
> 2) Using the FanotifyMultiThreadScanner (old) from the git tree doesn't
> lock up. (With the single event read() patch removed for the moment).
>
>
> However I don't think this is a sufficient solution for general fanotify.
> For example an HSM may need to get the fanotify event to restore the
> encrypted file to disk.
> Or a file-access recorder (e.g. http://www.piware.de/tag/fanotify/ )
> will want all the accesses, including those 'generated' by the
> fanotify_read() call itself.
>
> Talpa, in this case, has it easier, since it is only used for AV, it can
> ignore any accesses that it's caused.
>
> What we might be able to do is set FMODE_NONOTIFY for the lower access
> if the upper access had it set? Since HSM and fatrace don't want to
> access the contents when they intercept.
>
> I guess HSM and fatrace might not intercept ecryptfs mounts anyway,
> since they don't directly access the disk?
>

So I've looked at the path required for that and I guess it involves
passing file->f_flags from ecryptfs_open through:
  * ecryptfs_get_lower_file (main.c)
  * ecryptfs_init_lower_file (main.c)
  * ecryptfs_privileged_open (kthread.c)

Does that look like the correct to you, Tyler?

I think HSM and fatrace usages won't request the file be opened, so
won't trigger that path though fanotify.

--
Douglas Leeder, Senior Software Engineer

________________________________

Sophos Limited, The Pentagon, Abingdon Science Park, Abingdon, OX14 3YP, United Kingdom.
Company Reg No 2096520. VAT Reg No GB 991 2418 08.
