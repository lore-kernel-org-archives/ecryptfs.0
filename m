From: James Muir <muir.james.a@gmail.com>
Subject: Re: porting to android
Date: Wed, 18 Sep 2013 17:36:03 -0400
Message-ID: <523A1CC3.3090607@gmail.com>
References: <52353200.9040101@gmail.com> <CAFftDdq-DQSzGDqKSDGCpvenGp_KtCgR0hzfX1uqSGnfmKAiqg@mail.gmail.com> <52374CEC.6010507@gmail.com> <CAFftDdrmF6gvk_Vh8AReUrXVRLCs25SdFBZyqUhHv-tid5KDSg@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-vb0-f43.google.com ([209.85.212.43]:58182 "EHLO
	mail-vb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753852Ab3IRVgF (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Wed, 18 Sep 2013 17:36:05 -0400
Received: by mail-vb0-f43.google.com with SMTP id h11so5661213vbh.2
        for <ecryptfs@vger.kernel.org>; Wed, 18 Sep 2013 14:36:04 -0700 (PDT)
In-Reply-To: <CAFftDdrmF6gvk_Vh8AReUrXVRLCs25SdFBZyqUhHv-tid5KDSg@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: William Roberts <bill.c.roberts@gmail.com>
Cc: ecryptfs@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 09/16/2013 02:34 PM, William Roberts wrote:
> my tools were generic... I did it over a year ago. I am having a
> hard time remembering what, or how I did it.
> 

That's too bad.  I could use some help :-)

I've had limited success so far.  I've if-def'd out the Mozilla NSS
stuff and am just concentrating on getting mount.ecryptfs working when
 options are passed directly to it:

  mount.ecryptfs lower upper \
 -o ecryptfs_cipher=aes,ecryptfs_key_bytes=16,...

There are three libraries that mount.ecryptfs needs:  libkeyutils,
libecryptfs, and libecryptfs_key_mod_passphrase.  I've managed to
build each of those after some minor changes (for android-arm).  With
those libraries available, I can then build the mount utility.
However, when I try the above command on my device I get an error from
the function ecryptfs_eval_decision_graph()  :-(

Here is a more general question for the list:  is this forum more for
the ecryptfs kernel mod devs?  or do the ecryptfs user-tool devs hang
out here, too?

- -James M
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlI6HLsACgkQ4Arkm0Hw/FIg+QCghuQJadNtJm5rRL9QID7ugJwf
P4sAnjbNzYw52jhPMdtkFZgPBBRiCasz
=NVGB
-----END PGP SIGNATURE-----
