Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9323D524F
	for <ecryptfs@vger.kernel.org>; Fri, 25 Sep 2026 17:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790356054; cv=pass; b=LsadQirc+DKTM+WgVkljMLHms1lqi71GcihXtENhneP/EECAR+KYOrrF4UbfgnXt4c6Txxv3xnqI1WWOTfPPlmk6SGBVZ0TTXywZYcrbq02CXLoELSndKgzn6WnxDH7H+8NvWOAqVVAXi426RAYIagIWWzChjpycCFZHRf4+8NU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790356054; c=relaxed/simple;
	bh=Z/QlDjEqmTsvd8hmVsRhjPJAPZKduCsAshcn9SEcHsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=doB00YcFjj7ylLJudIwQbZmFthcVCptYRF+dGxjiR6xT6BegRZieWJHUSR00Zj3ZDurFMmmlqYwOFnPiqi38BQqLHbjutcby4IljdEfpIWJpWI+mJRw7fjSd/VdmbgSrUCiAQVYchgyZQkI+mj0u2iPV2++mw2AEHgWhCJsEue8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JQ7vBslB; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JQ7vBslB"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2db1ca06a25so5145555ad.2
        for <ecryptfs@vger.kernel.org>; Fri, 25 Sep 2026 10:07:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790356042; cv=none;
        d=google.com; s=arc-20260327;
        b=dv4vo44mk96zJt6iKJY0kRl1VTIkobAzB8kGIknlR462b0u42jesnneFDUMAkbQood
         R8EAXtzfLoYGz5RFvx5RxAcL0QhDPRcZD2WUI1N6IzTSc7tErOtwIuTbBitgdpCzpt86
         I9DnHJwS5YJBawPLN6V5IYKRHvaW9Q7Kcn+0fhCgwGvBx3wUtvDGtzAQb64svtXHUFfG
         Ty4gpwQ+F/duHnle9MQk2fL3Y3b/TiMKZz3eL84JsTCm64TnFN9AcbPmyfYnX3+tZq5e
         9YJ9dq403XTl7ZZ0Jwx2RGCSFQ/Jh6h1XEhK6i6ESRXPAc4FX62UlLPI4ksO8ZKjKWnC
         2Vxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8YwzIASUiQRwU6GfvzkJObDJseuyBEMVP7g4XrNm/58=;
        fh=xx5FCnfAtH9O8lZv3gQKGOmOpqAbpsdBoLy4JhkqRfk=;
        b=iEFuK3ctEg9Jj7PtyWNzMqRgfHaHP070zi2KVT+S1cGJTI5ZDoFT55AfTk7at/pVp8
         kZ6O++u1r9OmoE9XxKLocnMcQxY0+rNBbu4FlA1mj5J7zrnyzAzoVI9DVWD9SzcjaFqJ
         6ufurvxKxQumnDJk4t5k+9ME8+CkiChmLhl7yjvdviAcra47PGY0uWeFfo5Qqy/R3uGx
         3n5Xxm8KRpcnd2twnQUk+HIok6ndaykXaOWG3e4cg1xCSHT75hYBdWLV4aj3KI0kREPx
         +SVywuQfLmiwxK1m5kLAtn3bbdeAlAgSL8NPFadDVap9d1V57cVQ1gYAYSfFRRcJ97ci
         XQvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790356042; x=1790960842; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8YwzIASUiQRwU6GfvzkJObDJseuyBEMVP7g4XrNm/58=;
        b=JQ7vBslBA75Oz3vhccuiegu2ZSCVFqSF0HyjC/3/vNzOkrP+yD6f4D4JjYMSYAoFrr
         wlg7Wmn6oEu7SXRotz0a67VZfHRO6XibZ9ZQ2iaB3D1nQj3Xnbu+DnvAmLPuwuabcTJk
         PXz37aU1zp89S9iK0/x3WEyWrQZ8hNLRiSYpSLIsFe52Q0ZtYHr08wUrk94pc3ENWlQd
         J+Tedgfpmw+/PX5h3yjumGEOqc+s3rcWYPx4Hn4luwZxasnr3NVcHxFxvCE/jfitgeBw
         +jOt/CmP2fD13Y486VYHbVYAPN3U4OMa+qtVuZhbWJD5jm5g1hu0o/Zq9FL93oXYU7V4
         vv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790356042; x=1790960842;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8YwzIASUiQRwU6GfvzkJObDJseuyBEMVP7g4XrNm/58=;
        b=myM/c9c4VI1Vq+6B3jmTjZZ9pggdDMJHoLweanndR3314fXgqz+PR8MflL7/Kocmil
         bfTnXswAusSU5C5EUmvx3SXL93BskF1b8FXGZfD/C3N5Ro7XCnucjMaVRCQUjkvrKEEx
         248JynZFPaOmyHoQWgamwr0ja+4bHgtRmuy7AeZVMcUgvwS8oVyZ+QWnzHAj7dOpuuql
         KScJGYNanr9FjGygIDMiUSRyrnVT9n2sQSn1h3tdmh/VbNH4KwgrLRZudI90NwRZJglE
         NpQ0iw6Lpb5AR97QlsU8LO/8RwPbhFpkPespE1K4V6W85fuRYblBnOBNmGN8EEZmbRPo
         YbzA==
