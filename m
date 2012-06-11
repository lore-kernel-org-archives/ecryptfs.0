From: =?ISO-8859-15?Q?Georg_Sch=F6nberger?= 
	<gschoenberger@thomas-krenn.com>
Subject: ecryptfs o_direct
Date: Mon, 11 Jun 2012 08:54:15 +0200
Message-ID: <4FD59617.1010608@thomas-krenn.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail.thomas-krenn.com ([217.7.54.186]:40753 "EHLO
	mail.thomas-krenn.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130Ab2FKHDr (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 11 Jun 2012 03:03:47 -0400
Received: from iris.tks.local (iris.tks.local [192.168.10.63])
	by mail.thomas-krenn.com (Postfix) with ESMTP id 15C2DBE114
	for <ecryptfs@vger.kernel.org>; Mon, 11 Jun 2012 08:54:25 +0200 (CEST)
Received: from localhost (ate.tks.local [192.168.10.78])
	by iris.tks.local (Postfix) with ESMTP id BDD4840605
	for <ecryptfs@vger.kernel.org>; Mon, 11 Jun 2012 08:54:24 +0200 (CEST)
Received: from mail.thomas-krenn.com ([127.0.0.1])
	by localhost (ate.TKS.local [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CWn8kH4K8Ruc for <ecryptfs@vger.kernel.org>;
	Mon, 11 Jun 2012 08:54:15 +0200 (CEST)
Received: from [10.1.102.103] (unknown [91.223.201.22])
	by mail.thomas-krenn.com (Postfix) with ESMTPSA
	for <ecryptfs@vger.kernel.org>; Mon, 11 Jun 2012 08:54:15 +0200 (CEST)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: ecryptfs@vger.kernel.org

Hello everyone,

is there a short explanation available why ecryptfs is not working with
direct I/O?
According to Jens Axboe I cannot use FIO with option "direct=1" because
my encrypted home partition with ecryptfs is not supporting O_DIRECT.

-Georg
