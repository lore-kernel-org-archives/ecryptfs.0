Received: from ns1.suksangroup.com (ns1.suksangroup.com [103.13.31.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA8D3128B8
	for <ecryptfs@vger.kernel.org>; Tue, 14 Jul 2026 05:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.13.31.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784006323; cv=none; b=f0mk5j3Adkv9Rphd3EsGGWfXWt7TQjqux018hIWJl+V03ROe9dQkE9YH/2yImsrG6B7PJ5TROCMmmgCCDbmunoPAjHDV6ywk7Er6MWM9vNjHH4kSexWZP8wHwbz8XAHlrAkpt3YpQNvWndAr64MViMpoqutqJLXadiVCTw2zDZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784006323; c=relaxed/simple;
	bh=4UDVjbNzAcN8I1HWyfOc3YwfmTXwH5ht0OgVkbfOBtY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EbjBqxuhdG7kB+YANLInXlTBiBFifgOd29p6o4IlfoQwwKF5vcZ2JEaKlet2vXAjDZCWspt9CwmyMFUc7jyRN6gY7H+6NRYsXnJXZE8uNbBa+jAU0/pgd4nZIAYa6Tbe5mPS1goXtYgTlyB1U204fyxMPAS0Rf9yi3DiYt/3/lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=inbox.org; spf=fail smtp.mailfrom=inbox.org; dkim=pass (2048-bit key) header.d=suksangroup.co.th header.i=@suksangroup.co.th header.b=17se7SuP; arc=none smtp.client-ip=103.13.31.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=inbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=inbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suksangroup.co.th header.i=@suksangroup.co.th header.b="17se7SuP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=suksangroup.co.th; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Sender:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4UDVjbNzAcN8I1HWyfOc3YwfmTXwH5ht0OgVkbfOBtY=; b=17se7SuPi0mS4bL0KBNHngjkbH
	Ph5CUdg3K6Fg4I2C3ool1XPv/5SMLkwpjILj/AmGDez+oHQ1Irfj5sU7DBN+LrrKFl73D+fqhxvNa
	FBqQ/ts5K9g3IXkhHTXz0ILtvd3DNKP4ZKVUgX71+S80agVpZaVfbczWrZ7Mo2ehph2PCga6bzWrO
	+QSfr4ASh7cqpn4G5LSnQr2X+EUY0a/niGksJESV2XV79TuRMoAcqqCICXoTGDh67e66pV9Y3gB6X
	1gkaIhx9TtHcWAEnyasyXA7UawDGZCS92zxs71mu5PhetlfkTOjwsQxcfvHfn6SrPR3YvAZvkl0zk
	Iv26D1wg==;
Received: from [207.189.26.187] (port=61605)
	by ns1.suksangroup.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <info@inbox.org>)
	id 1wjVXU-0000000Ft3Y-2mAb
	for ecryptfs@vger.kernel.org;
	Tue, 14 Jul 2026 12:18:39 +0700
Reply-To: hanns.schofield@lexcapitalgrowth.com
From: Harry Schofield ESQ <info@inbox.org>
To: ecryptfs@vger.kernel.org
Subject: Dear ecryptfs, project info
Date: 14 Jul 2026 00:18:36 -0500
Message-ID: <20260714001836.0E78CC0CC4DC6A7D@inbox.org>
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns1.suksangroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - inbox.org
X-Get-Message-Sender-Via: ns1.suksangroup.com: authenticated_id: smtp@suksangroup.co.th
X-Authenticated-Sender: ns1.suksangroup.com: smtp@suksangroup.co.th
X-Source: 
X-Source-Args: 
X-Source-Dir: 


Re:Good day ecryptfs,

Please let me know if this is best email to send you the project=20
info.

Kind regards,

Harry Schofield, ceMBA


