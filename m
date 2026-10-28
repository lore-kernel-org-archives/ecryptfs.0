Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793225386;
	b=ZO5Nav5ro6UFT+XwIB4V9ud3ZEkbqqHmlSMWx4IEoy+zgB89UTk8m5eGJ8llMGbtYF33
	 WqDnnmxpQ2oriouKyzy5yDzkanGF0SMoNq9hHfortF1fhm7U+CCruEOd44O6EUMO4VBHb
	 f73uUQ8r5CksLEmqANBt0bG7Y94xrBF4FhHdiwI+P74mgTUQlDo51+MOZvTyRZS65nhku
	 /z0hqw+0UkXMX8MyoEO/C+ERXArHCGdIu3eeLDes8uGLPFOzGHTL8EdgpmfSAD+Ku/8Ve
	 0QlTSOZnlt3zbza7Gmwre6PeG8IJBkb1dP36DSyMxigcJuqKMhCaJWUioegpGakGudQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793225386;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=j5xHrk121VJ6jsiOiBImMpaem11Ex15L22vqkzMRx+Y=;
	b=U9/kc9vfnkX5dGMhFg80mv60Zta7vhfpDAodwQrc8ZXfJl2CLMlPsi5dn2b0Mh1p55rc
	 ES+Wz2XV/u+U2Y1WcjD7r5R6CkNBWwvWVceAd+Hb6y8B/R+pVcF9vyAXPhDGO7p/DKt1Q
	 ImQHwjxtdk3Co55NAB0oTb/pKohAHQsqGNnhw3oQNnVyof0KOvwL6d3f1KKC0R2vp0opn
	 viasMeNI2hggzTTB8Y4YeiicYj9b+5IH1v6p8HuVNVqEANqhEmiWOljifP5Vw7HRaqmiu
	 Q4OJNQ6+Msm7s7DIdgl4eB3ULnaM0kDCRjxsNlsKapeoVYgjSdPSsRd6GxpuKFRDLPw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PNja0RrK;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=dMvVeWef;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A585D606A31D
	for <ecryptfs@vger.kernel.org>; Wed, 28 Oct 2026 22:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A585D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PNja0RrK;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=dMvVeWef
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793225384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j5xHrk121VJ6jsiOiBImMpaem11Ex15L22vqkzMRx+Y=;
	b=PNja0RrK+GAXFseGHRAPgDcQljq0pWRU5IrNz2yhBUldeqB5xObADIbjyjHyNHrutF7Pt+
	rJoNk3kv9NPLEvl8XKZoimFvycT999RKjoXG01AAR++Ak8kkM30MDhOQrx+KtOHBWo5kfK
	yRocWGrPgLWx6N9WURbn5mAhp5Y0UlA=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-QfGhkiOuPBide4xqwavbYQ-1; Wed, 28 Oct 2026 18:09:43 -0400
X-MC-Unique: QfGhkiOuPBide4xqwavbYQ-1
X-Mimecast-MFC-AGG-ID: QfGhkiOuPBide4xqwavbYQ_1793225383
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-67906c453b8so313558d50.1
        for <ecryptfs@vger.kernel.org>; Wed, 28 Oct 2026 15:09:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793225383; cv=none;
        d=google.com; s=arc-20260327;
        b=nM7aiHY0aFo52AgTD3hc36gFJyhPHqQhSmvbqIi5Q04KO7T1yZ2Y+xH+ZPv/t1/vr6
         hhApIHNZ6CP3cpJsfWpFTJJYoLTkUIqaTMZS90/61uT+Dy1vxkzfxE9VaquYIRrQAJ55
         MOMJNfQ4BAcNRfFykbRlYaPZq9nin3AUbSUi6yX4rqNjJ9/FuxzJ+2vTlP5mbFdFuNib
         CLcNj3p3s/LLykGmUYeGbCJkHRYa0Mmi7wgQYILV7WDFyoA+9ifyutLGLdJT0H0hJiX9
         KEjY8FJp2L4qIWSBI/R9FNCCEQar0MtWpsmNxcePaKbfU1MezksMTAGEgDwgaeGegM9D
         JVSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j5xHrk121VJ6jsiOiBImMpaem11Ex15L22vqkzMRx+Y=;
        fh=vt4oo6HcgNns9N1MvKoexJ75mgP/+XnLfbsFb8JLLAI=;
        b=Pumb7JUPVBZNO1w0FgRMl1Aidv1zl9yPhF+7cVNmTEJP1Pgk5vJXh/Ut0zndrRFqqj
         fT/lBdrQz4M5IcZxTUnYiH8PEaT0jquQRaC709EIRxQGgni/ITNwbrWrpFPnVcaExqPX
         ucm2gVS+u1HGt5AufJ/jhSwAqJ6BJBUd8yGw3dWXM87O0vTu9BLWaF/Kh0+1JxRecPix
         rXkOh+fUl14sfeezfIsa9Ah0GTnGmKzL4b4l/Z/YIPQK0n2V1UTS3OeBpQ/lgrzFT5pN
         BYwT+PGIkcXHNDgzXNfwmTM/5+YXi4PrV3e3tUX8xJ6eAvrAjffviWyKr7h27Wak9ozq
         /d/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793225383; x=1793830183; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j5xHrk121VJ6jsiOiBImMpaem11Ex15L22vqkzMRx+Y=;
        b=dMvVeWefC8P+UdQKNVCTRzDnhWHngZQGob2rSgzwsZSnRN8SAHr7CL96OPYJXufFq7
         zSTFFPllhPr/w76wrseeWsykFIT3XNeylizZvRvScikFw2Vx8ZBVf5aKYuJSSTUPuuch
         XBaTxNgE5Gyy25Odb94BXqgaNMMlvyhAsHvl+cohQ1ckCaDBDm4+NkPEdFeD/j45D4SX
         9JdubWa1Rkola0sqbNiDrUuR0ynjj8Js5euvpFf83x/dOZOzpzImQtYe9Q9exxMiq/qr
         mXS/pEC6VjG6Gc4ktJQ1wDheP9WEZsIfL+MfkoZBHHuqMX4NfKOOS6gRPfYVsrX4HqWa
         L7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793225383; x=1793830183;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j5xHrk121VJ6jsiOiBImMpaem11Ex15L22vqkzMRx+Y=;
        b=vBMino5JZTdw3TSPgZjDAxalTZZXSf0VPkjNItWCxvKStaFlUtCV3Ql/8hGOXg1RHa
         O+PyN/bbd7nGWsOZeh8kUMet2w6VFB9gEceJXPhVHSH6/HWKXlFl8JTmHa2+pj5LuxzI
         wRbnhmOTeufx10cb/jYYMS43jjFuy9SKPZWnT5BzF+B1+RV1m8Uc/hcctkCHzWUgQA6p
         PDWg/HHPGCHPeFE7F0Fx8dp68gkMqdOJ4nU6rSbZoveQ9epENNs+C43Qua3JiQXnPhoc
         YlmowZXDkEMHnfK+TMw8fY2uUeYRoqrdhwyGul8QjduoipFFnMA+XThPqNdPa/fRB9Ng
         87IA==
