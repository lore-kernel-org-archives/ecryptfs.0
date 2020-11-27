From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] eCryptfs: add a semicolon
Date: Fri, 27 Nov 2020 10:11:23 -0800
Message-ID: <3168a3aa5c4ac564340cba2a151359e8cd3dee5f.camel@perches.com>
References: <20201127160513.2619747-1-trix@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from smtprelay0139.hostedemail.com ([216.40.44.139]:49898 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732323AbgK0SL1 (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Fri, 27 Nov 2020 13:11:27 -0500
In-Reply-To: <20201127160513.2619747-1-trix@redhat.com>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: trix@redhat.com, code@tyhicks.com, hannes@cmpxchg.org, mhocko@suse.com, longman@redhat.com, herbert@gondor.apana.org.au, ebiggers@google.com
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 2020-11-27 at 08:05 -0800, trix@redhat.com wrote:
> Function like macros should have a semicolon.
[]
> diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
[]
> @@ -1172,7 +1172,7 @@ decrypt_pki_encrypted_session_key(struct ecryptfs_a=
uth_tok *auth_tok,
> =A0	rc =3D ecryptfs_cipher_code_to_string(crypt_stat->cipher, cipher_code=
);
> =A0	if (rc) {
> =A0		ecryptfs_printk(KERN_ERR, "Cipher code [%d] is invalid\n",
> -				cipher_code)
> +				cipher_code);

As this is the only use that does not have a semicolon,
it'd be good to add the removal of the semicolon from
the #define at the same time.


