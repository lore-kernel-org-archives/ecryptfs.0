From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 00/44] Manually convert filesystem FS documents to ReST
Date: Mon, 17 Feb 2020 20:01:46 -0800
Message-ID: <20200218040146.GM7778@bombadil.infradead.org>
References: <cover.1581955849.git.mchehab+huawei@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <cover.1581955849.git.mchehab+huawei@kernel.org>
List-Id: <ecryptfs.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=m.gmane-mx.org@lists.infradead.org
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Latchesar Ionkov <lucho@ionkov.net>, Martin Brandenburg <martin@omnibond.com>, Jan Kara <jack@suse.cz>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Dominique Martinet <asmadeus@codewreck.org>, Amir Goldstein <amir73il@gmail.com>, Bob Copeland <me@bobcopeland.com>, David Howells <dhowells@redhat.com>, Chris Mason <clm@fb.com>, linux-mtd@lists.infradead.org, Ilya Dryomov <idryomov@gmail.com>, linux-afs@lists.infradead.org, Mike Marshall <hubcap@omnibond.com>, Naohiro Aota <naohiro.aota@wdc.com>, Christoph Hellwig <hch@infradead.org>, linux-nilfs@vger.kernel.org, Andreas Gruenbacher <agruenba@redhat.com>, Sage Weil <sage@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Richard Weinberger <richard@nod.at>, Tyler Hicks <code@tyhicks.com>, cluster-devel@redhat.com, v9fs-developer@lists.sourceforge.net, Gao Xiang <xiang@kernel.org>, linux-ext4@vger.kernel.org, Salah

On Mon, Feb 17, 2020 at 05:11:46PM +0100, Mauro Carvalho Chehab wrote:
> There are lots of plain text documents under Documentation/filesystems.
> 
> Manually convert several of those to ReST and add them to the index file.

I think at least 90% of this material needs to be in admin-guide.  Should
we create Documentation/admin-guide/filesystems/ and move most of these
files there?

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
