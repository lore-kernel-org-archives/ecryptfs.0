Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D61E2F363F;
	Fri, 21 Aug 2026 00:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787271801; cv=none; b=p0iI3E6aAnZYIs3gqh6JSCFZulVIv9IFQlYv1EWaIu1MGdGIKDuf06vrRMRBThczsYPT+Iae5zZtm5WXXzBKqH9isNOykgGy5mphUCiaj4y6foz6wsqPX29sUboXRbJklmEPlvMU1Itzn5TJqD6yjHIt3bl/RKKrg69SOl6OEmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787271801; c=relaxed/simple;
	bh=zrlAAfX7JLJHIuqnEH5V/1pIwPu+vYrTRCBE91OMDkU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uKXF6/UG5FxRVjKpj8H0VQ/UOYqiL66geFeUGVF4YeK+tmhMmXAKPWIF/pdWLcOt+WyJCQ6jD+FvjDuDGwcCk5DUnW33xS7In9ZmMTRb5+ltrECo5H7Uz3zOGxJCPvV13r7djTZyiTui6/dL6VyFtqL8+L6OFLDtwVGEPq5NOf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com; spf=pass smtp.mailfrom=tyhicks.com; dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b=H+Pua2lg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VqM4sVac; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b="H+Pua2lg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VqM4sVac"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5CEBC140018A;
	Thu, 20 Aug 2026 20:23:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 20 Aug 2026 20:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1787271798; x=1787358198; bh=yB19lK/h5CZdCq8nzXw4TPHkxOxQP/on
	3rL98Jj5ktM=; b=H+Pua2lge+PqyivWrUAdQhTNi398yXln1lmcvbs61uL7HWc2
	QtE2BfIJz6P6AEqk9m92wyFeHOfrf0uLOUv4q5efal+sRqlkhSfD1r603jPzXcyA
	wFghBnURCL4eGhI9p7eUfeHegFxJVpo/zS3y5jrJoZxCqFW+5SbjamRw6DQWKowr
	kbdZ7cF3+uaZW2dzx6a9g2l0MwC7AjVHFg7SeQyn+HlR4v02lETBciRu6m4WgMUk
	dU/jHdClzAH/0zJOtfIBe5qddEJO5ZVSFTihKDIANBtSu76Kew2EUwxD6DY7U7fR
	YH2ac40sLl1QIJoeUKX7FAxW4L2jE/0IV9hSww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787271798; x=
	1787358198; bh=yB19lK/h5CZdCq8nzXw4TPHkxOxQP/on3rL98Jj5ktM=; b=V
	qM4sVac/rjIs5wQ5TdBlNwQZuXuQLJhzHuPYmapnBu4Y0LjJctELRF8Cx57bU1N8
	wGssvZ2pV/Q6aIhiRJTnNEZPLzPqnPQ50eerbsXsWEJlqciblb3XyL6Aid3g3WLD
	vfvelPZFuwfNoO8UD5848zaR728o5/FfrKO0yp0Z+OgTSSQ9pYyyv6S98Pw006KJ
	zmngQNfyI8Y1rtaw7wgmx4y/oIhZhskJU9rY/BVhkcUVw2L8c4pR5BWwa4DP8ISg
	9NvEJ9nhUI2iPoTD5QdOXHyC1Tz5xR9dxbFrI8j9HDLPqagLbwStgcfrjBnBcF0M
	m7UJFJrlHE+ttBp7eR3IA==
X-ME-Sender: <xms:dpqHaigZXX7O7V7Y13EkVba-Suol-q8QzeDN1Zy9DS5YhVixIBIRuw>
    <xme:dpqHag20PSxyiXxGxOkBERC4GwRUw3dms9J8TyetO2Np9O9gLi7-W5YkBISfGHLee
    zNwfa-LW47qu-M44NE59t2t-BF4mWdXCYRLWXWF9upW4leVKuYZAhXI>
