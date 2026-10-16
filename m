Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98B354146F
	for <ecryptfs@vger.kernel.org>; Fri, 16 Oct 2026 16:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792169928; cv=pass; b=Hm53SuXNYwTSF1P0oR0YpxfBMwTLT+3O1hJtoEQ4EqVI7YrRnr0MuC6KUJIo82soxJPTEDWjdFg4GfE2Oms7qPyhCsdAhcoEAJA3jRxLDGb+GvQlveRRtcjp6nen2qy7IjIZGxCar8hmRZfhr+8NL7ng2eU7UIyTNzBNQvFBJWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792169928; c=relaxed/simple;
	bh=k61iFgS+IKJHl0EJEuWZvUQY83UqouqRdjCkl8RGuw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X2uNn+x1Vzzf6QUDzYKjyU87lSvbod0d503XS8zvI4ITZaCKfzMlS1S2o5LnR6PD4y+1EURl1sgMfgGbHmPKrNm5ZkKaVWZN3coy3b2xqF/NaXfGxWqjNmm52R7r7YCL5c+hllWvsPRHRSSicvYsYgxxuPN+Dq/B2pra0jfMDbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFIgFeWt; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFIgFeWt"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e608cd460eso111985ad.3
        for <ecryptfs@vger.kernel.org>; Fri, 16 Oct 2026 09:58:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792169925; cv=none;
        d=google.com; s=arc-20260327;
        b=X+BvBk2n6SMTK7Gp2r9EwORuqp4dOuBURtk1TpPnpv+T5ibW1OBcGIACkjJJ4h3tPH
         Elp5TQ51r7ten1t6nQqw1f+F0IVyP5QZBMq+qPesGhIhvBUIV0ki3Yn4NHCPMtoySgWq
         s2/Npyt7owzxEXNha+iOhpXbsptlr4wgPgiftK7MTkNonj4gEbxXcPBN6nquovdJpeRX
         8JajPKdUkBigWQ2CP2ZbpSPacd42+d9Upqm1WsyIEIW8T5f9zzg63eHg+DXPhvah6O+y
         QrOCTs+/pg0P5LBxOf38clPMLvh8OTSQod795SLoclFvt4meRg6bWlWzCXGvwKKTh3Va
         S5cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JIN5PWNqxoh9H+t94mJngNpG6Duh35uUvogPeO7NlXs=;
        fh=hNPA9u0Z7LuBvwRqduzXrA05s6NoW+WUUCqSZln3xig=;
        b=EEWZqqTe5avvHKlW9DZu3rSaJK3bpOhSPqNCla6pgimSLKo8gUwpMLrjjzrYDtADhT
         pSBi9Fqp1hc5rFCqQiTANgjQuKDErvXW+SoAr4cdrisKg32VORxZACOG0T716+zSYSlO
         SapzXNqZtuNtILlifeqh+5FonrWT6Dry/+qht7IvYAS9ysmWhk9v2xt2aS0nETmxWvzk
         UE38M7zX/MuhoHuOe+BflVkOCWdP4Bdb6jn3u0GILvl7HuNplJGPXIrRpghucJgp9/B6
         tPE6HSeqkZEpT8lKOPWde//BOdYLFIMYaW1NyZa5EvqQ35Y5kXxLHt+BETGMzDaWS0Gg
         WocA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792169925; x=1792774725; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JIN5PWNqxoh9H+t94mJngNpG6Duh35uUvogPeO7NlXs=;
        b=CFIgFeWtZE5pkfdVrIbXLZNHpX0RQMyzFxoLRzVtvGQAF0ry4cuAf9KtPW3AfxbBWW
         386zszQbOcB+wsirsxJ5u/ozBImHT5J2/pGij81SIrJbbn0ewFicmQscAaHzS6Ur0Fun
         l5fGa46rgf8agTvSKMEumFCLXDte4j6gYsDnU34mFtcPgr4vUQe+qKE8BPagrsJ+bhss
         a3LhmpRvan3qMmF20g5EoarOk62clVnMCPs/nA7A/KnRX+m06L0CwCKHBsac0ZXv09oZ
         0citfcivUXRqApGoH7jZ4DLm3vMAcEtMpQx3kUZOLNWkWT9ITQQBHfs/PsqrCHGly2xe
         Vc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792169925; x=1792774725;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JIN5PWNqxoh9H+t94mJngNpG6Duh35uUvogPeO7NlXs=;
        b=0yriQN8ubcWkRa8Nqu0mp+pMC4jCkyVEsS8VYZvb7JQw/l/Dlm9y+Uru0CFhr3cY5X
         OPhlkkTjz0wou1TjXaREWwd14j3elYJ1U5qSkHivJszYBv2OXYHG+KkO8SDCE/pD181E
         bBv8xR0yzGinO+a3bdxbQ2EWbhlXcox5Kz3Vjv+jyzcD67V/mq0+O27s17167cvkXpYB
         /nRZtY/WkEofvfR2STASPOoKppNJgCAN7B863V38gzRb9nbrTpIBjVmkY+fP4APBPrQS
         vjyymykPfXUgnXTu5sI1YtQQfREea4foyePiseDefzhRhgf7dAFNHk6AaZScDsmHqVLs
         4fIw==
