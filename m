From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] eCryptfs: Improve statfs reporting
Date: Mon, 19 Dec 2011 14:44:58 -0800
Message-ID: <CAGXu5jKj=UcH_8GXM5EHFbdxx09T_wk003mgGZmfrxKfvVwvVQ@mail.gmail.com>
References: <1324313961-16531-1-git-send-email-tyhicks@canonical.com>
	<CAGXu5jKPML0DB55umbVNc1bbZsLB6yosjTtYKNimctyQSytMEQ@mail.gmail.com>
	<20111219194739.GD14413@boyd>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47057 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095Ab1LSWo6 convert rfc822-to-8bit (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 19 Dec 2011 17:44:58 -0500
Received: by iaeh11 with SMTP id h11so9213748iae.19
        for <ecryptfs@vger.kernel.org>; Mon, 19 Dec 2011 14:44:58 -0800 (PST)
In-Reply-To: <20111219194739.GD14413@boyd>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Tyler Hicks <tyhicks@canonical.com>
Cc: ecryptfs@vger.kernel.org, John Johansen <john.johansen@canonical.com>

On Mon, Dec 19, 2011 at 11:47 AM, Tyler Hicks <tyhicks@canonical.com> w=
rote:
> On 2011-12-19 09:35:44, Kees Cook wrote:
>> On Mon, Dec 19, 2011 at 8:59 AM, Tyler Hicks <tyhicks@canonical.com>=
 wrote:
>> > statfs() calls on eCryptfs files returned the wrong filesystem typ=
e and,
>> > when using filename encryption, the wrong maximum filename length.
>>
>> Thanks for getting this fixed up!
>
> I appreciate the review!
>
>> > +#define ENC_NAME_MAX_BLOCKLEN_8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A014=
3
>> > +#define ENC_NAME_MAX_BLOCKLEN_16 =A0 =A0 =A0 143
>> ...
>> > + =A0 =A0 =A0 /* Return an exact amount for the common cases */
>> > + =A0 =A0 =A0 if (lower_namelen =3D=3D NAME_MAX) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cipher_blocksize =3D=3D 8) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (*namelen) =3D ENC_N=
AME_MAX_BLOCKLEN_8;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (cipher_blocksize =3D=3D 1=
6) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (*namelen) =3D ENC_N=
AME_MAX_BLOCKLEN_16;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> > + =A0 =A0 =A0 }
>>
>> Why different paths here when the defines are the same?
>
> I'll get that fixed. I had the 8 byte block size in as just a placeho=
lder
> until I could test the max length (I knew 16 byte block size max was =
143
> characters, but didn't know the 8 byte max). I should have merged the
> two paths after discovering that they were both the same value.
>
>> Also, what math is used to determine the "143"?
>
> No math involved. Just testing.
>
>> > + =A0 =A0 =A0 /* Return a safe estimate for the uncommon cases */
>> > + =A0 =A0 =A0 (*namelen) -=3D ECRYPTFS_FNEK_ENCRYPTED_FILENAME_PRE=
=46IX_SIZE;
>> > + =A0 =A0 =A0 /* Since this is the max decoded size, subtract 1 "d=
ecoded block" len */
>> > + =A0 =A0 =A0 (*namelen) =3D ecryptfs_max_decoded_size(*namelen) -=
 3;
>> > + =A0 =A0 =A0 (*namelen) -=3D ECRYPTFS_TAG_70_MAX_METADATA_SIZE;
>> > + =A0 =A0 =A0 (*namelen) -=3D ECRYPTFS_FILENAME_MIN_RANDOM_PREPEND=
_BYTES;
>> > + =A0 =A0 =A0 /* Worst case is that the filename is padded nearly =
a full block size */
>> > + =A0 =A0 =A0 (*namelen) -=3D cipher_blocksize - 1;
>
> I should probably add a check here to make sure namelen isn't negativ=
e at this point.

Heh, good idea. :)

>> Would it be less fragile to just use this path for all the
>> calculations? Almost everything is a literal value.
>
> I agree that just having one path would be cleaner, but this calculat=
ion
> is just a rounded down estimate and the hard-coded common cases above
> should be sufficient the vast majority of the time.
>
> For the most common case of lower_f_namelen being 255 and a
> cipher_blocksize of 16, this math comes out to 130. To try to give
> userspace apps a little more room to work with, I figured it would be
> better to hard-code in the two common cases.

Ah-ha, okay, sounds good to me.

>> Would it make sense to reproduce the sizing comments from here into
>> the #defines above, just to avoid losing this documentation?
>
> These comments were actually a repeat of the comments right above thi=
s
> line. That comment section is still there and is what I consider the
> "official" in-code documentation of a tag 70 packet. Here is the comm=
ent
> section:

Ah-ha. Excellent. That's what I get for only reading the diff. ;)

-Kees

--=20
Kees Cook
ChromeOS Security
