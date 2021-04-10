From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 2/3] ecryptfs: use private mount in path
Date: Sat, 10 Apr 2021 00:31:02 +0000
Message-ID: <YHDxxunCKNuV34Oz@zeniv-ca.linux.org.uk>
References: <20210409162422.1326565-1-brauner@kernel.org>
 <20210409162422.1326565-3-brauner@kernel.org>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20210409162422.1326565-3-brauner@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christian Brauner <brauner@kernel.org>
Cc: Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, Christian Brauner <christian.brauner@ubuntu.com>, Miklos Szeredi <miklos@szeredi.hu>

On Fri, Apr 09, 2021 at 06:24:21PM +0200, Christian Brauner wrote:

> Reading through the codebase of ecryptfs it currently takes path->mnt
> and then retrieves that path whenever it needs to perform operations in
> the underlying filesystem. Simply drop the old path->mnt once we've
> created a private mount and place the new private mnt into path->mnt.
> This should be all that is needed to make this work since ecryptfs uses
> the same lower path's vfsmount to construct the paths it uses to operate
> on the underlying filesystem.

> +	mnt = clone_private_mount(&path);

Incidentally, why is that thing anything other than a trivial wrapper
for mnt_clone_internal() (if that - I'm not convinced that the check of
unbindable is the right thing to do here).  Miklos?
