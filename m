Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB4228B4FD
	for <ecryptfs@vger.kernel.org>; Fri, 16 Oct 2026 00:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792110738; cv=pass; b=nTiT6K/WV1ziFKQignuirCBWiJoAl9Om6rFLBf8BdF34bJxv+oiXp/EkhrM7G172vDPeFxHeU/tpFmMzDHC8wtqyph8GwnT7ovVwzben4Vr6HzoofMhVpahFTOM9mh/4S78KBHfAhfDExrEbptTQobv6m3oBUc9zmUkLQveFci0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792110738; c=relaxed/simple;
	bh=HxZt08dVRw4ejTWE+FGXV5r0nmHjM+0lQhVW4+dpeTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pUvj4PBuBjwDMQpIoywm9+JZLd9VH4uJmTS9xguFuSq+5/aMj1pt52uXvm3K8WL09Qcy8vbEu2Cny57dobYONGC26SJ5RyKWVg14HAbgGmAUqyIxjaIOjbMDGVW+wtnjSQo9WKNvJ1cwl185ebdp2jmZm4IMpua7gMwPWTmATEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OMi03vrw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=a6aGHoVG; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OMi03vrw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="a6aGHoVG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792110735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2PpmzonvJ+GFyXX1ccvr8BDAPumMVPYHB7D08eoJkdk=;
	b=OMi03vrwiksem2U41TCFBpUAaYtOZu+lGZOzQNCPnbZbJzhol7uqK7YGClwnyJrFYP7ZvB
	XuiMXVbpxX9CP5a1piIHy0xC5qZ6xdSYcBrXoms3/U4sR8cR+kr8KrpKQcTPzttb0PiRWY
	wj4ZU8y3W/z/IQVJFmLs9cARieZ3mzo=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-H6loIRmoN9SRBDongk8uiQ-1; Fri, 16 Oct 2026 00:32:14 +0000
X-MC-Unique: H6loIRmoN9SRBDongk8uiQ-1
X-Mimecast-MFC-AGG-ID: H6loIRmoN9SRBDongk8uiQ_1792110733
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-677d10671b7so7501813d50.1
        for <ecryptfs@vger.kernel.org>; Thu, 15 Oct 2026 17:32:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792110733; cv=none;
        d=google.com; s=arc-20260327;
        b=GcBkVcwbKTH7BtpoROVSfoFoqvu/4n/ogR/uUU81ykGVGtJfSidnq3uVuQV63cCR4D
         Rg/pENnU9OKtr1SUtlgDJYJOb9PdOQmOxaBsxvraEbshBQHwcahP4itTt8YQow2pIbvx
         wpGKlaveSTp0olpM2pEU/wjG2vibp9FXTlzy8MyLU7AiCECLX1AOXwuvkCWCBBbXnino
         YKvErT+bQ1BHRCPqn+WAfbl0Je5xdrCCFLkHgrMxnKs5XEIVWymDHOnem/IBaLrQKdnR
         cnMkxruwkQRKgxsODM8hz567bhDFu4Hab+Yi74AualP13/cFf2+FMNLQgc7rBg6Jywul
         XtDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2PpmzonvJ+GFyXX1ccvr8BDAPumMVPYHB7D08eoJkdk=;
        fh=2AjIcnEZnWyWO0fTXECrRyYx2lkSLYlrzaFEfa93Z7s=;
        b=fHBomKvsPJJgf/8IXVAwV5g8fb24tmQ3YrnCypPbDJa1jz3nLp3UM44BGPpgx6BSeR
         7qRuV2L1wOLKXluc0xGpRDUanoPySM/szHx8vvvWw8o1mi/WQH9S4kG59ZKUScdCKFJs
         W3D7dGtKMJnLvTpEDUHH0wDn29OkCOj2kPZs17aMNCBjecffniUAvaawDoknYdDF1jea
         66J0+X8+O01Dn23VBzzJnn80efHyh0mWY+/wIDcFPMqAqQc9+kfNnSdv7xYfEQbuDavi
         oaKOv8hyvSXPKH0pjuiNGTxEIFpUuGxKY1HRNIJHV9E7V3+AArfdH1ffSoKZp2ca6jNP
         t8dQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792110733; x=1792715533; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2PpmzonvJ+GFyXX1ccvr8BDAPumMVPYHB7D08eoJkdk=;
        b=a6aGHoVGIYOsFz/XfTl3ih7pJmkn7G8MvkQUgyC4pbFnoTXyQ6IKAieAD7L6p8cEPh
         T4VNJw5qBoecq3yoztukTVDgAN9R39xL49fo+67cgW69kYZYhWo+3cOPctZXqJ+bCSIY
         OYsaCsgHoXKRMQoVyKK8XqyKa49ZZEHamA6EuLTMlcfek1jiFFeHjOAfARX9Pg7T3HXL
         x3twPA2xlFo6q2czC6mUxMNHqigersgPvgokjs96lJd9xnh1AKtqqcKSb7G1szhrPyeR
         x/81KEOTrA7F73dkAWtRYvAPmB80S/QXlQHT6GbmWbsj8txovb21kc93//owNdVWf23Q
         DHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792110733; x=1792715533;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2PpmzonvJ+GFyXX1ccvr8BDAPumMVPYHB7D08eoJkdk=;
        b=B7dfGWuRwuvTtVDSrR89PtpfjTO5FhXVoxFeDeBa74Ku1Rvolq/5/U2AxrwDz5VaI2
         /5MMdDC8mp7USCeCmIha19jYXTQzI9cRdNPgJ68LT9BBfsuAPwKA4qTPkAG2wmzof8K3
         1cFyDxtqCNgHclC+qTkH8L0UnLUoyAinSYQ3VAyox9A/LRcysl94uHIXtDx4m13rDQYQ
         detjKo3F0rx0CcSVJ/iu8IO6KU8jzPYkK6P+xEeFfCBxJwJya717vxjr6aaOej6n6xqT
         u3ckb7vsAKeM4+sOMEcQwQRnjkklh2H4QpehBr4cj60dZ/Lji9QxYFmMqlJkJvkglk4c
         y9Ig==
