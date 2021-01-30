From: Tyler Hicks <code@tyhicks.com>
Subject: Re: [PATCH] eCryptfs: add a semicolon
Date: Sat, 30 Jan 2021 11:57:11 -0600
Message-ID: <20210130175711.GB58096@elm>
References: <20201127160513.2619747-1-trix@redhat.com>
 <3168a3aa5c4ac564340cba2a151359e8cd3dee5f.camel@perches.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbhA3R6D (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Sat, 30 Jan 2021 12:58:03 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D527C061574
        for <ecryptfs@vger.kernel.org>; Sat, 30 Jan 2021 09:57:14 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id g69so13817294oib.12
        for <ecryptfs@vger.kernel.org>; Sat, 30 Jan 2021 09:57:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <3168a3aa5c4ac564340cba2a151359e8cd3dee5f.camel@perches.com>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Joe Perches <joe@perches.com>
Cc: trix@redhat.com, hannes@cmpxchg.org, mhocko@suse.com, longman@redhat.com, herbert@gondor.apana.org.au, ebiggers@google.com, ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org

On 2020-11-27 10:11:23, Joe Perches wrote:
> On Fri, 2020-11-27 at 08:05 -0800, trix@redhat.com wrote:
> > Function like macros should have a semicolon.
> []
> > diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
> []
> > @@ -1172,7 +1172,7 @@ decrypt_pki_encrypted_session_key(struct ecryptfs=
_auth_tok *auth_tok,
> > =A0	rc =3D ecryptfs_cipher_code_to_string(crypt_stat->cipher, cipher_co=
de);
> > =A0	if (rc) {
> > =A0		ecryptfs_printk(KERN_ERR, "Cipher code [%d] is invalid\n",
> > -				cipher_code)
> > +				cipher_code);
>=20
> As this is the only use that does not have a semicolon,
> it'd be good to add the removal of the semicolon from
> the #define at the same time.

I double checked that this is the only ecryptfs_printk() usage missing
the trailing semicolon and then made Joe's suggested change before
pushing the patch to the eCryptfs next branch:

 https://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs.git/log/?=
h=3Dnext

Thanks for the cleanup!

Tyler
