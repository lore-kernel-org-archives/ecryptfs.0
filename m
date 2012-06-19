From: "Li Wang" <liwang@nudt.edu.cn>
Subject: RE: Re: [PATCH 1/1] ecryptfs: Migrate to ablkcipher API
Date: Tue, 19 Jun 2012 11:19:52 +0800
Message-ID: <001501cd4dca$67c32ff0$37498fd0$@edu.cn>
References: <1339589670-12189-1-git-send-email-colin.king@canonical.com>	<1339589670-12189-2-git-send-email-colin.king@canonical.com>	<20120613161124.GB21062@boyd>	<CAEcckGpMt1O+2syGbCQYC5ERCmXwCCvYjTYrHEeqZtQsA-qLLg@mail.gmail.com>	<CAEcckGqhvz4gyvTHk0bSXf7pn5yEmWk7N+jT1BGrWxwGBX9wvQ@mail.gmail.com>	<20120613211706.GD22116@boyd>	<CAEcckGqhy9Yx9-vGYDVHBT8utsPR7cYaGjnAoRXM5ejnUonPyg@mail.gmail.com>	<20120613222043.GE22116@boyd>	<539626322.30300@eyou.net>	<2e4d61d7.159a5.137f4febf0f.Coremail.dragonylffly@163.com> <540039783.18266@eyou.net>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail.nudt.edu.cn ([61.187.54.11]:41862 "HELO nudt.edu.cn"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751509Ab2FSD0B convert rfc822-to-8bit (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 18 Jun 2012 23:26:01 -0400
In-Reply-To: <540039783.18266@eyou.net>
Content-Language: zh-cn
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: 'Thieu Le' <thieule@google.com>
Cc: 'Tyler Hicks' <tyhicks@canonical.com>, ecryptfs@vger.kernel.org, 'Colin King' <colin.king@canonical.com>

Hi,
  If I am not wrong, the readahead is turned off by eCryptfs. And, I th=
ink
it should be very careful to turn it on for eCryptfs, since the encrypt=
ion overhead
introduced, and the page being read aheaded may not be used.
  Generally, I think it is very good job to turn the encryption job asy=
nchronously,
I suggest we may consider first adopt some more flexible way, for examp=
le,
give the user chance to choose between synchronous and asynchronous.

Cheers,
Li Wang


-----Original Message-----
=46rom: liwang@nudt.edu.cn [mailto:liwang@nudt.edu.cn] On Behalf Of Thi=
eu Le
Sent: Tuesday, June 19, 2012 1:17 AM
To: dragonylffly
Cc: Tyler Hicks; ecryptfs@vger.kernel.org; Colin King
Subject: Re: Re: [PATCH 1/1] ecryptfs: Migrate to ablkcipher API

Inline.

On Sat, Jun 16, 2012 at 4:12 AM, dragonylffly <dragonylffly@163.com> wr=
ote:
> HI,
> =A0 I did not think it thoroughly, I have two questions,
> 1 For asynchronous encryption, although it may enjoy a throughput
> improvement for a bunch of pages, however, it seems that each dirty
> page will now more likely have a longer time to be written back after
> marked PG_WRITEBACK,
> in other words, it is being locked for a longer time, what if a write
> happens on that locked page? so it seems it may slow down the
> performance on some REWRITE cases.

If I understand you correctly, I think there could be some slowdown in
your scenario if we assume the sync and async crypto code paths are
similar or the async path is longer.  However, if there are are
multiple extents per page, the async approach will allow us to run the
crypto requests in parallel thereby lowering the amount of time under
page lock.


>
> 2 It is not very clear that why it could speed up read performance,
> from the Linux source code, it seems the kernel will wait for the
> non uptodate page being uptodate (do_generic_file_read) before trying=
 next page.

There are two ways that this patch can speed up performance in the read=
 path:

1. If the page contains multiple extents, this patch will submit the
extent decryption requests to the crypto API in parallel.

2. The readahead does not wait for the page to be read thereby
allowing us to submit multiple extents decryption requests in
parallel.


>
> Cheers,
> Li Wang
>
> At=A02012-06-14=A006:25:28,"Thieu=A0Le"=A0<thieule@google.com>=A0wrot=
e:
>>Kewl=A0:)
>>
>>Let=A0me=A0know=A0if=A0you=A0have=A0more=A0questions.
>>
>>
>>On=A0Wed,=A0Jun=A013,=A02012=A0at=A03:20=A0PM,=A0Tyler=A0Hicks=A0<tyh=
icks@canonical.com>=A0wrote:
>>>=A0On=A02012-06-13=A015:03:42,=A0Thieu=A0Le=A0wrote:
>>>>=A0On=A0Wed,=A0Jun=A013,=A02012=A0at=A02:17=A0PM,=A0Tyler=A0Hicks=A0=
<tyhicks@canonical.com>=A0wrote:
>>>>=A0>=A0On=A0Wed,=A0Jun=A013,=A02012=A0at=A011:53=A0AM,=A0Thieu=A0Le=
=A0<thieule@google.com>=A0wrote:
>>>>=A0>>
>>>>=A0>>=A0Hi=A0Tyler,=A0I=A0believe=A0the=A0performance=A0improvement=
=A0from=A0the=A0async
>>>>=A0>>=A0interface=A0comes=A0from=A0the=A0ability=A0to=A0fully=A0uti=
lize=A0the=A0crypto
>>>>=A0>>=A0hardware.
>>>>=A0>>
>>>>=A0>>=A0Firstly,=A0being=A0able=A0to=A0submit=A0multiple=A0outstand=
ing=A0requests=A0fills
>>>>=A0>>=A0the=A0crypto=A0engine=A0pipeline=A0which=A0allows=A0it=A0to=
=A0run=A0more=A0efficiently
>>>>=A0>>=A0(ie.=A0minimal=A0cycles=A0are=A0wasted=A0waiting=A0for=A0th=
e=A0next=A0crypto=A0request).
>>>>=A0>>=A0=A0This=A0perf=A0improvement=A0is=A0similar=A0to=A0network=A0=
transfer=A0efficiency.
>>>>=A0>>=A0=A0Sending=A0a=A01GB=A0file=A0via=A04K=A0packets=A0synchron=
ously=A0is=A0not=A0going=A0to
>>>>=A0>>=A0fully=A0saturate=A0a=A0gigabit=A0link=A0but=A0queuing=A0a=A0=
bunch=A0of=A04K=A0packets=A0to
>>>>=A0>>=A0send=A0will.
>>>>=A0>
>>>>=A0>=A0Ok,=A0it=A0is=A0clicking=A0for=A0me=A0now.=A0Additionally,=A0=
I=A0imagine=A0that=A0the=A0async
>>>>=A0>=A0interface=A0helps=A0in=A0the=A0multicore/multiprocessor=A0ca=
se.
>>>>=A0>
>>>>=A0>>=A0Secondly,=A0if=A0you=A0have=A0crypto=A0hardware=A0that=A0ha=
s=A0multiple=A0crypto
>>>>=A0>>=A0engines,=A0then=A0the=A0multiple=A0outstanding=A0requests=A0=
allow=A0the=A0crypto
>>>>=A0>>=A0hardware=A0to=A0put=A0all=A0of=A0those=A0engines=A0to=A0wor=
k.
>>>>=A0>>
>>>>=A0>>=A0To=A0answer=A0your=A0question=A0about=A0page_crypt_req,=A0i=
t=A0is=A0used=A0to=A0track
>>>>=A0>>=A0all=A0of=A0the=A0extent_crypt_reqs=A0for=A0a=A0particular=A0=
page.=A0=A0When=A0we=A0write=A0a
>>>>=A0>>=A0page,=A0we=A0break=A0the=A0page=A0up=A0into=A0extents=A0and=
=A0encrypt=A0each=A0extent.
>>>>=A0>>=A0=A0For=A0each=A0extent,=A0we=A0submit=A0the=A0encrypt=A0req=
uest=A0using
>>>>=A0>>=A0extent_crypt_req.=A0=A0To=A0determine=A0when=A0the=A0entire=
=A0page=A0has=A0been
>>>>=A0>>=A0encrypted,=A0we=A0create=A0one=A0page_crypt_req=A0and=A0ass=
ociates=A0the
>>>>=A0>>=A0extent_crypt_req=A0to=A0the=A0page=A0by=A0incrementing
>>>>=A0>>=A0page_crypt_req::num_refs.=A0=A0As=A0the=A0extent=A0encrypt=A0=
request=A0completes,
>>>>=A0>>=A0we=A0decrement=A0num_refs.=A0=A0The=A0entire=A0page=A0is=A0=
encrypted=A0when=A0num_refs
>>>>=A0>>=A0goes=A0to=A0zero,=A0at=A0which=A0point,=A0we=A0end=A0the=A0=
page=A0writeback.
>>>>=A0>
>>>>=A0>=A0Alright,=A0that=A0is=A0what=A0I=A0had=A0understood=A0from=A0=
reviewing=A0the=A0code.=A0No
>>>>=A0>=A0surprises=A0there.
>>>>=A0>
>>>>=A0>=A0What=A0I'm=A0suggesting=A0is=A0to=A0do=A0away=A0with=A0the=A0=
page_crypt_req=A0and=A0simply=A0have
>>>>=A0>=A0ecryptfs_encrypt_page_async()=A0keep=A0track=A0of=A0the=A0ex=
tent_crypt_reqs=A0for
>>>>=A0>=A0the=A0page=A0it=A0is=A0encrypting.=A0Its=A0prototype=A0would=
=A0look=A0like=A0this:
>>>>=A0>
>>>>=A0>=A0int=A0ecryptfs_encrypt_page_async(struct=A0page=A0*page);
>>>>=A0>
>>>>=A0>=A0An=A0example=A0of=A0how=A0it=A0would=A0be=A0called=A0would=A0=
be=A0something=A0like=A0this:
>>>>=A0>
>>>>=A0>=A0static=A0int=A0ecryptfs_writepage(struct=A0page=A0*page,=A0s=
truct=A0writeback_control=A0*wbc)
>>>>=A0>=A0{
>>>>=A0>=A0=A0=A0=A0=A0=A0=A0=A0int=A0rc=A0=3D=A00;
>>>>=A0>
>>>>=A0>=A0=A0=A0=A0=A0=A0=A0=A0/*
>>>>=A0>=A0=A0=A0=A0=A0=A0=A0=A0=A0*=A0Refuse=A0to=A0write=A0the=A0page=
=A0out=A0if=A0we=A0are=A0called=A0from=A0reclaim=A0context
>>>>=A0>=A0=A0=A0=A0=A0=A0=A0=A0=A0*=A0since=A0our=A0writepage()=A0path=
=A0may=A0potentially=A0allocate=A0memory=A0when
>>>>=A0>=A0=A0=A0=A0=A0=A0=A0=A0=A0*=A0calling=A0into=A0the=A0lower=A0f=
s=A0vfs_write()=A0which=A0may=A0in=A0turn=A0invoke
>>>>=A0>=A0=A0=A0=A0=A0=A0=A0=A0=A0*=A0us=A0again.
>>>>=A0>=A0=A0=A0=A0=A0=A0=A0=A0=A0*/
>>>>=A0>=A0=A0=A0=A0=A0=A0=A0=A0if=A0(current->flags=A0&=A0PF_MEMALLOC)=
=A0{
>>>>=A0>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0redirty_page_fo=
r_writepage(wbc,=A0page);
>>>>=A0>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0goto=A0out;
>>>>=A0>=A0=A0=A0=A0=A0=A0=A0=A0}
>>>>=A0>
>>>>=A0>=A0=A0=A0=A0=A0=A0=A0=A0set_page_writeback(page);
>>>>=A0>=A0=A0=A0=A0=A0=A0=A0=A0rc=A0=3D=A0ecryptfs_encrypt_page_async(=
page);
>>>>=A0>=A0=A0=A0=A0=A0=A0=A0=A0if=A0(unlikely(rc))=A0{
>>>>=A0>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ecryptfs_printk=
(KERN_WARNING,=A0"Error=A0encrypting=A0"
>>>>=A0>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0"page=A0(upper=A0index=A0[0x%.16lx])\n=
",=A0page->index);
>>>>=A0>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ClearPageUptoda=
te(page);
>>>>=A0>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0SetPageError(pa=
ge);
>>>>=A0>=A0=A0=A0=A0=A0=A0=A0=A0}=A0else=A0{
>>>>=A0>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0SetPageUptodate=
(page);
>>>>=A0>=A0=A0=A0=A0=A0=A0=A0=A0}
>>>>=A0>=A0=A0=A0=A0=A0=A0=A0=A0end_page_writeback(page);
>>>>=A0>=A0out:
>>>>=A0>=A0=A0=A0=A0=A0=A0=A0=A0unlock_page(page);
>>>>=A0>=A0=A0=A0=A0=A0=A0=A0=A0return=A0rc;
>>>>=A0>=A0}
>>>>
>>>>=A0Will=A0this=A0make=A0ecryptfs_encrypt_page_async()=A0block=A0unt=
il=A0all=A0of=A0the
>>>>=A0extents=A0are=A0encrypted=A0and=A0written=A0to=A0the=A0lower=A0f=
ile=A0before=A0returning?
>>>>
>>>>=A0In=A0the=A0current=A0patch,=A0ecryptfs_encrypt_page_async()=A0re=
turns
>>>>=A0immediately=A0after=A0the=A0extents=A0are=A0submitted=A0to=A0the=
=A0crypto=A0layer.
>>>>=A0ecryptfs_writepage()=A0will=A0also=A0return=A0before=A0the=A0enc=
ryption=A0and=A0write
>>>>=A0to=A0the=A0lower=A0file=A0completes.=A0=A0This=A0allows=A0the=A0=
OS=A0to=A0start=A0writing
>>>>=A0other=A0pending=A0pages=A0without=A0being=A0blocked.
>>>
>>>=A0Ok,=A0now=A0I=A0see=A0the=A0source=A0of=A0my=A0confusion.=A0The=A0=
wait_for_completion()
>>>=A0added=A0in=A0ecryptfs_encrypt_page()=A0was=A0throwing=A0me=A0off.=
=A0I=A0initially
>>>=A0noticed=A0that=A0and=A0didn't=A0realize=A0that=A0wait_for_complet=
ion()=A0was=A0*not*
>>>=A0being=A0called=A0in=A0ecryptfs_writepage().
>>>
>>>=A0I=A0hope=A0to=A0give=A0the=A0rest=A0of=A0the=A0patch=A0a=A0thorou=
gh=A0review=A0by=A0the=A0end=A0of=A0the
>>>=A0week.=A0Thanks=A0for=A0your=A0help!
>>>
>>>=A0Tyler
>>>
>>>>
>>>>
>>>>=A0>
>>>>=A0>
>>>>=A0>>=A0We=A0can=A0get=A0rid=A0of=A0page_crypt_req=A0if=A0we=A0can=A0=
guarantee=A0that=A0the=A0extent
>>>>=A0>>=A0size=A0and=A0page=A0size=A0are=A0the=A0same.
>>>>=A0>
>>>>=A0>=A0We=A0can't=A0guarantee=A0that=A0but=A0that=A0doesn't=A0matte=
r=A0because
>>>>=A0>=A0ecryptfs_encrypt_page_async()=A0already=A0handles=A0that=A0p=
roblem.=A0Its=A0caller=A0doesn't
>>>>=A0>=A0care=A0if=A0the=A0extent=A0size=A0is=A0less=A0than=A0the=A0p=
age=A0size.
>>>>=A0>
>>>>=A0>=A0Tyler
>>>>=A0--
>>>>=A0To=A0unsubscribe=A0from=A0this=A0list:=A0send=A0the=A0line=A0"un=
subscribe=A0ecryptfs"=A0in
>>>>=A0the=A0body=A0of=A0a=A0message=A0to=A0majordomo@vger.kernel.org
>>>>=A0More=A0majordomo=A0info=A0at=A0=A0http://vger.kernel.org/majordo=
mo-info.html
>>--
>>To=A0unsubscribe=A0from=A0this=A0list:=A0send=A0the=A0line=A0"unsubsc=
ribe=A0ecryptfs"=A0in
>>the=A0body=A0of=A0a=A0message=A0to=A0majordomo@vger.kernel.org
>>More=A0majordomo=A0info=A0at=A0=A0http://vger.kernel.org/majordomo-in=
fo.html