X-Forwarded-Encrypted: i=1; AKwUvBxIuEIo8JeNq1DI2BZR5xPI8tW7UFjkyNsJju7UaT2B1Nb1l6Q4VMlwX7wMY/xF5p5JbgYtGN0EHg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKqEoTZb4nkXQh3xjmmOXQ8rF161qJsNFT9kEBdQX3lzQQDtQtr
	CQsOybDUMsZ0eWfodwlHcgwa0wiFiPlOgSnTksvRdQtQVQFG5QOkvf0sISPtAnEgHCFI++d5oR2
	nqEyqmvWKgrw/dOY3amGD1MQdm8YVAWN03soszPcIiD+H8Nc9MzhvI32tGmujxG+p5LxlYT/wwQ
	sJENP5mazkgBdr3SZ4q0nK85UN1nDjqPjVxyk=
X-Gm-Gg: AYBFou08DJg5cWQfmlOehRzr26IpoPveOQzTJwI+jlt/3os7ehRzFk9IfgMuqzmMU4C
	imVBupNVuDPuAkHjKYUP4cwx2mzkeOxiRVVmcQvrOiNjX1O4iqXnKXFR39ZTiF/PF6gF8imHsgJ
	YCHbWe+RPcnFkGM7BSmKGAwi7oG/3kGF4a3BKpJ1lE4Sr287U7A/MYOKYHqGD8F2VeMWPr3WpCw
	9avsiBdbnnPA4Px2xWZkdqO2FYQ+fL8QNI3zMi+WfnD8Q==
X-Received: by 2002:a05:690e:12cf:b0:677:c92e:eee4 with SMTP id 956f58d0204a3-67936ac0905mr8161303d50.86.1792110733223;
        Thu, 15 Oct 2026 17:32:13 -0700 (PDT)
X-Received: by 2002:a05:690e:12cf:b0:677:c92e:eee4 with SMTP id
 956f58d0204a3-67936ac0905mr8161290d50.86.1792110732554; Thu, 15 Oct 2026
 17:32:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012-work-fs-sb_rdonly-v1-0-60743a3dc326@kernel.org> <20261012-work-fs-sb_rdonly-v1-20-60743a3dc326@kernel.org>
In-Reply-To: <20261012-work-fs-sb_rdonly-v1-20-60743a3dc326@kernel.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 16 Oct 2026 02:32:01 +0200
X-Gm-Features: AclHuK8NmKT3H02cx2l9pkluaZaWRnSiR4jZEUSx8b1tH5UXdD0FGyrgWytahmA
Message-ID: <CAHc6FU5bdAjABRm=bnH68b2f66TZTDZ8sPdatLB2fS7-55U=yw@mail.gmail.com>
Subject: Re: [PATCH RFC 20/28] gfs2: wait for a pending withdraw before
 remounting read-only
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

Christian,

