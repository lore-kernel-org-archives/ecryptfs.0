From: Dave Hansen <dave.hansen@intel.com>
Subject: ecryptfs log spew from EINTR
Date: Wed, 05 Mar 2014 09:15:28 -0800
Message-ID: <53175BB0.1020107@intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:64744 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750817AbaCERPo (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
	Wed, 5 Mar 2014 12:15:44 -0500
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: ecryptfs@vger.kernel.org, Tyler Hicks <tyhicks@canonical.com>, LKML <linux-kernel@vger.kernel.org>

I have a little program that uses mmap() to copy files.  Essentially:

	addr1 = mmap(fd1);
	addr2 = mmap(fd2);
	memcpy(addr1, addr2, len);

If these files are on ecryptfs and I interrupt the memcpy() with ^C, I
consistently get this in dmesg:

ecryptfs_decrypt_page: Error attempting to read lower page; rc = [-4]
ecryptfs_readpage: Error decrypting page; rc = [-4]

-4 is, of course -EINTR because of the ^C.  Should we be suppressing the
message when we see EINTR?
