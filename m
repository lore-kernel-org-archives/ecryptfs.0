From: "Wiest, Damian" <damian.wiest@apervita.com>
Subject: Re: Problem "cracking" a key_sig
Date: Tue, 7 Jul 2015 14:21:14 -0500
Message-ID: <CAPGmukRMKWsU8FHOq8oeGkJ738ATdG3ZOZxzgWjRbZtkxy-0SA@mail.gmail.com>
References: <CACmgvd8d5CAu=i=BNSAEbV5GA+XUe44wPw7xtFuAMkC-nBFzaw@mail.gmail.com>
	<CACmgvd_TSc6eDBnEg3GVdk40p3k4KxUjTb2=tkrOvr7URXJDCw@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:33709 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932617AbbGGTVP convert rfc822-to-8bit (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 7 Jul 2015 15:21:15 -0400
Received: by iggp10 with SMTP id p10so5062739igg.0
        for <ecryptfs@vger.kernel.org>; Tue, 07 Jul 2015 12:21:15 -0700 (PDT)
In-Reply-To: <CACmgvd_TSc6eDBnEg3GVdk40p3k4KxUjTb2=tkrOvr7URXJDCw@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: ecryptfs@vger.kernel.org

If you've got a copy of the auth tok sig that was used, you can
repeatedly call ecryptfs-add-passphrase with your guess until you get
a match.  This will add the passphrase to your keyring, so you may
want to clean up bad guesses with keyctl.

To avoid this situation in the future I would suggest using either the
ecryptfs-manager or ecryptfs-insert-wrapped-passphrase commands to
load the passphrase to your keyring.  ecryptfs-manager will ask you to
enter your passphrase twice to catch typos and the
ecryptfs-insert-wrapped-passphrase command will fail if you enter the
wrapping passphrase incorrectly.  You can then use the auth tok sig in
your mount command instead of the actual passphrase.

# ecryptfs-insert-wrapped-passphrase-into-keyring ./wrapped.passphrase
Passphrase:
Inserted auth tok with sig [2df13936c580ecff] into the user session key=
ring

# mount -t ecryptfs ./.secret ./secret -o
ecryptfs_sig=3D2df13936c580ecff,ecryptfs_cipher=3Daes,ecryptfs_key_byte=
s=3D32,key=3Dpassphrase,ecryptfs_enable_filename_crypto=3Dn,ecryptfs_pa=
ssthrough=3Dn
Passphrase:
Attempting to mount with the following options:
  ecryptfs_unlink_sigs
  ecryptfs_fnek_sig=3D4e8a0ece5dbf48c8
  ecryptfs_key_bytes=3D16
  ecryptfs_cipher=3Daes
  ecryptfs_sig=3Dff09227dc73d8090
Mounted eCryptfs

You will still be prompted for a passphrase when mounting, but you can
enter anything and ecryptfs will use the sig you provided to locate
the passphrase in your keyring.  Be aware that the values for
ecryptfs_sig and ecryptfs_fnek_sig that will displayed after mounting
are bogus.  Also, always test mounting your filesystem a few times to
ensure there are no surprises and backup your passphrase to a secure
location.

-Damian


On Mon, Jul 6, 2015 at 5:58 PM, Marc Pe=C3=B1a Segarra <segarrra@gmail.=
com> wrote:
>
> Hi all,
>
> I'm using Ubuntu 14.04 and I use ecryptfs to encrypt arbitrary
> directories; to mount the directories I use a command like this:
>
> sudo mount -t ecryptfs .secret/ secret/ -o
> key=3Dpassphrase,ecryptfs_cipher=3Daes,ecryptfs_key_bytes=3D32,ecrypt=
fs_passthrough=3Dn,ecryptfs_enable_filename_crypto=3Dn
>
> The thing is that, somehow, I messed it up when pasting the password
> on the first mount in one of the directories (yeah, I know that the
> message saying that I've never mounted with that key before should
> have been quite clarifying)...copied all the data and unmounted it.
>
> Now, when I mount it and try to read files I get errors and messages
> like this in dmesg:
>
> [ 4210.614158] ecryptfs_parse_options: eCryptfs: unrecognized option
> [ecryptfs_debug=3D5]
> [ 4215.347261] Could not find key with description: [306437480dxxxxxx=
]
> [ 4215.347269] process_request_key_err: No key
> [ 4215.347272] ecryptfs_parse_packet_set: Could not find a usable
> authentication token
> [ 4215.347277] Valid eCryptfs headers not found in file header region
> or xattr region, inode 919485
>
> After downloading the code of the Ubuntu package I found out that in
> the directory tests/userspace there were the tests for verifying
> passphase signs, so I thought that I could use that to iterate throug=
h
> mutations of the pasted passphrase in the hope of reproducing the mes=
s
> I provoked.
>
> The problem I'm having is that the test program expects four paramete=
rs:
> pass
> salt
> expected_sig
> expected_fekek
>
> But since in my configuration I don't have a "file encryption key,
> encryption key" I don't know how I could modify it in order to try to
> find my passphrase; or should I use any other executable from
> ecryptfs?
>
> Thanks a lot!
> --
> To unsubscribe from this list: send the line "unsubscribe ecryptfs" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20


Confidentiality Notice: This e-mail transmission may contain confidenti=
al=20
or legally privileged information that is intended only for the individ=
ual=20
or entity named in the e-mail address. If you have received this=20
communication in error, please notify me by return e-mail, and destroy =
this=20
communication and all copies thereof, including any attachments.=20

Apervita =C2=AE is a registered trademark of Apervita Inc.

=20
