From: =?UTF-8?Q?Marc_Pe=C3=B1a_Segarra?= <segarrra@gmail.com>
Subject: Fwd: Problem "cracking" a key_sig
Date: Tue, 7 Jul 2015 00:58:06 +0200
Message-ID: <CACmgvd_TSc6eDBnEg3GVdk40p3k4KxUjTb2=tkrOvr7URXJDCw@mail.gmail.com>
References: <CACmgvd8d5CAu=i=BNSAEbV5GA+XUe44wPw7xtFuAMkC-nBFzaw@mail.gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-vn0-f45.google.com ([209.85.216.45]:41682 "EHLO
	mail-vn0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755343AbbGFW60 (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 6 Jul 2015 18:58:26 -0400
Received: by vnbf62 with SMTP id f62so9284273vnb.8
        for <ecryptfs@vger.kernel.org>; Mon, 06 Jul 2015 15:58:25 -0700 (PDT)
In-Reply-To: <CACmgvd8d5CAu=i=BNSAEbV5GA+XUe44wPw7xtFuAMkC-nBFzaw@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org

Hi all,

I'm using Ubuntu 14.04 and I use ecryptfs to encrypt arbitrary
directories; to mount the directories I use a command like this:

sudo mount -t ecryptfs .secret/ secret/ -o
key=passphrase,ecryptfs_cipher=aes,ecryptfs_key_bytes=32,ecryptfs_passthrough=n,ecryptfs_enable_filename_crypto=n

The thing is that, somehow, I messed it up when pasting the password
on the first mount in one of the directories (yeah, I know that the
message saying that I've never mounted with that key before should
have been quite clarifying)...copied all the data and unmounted it.

Now, when I mount it and try to read files I get errors and messages
like this in dmesg:

[ 4210.614158] ecryptfs_parse_options: eCryptfs: unrecognized option
[ecryptfs_debug=5]
[ 4215.347261] Could not find key with description: [306437480dxxxxxx]
[ 4215.347269] process_request_key_err: No key
[ 4215.347272] ecryptfs_parse_packet_set: Could not find a usable
authentication token
[ 4215.347277] Valid eCryptfs headers not found in file header region
or xattr region, inode 919485

After downloading the code of the Ubuntu package I found out that in
the directory tests/userspace there were the tests for verifying
passphase signs, so I thought that I could use that to iterate through
mutations of the pasted passphrase in the hope of reproducing the mess
I provoked.

The problem I'm having is that the test program expects four parameters:
pass
salt
expected_sig
expected_fekek

But since in my configuration I don't have a "file encryption key,
encryption key" I don't know how I could modify it in order to try to
find my passphrase; or should I use any other executable from
ecryptfs?

Thanks a lot!
