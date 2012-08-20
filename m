From: Douglas Leeder <douglas.leeder-j34lQMj1tz/QT0dZR+AlfA@public.gmane.org>
Subject: Re: ecryptfs and fanotify
Date: Mon, 20 Aug 2012 09:46:56 +0100
Message-ID: <f78b2711-3536-460c-a5d8-d7ea7a34b0f0@abn-exch1b.green.sophos>
References: <5d3d0cdc-50db-4d60-8f9d-701acdbb86b0@ABN-EXCH1A.green.sophos>
	<CANT6BaPhaAOv3hg9CgoDa9JTp9vN60zf8bdAQX+dFp6YLSUwnA@mail.gmail.com>
	<F85176E33E12BA45BD553324E7858B300CE0A5@abn-exch1b.green.sophos>
	<20120814093124.GA12898@astaro.com> <502A2D77.50805@sophos.com>
	<94863d0d-4a43-427e-8c75-a6f8ced15ffa@ABN-EXCH1A.green.sophos>
	<20120814202739.GD5215@boyd>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <malware-list-bounces-h+Im9A44IAFcMpApZELgcQ@public.gmane.org>
In-Reply-To: <20120814202739.GD5215@boyd>
List-Id: <ecryptfs.vger.kernel.org>
List-Unsubscribe: <http://dmesg2.printk.net/cgi-bin/mailman/options/malware-list>,
	<mailto:malware-list-request-h+Im9A44IAFcMpApZELgcQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://dmesg2.printk.net/pipermail/malware-list>
List-Post: <mailto:malware-list-h+Im9A44IAFcMpApZELgcQ@public.gmane.org>
List-Help: <mailto:malware-list-request-h+Im9A44IAFcMpApZELgcQ@public.gmane.org?subject=help>
List-Subscribe: <http://dmesg2.printk.net/cgi-bin/mailman/listinfo/malware-list>,
	<mailto:malware-list-request-h+Im9A44IAFcMpApZELgcQ@public.gmane.org?subject=subscribe>
Sender: malware-list-bounces-h+Im9A44IAFcMpApZELgcQ@public.gmane.org
Errors-To: malware-list-bounces-h+Im9A44IAFcMpApZELgcQ@public.gmane.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Tyler C Hicks <tyhicks-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Cc: Florian Westphal <Florian.Westphal-j34lQMj1tz/QT0dZR+AlfA@public.gmane.org>, "malware-list-h+Im9A44IAFcMpApZELgcQ@public.gmane.org" <malware-list-h+Im9A44IAFcMpApZELgcQ@public.gmane.org>, Sergio Pena <sergio.pena-Bv2LyzZ6GzxBDgjK7y7TUQ@public.gmane.org>, "ecryptfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ecryptfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Eric Paris <eparis-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Dustin Kirkland <dustin.kirkland-Bv2LyzZ6GzxBDgjK7y7TUQ@public.gmane.org>, Eddie Garcia <eddie.garcia-Bv2LyzZ6GzxBDgjK7y7TUQ@public.gmane.org>

On 14/08/12 21:27, Tyler C Hicks wrote:

>>
>> So I've looked at the path required for that and I guess it involves
>> passing file->f_flags from ecryptfs_open through:
>>   * ecryptfs_get_lower_file (main.c)
>>   * ecryptfs_init_lower_file (main.c)
>>   * ecryptfs_privileged_open (kthread.c)
>>
>> Does that look like the correct to you, Tyler?
>
> Yeah, that should be the full list.
>
> However, I don't think this approach will work with the current
> eCryptfs design. eCryptfs only keeps one lower file open per inode. That
> means that there could be 10 file descriptors opened for a given
> eCryptfs file but there is still only one lower file opened that
> everything is multiplexed through.


I don't think that matters, either:

a) The file is already open, in which case the fanotify request will
simply pass on the already opened lower file. Or
b) The file is not open, and the flag will be passed onto the new lower
file open request.

For HSM: The lower file will be restored when the first open happens,
which is as required. Presumably the file won't be closed until the last
upper file descriptor is closed, so the HSM won't archive the file too
early either.

For fatrace: The initial open is recorded, and then writes? (I haven't
looked at fatrace in detail).

For AV: The lower file can't be scanned anyway, so it doesn't matter as
long as it doesn't lock up the system.

--
Douglas Leeder, Senior Software Engineer

________________________________

Sophos Limited, The Pentagon, Abingdon Science Park, Abingdon, OX14 3YP, United Kingdom.
Company Reg No 2096520. VAT Reg No GB 991 2418 08.
