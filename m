From: Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [PATCH v3 00/17] Xattr inode operation removal
Date: Mon, 30 May 2016 20:22:19 +0200
Message-ID: <CAHc6FU40o3VpzV-oL81NqrYB3Ryt-nCOeEZCfnQSPFZ==cWvDA@mail.gmail.com>
References: <1464598653-3656-1-git-send-email-agruenba@redhat.com>
	<CA+icZUXGxsw-g1W8QzwuFx=8UTnxzQD9UsNEH2PHCGrqW=0xdA@mail.gmail.com>
	<CAHc6FU6gZHEcrqvyKdKJbFVrd0L8=M2ynm2GD6tQx32fzTjD=g@mail.gmail.com>
	<CA+icZUVmB1pSuG1_3-nkiKjoDH9UrvUEsZjy8hS6_+Y2yDyruA@mail.gmail.com>
	<CA+icZUWVdtqK4OcXhjVDbrqfXBO5-DpbB5nVpX+iTN_RBDH5Xw@mail.gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-vk0-f47.google.com ([209.85.213.47]:35001 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161330AbcE3SWU (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 30 May 2016 14:22:20 -0400
Received: by mail-vk0-f47.google.com with SMTP id d127so70894163vkh.2
        for <ecryptfs@vger.kernel.org>; Mon, 30 May 2016 11:22:20 -0700 (PDT)
In-Reply-To: <CA+icZUWVdtqK4OcXhjVDbrqfXBO5-DpbB5nVpX+iTN_RBDH5Xw@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sedat.dilek@gmail.com
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Tyler Hicks <tyhicks@canonical.com>, ecryptfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, Mimi Zohar <zohar@linux.vnet.ibm.com>, linux-ima-devel@lists.sourceforge.net, LSM <linux-security-module@vger.kernel.org>, David Howells <dhowells@redhat.com>, Serge Hallyn <serge.hallyn@canonical.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>, Casey Schaufler <casey@schaufler-ca.com>, Oleg Drokin <oleg.drokin@intel.com>, Andreas Dilger <andreas.dilger@intel.com>

On Mon, May 30, 2016 at 6:02 PM, Sedat Dilek <sedat.dilek@gmail.com> wrote:
> I contacted the LTP mailing-list on the acl_test01 issues - WIP.
>
> From the LTP-ML I got the impulse to test with the xattr testcase...
>
> root# cd /opt/ltp ; LC_ALL=C ./runltp -s xattr | tee xattr.log
>
> ...this fails only in the cgroup_xattr testcase.
> [...]

The test seems to try getting/setting an xattr named "trusted." (no
suffix). That's an invalid name; such invalid names are rejected since
commit 98e9cb571 "vfs: Distinguish between full xattr names and proper
prefixes" (v4.5-rc1).

Could you try removing that from the LTP test and rerun it?

Thanks,
Andreas
