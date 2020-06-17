From: Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: Umask ignored when mounting NFSv4.2 share of an exported
 Filesystem with noacl (was: Re: Bug#962254: NFS(v4) broken at 4.19.118-2)
Date: Wed, 17 Jun 2020 18:50:04 +0200
Message-ID: <CAHc6FU5-WGL8OwELQvpu8CsQgqW5o2h92UG3d2E3RUTPnBPgog@mail.gmail.com>
References: <20200605183631.GA1720057@eldamar.local> <20200611223711.GA37917@mattapan.m5p.com>
 <20200613125431.GA349352@eldamar.local> <20200613184527.GA54221@mattapan.m5p.com>
 <20200615145035.GA214986@pick.fieldses.org> <20200615185311.GA702681@eldamar.local>
 <20200616023820.GB214986@pick.fieldses.org> <20200616024212.GC214986@pick.fieldses.org>
 <20200616161658.GA17251@lorien.valinor.li> <20200617144256.1028414-1-agruenba@redhat.com>
 <20200617153107.GL266716@pick.fieldses.org>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51939 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726815AbgFQQuU (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Wed, 17 Jun 2020 12:50:20 -0400
Received: by mail-ot1-f71.google.com with SMTP id t3so1286785otc.12
        for <ecryptfs@vger.kernel.org>; Wed, 17 Jun 2020 09:50:16 -0700 (PDT)
In-Reply-To: <20200617153107.GL266716@pick.fieldses.org>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "J. Bruce Fields" <bfields@redhat.com>
Cc: ecryptfs@vger.kernel.org, Salvatore Bonaccorso <carnil@debian.org>, Elliott Mitchell <ehem+debian@m5p.com>, 962254@bugs.debian.org, Linux NFS Mailing List <linux-nfs@vger.kernel.org>, Miklos Szeredi <mszeredi@redhat.com>

On Wed, Jun 17, 2020 at 5:31 PM J. Bruce Fields <bfields@redhat.com> wrote:
>
> On Wed, Jun 17, 2020 at 04:42:56PM +0200, Andreas Gruenbacher wrote:
> > Hi Bruce,
> >
> > On Wed, Jun 17, 2020 at 2:58 AM J. Bruce Fields <bfields@redhat.com> wrote:
> > > I think I'll send the following upstream.
> >
> > looking good, but how about using a little helper for this?
>
> I like it.  And the new comment's helpful too.
>
> >
> > Also I'm not sure if ecryptfs gets this right, so taking the ecryptfs
> > list into the CC.
>
> Yes, questions I had while doing this:
>
>         - cachefiles, ecrypfs, devtmpfs, and unix_mknod skip the check,
>           is that OK for all of them?  (Overlayfs too, I think?--that
>           code's harder to follow.
>
>         - why don't vfs_{create,mknod,mkdir} do the IS_POSIXACL check
>           themselves?  Even if it's unnecessary for some callers, surely
>           it wouldn't be wrong?

That's a good question. The security_path_{mkdir,mknod} hooks would
then probably be passed the original create mode before applying the
umask, but at that point it's not clear what the new inode's final
mode will be, anyway.

> I also wondered why both vfs_{create,mknod,mkdir} and the callers were
> calling security hooks, but now I see that the callers are calling
> security_path_* hooks and the vfs_ functions are calling
> security_inode_* hooks, so I guess they're not redundant.
>
> Though now I wonder why some of the callers (nfsd, overlayfs) are
> skipping the security_path_* hooks.

The path based security hooks are only used by apparmor and tomoyo.
Those hooks basically control who (which process) can do what where in
the filesystem, but nfsd isn't aware of the "who", and overlayfs is a
layer below the "where".

Andreas