X-Forwarded-Encrypted: i=1; AKwUvBw4C10IkKsxncevzwlIfsCY55EOmfU5peoV+r/LJqGQRHaOHWRoMAfxBfNyLF+dM9DA301kdavLvA==@vger.kernel.org
X-Gm-Message-State: AFuF++knCJ847m4kGugC54OpD4nVkq/f7fa2ogZW/LrtcQXCqUHw7iCR
	f6GWrSBGtZGcUOkg6jodoabUUi3TdqtE9qp6S1XJZ908wMK8qMsNaBEQzfadM+30RONMF2R9HPx
	prbUj2+rI3YWIhvhqVmNMrOSDEa4TpkqZEzKoBPH2
X-Gm-Gg: AYBFou3j7ACKZDykS5GKw4AORcpCWb4UV70nhBefHl84s2fm8C4xV9SIyfm3ZuuQ37y
	/csdvJQahteM6J+HJPVfwpoFR3c2t8USihqoedQxSMBr9kVcwJkzKn7dxBQlG1fFVYbCmKsV41Y
	aREDvJPcz9R+c29lBwJI17mXfPmqPjeiLsgY6DPF05Zwh8TL4tOShdkLHk4JhSC5Nam1FEPYL6h
	mNntc7dXlWsirW23kX3G6dxEkeWzAjlKiKBVlrAda1HdqvatlxR8V+Lj5d0PLI0+8U1bZF1EkX8
	XDRRr6SanMOcLzMcWIubnzvDMHUVvZ1S6q0Vx4aVm/PwIE1LhuiiIKnT2b5esV/rCv2F4Imvcqi
	APcYJt5gG6pMtXjvAw43Cjw==
X-Received: by 2002:a17:902:d48d:b0:2df:99e6:9448 with SMTP id
 d9443c01a7336-2df99e695bbmr12902675ad.61.1790356042370; Fri, 25 Sep 2026
 10:07:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924104831.1081137-1-caixinchen1@huawei.com> <20260925-zahnersatz-hielt-lerche-141893658522@brauner>
In-Reply-To: <20260925-zahnersatz-hielt-lerche-141893658522@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 25 Sep 2026 13:07:08 -0400
X-Gm-Features: AclHuK-PYyMWIn_xv6i13K6lF_3RP26uUOO_mtAnUMGHNcMrV5ydBitx8qn_ri0
Message-ID: <CAHC9VhSeXmOHvioZ12aVmnOtpP52-G=K_jS3K0fTSiCrDHStPw@mail.gmail.com>
Subject: Re: [PATCH RFC -next 00/12] landlock: Add READ_METADATA and
 WRITE_METADATA access rights
To: Christian Brauner <brauner@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Cai Xinchen <caixinchen1@huawei.com>, gnoack@google.com, jmorris@namei.org, 
	serge@hallyn.com, corbet@lwn.net, skhan@linuxfoundation.org, 
	rdunlap@infradead.org, gregkh@linuxfoundation.org, rafael@kernel.org, 
	dakr@kernel.org, dlemoal@kernel.org, hch@lst.de, axboe@kernel.dk, 
	viro@zeniv.linux.org.uk, jack@suse.cz, dhowells@redhat.com, code@tyhicks.com, 
	linkinjeon@kernel.org, sj1557.seo@samsung.com, yuezhang.mo@sony.com, 
	hirofumi@mail.parknet.co.jp, cel@kernel.org, jlayton@kernel.org, 
	neil@brown.name, okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, 
	miklos@szeredi.hu, amir73il@gmail.com, senozhatsky@chromium.org, 
	chenxiaosong@chenxiaosong.com, zohar@linux.ibm.com, roberto.sassu@huawei.com, 
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	stephen.smalley.work@gmail.com, omosnacek@gmail.com, casey@schaufler-ca.com, 
	nanx95726@gmail.com, djwong@kernel.org, daniel@iogearbox.net, 
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	netfs@lists.linux.dev, ecryptfs@vger.kernel.org, exfat@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	xiujianfeng@huawei.com, lujialin4@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 11:33=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
> On Thu, Sep 24, 2026 at 06:48:19PM +0800, Cai Xinchen wrote:
> > This series adds two new Landlock filesystem access rights,
> > LANDLOCK_ACCESS_FS_READ_METADATA and LANDLOCK_ACCESS_FS_WRITE_METADATA,
> > which control access to file and directory metadata such as inode
> > attributes (mode, ownership, timestamps), extended attributes and POSIX
> > ACLs.  It picks up the work from the "landlock: add chmod and chown
> > support" series [1] and follows the coarse-grained grouping discussed i=
n
> > that thread [2]: instead of separate chmod/chown rights, metadata
> > operations are grouped into one read and one write right.
>
> This is mostly fine for me. @Michael, for the fs side of things I would
> give you a stable branch vfs-7.*.shared.landlock.path that you can pull
> once this is ready.

This is in my queue, but I haven't reviewed the changes yet.

@Christian, I'm guessing you will merge patches 1/12, 3/13, and 4/12
since those are the VFS changes?  Once you have a branch for that, and
we have all the necessary ACKs, I'll merge the LSM changes in 2/12,
5/12, 6/12, and 7/12 and then Micka=C3=ABl can merge the Landlock patches.

Are we all okay with that?

--
paul-moore.com
