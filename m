Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE0231C567;
	Sun, 18 Oct 2026 02:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.30.2.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792291123; cv=none; b=AemRoi5Ci3HLyH/4DTlUmjMsTfKlRtaHDDDSuWq5Nqg2p1vR9lbBPHqFvSCHbK5AxMnVxcSGvz50PDBICXfSqg0e51QrMhpRIZtRMhoiJ14ltXmiEBzctRBk6o/a+UPR3+Bw46xmyGxbRpc3w8E0DS0kSmWefayG2cDoEqS+/zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792291123; c=relaxed/simple;
	bh=jTwpTmodEtB6gZq42D20BcrlywreEvYTF8Fo9a702qc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QCerAK9GwOkxW0wfTLcw3OJOv6Uv2d2pyGTRF+BagRSuxoBy6Ev9YddAedJ96iEKD6MJoUXjCRhCXDOmc+4kQsPaK6U+1xUSfqMVV3RKhj9zXzIewK6O1vcOKU5wQ2Cxy2+lZEC9RLXdRJfsTTl9IujU0I45Jde27kiN9Es4XzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu; spf=pass smtp.mailfrom=csail.mit.edu; arc=none smtp.client-ip=128.30.2.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
Received: from escalante.csail.mit.edu ([128.52.128.198])
	by outgoing2021.csail.mit.edu with esmtp (Exim 4.95)
	(envelope-from <nickolai@csail.mit.edu>)
	id 1xIGnI-004O83-6S;
	Sat, 17 Oct 2026 22:38:40 -0400
From: Nickolai Zeldovich <nickolai@csail.mit.edu>
To: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nickolai Zeldovich <nickolai@csail.mit.edu>
Subject: [PATCH v1] ecryptfs: release the inode when lookup fails to read the file size
Date: Sat, 17 Oct 2026 22:38:39 -0400
Message-ID: <20261018023840.798718-1-nickolai@csail.mit.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When eCryptfs cannot open the lower file of a regular file during
lookup, the lookup fails and leaks the eCryptfs inode it got, together
with that inode's reference on the lower inode.  Every failed lookup
leaks one more inode, and unmounting reports "VFS: Busy inodes after
unmount of ecryptfs" (a BUG with CONFIG_BUG_ON_DATA_CORRUPTION).  The
lower open fails, for example, with -ETXTBSY while the lower file is
being executed, or when an LSM or the lower file system's ->open()
refuses it; any user who can look up the name can repeat it.  A
concurrent lookup that found the new inode before it was unhashed
waits for I_NEW forever.

