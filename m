Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793753393;
	b=dhEslp4k5+EtHX0xmC7nj68LYhRNa1Ela+ELQh2gWRX0dJCoOCknfytW5VF8Zti8V/rt
	 8lx068p2Y/tJ9IIAbCU5yqm4TPHVT+u678vVHVy8pt4YqQwNUujn7lnGg+VCMTpLL5J6L
	 lLY2vBoU0OegYdCcfhjuTFkHPMaLUoZN13JLv3J1BGnQSjcb6mSuhVwG70Xrv33lDYNU2
	 gb07sG0WWPZ/EMiF6qRYmu89KO6voOT1GWEmJmkcVcnfFf5eriYgdyQiMfiZZt60bhgs8
	 WnC8x6b/Se/A7il7ftNxPDBe/3ud6snJhmte/RWa9qoEy92ujxVYfY/L9lnqXXT5Juw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793753393;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=/bumM81nPiENiLh9PH/Fm40C+VENRMD3A/OuAfI8Z4s=;
	b=Z4zBQuYju2WDqyjKbSijPVtZ2fr6HdPCgBhhTOzElpGpVlFdUMCkKkFYl5hfuEhF/MzF
	 mQlbTJrJwRsb8x+oRlX75f0Y2yxle6+C5avX5v7QazjVHBE2ruS01IPLHGSgCIcd2CgCR
	 XUBBZc1l46VS1pK8vlfzOQWuh9Iwtnrj1yc8tnWpIim4HRNuvt5Cg8JAPrwXEhZdlI3Av
	 M8IehYBmLmmQoMzSt1utVaFomDhwb22tySHk1ACFhaxCwEWoakI+BvfyJP+klKKray5w4
	 lMKzOWAC3eDYrPc8cmPcALH+zxw2rQBapKwmmW1Yo0P0pvNnD0PMY1bqWCdbIhJJGWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VT+pUP2N;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E536606A332
	for <ecryptfs@vger.kernel.org>; Wed,  4 Nov 2026 00:49:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E536606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VT+pUP2N
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-886e61fa30fso101058b3a.1
        for <ecryptfs@vger.kernel.org>; Tue, 03 Nov 2026 16:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793753391; x=1794358191; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/bumM81nPiENiLh9PH/Fm40C+VENRMD3A/OuAfI8Z4s=;
        b=VT+pUP2NwuZcLnfpE6RBehWP9rj7p+v+tKoR/WVHOzz1v7CJgJGu6gqjY1V/YGEdmw
         igNrVOnPTFLv9xvYK2tnZhcPD4jqAzwLjDlQ2iFsJIT0vgZOsXkUB60qRSrv68Heg2+2
         k5XkKmMrKWtBUKDoGvgF6CjyKJx7mmzehyXgiMW8Z51NtcdDEa4LvP5GkI/GPk/JWdX0
         E0pyc83t8pyqA1wDQ4YMhv4IP3UIHbsnnJtT4+s3TyxuI9ePzpN8dD0BzwPhXNBIUBNN
         GS4KAdHBqzLrJ9upnMsWdUfiG2GuZuR+cDGx90+hJalABWpp8S3bPmquj5j2mZuikn7l
         6bxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793753391; x=1794358191;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/bumM81nPiENiLh9PH/Fm40C+VENRMD3A/OuAfI8Z4s=;
        b=YOw9TDZ/7pmQFaOvFlh1fPz4RDQ5xYra3gBtGjaVSzAvYO4betlzo9MIIyEsQQ6ljH
         CCIeB0/3ju59QkNP4aea8HzRYUg00Mcyh9R2UPyVx4oNh6RqkEk4GN8MfRcmrLHzDq94
         ulnSa0w4YDyn/FEUXwyX4Br6qyryTwofXLOTvZNjcYIqUUrO9ZUQPAItb+PoPJlL9Sp6
         fBcPmz7EXmbQypbzrcvqH9Le6+mLJ8+kmgwTtJj+BgED6EmnJzYgKl5ZUHD7uNzAMOt/
         n3W+Dfpne+jjJcFvWJd+VqU+Tb6/xjSllmb5DPTXDxTYvBE92ghiEYdBUhywgQhnP5aW
         bVKg==
X-Forwarded-Encrypted: i=1; AKwUvByQmFaOvOS0h4DIIRBhLeA1m47cczZsDfcL2wciALlqZhVk3R3Tv0kuAf2ZD0o4go4MivTylqZfSA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8HOBm6OY60nflqtjtVQCPOxRF/XxrmAJk6otT9+PoIvIPtbfo0
	unFlH2d+v00U4B8EjkcThQ4Bizargjx+mYlEOVCStDplNaYoSSprgwc9
