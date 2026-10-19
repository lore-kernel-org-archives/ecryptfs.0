Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792448925;
	b=CcsB9MWckNCS0meHCBTEZ84H76TC99qB5UiG6A23Nmf9x8Kxs9zNM8Xyp17AFKBpWOqA
	 R1XgdtBRxP5+ahDk7Oxp/0FXuQSAKLhhFw/lnFVVagRfVz9NGlbJnRbX+M/XNBSO/+K0t
	 tjpFJoTijPSoTVz+AReQBZMLJf9zVsxFBiQdM7yQfbUazHIX7+RJzCU0btgVsNFNI65S0
	 e2wDwGTmLQkrzY91cB/AWcJM4r5lUKVnI5o5UeVGzXBjXsGzaxxYsGqKqERjjeNNT/Yy2
	 bCxykTe5IsCk6ZFZWBIrb+7pXS0J/vkHRp4xr8KZXo/0VRApQwwIW2qwqzikpuYtxAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792448925;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=OX7LJ5SbmTWyL1O7a6NbJLx6qKjyWvZdlldA1ZYQwo4=;
	b=2IlIKamTigpAxuMorLq8szT4rDTYvQZeMTXcI5iYrUTeLGvBTtSLiJ0f4SkbZpGkjZyw
	 pIQoMmb1Bm4Ibu9u2w52t3CBl2GIfI0IBxCmMSGYv3iRCDdtyxZ2+Vd+H8g6ZRlVyAE+H
	 gkDPYhwCOEr2fag10EfIaI86tsUU+ddhHQ3h0wAxGPGwofpgQmlz2VyccwymtEOPTPcBc
	 1td9FOrXWJ2siDmlv8Eo5ae/Tya7ZgWfZ4zoKwN1rUxZtp3I2TjefNlwwpSar/GW2ssC9
	 hvc/PILjPYMpDsxfJsAV12VX+SQxQgmZQFojnNBmRXt5wrO9+X//0wUSeu5zjpv3Xng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tyhicks.com;
	spf=pass smtp.mailfrom=tyhicks.com;
	dkim=pass header.d=tyhicks.com header.i=@tyhicks.com header.a=rsa-sha256 header.s=fm1 header.b=VNtgrOoa;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ACxxFw4C;
	arc=none smtp.remote-ip=202.12.124.155
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845DC606A31A
	for <ecryptfs@vger.kernel.org>; Mon, 19 Oct 2026 22:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 845DC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tyhicks.com header.i=@tyhicks.com header.a=rsa-sha256 header.s=fm1 header.b=VNtgrOoa;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ACxxFw4C
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D74797A01F7
	for <ecryptfs@vger.kernel.org>; Mon, 19 Oct 2026 18:28:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 19 Oct 2026 18:28:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792448923; x=1792535323; bh=OX7LJ5SbmT
	WyL1O7a6NbJLx6qKjyWvZdlldA1ZYQwo4=; b=VNtgrOoa3LX00REjt0smYquiir
	zYq4g2ZbeE4Z2BERW/mexPlmrunlZSTO6gU7wbE9PzY5MU8ITMABOjALWkFEslb6
	HXkN3C3FPeJVXpjq7OzCzMpQDtys8JikdmhZ0uotOXdGj+PRlOJXRoiFNPiVo9Bo
	oGpav81RQj41330KUT+Ai4GUBOE/ksmQwEPUfFShD4ZqJFs3KXStHWb0JFR2DGjd
	WAK+zgvJOgKOiqpG13pMAXm7QTGURAaEvFw7rdd5MiLkx0/tUuGDVPfIoqOdgoq/
	uKihKcVgwhlb5gKiP9UKZv4WYDcUQmKQKE15e+4N3Zq3kIgvt3ZYPh3h875Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792448923; x=1792535323; bh=OX7LJ5SbmTWyL1O7a6NbJLx6qKjyWvZdlld
	A1ZYQwo4=; b=ACxxFw4CpVGdHHAj4+NOl+yQoCmrwhA0XebBgbi1mIvaZgmiZj0
	sRYVjIbrAJNGgy6FXPS+t4cWDz110djNFaBYKlfG8xtH2Dqjbt4jTQXBMtv32RP1
	WNX/eCMZKy067fjKxLi43JnguvK8OCmugaxZiBkMZ37qtF0Q0cFQv7AN/ptvRaw1
	DmKPBhJi57t5wf5HfgmvR+3JMIniQITqQQAj1XWrfFJP1ugfvXXS+Ze9pZzqMDc1
	NzX33BJtmlHqbui1SsJCscl0ulfcrgWIxxTVi8v7uNgkNzyZ+T7ESZvhAklciK+Y
	00593g0c7vMIqrhG1J+JSHhPXbhYdI8gcPg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=tyhicks.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792448923; d=tyhicks.com;
	mf=PGNvZGVAdHloaWNrcy5jb20+;
	rt=PGVjcnlwdGZzQHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:ZmmSnwoSEDeXX0ld55/Z4mztAwvU2Kf/a0BmBaczh0awcHe
	KxqMhJBLJViCCgvpWzsIG3xJyXQVtdmcdmwH48Ubs86/aak+5W4DD4bMcDB1FMUg
	4PoJuBmg74CIIe9WxHUNoXiEOpMSqsr1uveeXw+ThKCeMyGP8kofbYutWWpa0786
	rPtuOK+955N1js1nPbUAwfOYmHdgxxaITwuZLm7zHo/ckmFnyoGJWDsWJhrE52AC
	f1FprFnxTGjfmiSeDUVavwX/T0r3tCjgXgQSlGTe0MpcrRDrFadg+2ST/UOwbC7/
	ua9tODNWumVB7+H+hoiFuCLe4vi1qh7k+QxjmBg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:mNwJugYNmHs/kUvTsxHSPPA3sykvPWFuRHjTzNWw7j0=:fV9H7cDxvj1c2HYvsZ1NqPDlLAHxBJgEpg3FzNoE7PQ=;