ecryptfs_lookup_interpose() gets the inode from iget5_locked() and,
for a regular file, reads the plaintext size with
ecryptfs_i_size_read() before unlocking a new inode.  On failure it
marks the inode bad and returns, but it neither clears I_NEW nor drops
the reference it holds.  The error path came with the deferred
unlock_new_inode() in commit 3b06b3ebf441 ("eCryptfs: Fix new inode
race condition").

Unlock a new inode and drop the reference on that path, as
iget_failed() does for a new inode.

Tested on x86_64 with a lower file on tmpfs that a process is
executing: 1000 failed stat() calls left 1000 inodes allocated and the
unmount warned about busy inodes; with the patch no inode is left and
the unmount is clean.

Fixes: 3b06b3ebf441 ("eCryptfs: Fix new inode race condition")
Assisted-by: LLM
Signed-off-by: Nickolai Zeldovich <nickolai@csail.mit.edu>
---

Notes:
    Reproducer (CONFIG_ECRYPT_FS, CONFIG_TMPFS, CONFIG_KEYS; runs as /init
    in QEMU, root; the key is a dummy auth_tok, nothing gets encrypted):
    
      gcc -O2 -static -o init ecryptfs_inew.c   # packed as /init in an initramfs
      qemu-system-x86_64 -m 1G -nographic -kernel bzImage -initrd initramfs.cpio \
          -append "console=ttyS0 rdinit=/init"
    
    Before:
      stat: Text file busy
      inodes left by 1000 failed lookups: 1000
      VFS: Busy inodes after unmount of ecryptfs (ecryptfs)   (console)
      unmounted
    After:
      stat: Text file busy
      inodes left by 1000 failed lookups: 0
      unmounted
    
    The same leak was reported on the list as "[BUG] ecryptfs leaks an inode
    on lookup failure -> kernel BUG in generic_shutdown_super()" (Farhad
    Alemi, 2026-08-27), with -ETXTBSY from the lower open.
    
    /*
     * Look up a lower file that is being executed through eCryptfs 1000 times,
     * count the inodes left behind, then unmount.
     * Runs as /init in QEMU; needs CONFIG_ECRYPT_FS, CONFIG_TMPFS, CONFIG_KEYS.
     */
    #include <fcntl.h>
    #include <linux/keyctl.h>
    #include <stdio.h>
    #include <sys/mount.h>
    #include <sys/reboot.h>
    #include <sys/stat.h>
    #include <sys/sendfile.h>
    #include <sys/syscall.h>
    #include <unistd.h>
    
    static long inodes(void)
    {
    	long n = -1;
    	FILE *f = fopen("/proc/sys/fs/inode-nr", "r");
    
    	if (f) {
    		if (fscanf(f, "%ld", &n) != 1)
    			n = -1;
    		fclose(f);
    	}
    	return n;
    }
    
    int main(int argc, char **argv)
    {
    	static char tok[1024];
    	int fd, in, i;
    	long n;
    	struct stat st;
    
    	if (argc > 1) {		/* the copy in the lower directory */
    		pause();
    		return 0;
    	}
    
    	mount("proc", "/proc", "proc", 0, NULL);
    	mkdir("/lower", 0755);
    	mkdir("/upper", 0755);
    	mount("tmpfs", "/lower", "tmpfs", 0, NULL);
    	in = open("/init", O_RDONLY);
    	fstat(in, &st);
    	fd = open("/lower/f", O_CREAT | O_WRONLY, 0755);
    	sendfile(fd, in, NULL, st.st_size);
    	close(fd);
    	close(in);
    	if (!fork()) {
    		execl("/lower/f", "f", "sleep", NULL);
    		_exit(1);
    	}
    	sleep(1);
    
    	tok[0] = 0x04;		/* auth_tok version 0.4, ECRYPTFS_PASSWORD */
    	if (syscall(SYS_add_key, "user", "0123456789abcdef", tok, sizeof(tok),
    		    KEY_SPEC_USER_KEYRING) < 0)
    		perror("add_key");
    	if (mount("/lower", "/upper", "ecryptfs", 0,
    		  "ecryptfs_sig=0123456789abcdef,ecryptfs_cipher=aes,ecryptfs_key_bytes=16"))
    		perror("mount ecryptfs");
    
    	n = inodes();
    	for (i = 0; i < 1000; i++)
    		if (stat("/upper/f", &st) && i == 0)
    			printf("stat: %m\n");
    	printf("inodes left by 1000 failed lookups: %ld\n", inodes() - n);
    	if (umount("/upper"))
    		perror("umount");
    	printf("unmounted\n");
    	fflush(stdout);
    	reboot(RB_POWER_OFF);
    	return 0;
    }

 fs/ecryptfs/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 525297c7ebd8..d7e90192efcf 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -363,6 +363,9 @@ static struct dentry *ecryptfs_lookup_interpose(struct dentry *dentry,
 		rc = ecryptfs_i_size_read(dentry, inode);
 		if (rc) {
 			make_bad_inode(inode);
+			if (inode_state_read_once(inode) & I_NEW)
+				unlock_new_inode(inode);
+			iput(inode);
 			return ERR_PTR(rc);
 		}
 	}

base-commit: 58161ead29e50d70a317ea26b472e0c7508e69da
-- 
2.53.0