X-Gm-Gg: AYBFou0n0vS04FI+BNRm33KoezfvTw++0mE/yeebj+p7pOmJxkw2BhwanNzkXubDr9t
	1UZETMBPfEfus/CteYW11rPzawmQQGaU6ZlemY7p0Rfxn72Jsc24gcuvbN6tghIvL8Vk9yy3Tcl
	tJYPnReRMvexqLNknodcrx906tcAx+AeBTU5OOYKH629McBlUvT9UGM+IJ5Hf9xI+hQZYvlfczp
	zDlrTsx6O20PjTzN+K/RS1KkeLr1R962Ky/dPiZ8yTf3iW0Tj0QzXTsTsa8T9dxc3nL8y4m86bb
	apABQLrwnhaXbaKmiBYVGUn8nE7iH+Ob0qy3bX/+lSHCaDB37cC8IJa8/UI6AYO/lqu9DDx8Zq6
	WqYH23vyb1O6CwST9GUG1yRFDIn0Tl+o1o0CTPj5jq3UPhfTSTyYllW+eL8NHGBYr6BwTsuvv2Z
	4E7vvzdGmbd0MXsMC9dAn0HYCDqeB9RUHJBmNx1nI3I7kIeO9/VH/XEiNbi5tg55+/6GYdSrnJZ
	L5eHf/9auGs1AnA6WJZknA1md5h4uEikxaoob6+6Mrdu/cRyHw3pRP6sb9h1/UkLnb3wMmNLwKg
	3iDRx55XeWiSO8Ih/tMPh3YIvU80YPSKEMxiceE=
X-Received: by 2002:a05:6a20:914b:b0:3e2:9470:5303 with SMTP id adf61e73a8af0-3e928953948mr11828504637.15.1793753391239;
        Tue, 03 Nov 2026 16:49:51 -0800 (PST)
Received: from localhost ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb46440cc7sm329325a12.3.2026.11.03.16.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 16:49:50 -0800 (PST)
Date: Wed, 4 Nov 2026 09:49:48 +0900
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, ecryptfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
	linux-nilfs@vger.kernel.org, exfat@lists.linux.dev,
	linux-mm@kvack.org, ntfs@lists.linux.dev,
	ocfs2-devel@lists.linux.dev, linux-btrfs@vger.kernel.org,
	gfs2@lists.linux.dev, linux-efi@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-xfs@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 17/34] ntfs: don't set SB_RDONLY after filesystem
 errors
Message-ID: <auqBLEvcurRZfGj6@hyunchul-PC02>
References: <20261029-work-fs-sb_rdonly-v2-0-2f44f64f0b66@kernel.org>
 <20261029-work-fs-sb_rdonly-v2-17-2f44f64f0b66@kernel.org>
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Post: <mailto:ecryptfs@vger.kernel.org>
List-Help: <mailto:ecryptfs+help@vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ecryptfs+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261029-work-fs-sb_rdonly-v2-17-2f44f64f0b66@kernel.org>

On Thu, Oct 29, 2026 at 05:07:08PM +0100, Christian Brauner wrote:
> With errors=remount-ro every ntfs_error() ends up in ntfs_handle_error()
> which sets SB_RDONLY without holding s_umount. If that happens while the
> volume is frozen through bdev_freeze() thaw_super() sees a read-only
> superblock and leaves the s_writers rwsems locked so every writer hangs.
> 
> So set NV_Errors and a new NV_EmergencyRO flag instead like ext4 does.
> ntfs_emergency_state() returns EIO after a shutdown and EROFS after an
> error and the write side shutdown checks use it now. fallocate,
> ->set_acl(), FS_IOC_SETFSLABEL, FITRIM and ntfs_mft_record_free() get a
> check as well. Errors while mounting still set SB_RDONLY, nothing can
> freeze the superblock before SB_BORN.
> 
> NV_Errors already refuses a remount to read-write and since
> commit 521978c4f444 ("ntfs: sync the volume dirty bit with the recorded
> error state") the volume stays marked dirty once errors were recorded.
> But the dirty bit may not be on disk yet when the error hits and
> writeback is refused from then on. So a work item writes it right away
> because ntfs_error() can be called with mft records locked, and umount
> lets a pending one run first.
> 
> Unlinked inodes are left to chkdsk in that state. Their mft records are
> freed with direct bios while the index and bitmap updates of the
> deletion can't be written back anymore. And writing to an encrypted file
> only warns now. It called ntfs_error() which let anyone put the volume
> into the emergency state.
> 
> /proc/mounts keeps showing the volume read-write. Writes through file
> descriptors opened before the error fail with EROFS.
> 
> Fixes: 6251f0b0de7d ("ntfs: update super block operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

-- 
Thanks,
Hyunchul