X-ME-Sender: <xms:m5nWao5VlZA4ZbhugOVnTqhupKwcsU4dhFgLv-8Gyfts_AhdkI0izQ>
    <xme:m5nWaqCC7MeGLw7mEiAM1LKCMJGY9KjJUtcGn9_z7xFCBw5FEClrCCwpuoU-vWU82
    GnLaJO5nxX8ndFrmeT1W9PPJCCv8RinhOYjqJqO1rtKhht6kTLawAgj>
X-ME-Received: <xmr:m5nWavZnYjbOrqTJkJUWiAQYdtZCXAz4qcq3W0bmO6T9EUer2c8u3TT_aA>
X-ME-Proxy-Cause: dmFkZTGx7dumu3T38TPNhvSWlmXCNMMPf6psR3G1gYBNJcURGiJyYYpI6M7c/XXLevz9Fa
    zK8GYwMuXm/L2h2JKGo/fl6Uij3w0Rk5RKYOO6dpBOfj/mF8uOJRNBI5h/kWDAfoVV4yOg
    REOohXCsioEmgGam3lEjPfVZlw9HSozD8v1PQk25T7EFqKRqUUy/aHVGvrAsCwWxQXZaZV
    zk0vcCs7fYkTljl7905vjTXzWLzacKfgS3gvMyhb9B5ml6Q2mYUhzyQufew5adKd+8TJDY
    hCJDC1i+cCKh0NV3VEp8IOikOvxKG+OWGKObHy6W9tMtkihID+Xi1Y6Mpesn1qiZwbQ6Ip
    YSUhXXvCznqhfjhARA1iJxapHSTqq8KK2qMMZYYMaNqSj4KohH/d3/Hy3cpyh/bkPT1F2o
    60JsHDXgyeB5n4h3y4KahGnhgEy0Kh6Lj/a9RT6dc10SiuEIOJlS91OCnqATnYhND0uga6
    z+fSHbNZUIhgsh7yh5wQeiUd/2EWKiiHmE73fsBAMYFyIcvdtZ2Bbxq090XJfSC6Ca4yzy
    Nsis1ThQ71PTr7xlpAmiH41HDJLE987IYYBBOSUEfUcM2oDZPuqRMekam1Gxh6SxS7L2UI
    POWtPI4a50mDA0Rfdi1B2BibjVlY7Sw7yNx86TEnJ/c4M/UW1DxaTmaP2c8A
