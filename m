From: Dustin Kirkland <dustin.kirkland@gazzang.com>
Subject: Re: [PATCH] eCryptfs: infinite loop bug
Date: Thu, 19 Jan 2012 08:03:57 -0600
Message-ID: <CANT6BaOqXwut5iA2ADO_2avW2kCSV0WL_6=3Vv1zdFNXrnXjPA@mail.gmail.com>
References: <12011815300568720b5d1587bb777fed0d5b016f0854@nudt.edu.cn>
	<4F16E4BC.5080100@gmail.com>
	<526922120.05125@eyou.net>
	<12011909443668a7a65ff897afc93db177848236f08f@nudt.edu.cn>
	<20120119084836.GA29477@boyd>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:47781 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567Ab2ASOD7 convert rfc822-to-8bit (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Thu, 19 Jan 2012 09:03:59 -0500
In-Reply-To: <20120119084836.GA29477@boyd>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Tyler Hicks <tyhicks@canonical.com>
Cc: Li Wang <liwang@nudt.edu.cn>, ecryptfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>

On Thu, Jan 19, 2012 at 2:48 AM, Tyler Hicks <tyhicks@canonical.com> wr=
ote:
> On 2012-01-19 09:44:36, Li Wang wrote:
>>
>>
>> Hi,
>> =A0 Thanks Cong Wang for the kind reminding regarding the patch form=
at.
>
> The commit message still needs some work. But there's no need to drag
> out the process for a fix like this, so I'll rewrite the commit messa=
ge
> and reply to this email with the cleaned up version. Let me know if y=
ou
> have any problems with that. You'll still be credited as the author.
>
> For future kernel patches, please see "15) The canonical patch format=
"
> of Documentation/SubmittingPatches and "5.4: PATCH FORMATTING AND
> CHANGELOGS" of Documentation/development-process/5.Posting for more
> information on how the commit message should be written.
>
> Also, your email came across in base64 encoding. I'm not sure of the
> reason for that or how to fix it.
>
>> =A0 We did notice that the total_remaining_zeroes need be revised as=
 well,
>> and the start_offset_in_page, num_bytes need not be revised (always =
smaller
>
> Yes, size_t will work fine, as Linus confirmed.
>
>> than PAGE_CACHE_SIZE, even the huge page size is supported,
>> the 4G page size is not present in the current world?)
>> but we forget to include the revision for total_remaining_zeroes, so=
 here comes the patch.
>
> I really appreciate the patch - thanks!

Tyler,

Is this the problem behind our long standing
tor-download-on-ecryptfs-hangs-cpu bug?
 * https://bugs.launchpad.net/ecryptfs/+bug/431975

--=20
:-Dustin

Dustin Kirkland
Chief Architect
Gazzang, Inc.
www.gazzang.com
