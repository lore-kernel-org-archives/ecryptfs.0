From: dragonylffly <dragonylffly@163.com>
Subject: Re:Re: [PATCH 1/1] ecryptfs: Migrate to ablkcipher API
Date: Sat, 16 Jun 2012 19:12:44 +0800 (CST)
Message-ID: <2e4d61d7.159a5.137f4febf0f.Coremail.dragonylffly@163.com>
References: <1339589670-12189-1-git-send-email-colin.king@canonical.com>
 <1339589670-12189-2-git-send-email-colin.king@canonical.com>
 <20120613161124.GB21062@boyd>
 <CAEcckGpMt1O+2syGbCQYC5ERCmXwCCvYjTYrHEeqZtQsA-qLLg@mail.gmail.com>
 <CAEcckGqhvz4gyvTHk0bSXf7pn5yEmWk7N+jT1BGrWxwGBX9wvQ@mail.gmail.com>
 <20120613211706.GD22116@boyd>
 <CAEcckGqhy9Yx9-vGYDVHBT8utsPR7cYaGjnAoRXM5ejnUonPyg@mail.gmail.com>
 <20120613222043.GE22116@boyd> <539626322.30300@eyou.net>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from m13-46.163.com ([220.181.13.46]:44061 "EHLO m13-46.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756325Ab2FPL2E convert rfc822-to-8bit (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Sat, 16 Jun 2012 07:28:04 -0400
In-Reply-To: <539626322.30300@eyou.net>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Thieu Le <thieule@google.com>
Cc: Tyler Hicks <tyhicks@canonical.com>, ecryptfs@vger.kernel.org, Colin King <colin.king@canonical.com>

HI,
   I did not think it thoroughly, I have two questions,
1 For asynchronous encryption, although it may enjoy a throughput=20
improvement for a bunch of pages, however, it seems that each dirty=20
page will now more likely have a longer time to be written back after
marked PG_WRITEBACK,
in other words, it is being locked for a longer time, what if a write
happens on that locked page? so it seems it may slow down the
performance on some REWRITE cases.

2 It is not very clear that why it could speed up read performance,  =20
from the Linux source code, it seems the kernel will wait for the
non uptodate page being uptodate (do_generic_file_read) before trying n=
ext page.

Cheers,
Li Wang

At=C2=A02012-06-14=C2=A006:25:28,"Thieu=C2=A0Le"=C2=A0<thieule@google.c=
om>=C2=A0wrote:
>Kewl=C2=A0:)
>
>Let=C2=A0me=C2=A0know=C2=A0if=C2=A0you=C2=A0have=C2=A0more=C2=A0questi=
ons.
>
>
>On=C2=A0Wed,=C2=A0Jun=C2=A013,=C2=A02012=C2=A0at=C2=A03:20=C2=A0PM,=C2=
=A0Tyler=C2=A0Hicks=C2=A0<tyhicks@canonical.com>=C2=A0wrote:
>>=C2=A0On=C2=A02012-06-13=C2=A015:03:42,=C2=A0Thieu=C2=A0Le=C2=A0wrote=
:
>>>=C2=A0On=C2=A0Wed,=C2=A0Jun=C2=A013,=C2=A02012=C2=A0at=C2=A02:17=C2=A0=
PM,=C2=A0Tyler=C2=A0Hicks=C2=A0<tyhicks@canonical.com>=C2=A0wrote:
>>>=C2=A0>=C2=A0On=C2=A0Wed,=C2=A0Jun=C2=A013,=C2=A02012=C2=A0at=C2=A01=
1:53=C2=A0AM,=C2=A0Thieu=C2=A0Le=C2=A0<thieule@google.com>=C2=A0wrote:
>>>=C2=A0>>
>>>=C2=A0>>=C2=A0Hi=C2=A0Tyler,=C2=A0I=C2=A0believe=C2=A0the=C2=A0perfo=
rmance=C2=A0improvement=C2=A0from=C2=A0the=C2=A0async
>>>=C2=A0>>=C2=A0interface=C2=A0comes=C2=A0from=C2=A0the=C2=A0ability=C2=
=A0to=C2=A0fully=C2=A0utilize=C2=A0the=C2=A0crypto
>>>=C2=A0>>=C2=A0hardware.
>>>=C2=A0>>
>>>=C2=A0>>=C2=A0Firstly,=C2=A0being=C2=A0able=C2=A0to=C2=A0submit=C2=A0=
multiple=C2=A0outstanding=C2=A0requests=C2=A0fills
>>>=C2=A0>>=C2=A0the=C2=A0crypto=C2=A0engine=C2=A0pipeline=C2=A0which=C2=
=A0allows=C2=A0it=C2=A0to=C2=A0run=C2=A0more=C2=A0efficiently
>>>=C2=A0>>=C2=A0(ie.=C2=A0minimal=C2=A0cycles=C2=A0are=C2=A0wasted=C2=A0=
waiting=C2=A0for=C2=A0the=C2=A0next=C2=A0crypto=C2=A0request).
>>>=C2=A0>>=C2=A0=C2=A0This=C2=A0perf=C2=A0improvement=C2=A0is=C2=A0sim=
ilar=C2=A0to=C2=A0network=C2=A0transfer=C2=A0efficiency.
>>>=C2=A0>>=C2=A0=C2=A0Sending=C2=A0a=C2=A01GB=C2=A0file=C2=A0via=C2=A0=
4K=C2=A0packets=C2=A0synchronously=C2=A0is=C2=A0not=C2=A0going=C2=A0to
>>>=C2=A0>>=C2=A0fully=C2=A0saturate=C2=A0a=C2=A0gigabit=C2=A0link=C2=A0=
but=C2=A0queuing=C2=A0a=C2=A0bunch=C2=A0of=C2=A04K=C2=A0packets=C2=A0to
>>>=C2=A0>>=C2=A0send=C2=A0will.
>>>=C2=A0>
>>>=C2=A0>=C2=A0Ok,=C2=A0it=C2=A0is=C2=A0clicking=C2=A0for=C2=A0me=C2=A0=
now.=C2=A0Additionally,=C2=A0I=C2=A0imagine=C2=A0that=C2=A0the=C2=A0asy=
nc
>>>=C2=A0>=C2=A0interface=C2=A0helps=C2=A0in=C2=A0the=C2=A0multicore/mu=
ltiprocessor=C2=A0case.
>>>=C2=A0>
>>>=C2=A0>>=C2=A0Secondly,=C2=A0if=C2=A0you=C2=A0have=C2=A0crypto=C2=A0=
hardware=C2=A0that=C2=A0has=C2=A0multiple=C2=A0crypto
>>>=C2=A0>>=C2=A0engines,=C2=A0then=C2=A0the=C2=A0multiple=C2=A0outstan=
ding=C2=A0requests=C2=A0allow=C2=A0the=C2=A0crypto
>>>=C2=A0>>=C2=A0hardware=C2=A0to=C2=A0put=C2=A0all=C2=A0of=C2=A0those=C2=
=A0engines=C2=A0to=C2=A0work.
>>>=C2=A0>>
>>>=C2=A0>>=C2=A0To=C2=A0answer=C2=A0your=C2=A0question=C2=A0about=C2=A0=
page_crypt_req,=C2=A0it=C2=A0is=C2=A0used=C2=A0to=C2=A0track
>>>=C2=A0>>=C2=A0all=C2=A0of=C2=A0the=C2=A0extent_crypt_reqs=C2=A0for=C2=
=A0a=C2=A0particular=C2=A0page.=C2=A0=C2=A0When=C2=A0we=C2=A0write=C2=A0=
a
>>>=C2=A0>>=C2=A0page,=C2=A0we=C2=A0break=C2=A0the=C2=A0page=C2=A0up=C2=
=A0into=C2=A0extents=C2=A0and=C2=A0encrypt=C2=A0each=C2=A0extent.
>>>=C2=A0>>=C2=A0=C2=A0For=C2=A0each=C2=A0extent,=C2=A0we=C2=A0submit=C2=
=A0the=C2=A0encrypt=C2=A0request=C2=A0using
>>>=C2=A0>>=C2=A0extent_crypt_req.=C2=A0=C2=A0To=C2=A0determine=C2=A0wh=
en=C2=A0the=C2=A0entire=C2=A0page=C2=A0has=C2=A0been
>>>=C2=A0>>=C2=A0encrypted,=C2=A0we=C2=A0create=C2=A0one=C2=A0page_cryp=
t_req=C2=A0and=C2=A0associates=C2=A0the
>>>=C2=A0>>=C2=A0extent_crypt_req=C2=A0to=C2=A0the=C2=A0page=C2=A0by=C2=
=A0incrementing
>>>=C2=A0>>=C2=A0page_crypt_req::num_refs.=C2=A0=C2=A0As=C2=A0the=C2=A0=
extent=C2=A0encrypt=C2=A0request=C2=A0completes,
>>>=C2=A0>>=C2=A0we=C2=A0decrement=C2=A0num_refs.=C2=A0=C2=A0The=C2=A0e=
ntire=C2=A0page=C2=A0is=C2=A0encrypted=C2=A0when=C2=A0num_refs
>>>=C2=A0>>=C2=A0goes=C2=A0to=C2=A0zero,=C2=A0at=C2=A0which=C2=A0point,=
=C2=A0we=C2=A0end=C2=A0the=C2=A0page=C2=A0writeback.
>>>=C2=A0>
>>>=C2=A0>=C2=A0Alright,=C2=A0that=C2=A0is=C2=A0what=C2=A0I=C2=A0had=C2=
=A0understood=C2=A0from=C2=A0reviewing=C2=A0the=C2=A0code.=C2=A0No
>>>=C2=A0>=C2=A0surprises=C2=A0there.
>>>=C2=A0>
>>>=C2=A0>=C2=A0What=C2=A0I'm=C2=A0suggesting=C2=A0is=C2=A0to=C2=A0do=C2=
=A0away=C2=A0with=C2=A0the=C2=A0page_crypt_req=C2=A0and=C2=A0simply=C2=A0=
have
>>>=C2=A0>=C2=A0ecryptfs_encrypt_page_async()=C2=A0keep=C2=A0track=C2=A0=
of=C2=A0the=C2=A0extent_crypt_reqs=C2=A0for
>>>=C2=A0>=C2=A0the=C2=A0page=C2=A0it=C2=A0is=C2=A0encrypting.=C2=A0Its=
=C2=A0prototype=C2=A0would=C2=A0look=C2=A0like=C2=A0this:
>>>=C2=A0>
>>>=C2=A0>=C2=A0int=C2=A0ecryptfs_encrypt_page_async(struct=C2=A0page=C2=
=A0*page);
>>>=C2=A0>
>>>=C2=A0>=C2=A0An=C2=A0example=C2=A0of=C2=A0how=C2=A0it=C2=A0would=C2=A0=
be=C2=A0called=C2=A0would=C2=A0be=C2=A0something=C2=A0like=C2=A0this:
>>>=C2=A0>
>>>=C2=A0>=C2=A0static=C2=A0int=C2=A0ecryptfs_writepage(struct=C2=A0pag=
e=C2=A0*page,=C2=A0struct=C2=A0writeback_control=C2=A0*wbc)
>>>=C2=A0>=C2=A0{
>>>=C2=A0>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int=C2=A0rc=C2=
=A0=3D=C2=A00;
>>>=C2=A0>
>>>=C2=A0>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
>>>=C2=A0>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*=C2=A0=
Refuse=C2=A0to=C2=A0write=C2=A0the=C2=A0page=C2=A0out=C2=A0if=C2=A0we=C2=
=A0are=C2=A0called=C2=A0from=C2=A0reclaim=C2=A0context
>>>=C2=A0>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*=C2=A0=
since=C2=A0our=C2=A0writepage()=C2=A0path=C2=A0may=C2=A0potentially=C2=A0=
allocate=C2=A0memory=C2=A0when
>>>=C2=A0>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*=C2=A0=
calling=C2=A0into=C2=A0the=C2=A0lower=C2=A0fs=C2=A0vfs_write()=C2=A0whi=
ch=C2=A0may=C2=A0in=C2=A0turn=C2=A0invoke
>>>=C2=A0>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*=C2=A0=
us=C2=A0again.
>>>=C2=A0>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*/
>>>=C2=A0>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if=C2=A0(curr=
ent->flags=C2=A0&=C2=A0PF_MEMALLOC)=C2=A0{
>>>=C2=A0>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0redirty_page_for_writepage(wbc,=C2=A0p=
age);
>>>=C2=A0>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0goto=C2=A0out;
>>>=C2=A0>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>>>=C2=A0>
>>>=C2=A0>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0set_page_writ=
eback(page);
>>>=C2=A0>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rc=C2=A0=3D=C2=
=A0ecryptfs_encrypt_page_async(page);
>>>=C2=A0>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if=C2=A0(unli=
kely(rc))=C2=A0{
>>>=C2=A0>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ecryptfs_printk(KERN_WARNING,=C2=A0"Er=
ror=C2=A0encrypting=C2=A0"
>>>=C2=A0>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"page=C2=A0(up=
per=C2=A0index=C2=A0[0x%.16lx])\n",=C2=A0page->index);
>>>=C2=A0>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ClearPageUptodate(page);
>>>=C2=A0>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SetPageError(page);
>>>=C2=A0>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}=C2=A0else=C2=
=A0{
>>>=C2=A0>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SetPageUptodate(page);
>>>=C2=A0>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>>>=C2=A0>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0end_page_writ=
eback(page);
>>>=C2=A0>=C2=A0out:
>>>=C2=A0>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unlock_page(p=
age);
>>>=C2=A0>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=C2=A0r=
c;
>>>=C2=A0>=C2=A0}
>>>
>>>=C2=A0Will=C2=A0this=C2=A0make=C2=A0ecryptfs_encrypt_page_async()=C2=
=A0block=C2=A0until=C2=A0all=C2=A0of=C2=A0the
>>>=C2=A0extents=C2=A0are=C2=A0encrypted=C2=A0and=C2=A0written=C2=A0to=C2=
=A0the=C2=A0lower=C2=A0file=C2=A0before=C2=A0returning?
>>>
>>>=C2=A0In=C2=A0the=C2=A0current=C2=A0patch,=C2=A0ecryptfs_encrypt_pag=
e_async()=C2=A0returns
>>>=C2=A0immediately=C2=A0after=C2=A0the=C2=A0extents=C2=A0are=C2=A0sub=
mitted=C2=A0to=C2=A0the=C2=A0crypto=C2=A0layer.
>>>=C2=A0ecryptfs_writepage()=C2=A0will=C2=A0also=C2=A0return=C2=A0befo=
re=C2=A0the=C2=A0encryption=C2=A0and=C2=A0write
>>>=C2=A0to=C2=A0the=C2=A0lower=C2=A0file=C2=A0completes.=C2=A0=C2=A0Th=
is=C2=A0allows=C2=A0the=C2=A0OS=C2=A0to=C2=A0start=C2=A0writing
>>>=C2=A0other=C2=A0pending=C2=A0pages=C2=A0without=C2=A0being=C2=A0blo=
cked.
>>
>>=C2=A0Ok,=C2=A0now=C2=A0I=C2=A0see=C2=A0the=C2=A0source=C2=A0of=C2=A0=
my=C2=A0confusion.=C2=A0The=C2=A0wait_for_completion()
>>=C2=A0added=C2=A0in=C2=A0ecryptfs_encrypt_page()=C2=A0was=C2=A0throwi=
ng=C2=A0me=C2=A0off.=C2=A0I=C2=A0initially
>>=C2=A0noticed=C2=A0that=C2=A0and=C2=A0didn't=C2=A0realize=C2=A0that=C2=
=A0wait_for_completion()=C2=A0was=C2=A0*not*
>>=C2=A0being=C2=A0called=C2=A0in=C2=A0ecryptfs_writepage().
>>
>>=C2=A0I=C2=A0hope=C2=A0to=C2=A0give=C2=A0the=C2=A0rest=C2=A0of=C2=A0t=
he=C2=A0patch=C2=A0a=C2=A0thorough=C2=A0review=C2=A0by=C2=A0the=C2=A0en=
d=C2=A0of=C2=A0the
>>=C2=A0week.=C2=A0Thanks=C2=A0for=C2=A0your=C2=A0help!
>>
>>=C2=A0Tyler
>>
>>>
>>>
>>>=C2=A0>
>>>=C2=A0>
>>>=C2=A0>>=C2=A0We=C2=A0can=C2=A0get=C2=A0rid=C2=A0of=C2=A0page_crypt_=
req=C2=A0if=C2=A0we=C2=A0can=C2=A0guarantee=C2=A0that=C2=A0the=C2=A0ext=
ent
>>>=C2=A0>>=C2=A0size=C2=A0and=C2=A0page=C2=A0size=C2=A0are=C2=A0the=C2=
=A0same.
>>>=C2=A0>
>>>=C2=A0>=C2=A0We=C2=A0can't=C2=A0guarantee=C2=A0that=C2=A0but=C2=A0th=
at=C2=A0doesn't=C2=A0matter=C2=A0because
>>>=C2=A0>=C2=A0ecryptfs_encrypt_page_async()=C2=A0already=C2=A0handles=
=C2=A0that=C2=A0problem.=C2=A0Its=C2=A0caller=C2=A0doesn't
>>>=C2=A0>=C2=A0care=C2=A0if=C2=A0the=C2=A0extent=C2=A0size=C2=A0is=C2=A0=
less=C2=A0than=C2=A0the=C2=A0page=C2=A0size.
>>>=C2=A0>
>>>=C2=A0>=C2=A0Tyler
>>>=C2=A0--
>>>=C2=A0To=C2=A0unsubscribe=C2=A0from=C2=A0this=C2=A0list:=C2=A0send=C2=
=A0the=C2=A0line=C2=A0"unsubscribe=C2=A0ecryptfs"=C2=A0in
>>>=C2=A0the=C2=A0body=C2=A0of=C2=A0a=C2=A0message=C2=A0to=C2=A0majordo=
mo@vger.kernel.org
>>>=C2=A0More=C2=A0majordomo=C2=A0info=C2=A0at=C2=A0=C2=A0http://vger.k=
ernel.org/majordomo-info.html
>--
>To=C2=A0unsubscribe=C2=A0from=C2=A0this=C2=A0list:=C2=A0send=C2=A0the=C2=
=A0line=C2=A0"unsubscribe=C2=A0ecryptfs"=C2=A0in
>the=C2=A0body=C2=A0of=C2=A0a=C2=A0message=C2=A0to=C2=A0majordomo@vger.=
kernel.org
>More=C2=A0majordomo=C2=A0info=C2=A0at=C2=A0=C2=A0http://vger.kernel.or=
g/majordomo-info.html