X-ME-Proxy: <xmx:m5nWalYIRB-_w9RGbPE6muvK5oq50BneXmvibVnbka6cBlslGKyNfw>
    <xmx:m5nWam_epiAl_p3J_pLFzOrvpdcS8ncPhG6nrWUf4Av_81FgiYJKWQ>
    <xmx:m5nWakh9WPy89P5sR8EXsk-TdZLeuvdFVRdkobpySkDFbYOs3zIz6A>
    <xmx:m5nWamc93Y1Sshc7-J_RYHIlqGj-TDhBmR6xXV-EzpFhz8e0ZAxWvg>
    <xmx:m5nWaspsojhRjgWUddtQUIZg9YZsJYB3J_UEcjjj212exjnzGUXzuTKB>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 18:28:42 -0400 (EDT)
Date: Mon, 19 Oct 2026 17:28:30 -0500
From: Tyler Hicks <code@tyhicks.com>
To: Nickolai Zeldovich <nickolai@csail.mit.edu>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] ecryptfs: release the inode when lookup fails to read
 the file size
Message-ID: <ataZjvBo29sDyej3@yaupon>
References: <20261018023840.798718-1-nickolai@csail.mit.edu>
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Post: <mailto:ecryptfs@vger.kernel.org>
List-Help: <mailto:ecryptfs+help@vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ecryptfs+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018023840.798718-1-nickolai@csail.mit.edu>