On Mon, Oct 12, 2026 at 1:27=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> Since commit 9c4a3de6cd5b ("gfs2: Asynchronous withdraw") most of a
> withdraw happens in do_withdraw() from a work item and SDF_JOURNAL_LIVE
> stays set until it ran. A remount to read-only in that window goes
> through gfs2_make_fs_ro(). Its log flushes bail out early on the
> withdrawn filesystem before FLUSH_SHUTDOWN can clear SDF_JOURNAL_LIVE
> and then gfs2_quota_cleanup() hits its BUG_ON():
>
>   kernel BUG at fs/gfs2/quota.c:1532!
>   RIP: 0010:gfs2_quota_cleanup+0x562/0x6b0
>    gfs2_make_fs_ro+0xf3/0x2e0
>    gfs2_reconfigure+0x42e/0xfd0
>    reconfigure_super+0x437/0xb20
>
> Just flushing the withdraw work before the remount isn't enough.
> gfs2_withdraw() sets SDF_WITHDRAWN, calls dump_stack() and only then
> queues the work. So a remount can see a withdrawn filesystem while
> there's nothing to flush yet. And a withdraw can also start in the
> middle of gfs2_make_fs_ro().
>
> So let do_withdraw() wake up waiters when it clears SDF_JOURNAL_LIVE and
> let gfs2_make_fs_ro() wait for the bit after its log flushes, right
> before gfs2_quota_cleanup(). On a healthy filesystem the shutdown flush
> already cleared it. umount doesn't need to wait. gfs2_put_super() sets
> SDF_NORECOVERY first and gfs2_quota_cleanup() only BUGs without it. Once
> the bit is clear the journal isn't live anymore and gfs2_make_fs_ro()
> doesn't write anything.
>
> gfs2_make_fs_rw() can leave the bit set on a withdrawn filesystem as
> well. It checks for a withdraw and then sets SDF_JOURNAL_LIVE. If
> do_withdraw() runs in between it finds the journal not live yet and
> returns. Nothing clears the bit then and the next remount to read-only
> waits for it forever. So check for the withdraw and set the bit under
> sd_log_flush_lock, which do_withdraw() holds while it tests the bit.
> Then either the remount sees the withdraw or do_withdraw() sees the live
> journal.
>
> Reproducer, lock_nolock: a SCHED_FIFO task writes 1 to the withdraw
> sysfs knob from cpu 1 and keeps cpu 1 busy (RT throttling and cpu 1's
> fair server disabled) so do_withdraw() can't run, then from cpu 2:
>
>   mount -o remount,ro /mnt
>
> On lock_dlm the window lasts as long as the withdraw helper runs. The
> window before the work is queued can be widened with a kprobe on
> dump_stack_lvl() that delays the task writing to the withdraw knob by a
> few seconds. A remount to read-only or sysrq u in that window hits the
> same BUG_ON().
>
> Fixes: 9c4a3de6cd5b ("gfs2: Asynchronous withdraw")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/gfs2/super.c | 22 ++++++++++++++++++----
>  fs/gfs2/util.c  |  2 +-
>  2 files changed, 19 insertions(+), 5 deletions(-)
>
> diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
> index 06302c29340f..1d7b39354d65 100644
> --- a/fs/gfs2/super.c
> +++ b/fs/gfs2/super.c
> @@ -147,12 +147,23 @@ int gfs2_make_fs_rw(struct gfs2_sbd *sdp)
>         }
>
>         error =3D gfs2_quota_init(sdp);
> -       if (!error && gfs2_withdrawn(sdp)) {
> -               gfs2_quota_cleanup(sdp);
> +       if (error)
> +               return error;
> +
> +       /*
> +        * do_withdraw() only takes a live journal down. Check for a with=
draw
> +        * under the lock it holds for that so that either we see the wit=
hdraw
> +        * or it sees the journal live. Otherwise gfs2_make_fs_ro() waits=
 for
> +        * the bit forever.
> +        */
> +       down_write(&sdp->sd_log_flush_lock);
> +       if (gfs2_withdrawn(sdp))
>                 error =3D -EIO;
> -       }
> -       if (!error)
> +       else
>                 set_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags);
> +       up_write(&sdp->sd_log_flush_lock);
> +       if (error)
> +               gfs2_quota_cleanup(sdp);
>         return error;
>  }
>
> @@ -565,6 +576,9 @@ void gfs2_make_fs_ro(struct gfs2_sbd *sdp)
>                                    HZ * 5);
>                 gfs2_assert_warn(sdp, gfs2_log_is_empty(sdp));
>         }
> +       /* A withdraw that do_withdraw() didn't finish yet leaves it live=
. */
> +       if (!test_bit(SDF_NORECOVERY, &sdp->sd_flags))
> +               wait_on_bit(&sdp->sd_flags, SDF_JOURNAL_LIVE, TASK_UNINTE=
RRUPTIBLE);
>         gfs2_quota_cleanup(sdp);
>  }
>
> diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
> index 83b8bb6446e5..1535ce2b7aa8 100644
> --- a/fs/gfs2/util.c
> +++ b/fs/gfs2/util.c
> @@ -122,7 +122,7 @@ static void do_withdraw(struct gfs2_sbd *sdp)
>                 up_write(&sdp->sd_log_flush_lock);
>                 return;
>         }
> -       clear_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags);
> +       clear_and_wake_up_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags);
>         gfs2_ail_drain(sdp); /* frees all transactions */
>         up_write(&sdp->sd_log_flush_lock);
>
>
> --
> 2.53.0
>

this looks good all around, thank you very much. Can I add it to my gfs2 qu=
eue?

Thanks,
Andreas