X-Gm-Message-State: AFq9FYKHxsegE5esiYHDAueHLHYTgL492v9eBJCGPtTZ7YONtHHXvPyh
	HHOvOJ4syXscF7w6/Fhph4Ij5dC75/rnrNBOq0PaEb2PHVDP2fk2NLEYJv8BrUsU24pAJrTWnd9
	tgZPa7RcymLjsJBGmCxd8RvXeBnFN0/A=
X-Gm-Gg: AYBFou2Qcsk1eSXIIA3wsYFj3nPc2y4oft+3qCtnADcMX3eNIpeRqzWmtAF8E+LA4vy
	qAVjPkdHl+xI4euF2uUqgF9cgN3Av2YqzfWH3Rxw0HjsXb/euifqEvLcmX8TRDTkG+EONijScYb
	CuG9pa0aeFra7XzuVnKjdDGPFkHcEuLMY+FoF18v91hfJoIUwcAx3B61C6C4i7z2ABVFi2m4S+m
	vKHFBT/MavnCVfWjFqf/+82qHL6ttCpzZaGvFjcVEdue7x+K7VcXNymSqn12aQ3JN/U59oSx14c
	UwwieFbihcGRhDoJqE+9o/070Bx8TD0OoFbeFcIe0gleDEVzUf7AI80=
X-Received: by 2002:a17:902:e74b:b0:2e5:a355:56e4 with SMTP id
 d9443c01a7336-2e9a6c1bc25mr5321195ad.11.1792169924791; Fri, 16 Oct 2026
 09:58:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261004123755.14642-1-adrianox@gmail.com> <as266is_fT232oMM@elm>
In-Reply-To: <as266is_fT232oMM@elm>
From: =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>
Date: Fri, 16 Oct 2026 13:58:29 -0300
X-Gm-Features: AclHuK-gfESszHabRN0PS5BgGr5Od1_R3my1yeSujcE6rIsnwzhPm4ULckGMbVY
Message-ID: <CAMGU2hW2Bk7k301cjYvEQQR5jqGPCV7H5MC+rbHsTtWsXA8oOg@mail.gmail.com>
Subject: Re: [PATCH v2] ecryptfs: validate auth tok payload size
To: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, syzbot+03c68e42ce4b33f7ce9b@syzkaller.appspotmail.com, 
	Nguyen Duy Nhat Anh <neganhat@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El mar, 13 oct 2026 a las 2:00, Tyler Hicks (<code@tyhicks.com>) escribi=C3=
