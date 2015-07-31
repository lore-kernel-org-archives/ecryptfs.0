From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 12/15] fs: Drop unlikely before IS_ERR(_OR_NULL)
Date: Fri, 31 Jul 2015 10:20:56 +0100
Message-ID: <396.1438334456@warthog.procyon.org.uk>
References: <4fd8dd8ed76901a89d6cd17e50ac585ea929f1fb.1438331416.git.viresh.kumar@linaro.org> <cover.1438331416.git.viresh.kumar@linaro.org> <cover.1438331416.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <4fd8dd8ed76901a89d6cd17e50ac585ea929f1fb.1438331416.git.viresh.kumar@linaro.org>
Content-ID: <395.1438334456.1@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Transfer-Encoding: 7bit
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: dhowells@redhat.com, akpm@linux-foundation.org, linaro-kernel@lists.linaro.org, linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, Andreas Dilger <adilger.kernel@dilger.ca>, Anna Schumaker <anna.schumaker@netapp.com>, Boaz Harrosh <ooo@electrozaur.com>, Christoph Hellwig <hch@lst.de>, "open list:ECRYPT FILE SYSTEM" <ecryptfs@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Fabian Frederick <fabf@skynet.be>, Joe Perches <joe@perches.com>, "open list:COMMON INTERNET FILE SYSTEM
	CIFS" <linux-cifs@vger.kernel.org>, "open list:EXT4 FILE SYSTEM" <linux-ext4@vger.kernel.org>, "open list:FILESYSTEMS VFS and
	infrastructure" <linux-fsdevel@vger.kernel.org>, "open list:NFS, SUNRPC, AND LOCKD CLIENTS" <linux-nfs@vger.kernel.org>, Peng Tao <tao.peng@primarydata.com>, Petr Vandrovec <petr@vandrovec.name>, moderated lis <samba-technical@lists.samba.org>

Viresh Kumar <viresh.kumar@linaro.org> wrote:

> IS_ERR(_OR_NULL) already contain an 'unlikely' compiler flag and there
> is no need to do that again from its callers. Drop it.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: David Howells <dhowells@redhat.com>