On 2026-10-17 22:38:39, Nickolai Zeldovich wrote:
> When eCryptfs cannot open the lower file of a regular file during
> lookup, the lookup fails and leaks the eCryptfs inode it got, together
> with that inode's reference on the lower inode.  Every failed lookup
> leaks one more inode, and unmounting reports "VFS: Busy inodes after
> unmount of ecryptfs" (a BUG with CONFIG_BUG_ON_DATA_CORRUPTION).  The
> lower open fails, for example, with -ETXTBSY while the lower file is
> being executed, or when an LSM or the lower file system's ->open()
> refuses it; any user who can look up the name can repeat it.  A
> concurrent lookup that found the new inode before it was unhashed
> waits for I_NEW forever.
> 
> ecryptfs_lookup_interpose() gets the inode from iget5_locked() and,
> for a regular file, reads the plaintext size with
> ecryptfs_i_size_read() before unlocking a new inode.  On failure it
> marks the inode bad and returns, but it neither clears I_NEW nor drops
> the reference it holds.  The error path came with the deferred
> unlock_new_inode() in commit 3b06b3ebf441 ("eCryptfs: Fix new inode
> race condition").
> 
> Unlock a new inode and drop the reference on that path, as
> iget_failed() does for a new inode.
> 
> Tested on x86_64 with a lower file on tmpfs that a process is
> executing: 1000 failed stat() calls left 1000 inodes allocated and the
> unmount warned about busy inodes; with the patch no inode is left and
> the unmount is clean.
> 
> Fixes: 3b06b3ebf441 ("eCryptfs: Fix new inode race condition")
> Assisted-by: LLM
> Signed-off-by: Nickolai Zeldovich <nickolai@csail.mit.edu>

Hello - Thank you for the fix and the level of testing that you
performed. Christian Brauner recently sent out a fix for the same issue.
I've already acked his fix but please take a look to see if you disagree
with anything there. It is slightly different than what you proposed.

 https://lore.kernel.org/ecryptfs/20261012-work-fs-sb_rdonly-v1-1-60743a3dc326@kernel.org/

If you have review feedback on Christian's patch, please reply in that
thread. Thanks!

Tyler

> ---
> 
> Notes:
>     Reproducer (CONFIG_ECRYPT_FS, CONFIG_TMPFS, CONFIG_KEYS; runs as /init
>     in QEMU, root; the key is a dummy auth_tok, nothing gets encrypted):
>     
>       gcc -O2 -static -o init ecryptfs_inew.c   # packed as /init in an initramfs
>       qemu-system-x86_64 -m 1G -nographic -kernel bzImage -initrd initramfs.cpio \
>           -append "console=ttyS0 rdinit=/init"
>     
>     Before:
>       stat: Text file busy
>       inodes left by 1000 failed lookups: 1000
>       VFS: Busy inodes after unmount of ecryptfs (ecryptfs)   (console)
>       unmounted
>     After:
>       stat: Text file busy
>       inodes left by 1000 failed lookups: 0
>       unmounted
>     
>     The same leak was reported on the list as "[BUG] ecryptfs leaks an inode
>     on lookup failure -> kernel BUG in generic_shutdown_super()" (Farhad
>     Alemi, 2026-08-27), with -ETXTBSY from the lower open.
>     
>     /*
>      * Look up a lower file that is being executed through eCryptfs 1000 times,
>      * count the inodes left behind, then unmount.
>      * Runs as /init in QEMU; needs CONFIG_ECRYPT_FS, CONFIG_TMPFS, CONFIG_KEYS.
>      */
>     #include <fcntl.h>
>     #include <linux/keyctl.h>
>     #include <stdio.h>
>     #include <sys/mount.h>
>     #include <sys/reboot.h>
>     #include <sys/stat.h>
>     #include <sys/sendfile.h>
>     #include <sys/syscall.h>
>     #include <unistd.h>
>     
>     static long inodes(void)
>     {
>     	long n = -1;
>     	FILE *f = fopen("/proc/sys/fs/inode-nr", "r");
>     
>     	if (f) {
>     		if (fscanf(f, "%ld", &n) != 1)
>     			n = -1;
>     		fclose(f);
>     	}
>     	return n;
>     }
>     
>     int main(int argc, char **argv)
>     {
>     	static char tok[1024];
>     	int fd, in, i;
>     	long n;
>     	struct stat st;
>     
>     	if (argc > 1) {		/* the copy in the lower directory */
>     		pause();
>     		return 0;
>     	}
>     
>     	mount("proc", "/proc", "proc", 0, NULL);
>     	mkdir("/lower", 0755);
>     	mkdir("/upper", 0755);
>     	mount("tmpfs", "/lower", "tmpfs", 0, NULL);
>     	in = open("/init", O_RDONLY);
>     	fstat(in, &st);
>     	fd = open("/lower/f", O_CREAT | O_WRONLY, 0755);
>     	sendfile(fd, in, NULL, st.st_size);
>     	close(fd);
>     	close(in);
>     	if (!fork()) {
>     		execl("/lower/f", "f", "sleep", NULL);
>     		_exit(1);
>     	}
>     	sleep(1);
>     
>     	tok[0] = 0x04;		/* auth_tok version 0.4, ECRYPTFS_PASSWORD */
>     	if (syscall(SYS_add_key, "user", "0123456789abcdef", tok, sizeof(tok),
>     		    KEY_SPEC_USER_KEYRING) < 0)
>     		perror("add_key");
>     	if (mount("/lower", "/upper", "ecryptfs", 0,
>     		  "ecryptfs_sig=0123456789abcdef,ecryptfs_cipher=aes,ecryptfs_key_bytes=16"))
>     		perror("mount ecryptfs");
>     
>     	n = inodes();
>     	for (i = 0; i < 1000; i++)
>     		if (stat("/upper/f", &st) && i == 0)
>     			printf("stat: %m\n");
>     	printf("inodes left by 1000 failed lookups: %ld\n", inodes() - n);
>     	if (umount("/upper"))
>     		perror("umount");
>     	printf("unmounted\n");
>     	fflush(stdout);
>     	reboot(RB_POWER_OFF);
>     	return 0;
>     }
> 
>  fs/ecryptfs/inode.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index 525297c7ebd8..d7e90192efcf 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -363,6 +363,9 @@ static struct dentry *ecryptfs_lookup_interpose(struct dentry *dentry,
>  		rc = ecryptfs_i_size_read(dentry, inode);
>  		if (rc) {
>  			make_bad_inode(inode);
> +			if (inode_state_read_once(inode) & I_NEW)
> +				unlock_new_inode(inode);
> +			iput(inode);
>  			return ERR_PTR(rc);
>  		}
>  	}
> 
> base-commit: 58161ead29e50d70a317ea26b472e0c7508e69da
> -- 
> 2.53.0
> 