X-ME-Received: <xmr:dpqHakiNRjXfFMn75yXvZllakGNTzhw3ujTv7gCVeaHAwo69ZuLJgA>
X-ME-Proxy-Cause: dmFkZTFpUzFYkeZmHbscADeOWwKGZaCqNn/l7cv+1+J3ajiSK+G3p0HsA4ymwEXONJB40B
    Qr0OhcVr6GLRGX0FObAJW0n1YzvcMI7lyztO0l4UUry15FkunBb/tp7XCEHhq91r7kQBK2
    n44NW0QzEV73/M1lDn62E6kLopT9cph7lmIwTyLiB0K+qrE8KOSBX5l6KhsNBtJSAMa/C/
    H2i51lVVVRNNNWBB2SZVZskkD49AqBtH4JAUuhUtJukOnr5iZHGmA93rDGzsGBlf04C4Al
    v6H7R3AH7x5BGXt8S6WsEZpEazAf66IZAiVcJG7a4QLzdZBHYE6ZEEjgySuK+nHNVZqbXk
    0RB+o1BF92g3OLvQX0zWbpUQTzKazhHJIrSFccxUG7obPajwKtE2eyEdy17eiVndr4+EOq
    Ng9MGlRlP3z10n892MK6ZfmTlTv6EX3Gox4k8m4GLlxfLEv6weps3uWukHsEjCh9NBtMUr
    JQYWgrg99afnjfgC3NIWvL/I4ELezoH1kxmHKViGgykC6rizoS7GRDlI3987DpM+rcif8z
    5QvNQenyWXQ8jrNSoduDGCHtLq3Ni/l551t76JcZbC8PnUNP3gFxy0kWzzGkwT2MUr3RmS
    eTZ3ZEMHc6Mm7eFxBJFqX0VgKWegScb3ROWOgMyWeMp3bCuFA5OVW01Vj3WA
X-ME-Proxy: <xmx:dpqHaocl7w61cHEv9rMPqc-v5Uk2gtPgehM4Hqg1LUcn-hsktdXKWw>
    <xmx:dpqHavlX6WmQuLIqjop1fUA9BcWOPe9JgVxWpcBTzpHMpsbCEjyypw>
    <xmx:dpqHapsRHeAZ86X0iLF8Qr6wLw3XHYzP31SAshHmjnyUGC4dXudYCA>
    <xmx:dpqHat9TKNJjWkaY1ZnjHgDHyAhTx2EK-VQMAv1ATEfG8IVzBoMDcw>
    <xmx:dpqHamd_Jbohjmfcg1aiRVtHr5eUVEmU4I_-zX84dIVTzLWQI4C9U8zo>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 20:23:17 -0400 (EDT)
Date: Thu, 20 Aug 2026 19:22:55 -0500
From: Tyler Hicks <code@tyhicks.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
	ecryptfs@vger.kernel.org
Subject: [GIT PULL] eCryptfs fixes for 7.3-rc1
Message-ID: <aoeaX-Z7eSZuYP1A@elm>
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit a13c140cc289c0b7b3770bce5b3ad42ab35074aa:

  Linux 7.2-rc3 (2026-07-12 14:16:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs.git tags/ecryptfs-7.3-rc1

for you to fetch changes up to f81cb44f9a4b88d73ee5dec4a1ccdb0232fd2e3f:

  ecryptfs: ecryptfs_kernel.h: clean up kernel-doc comments (2026-07-22 19:59:33 -0500)

----------------------------------------------------------------
eCryptfs updates for 7.3-rc1

The set of eCryptfs changes for the 7.3-rc1 merge window consists of:
- Hardening and fixes for maliciously crafted eCryptfs metadata in the
  lower encrypted file
- Hardening and fixes for maliciously crafted userspace <-> kernel
  miscdev communications
- Locking fixes for userspace <-> kernel miscdev communications
- Fix to display encrypted filename related mount options
- Clean up address_space_operations and reduce build dependencies by
  moving to filemap_dirty_folio()
- Get rid of an unnecessary memory allocation in the inode update path
- Kernel-doc formatting corrections

The patches have all spent time in linux-next and they pass all tests in
the ecryptfs-utils tree. I did manual validation of the miscdev fixes
since we don't have test coverage for that feature.

----------------------------------------------------------------
Aditya Prakash Srivastava (1):
      ecryptfs: use filemap_dirty_folio for address space operations

HanQuan (1):
      ecryptfs: reject oversized encrypted_key_size in parse_tag_3_packet

Pengpeng Hou (1):
      eCryptfs: bound the packet-length peek to the user buffer

Randy Dunlap (1):
      ecryptfs: ecryptfs_kernel.h: clean up kernel-doc comments

Yichong Chen (7):
      ecryptfs: release message context on send failure
      ecryptfs: hold msg ctx list lock when cleaning daemon queue
      ecryptfs: pass packet set buffer size to parser
      ecryptfs: fix tag 11 packet exact-fit size check
      ecryptfs: reject too-small tag 70 packets
      ecryptfs: show filename encryption options
      ecryptfs: avoid heap allocation for inode size write

 fs/ecryptfs/crypto.c          |  2 +-
 fs/ecryptfs/ecryptfs_kernel.h | 15 ++++++++-------
 fs/ecryptfs/keystore.c        | 45 +++++++++++++++++++++++++++++++++++++------
 fs/ecryptfs/messaging.c       | 11 ++++++++++-
 fs/ecryptfs/miscdev.c         |  5 +++--
 fs/ecryptfs/mmap.c            | 30 +++++------------------------
 fs/ecryptfs/super.c           |  7 +++++++
 7 files changed, 73 insertions(+), 42 deletions(-)
