From: Richard Weinberger <richard@nod.at>
Subject: [RFC][PATCH] ecryptfs: Allow only one instance per lower path
Date: Fri, 31 Jul 2015 12:23:10 +0200
Message-ID: <1438338190-22518-1-git-send-email-richard@nod.at>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tyhicks@canonical.com
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevell@vger.kernel.org, Richard Weinberger <richard@nod.at>

Mounting the same lower path multiple times should not result
into multiple ecryptfs instances, otherwise ecryptfs gets confused.

A command sequence of:

$ mount -t ecryptfs /tmp/.secret /mnt_a/secret/
$ mount -t ecryptfs /tmp/.secret /mnt_b/secret/
$ mkdir -p /mnt_a/secret/xxx
$ mkdir -p /mnt_b/secret/xxx
$ echo foo > /mnt_a/secret/xxx/test.txt
$ echo foo > /mnt_b/secret/xxx/test.txt
$ rm -rf /mnt_a/secret/xxx
$ rm -rf /mnt_b/secret/xxx

results into:
[  125.536842] ------------[ cut here ]------------
[  125.537981] WARNING: CPU: 0 PID: 2100 at fs/inode.c:275 drop_nlink+0x41/0x50()
[  125.539694] Modules linked in:
[  125.540481] CPU: 0 PID: 2100 Comm: rm Not tainted 4.2.0-rc3+ #67
[  125.541909] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.7.5-0-ge51488c-20140816_022509-build35 04/01/2014
[  125.544603]  ffffffff81bd943b ffff88007ba67d08 ffffffff818b032f 0000000000000001
[  125.546522]  0000000000000000 ffff88007ba67d48 ffffffff810502b7 ffff88007ba67d0a
[  125.548443]  ffff88007caa7c58 ffff88007b59aad8 ffff88007cc3e780 0000000000000000
[  125.550224] Call Trace:
[  125.550772]  [<ffffffff818b032f>] dump_stack+0x45/0x57
[  125.551929]  [<ffffffff810502b7>] warn_slowpath_common+0x87/0xc0
[  125.553281]  [<ffffffff81050395>] warn_slowpath_null+0x15/0x20
[  125.554588]  [<ffffffff81178be1>] drop_nlink+0x41/0x50
[  125.555744]  [<ffffffff811252d8>] shmem_unlink+0x68/0x80
[  125.556950]  [<ffffffff8116b265>] vfs_unlink+0xd5/0x180
[  125.558126]  [<ffffffff81241d2f>] ecryptfs_do_unlink+0x6f/0x130
[  125.559456]  [<ffffffff81241dfd>] ecryptfs_unlink+0xd/0x10
[  125.560701]  [<ffffffff8116b265>] vfs_unlink+0xd5/0x180
[  125.561814]  [<ffffffff8116ece0>] do_unlinkat+0x240/0x290
[  125.562954]  [<ffffffff8116f5e6>] SyS_unlinkat+0x16/0x30
[  125.564090]  [<ffffffff818bac17>] entry_SYSCALL_64_fastpath+0x12/0x6a
[  125.565447] ---[ end trace 7d3a7839aa1d00d2 ]---
[  125.566432] ------------[ cut here ]------------
[  125.567415] WARNING: CPU: 0 PID: 2100 at fs/dcache.c:309 dentry_free+0x73/0x90()
[  125.568981] Modules linked in:
[  125.569668] CPU: 0 PID: 2100 Comm: rm Tainted: G        W       4.2.0-rc3+ #67
[  125.571194] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.7.5-0-ge51488c-20140816_022509-build35 04/01/2014
[  125.573538]  ffffffff81bd5e7b ffff88007ba67d38 ffffffff818b032f 0000000000000001
[  125.575111]  0000000000000000 ffff88007ba67d78 ffffffff810502b7 ffff88007cc3e780
[  125.576671]  ffff88007cc3e780 0000000000000000 ffff88007cc3e7d8 0000000000000000
[  125.578239] Call Trace:
[  125.578728]  [<ffffffff818b032f>] dump_stack+0x45/0x57
[  125.579768]  [<ffffffff810502b7>] warn_slowpath_common+0x87/0xc0
[  125.580977]  [<ffffffff81050395>] warn_slowpath_null+0x15/0x20
[  125.582152]  [<ffffffff81174943>] dentry_free+0x73/0x90
[  125.583200]  [<ffffffff81175183>] __dentry_kill+0x153/0x1d0
[  125.584323]  [<ffffffff8117537f>] dput+0x17f/0x1d0
[  125.585274]  [<ffffffff81168e25>] path_put+0x15/0x30
[  125.586230]  [<ffffffff81240f5a>] ecryptfs_d_release+0x1a/0x40
[  125.587335]  [<ffffffff8117515f>] __dentry_kill+0x12f/0x1d0
[  125.588400]  [<ffffffff8117537f>] dput+0x17f/0x1d0
[  125.589320]  [<ffffffff8116ec27>] do_unlinkat+0x187/0x290
[  125.590351]  [<ffffffff8116f5e6>] SyS_unlinkat+0x16/0x30
[  125.591359]  [<ffffffff818bac17>] entry_SYSCALL_64_fastpath+0x12/0x6a
[  125.592580] ---[ end trace 7d3a7839aa1d00d3 ]---
[  125.604089] ------------[ cut here ]------------
[  125.605005] WARNING: CPU: 0 PID: 0 at kernel/rcu/tree.c:2694 rcu_process_callbacks+0x4b7/0x570()
[  125.605075] Modules linked in:
[  125.605075] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W       4.2.0-rc3+ #67
[  125.605075] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.7.5-0-ge51488c-20140816_022509-build35 04/01/2014
[  125.605075]  ffffffff81bb9a07 ffff88007fc03e48 ffffffff818b032f 0000000000000000
[  125.605075]  0000000000000000 ffff88007fc03e88 ffffffff810502b7 ffff88007fc03e78
[  125.605075]  ffffffff81e3f180 0000000000000246 0000000000000000 0000000000000001
[  125.605075] Call Trace:
[  125.605075]  <IRQ>  [<ffffffff818b032f>] dump_stack+0x45/0x57
[  125.605075]  [<ffffffff810502b7>] warn_slowpath_common+0x87/0xc0
[  125.605075]  [<ffffffff81050395>] warn_slowpath_null+0x15/0x20
[  125.605075]  [<ffffffff810a1487>] rcu_process_callbacks+0x4b7/0x570
[  125.605075]  [<ffffffff81053eb4>] __do_softirq+0xd4/0x250
[  125.605075]  [<ffffffff81054226>] irq_exit+0x86/0x90
[  125.605075]  [<ffffffff810377f5>] smp_apic_timer_interrupt+0x45/0x60
[  125.605075]  [<ffffffff818bb9e8>] apic_timer_interrupt+0x68/0x70
[  125.605075]  <EOI>  [<ffffffff8100cf5b>] ? default_idle+0x1b/0xa0
[  125.605075]  [<ffffffff8100d4ba>] arch_cpu_idle+0xa/0x10
[  125.605075]  [<ffffffff81086f30>] default_idle_call+0x30/0x40
[  125.605075]  [<ffffffff81087199>] cpu_startup_entry+0x1f9/0x2e0
[  125.605075]  [<ffffffff818a9a87>] rest_init+0x77/0x80
[  125.605075]  [<ffffffff81f2dff5>] start_kernel+0x43e/0x44b
[  125.605075]  [<ffffffff81f2d99c>] ? set_init_arg+0x58/0x58
[  125.605075]  [<ffffffff81f2d5ad>] x86_64_start_reservations+0x2a/0x2c
[  125.605075]  [<ffffffff81f2d69b>] x86_64_start_kernel+0xec/0xf0
[  125.605075] ---[ end trace 7d3a7839aa1d00d4 ]---