X-Forwarded-Encrypted: i=1; AKwUvBz4G7ZAC6a0CBJUMwvWAQ0sJqreMebfTxnNkMyKIqGw7b3DxgWzu6t35SzlLd4fkmwrmH9E1Z0jAw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJpOxgTnGYgJLxK+POi0HxEtLU4cqi2DMsg00bWY3U3dQjkVs0r
	tGSw/dRU9sCtxflo0TZP/7eclKnDiZt1C5CJFswVQBWdpPVQD4G2Ds4fNd48OP+S9DhbSjpmtHG
	bV9BgvaHzdL733W3ECYlRtxVoZCVJvr2ovDye6MnSls1QE1Fow5RHcPTnzPS6Lnlq9lV8cCQnpU
	8WuR5f2PRtPNZqtDofvD6ycomGAne/hWsbtWE=
X-Gm-Gg: AYBFou2vd2PVRaBOPZ52TCGloCzbDzdXV2IpvfcCEmDWbkkV91EVs0BbmjYbpc8iTK6
	/zlaoiClCuppXUiyEYdaE/2nBsW/Pi2+vdkKi4NLJV5omTfJ0RFRU1zBoVBvO7BVtOz89wvh4Xu
	461/bK+CI1VGyb7cQehO98XH/YRRDoTce3hfk4aPe8cM2NrRF6H1yX5UEVjjGjpwxYE8TcTbkO7
	WBd2y6jcO/b7ayHfd4g9a5ElKKbdNOQWbyMDEsiOLf1gQ==
X-Received: by 2002:a05:690e:1918:b0:679:ad2f:3fbf with SMTP id 956f58d0204a3-67a8d0047a5mr704869d50.8.1793225382842;
        Wed, 28 Oct 2026 15:09:42 -0700 (PDT)
X-Received: by 2002:a05:690e:1918:b0:679:ad2f:3fbf with SMTP id
 956f58d0204a3-67a8d0047a5mr704846d50.8.1793225382297; Wed, 28 Oct 2026
 15:09:42 -0700 (PDT)
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Post: <mailto:ecryptfs@vger.kernel.org>
List-Help: <mailto:ecryptfs+help@vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ecryptfs+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261012-work-fs-sb_rdonly-v1-0-60743a3dc326@kernel.org>
 <20261012-work-fs-sb_rdonly-v1-21-60743a3dc326@kernel.org>
 <CAHc6FU6z4kX5R3Og8m0dYOHsjFcw+4Btvfe87AGPxy_EWs0E7A@mail.gmail.com> <20261028-zurschaustellen-okkupieren-inkompatibel-d11525ce88b8@brauner>
In-Reply-To: <20261028-zurschaustellen-okkupieren-inkompatibel-d11525ce88b8@brauner>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 28 Oct 2026 23:09:31 +0100
X-Gm-Features: AclHuK9MzobLdiG2EG9M5KT_ibZzYxdrTghiXff6ZlesOE7YSK8Ag_RtXekxyZI
Message-ID: <CAHc6FU6VSAWQ4RJTO_eLnpqN5qvrShbJeT+ADwiA6ohpq8dO4Q@mail.gmail.com>
Subject: Re: [PATCH RFC 21/28] gfs2: don't set SB_RDONLY on withdraw
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, ecryptfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
	linux-nilfs@vger.kernel.org, exfat@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, ntfs@lists.linux.dev, 
	ocfs2-devel@lists.linux.dev, linux-btrfs@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-efi@vger.kernel.org, 
	linux-mtd@lists.infradead.org, linux-xfs@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 5:02=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On Fri, Oct 16, 2026 at 02:01:00AM +0200, Andreas Gruenbacher wrote:
> > According to commit d564053f0746 ("GFS2: Clean up freeze code"), the
> > idea of the freeze sysfs file was to make it behave like the FIFREEZE
> > / FITHAW ioctls. This isn't what the code is doing at all.
>
> That's a pre-existing and separate from this series. freeze_store() calls
> freeze_super() and thaw_super() directly with FREEZE_HOLDER_USERSPACE and=
 never
> goes through gfs2_freeze_super() and gfs2_thaw_super(). So it never takes=
 the
> freeze glock. I don't think that's for this series to fix.

I mainly wanted to point out that this behavior isn't intentional.

Thanks,
Andreas

