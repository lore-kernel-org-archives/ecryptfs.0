From: Florian Westphal <Florian.Westphal-NDHo7HnFrt3QT0dZR+AlfA@public.gmane.org>
Subject: Re: ecryptfs and fanotify
Date: Tue, 14 Aug 2012 11:31:24 +0200
Message-ID: <cb09b826-ba88-48ac-87c7-f58370d2092c@ABN-EXCH1A.green.sophos>
References: <5d3d0cdc-50db-4d60-8f9d-701acdbb86b0@ABN-EXCH1A.green.sophos>
	<CANT6BaPhaAOv3hg9CgoDa9JTp9vN60zf8bdAQX+dFp6YLSUwnA@mail.gmail.com>
	<F85176E33E12BA45BD553324E7858B300CE0A5@abn-exch1b.green.sophos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <malware-list-bounces-h+Im9A44IAFcMpApZELgcQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <F85176E33E12BA45BD553324E7858B300CE0A5-wyMY/JD5BThOaAOxIYwbkpbnZX9N9W2w@public.gmane.org>
List-Id: <ecryptfs.vger.kernel.org>
List-Unsubscribe: <http://dmesg2.printk.net/cgi-bin/mailman/options/malware-list>,
	<mailto:malware-list-request-h+Im9A44IAFcMpApZELgcQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://dmesg2.printk.net/pipermail/malware-list>
List-Post: <mailto:malware-list-h+Im9A44IAFcMpApZELgcQ@public.gmane.org>
List-Help: <mailto:malware-list-request-h+Im9A44IAFcMpApZELgcQ@public.gmane.org?subject=help>
List-Subscribe: <http://dmesg2.printk.net/cgi-bin/mailman/listinfo/malware-list>,
	<mailto:malware-list-request-h+Im9A44IAFcMpApZELgcQ@public.gmane.org?subject=subscribe>
Sender: malware-list-bounces-h+Im9A44IAFcMpApZELgcQ@public.gmane.org
Errors-To: malware-list-bounces-h+Im9A44IAFcMpApZELgcQ@public.gmane.org
To: Douglas Leeder <douglas.leeder-j34lQMj1tz/QT0dZR+AlfA@public.gmane.org>
Cc: Sergio Pena <sergio.pena-Bv2LyzZ6GzxBDgjK7y7TUQ@public.gmane.org>, "malware-list-h+Im9A44IAFcMpApZELgcQ@public.gmane.org" <malware-list-h+Im9A44IAFcMpApZELgcQ@public.gmane.org>, "ecryptfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ecryptfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Eric Paris <eparis-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Tyler C Hicks <tyhicks-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Dustin Kirkland <dustin.kirkland-Bv2LyzZ6GzxBDgjK7y7TUQ@public.gmane.org>, Eddie Garcia <eddie.garcia-Bv2LyzZ6GzxBDgjK7y7TUQ@public.gmane.org>

Douglas Leeder <douglas.leeder-j34lQMj1tz/QT0dZR+AlfA@public.gmane.org> wrote:
> So as, I sent later, making fanotify only return one file event per fanotify read(), So that suggests that the request is getting stuck in a cycle or adding a request.
> 
> Florian has also been looking at this problem, and has pointed out that FMODE_NONOTIFY should prevent the loop seen in the backtrace, so I'm wondering if it's getting lost somewhere in ecryptfs. Or perhaps it needs to be explicitly propagated to the open request for the lower file?

Douglas, can you reproduce the problem with this patch applied?

diff --git a/fs/ecryptfs/kthread.c b/fs/ecryptfs/kthread.c
index 809e67d..1d8a53b 100644
--- a/fs/ecryptfs/kthread.c
+++ b/fs/ecryptfs/kthread.c
@@ -74,7 +74,7 @@ static int ecryptfs_threadfn(void *ignored)
 					       kthread_ctl_list);
 			list_del(&req->kthread_ctl_list);
 			*req->lower_file = dentry_open(&req->path,
-				(O_RDWR | O_LARGEFILE), current_cred());
+				(O_RDWR | O_LARGEFILE | FMODE_NONOTIFY), current_cred());
 			complete(&req->done);
 		}
 		mutex_unlock(&ecryptfs_kthread_ctl.mux);
@@ -133,7 +133,7 @@ int ecryptfs_privileged_open(struct file **lower_file,
 			     const struct cred *cred)
 {
 	struct ecryptfs_open_req req;
-	int flags = O_LARGEFILE;
+	int flags = O_LARGEFILE|FMODE_NONOTIFY;
 	int rc = 0;
 
 	init_completion(&req.done);
