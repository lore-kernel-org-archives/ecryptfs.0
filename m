From: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 11/13] ubifs: Tell the VFS that readpage was synchronous
Date: Thu, 17 Sep 2020 22:46:52 +0200 (CEST)
Message-ID: <482280458.101023.1600375612958.JavaMail.zimbra@nod.at>
References: <20200917151050.5363-1-willy@infradead.org> <20200917151050.5363-12-willy@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200917151050.5363-12-willy@infradead.org>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, v9fs-developer@lists.sourceforge.net, linux-kernel <linux-kernel@vger.kernel.org>, linux-afs@lists.infradead.org, ceph-devel <ceph-devel@vger.kernel.org>, linux-cifs@vger.kernel.org, ecryptfs@vger.kernel.org, linux-um <linux-um@lists.infradead.org>, linux-mtd <linux-mtd@lists.infradead.org>

----- Urspr=C3=BCngliche Mail -----
> Von: "Matthew Wilcox" <willy@infradead.org>
> An: "linux-fsdevel" <linux-fsdevel@vger.kernel.org>
> CC: "Matthew Wilcox" <willy@infradead.org>, "linux-mm" <linux-mm@kvack.or=
g>, v9fs-developer@lists.sourceforge.net,
> "linux-kernel" <linux-kernel@vger.kernel.org>, linux-afs@lists.infradead.=
org, "ceph-devel"
> <ceph-devel@vger.kernel.org>, linux-cifs@vger.kernel.org, ecryptfs@vger.k=
ernel.org, "linux-um"
> <linux-um@lists.infradead.org>, "linux-mtd" <linux-mtd@lists.infradead.or=
g>, "richard" <richard@nod.at>
> Gesendet: Donnerstag, 17. September 2020 17:10:48
> Betreff: [PATCH 11/13] ubifs: Tell the VFS that readpage was synchronous

> The ubifs readpage implementation was already synchronous, so use
> AOP_UPDATED_PAGE to avoid cycling the page lock.
>=20
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
> fs/ubifs/file.c | 16 ++++++++++------
> 1 file changed, 10 insertions(+), 6 deletions(-)

For ubifs, jffs2 and hostfs:

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
