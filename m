From: Richard Weinberger <richard@nod.at>
Subject: Re: [RFC][PATCH] ecryptfs: Allow only one instance per lower path
Date: Sun, 2 Aug 2015 09:51:16 +0200
Message-ID: <55BDCBF4.1050305@nod.at>
References: <1438338190-22518-1-git-send-email-richard@nod.at>
 <20150802010259.GA19522@boyd>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150802010259.GA19522@boyd>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Tyler Hicks <tyhicks@canonical.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>

Am 02.08.2015 um 03:03 schrieb Tyler Hicks:
> Thanks for the report and for the patch, Richard!
>=20
> On 2015-07-31 12:23:10, Richard Weinberger wrote:
>> Mounting the same lower path multiple times should not result
>> into multiple ecryptfs instances, otherwise ecryptfs gets confused.
>>
>> A command sequence of:
>=20
> An important detail that took me a while to realize is that /tmp shou=
ld
> be tmpfs in order to trigger the warnings below. I was unable to
> reproduce the warnings with ext4 as the lower filesystem.

Hmm, I saw it with UBIFS found that it triggers with tmpfs too.
I gave ext4 a quick try and yes, it behaves differently, I get
a EIO upon the second unlink().

>> $ mount -t ecryptfs /tmp/.secret /mnt_a/secret/
>> $ mount -t ecryptfs /tmp/.secret /mnt_b/secret/
>> $ mkdir -p /mnt_a/secret/xxx
>> $ mkdir -p /mnt_b/secret/xxx
>=20
> Note that the -p option is covering up the fact that /mnt_b/secret/xx=
x
> already exists. Remove that option and you should see this error:
>=20
>   mkdir: cannot create directory =E2=80=98/mnt_b/secret/xxx=E2=80=99:=
 File exists
>=20
> This really isn't important other than understanding that the second
> mkdir it isn't needed.
>=20
>> $ echo foo > /mnt_a/secret/xxx/test.txt
>> $ echo foo > /mnt_b/secret/xxx/test.txt
>=20
> /mnt_b/secret/xxx/test.txt should already exist (it does for me, at
> least) so the same file is being written to twice in a row. Again, no=
t
> really important other than to know that it isn't needed.
>=20
>> $ rm -rf /mnt_a/secret/xxx
>> $ rm -rf /mnt_b/secret/xxx
>=20
> The /mnt_b/secret/xxx dcache entry is stale here because the underlyi=
ng
> file was removed by the first rm command in the /mnt_a/secret mount. =
The
> lower inode's nlink is 0 at this point and what should be happening
> here, I think, is that the eCryptfs dentry should be invalidated and =
the
> eCryptfs inode should be destroyed.
>=20
> I think that the proper fix is to catch this condition in
> ecryptfs_d_revalidate(). I've started working on coming up with a pat=
ch
> for that but I'll need some more time to finish and test it.

So ecryptfs definitely supports mounting the same lower path multiple t=
imes?
What is the benefit of that behavior?

Thanks,
//richard
