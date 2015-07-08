From: =?UTF-8?Q?Marc_Pe=C3=B1a_Segarra?= <segarrra@gmail.com>
Subject: Re: Problem "cracking" a key_sig
Date: Thu, 9 Jul 2015 00:43:32 +0200
Message-ID: <CACmgvd98G_n=7JUugr2PZKD5n8LTyCOfDaJXHc9q0j=ydjPtZg@mail.gmail.com>
References: <CACmgvd8d5CAu=i=BNSAEbV5GA+XUe44wPw7xtFuAMkC-nBFzaw@mail.gmail.com>
 <CACmgvd_TSc6eDBnEg3GVdk40p3k4KxUjTb2=tkrOvr7URXJDCw@mail.gmail.com>
 <CAPGmukRMKWsU8FHOq8oeGkJ738ATdG3ZOZxzgWjRbZtkxy-0SA@mail.gmail.com> <CAPGmukSvtbg8vZphHdyoqFbO1PfLgvsAMHpmb2q+xw6yqwtL-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-vn0-f42.google.com ([209.85.216.42]:36573 "EHLO
	mail-vn0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041AbbGHWnw convert rfc822-to-8bit (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Wed, 8 Jul 2015 18:43:52 -0400
Received: by vnbg129 with SMTP id g129so32772624vnb.3
        for <ecryptfs@vger.kernel.org>; Wed, 08 Jul 2015 15:43:52 -0700 (PDT)
In-Reply-To: <CAPGmukSvtbg8vZphHdyoqFbO1PfLgvsAMHpmb2q+xw6yqwtL-Q@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: "Wiest, Damian" <damian.wiest@apervita.com>
Cc: ecryptfs@vger.kernel.org

Thanks a lot Damian! Following your advice I've been able to recover
the mangled password!

I took the instructions from here:
http://www.unix-ninja.com/p/Securing_your_private_data_with_the_Enterpr=
ise_Cryptographic_Filesystem/

But your aproach seems better.



On Tue, Jul 7, 2015 at 9:49 PM, Wiest, Damian <damian.wiest@apervita.co=
m> wrote:
> Sorry, I was looking at some old notes.  You should mount using the -=
i
> option to suppress the ecryptfs mount helper if you're using a
> passphrase stored in your keyring.
>
> -Damian
>
>
> On Tue, Jul 7, 2015 at 2:21 PM, Wiest, Damian <damian.wiest@apervita.=
com> wrote:
>> If you've got a copy of the auth tok sig that was used, you can
>> repeatedly call ecryptfs-add-passphrase with your guess until you ge=
t
>> a match.  This will add the passphrase to your keyring, so you may
>> want to clean up bad guesses with keyctl.
>>
>> To avoid this situation in the future I would suggest using either t=
he
>> ecryptfs-manager or ecryptfs-insert-wrapped-passphrase commands to
>> load the passphrase to your keyring.  ecryptfs-manager will ask you =
to
>> enter your passphrase twice to catch typos and the
>> ecryptfs-insert-wrapped-passphrase command will fail if you enter th=
e
>> wrapping passphrase incorrectly.  You can then use the auth tok sig =
in
>> your mount command instead of the actual passphrase.
>>
>> # ecryptfs-insert-wrapped-passphrase-into-keyring ./wrapped.passphra=
se
>> Passphrase:
>> Inserted auth tok with sig [2df13936c580ecff] into the user session =
keyring
>>
>> # mount -t ecryptfs ./.secret ./secret -o
>> ecryptfs_sig=3D2df13936c580ecff,ecryptfs_cipher=3Daes,ecryptfs_key_b=
ytes=3D32,key=3Dpassphrase,ecryptfs_enable_filename_crypto=3Dn,ecryptfs=
_passthrough=3Dn
>> Passphrase:
>> Attempting to mount with the following options:
>>   ecryptfs_unlink_sigs
>>   ecryptfs_fnek_sig=3D4e8a0ece5dbf48c8
>>   ecryptfs_key_bytes=3D16
>>   ecryptfs_cipher=3Daes
>>   ecryptfs_sig=3Dff09227dc73d8090
>> Mounted eCryptfs
>>
>> You will still be prompted for a passphrase when mounting, but you c=
an
>> enter anything and ecryptfs will use the sig you provided to locate
>> the passphrase in your keyring.  Be aware that the values for
>> ecryptfs_sig and ecryptfs_fnek_sig that will displayed after mountin=
g
>> are bogus.  Also, always test mounting your filesystem a few times t=
o
>> ensure there are no surprises and backup your passphrase to a secure
>> location.
>>
>> -Damian
>>
>>
>> On Mon, Jul 6, 2015 at 5:58 PM, Marc Pe=C3=B1a Segarra <segarrra@gma=
il.com> wrote:
>>>
>>> Hi all,
>>>
>>> I'm using Ubuntu 14.04 and I use ecryptfs to encrypt arbitrary
>>> directories; to mount the directories I use a command like this:
>>>
>>> sudo mount -t ecryptfs .secret/ secret/ -o
>>> key=3Dpassphrase,ecryptfs_cipher=3Daes,ecryptfs_key_bytes=3D32,ecry=
ptfs_passthrough=3Dn,ecryptfs_enable_filename_crypto=3Dn
>>>
>>> The thing is that, somehow, I messed it up when pasting the passwor=
d
>>> on the first mount in one of the directories (yeah, I know that the
>>> message saying that I've never mounted with that key before should
>>> have been quite clarifying)...copied all the data and unmounted it.
>>>
>>> Now, when I mount it and try to read files I get errors and message=
s
>>> like this in dmesg:
>>>
>>> [ 4210.614158] ecryptfs_parse_options: eCryptfs: unrecognized optio=
n
>>> [ecryptfs_debug=3D5]
>>> [ 4215.347261] Could not find key with description: [306437480dxxxx=
xx]
>>> [ 4215.347269] process_request_key_err: No key
>>> [ 4215.347272] ecryptfs_parse_packet_set: Could not find a usable
>>> authentication token
>>> [ 4215.347277] Valid eCryptfs headers not found in file header regi=
on
>>> or xattr region, inode 919485
>>>
>>> After downloading the code of the Ubuntu package I found out that i=
n
>>> the directory tests/userspace there were the tests for verifying
>>> passphase signs, so I thought that I could use that to iterate thro=
ugh
>>> mutations of the pasted passphrase in the hope of reproducing the m=
ess
>>> I provoked.
>>>
>>> The problem I'm having is that the test program expects four parame=
ters:
>>> pass
>>> salt
>>> expected_sig
>>> expected_fekek
>>>
>>> But since in my configuration I don't have a "file encryption key,
>>> encryption key" I don't know how I could modify it in order to try =
to
>>> find my passphrase; or should I use any other executable from
>>> ecryptfs?
>>>
>>> Thanks a lot!
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ecryptfs"=
 in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
>
>
> Confidentiality Notice: This e-mail transmission may contain confiden=
tial
> or legally privileged information that is intended only for the indiv=
idual
> or entity named in the e-mail address. If you have received this
> communication in error, please notify me by return e-mail, and destro=
y this
> communication and all copies thereof, including any attachments.
>
> Apervita =C2=AE is a registered trademark of Apervita Inc.
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ecryptfs" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