Reuse the existing super block if the lower path is already mounted
to get rid of that issue.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
Tyler,

I'm not sure whether my fix is the correct solution.
Maybe ecryptfs supports mounting the same lower path mutliple times
and something else is broken.

Thanks,
//richard
---
 fs/ecryptfs/main.c | 39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index 4f4d047..bf6ad60 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -481,6 +481,15 @@ out:
 struct kmem_cache *ecryptfs_sb_info_cache;
 static struct file_system_type ecryptfs_fs_type;
 
+static int sb_test(struct super_block *sb, void *data)
+{
+	struct ecryptfs_dentry_info *info = sb->s_root->d_fsdata;
+	struct path *p2 = &info->lower_path;
+	struct path *p1 = data;
+
+	return p1->dentry->d_inode == p2->dentry->d_inode;
+}
+
 /**
  * ecryptfs_get_sb
  * @fs_type
@@ -514,15 +523,29 @@ static struct dentry *ecryptfs_mount(struct file_system_type *fs_type, int flags
 	}
 	mount_crypt_stat = &sbi->mount_crypt_stat;
 
-	s = sget(fs_type, NULL, set_anon_super, flags, NULL);
+	err = "Reading sb failed";
+	rc = kern_path(dev_name, LOOKUP_FOLLOW | LOOKUP_DIRECTORY, &path);
+	if (rc) {
+		ecryptfs_printk(KERN_WARNING, "kern_path() failed\n");
+		goto out;
+	}
+
+	s = sget(fs_type, sb_test, set_anon_super, flags, &path);
 	if (IS_ERR(s)) {
 		rc = PTR_ERR(s);
-		goto out;
+		goto out_put;
+	}
+
+	if (s->s_root) {
+		path_put(&path);
+		ecryptfs_destroy_mount_crypt_stat(&sbi->mount_crypt_stat);
+		kmem_cache_free(ecryptfs_sb_info_cache, sbi);
+		return dget(s->s_root);
 	}
 
 	rc = bdi_setup_and_register(&sbi->bdi, "ecryptfs");
 	if (rc)
-		goto out1;
+		goto out_free;
 
 	ecryptfs_set_superblock_private(s, sbi);
 	s->s_bdi = &sbi->bdi;
@@ -532,12 +555,6 @@ static struct dentry *ecryptfs_mount(struct file_system_type *fs_type, int flags
 	s->s_op = &ecryptfs_sops;
 	s->s_d_op = &ecryptfs_dops;
 
-	err = "Reading sb failed";
-	rc = kern_path(dev_name, LOOKUP_FOLLOW | LOOKUP_DIRECTORY, &path);
-	if (rc) {
-		ecryptfs_printk(KERN_WARNING, "kern_path() failed\n");
-		goto out1;
-	}
 	if (path.dentry->d_sb->s_type == &ecryptfs_fs_type) {
 		rc = -EINVAL;
 		printk(KERN_ERR "Mount on filesystem of type "
@@ -608,9 +625,9 @@ static struct dentry *ecryptfs_mount(struct file_system_type *fs_type, int flags
 	return dget(s->s_root);
 
 out_free:
-	path_put(&path);
-out1:
 	deactivate_locked_super(s);
+out_put:
+	path_put(&path);
 out:
 	if (sbi) {
 		ecryptfs_destroy_mount_crypt_stat(&sbi->mount_crypt_stat);
-- 
1.8.4.5