=B3:
>
> On 2026-10-04 09:37:55, Adriano Cordova wrote:
> > Validate that a key payload is large enough to hold a struct
> > ecryptfs_auth_tok, and that the password token's
> > session_key_encryption_key_bytes fits within
> > session_key_encryption_key[], before the payload is dereferenced.
>
> Hi Adriano - Thank you for the fixes!
>
> >
> > Cc: <stable@vger.kernel.org>
> > Reported-by: syzbot+03c68e42ce4b33f7ce9b@syzkaller.appspotmail.com
> > Reported-by: Nguyen Duy Nhat Anh <neganhat@gmail.com>
> > Tested-by: syzbot+03c68e42ce4b33f7ce9b@syzkaller.appspotmail.com
> > Link: https://syzkaller.appspot.com/bug?extid=3D03c68e42ce4b33f7ce9b
>
> Change this tag from `Link:` to `Closes:`, please.
>
> > Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> > ---
> > Changes in v2:
> > - Add Reported-by tag.
> >
> >  fs/ecryptfs/ecryptfs_kernel.h | 6 ++++++
> >  fs/ecryptfs/keystore.c        | 7 +++++++
> >  2 files changed, 13 insertions(+)
> >
> > diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kerne=
l.h
> > index 58165928ed1e..4315c18ba1cd 100644
> > --- a/fs/ecryptfs/ecryptfs_kernel.h
> > +++ b/fs/ecryptfs/ecryptfs_kernel.h
> > @@ -88,6 +88,9 @@ ecryptfs_get_encrypted_key_payload_data(struct key *k=
ey)
> >       if (!payload)
> >               return ERR_PTR(-EKEYREVOKED);
> >
> > +     if (payload->payload_datalen < sizeof(struct ecryptfs_auth_tok))
> > +             return ERR_PTR(-EINVAL);
> > +
>
> This change should be in its own patch with the following Fixes tag:
>
>   Fixes: 1252cc3b232e ("eCryptfs: added support for the encrypted key typ=
e")
>
> >       return (struct ecryptfs_auth_tok *)payload->payload_data;
> >  }
> >
> > @@ -124,6 +127,9 @@ ecryptfs_get_key_payload_data(struct key *key)
> >       if (!ukp)
> >               return ERR_PTR(-EKEYREVOKED);
> >
> > +     if (ukp->datalen < sizeof(struct ecryptfs_auth_tok))
> > +             return ERR_PTR(-EINVAL);
> > +
>
> Nguyen Duy Nhat Anh submitted this fix prior to your v1 so it is best if
> I take that initial patch. Please drop this change.
>
> >       return (struct ecryptfs_auth_tok *)ukp->data;
> >  }
> >
> > diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
> > index 51651314b7a6..7f2dbc81fcbc 100644
> > --- a/fs/ecryptfs/keystore.c
> > +++ b/fs/ecryptfs/keystore.c
> > @@ -477,6 +477,13 @@ ecryptfs_verify_auth_tok_from_key(struct key *auth=
_tok_key,
> >               rc =3D -EINVAL;
> >               goto out;
> >       }
> > +     if ((*auth_tok)->token_type =3D=3D ECRYPTFS_PASSWORD
> > +         && (*auth_tok)->token.password.session_key_encryption_key_byt=
es
> > +            > ECRYPTFS_MAX_KEY_BYTES) {
> > +             printk(KERN_ERR "Invalid password auth_tok sKEK size\n");
> > +             rc =3D -EINVAL;
> > +             goto out;
> > +     }
>
> This change should be in its own patch with the following Fixes tag:
>
>   Fixes: 9c79f34f7ee7 ("eCryptfs: Filename Encryption: Tag 70 packets")
>
> Thanks again!
>
> Tyler
>
> >  out:
> >       return rc;
> >  }
> > --
> > 2.51.0
> >

Hi Tyler, thanks for the review. I will split the changes and send a v2.

Adriano
