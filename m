Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com [74.125.228.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C643BCD15
	for <ecryptfs@vger.kernel.org>; Sun,  4 Oct 2026 12:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791117100; cv=pass; b=dNJQ3yBKB0abI/HbATx/kry6vlildLe9eHK+o10mlhEiEGfbCvRz+nbVuN1Ne+KY88ULdnqDhZw3eVuWWEPBWfWPYP6LPiXRCSGKmLuzpjJ723reIZhEtX4XeKXDOvKFkz4K1naoLMqA0yRFvTZR7SYm4NkfZNovNybFU3S8q1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791117100; c=relaxed/simple;
	bh=GXfjk93rqVjkEm8QtrTGYzEWMYxFujv0Lq5SqSgVimE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cOssdOm007Kc4viEnC2zcia7P+2GbToB0K7+o7uNHw4oQSmsiVkTBThe8HqkgGYCGaEvKfETpfBQ4PHNaUueNupnmpE3isAcp7FtaqUTmkgaMT0UV1havTI9cVZAdVb3grBUSS81UYWH9T6Wefzb9pWstuQs056YylUz1ZE2FwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oItSJmc5; arc=pass smtp.client-ip=74.125.228.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oItSJmc5"
Received: by mail-pz2-f38.google.com with SMTP id 41be03b00d2f7-cc79a5bdf9fso171713a12.1
        for <ecryptfs@vger.kernel.org>; Sun, 04 Oct 2026 05:31:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791117099; cv=none;
        d=google.com; s=arc-20260327;
        b=gw4hHgDIFa90lXjKpxPctbr6nib97g4cjF0lZN0wweYcAKU/JT26zjSPrkmcsvicUj
         NMkrFKxmkgPJ7PT5Bawdnu8cspZ5tHJQG34wwEtB63/+26rNnwuunyl5PNu4tIYiVA5f
         SbTzPlXaPZoXDEuNw7ufUV8aNQ8OSxnelb1JibH8SkOq/VZ9VkVzD546TpMQm92oINBf
         w8E92WYGHSiOTwWe5mbBnopzrHe69qAtx72SSTN7JTrvV2aO99NkcXuxyGha0e1xIJuH
         9wMCqnWshrl+XOCzb+dLYalGYorj+ih/0al5DekqDqyrZC2P1dACShvP2BxGXjKpH8ZV
         jcoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GXfjk93rqVjkEm8QtrTGYzEWMYxFujv0Lq5SqSgVimE=;
        fh=nghn267776b72EYWbPAr32LecUC2fBvJI2LSp9JRpPM=;
        b=ZPQFlWYxykpQYYuzikG2EL8MBfI3LfHcSotLVRKia0rWoBMfvjIQk7/HlNZ1y8lA/j
         pzZXd2IajZzrjivv/f7yqRCS1E5G8E9kcLnN18+FfPBkPGcLHKKrLDDfbq2mrdqAFquJ
         NshyFIlxGWHtTXKVeD7NEWEDqLfu3onn5C+tmRE1xdjLZWiqVHFD1e4Huqrg2KOPPOkN
         d0R1WX6RrK6fJGh2xq87vaGYJfyyIWaTKqeQvvwy/z0C+i/w8rNmFtMqECgvJZaLCxkU
         hJZmIghyDwJaluAQBhZ6lC1uQqwzqg0wblXmwmhU/hDbRcaVh01/TgUMfLjJIkdu56TW
         D9bQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791117099; x=1791721899; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GXfjk93rqVjkEm8QtrTGYzEWMYxFujv0Lq5SqSgVimE=;
        b=oItSJmc5gplGn+GwGiz/D479gTHCHpP74bE0H2I+RO8okuiDd85BMkhj7l7edgbp19
         hIwPIhWIXeb08HAt6AqvoSq1VbFPcYa2os5RElxw4TBIleXKGKJ5PD7MQzEBZpUIOoov
         zO+OGA1EYRuLkGaNwgxDIKChUpYgwHgYLwszFPfmsfG5Z/S3HuyeKNI/ozl/o3ofUHSf
         vgAU/ps4ydoV+8w1FYlr6Fi6y3mNaQ+Z7a52yrH+vGtqGWRHOWPjNFyGTGfGOK0YJMsp
         ofD6bcZP96QzcziVT2nIsLY29w67wXHxPIYZO5JQIL6lqMeryxilSBdKuw++Y49uSgB/
         I8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791117099; x=1791721899;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GXfjk93rqVjkEm8QtrTGYzEWMYxFujv0Lq5SqSgVimE=;
        b=ucCKnHL0XcAQ3tFx7hJR9+YXmt9eJLgdaz5wLsJ1jKuHqCs/fRhjso1ex2kEvIyVuw
         8+SXUS7Txd5p/tH9+SE40kI2o9li6H3UiX5y2gFyP0rjH03e6CaPlpjMFtY0z3daFxzR
         zmdzCiNKATADjxpGyxbIIETUHnbyfiZwItwLDtyrNJX2DY95NhBENR4u5wWVUdI6DOjM
         RWLbMRZZN6aKvv5oIbM3xu+N9MFD283eXf8eAuX0Xsr9OOlhuDDlYolacOLmAGdpj+aZ
         LGq3w7iOpaJtE8K65VcPploH3ahcgOotVGH/4QPNevAJQpthQyLfiG/Qkc2LTs7ojFXa
         hw9w==
X-Forwarded-Encrypted: i=1; AKwUvByw2NCKYus2zbEDPMzaOw2qTlGpXymy+h07xkRAToDrRWA0tm8qsw/BxQTPZhwC2OzKuuoX/7V73A==@vger.kernel.org
X-Gm-Message-State: AFq9FYKnjw8ogdUD0cTQBWGa9075mtKkAJjx/rmtsEC233h8Fe1+cvc3
	GPYBqPNVvVP7dfctylrN2KC1L9xDqoDbQPMJOeAwxexGov8OnQK6AII5TRxZX/S86wW3Jaz0dj8
	52JoHD487AvmKqVKjrLkgzYJHMnEsElQ=
X-Gm-Gg: AYBFou1LdqAsBa8nA4XkJxhBzPIKPfZGBA5WJAcrhDCUsd2yof1tKRBRijNlj2RNGoE
	7N20PmKx1//ZNWCLs3wxOhcMlCpVqKFNr0ANtfzZfpGuOg04hu4QbsHI50U7wlycWEB39CmdquB
	BsJN3fVghIK4dYhriVeA2y03ORpH/8a5+FN4Jbd0ARiaN/QKSg9fYFDpiYIaavGXSKBFgoVjs+/
	3dU+YBR5ma7UcUA0B5XcKVX8hjj0b9YqP7x/8JfEa4BnI2ilIXUDZveJDdR56W7Bize6DKW+wI2
	OSTBkPLyPhmAgWoePHL5FERPPAD5KW7m4cGDJUBrpTRD0Ci5xC+d3Qqm
X-Received: by 2002:a17:90b:268f:b0:3a4:e735:b3a3 with SMTP id
 98e67ed59e1d1-3a6cec8cd26mr4508237a91.40.1791117098607; Sun, 04 Oct 2026
 05:31:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001213915.1326602-1-adrianox@gmail.com> <20261003171352.10244-1-neganhat@gmail.com>
In-Reply-To: <20261003171352.10244-1-neganhat@gmail.com>
From: =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>
Date: Sun, 4 Oct 2026 09:31:26 -0300
X-Gm-Features: AclHuK8R9Jo3-68_DE9TmeC3aACV1AZP1ZEQoMrqadGoXULvBmqZTbxMVHejPuU
Message-ID: <CAMGU2hUmzd1i0mpLG0M2sj1Ki+2Esz5vFQjqJ6F6RnJM3RafyA@mail.gmail.com>
Subject: Re: ecryptfs: validate auth tok payload size
To: Nguyen Duy Nhat Anh <neganhat@gmail.com>
Cc: code@tyhicks.com, ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, syzbot+03c68e42ce4b33f7ce9b@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El s=C3=A1b, 3 oct 2026 a las 14:15, Nguyen Duy Nhat Anh
(<neganhat@gmail.com>) escribi=C3=B3:
>
> Hi Adriano,
>
> I noticed this patch touches the exact same lines as a bug fix I submitte=
d
> earlier for ecryptfs (the ecryptfs_get_key_payload_data fix):
> https://lore.kernel.org/all/20260917044558.41677-1-neganhat@gmail.com/T/
>
> Since your patch expands on this area, could you please add my
> Co-developed-by or Reported-by tag to this series?
>
> Thanks,
> Anh

Hi Anh,

Sure, I will send a v2
