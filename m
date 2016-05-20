From: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v2 11/18] vfs: Move xattr_resolve_name to the front of fs/xattr.c
Date: Fri, 20 May 2016 13:14:28 +0200
Message-ID: <1463742875-9836-12-git-send-email-agruenba@redhat.com>
References: <1463742875-9836-1-git-send-email-agruenba@redhat.com>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45150 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755310AbcETLQH (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
	Fri, 20 May 2016 07:16:07 -0400
In-Reply-To: <1463742875-9836-1-git-send-email-agruenba@redhat.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andreas Gruenbacher <agruenba@redhat.com>, linux-fsdevel@vger.kernel.org, Tyler Hicks <tyhicks@canonical.com>, ecryptfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, Mimi Zohar <zohar@linux.vnet.ibm.com>, linux-ima-devel@lists.sourceforge.net, linux-security-module@vger.kernel.org, David Howells <dhowells@redhat.com>, Serge Hallyn <serge.hallyn@canonical.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>, Casey Schaufler <casey@schaufler-ca.com>, Oleg Drokin <oleg.drokin@intel.com>, Andreas Dilger <andreas.dilger@intel.com>

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/xattr.c | 99 +++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 49 insertions(+), 50 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 2476acc..179dd03 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -24,6 +24,55 @@
 
 #include <asm/uaccess.h>
 
+static const char *
+strcmp_prefix(const char *a, const char *a_prefix)
+{
+	while (*a_prefix && *a == *a_prefix) {
+		a++;
+		a_prefix++;
+	}
+	return *a_prefix ? NULL : a;
+}
+
+/*
+ * In order to implement different sets of xattr operations for each xattr
+ * prefix with the generic xattr API, a filesystem should create a
+ * null-terminated array of struct xattr_handler (one for each prefix) and
+ * hang a pointer to it off of the s_xattr field of the superblock.
+ *
+ * The generic_fooxattr() functions will use this list to dispatch xattr
+ * operations to the correct xattr_handler.
+ */
+#define for_each_xattr_handler(handlers, handler)		\
+		for ((handler) = *(handlers)++;			\
+			(handler) != NULL;			\
+			(handler) = *(handlers)++)
+
+/*
+ * Find the xattr_handler with the matching prefix.
+ */
+static const struct xattr_handler *
+xattr_resolve_name(const struct xattr_handler **handlers, const char **name)
+{
+	const struct xattr_handler *handler;
+
+	for_each_xattr_handler(handlers, handler) {
+		const char *n;
+
+		n = strcmp_prefix(*name, xattr_prefix(handler));
+		if (n) {
+			if (!handler->prefix ^ !*n) {
+				if (*n)
+					continue;
+				return ERR_PTR(-EINVAL);
+			}
+			*name = n;
+			return handler;
+		}
+	}
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
 /*
  * Check permissions for extended attribute access.  This is a bit complicated
  * because different namespaces have very different rules.
@@ -634,56 +683,6 @@ SYSCALL_DEFINE2(fremovexattr, int, fd, const char __user *, name)
 	return error;
 }
 
-
-static const char *
-strcmp_prefix(const char *a, const char *a_prefix)
-{
-	while (*a_prefix && *a == *a_prefix) {
-		a++;
-		a_prefix++;
-	}
-	return *a_prefix ? NULL : a;
-}
-
-/*
- * In order to implement different sets of xattr operations for each xattr
- * prefix with the generic xattr API, a filesystem should create a
- * null-terminated array of struct xattr_handler (one for each prefix) and
- * hang a pointer to it off of the s_xattr field of the superblock.
- *
- * The generic_fooxattr() functions will use this list to dispatch xattr
- * operations to the correct xattr_handler.
- */
-#define for_each_xattr_handler(handlers, handler)		\
-		for ((handler) = *(handlers)++;			\
-			(handler) != NULL;			\
-			(handler) = *(handlers)++)
-
-/*
- * Find the xattr_handler with the matching prefix.
- */
-static const struct xattr_handler *
-xattr_resolve_name(const struct xattr_handler **handlers, const char **name)
-{
-	const struct xattr_handler *handler;
-
-	for_each_xattr_handler(handlers, handler) {
-		const char *n;
-
-		n = strcmp_prefix(*name, xattr_prefix(handler));
-		if (n) {
-			if (!handler->prefix ^ !*n) {
-				if (*n)
-					continue;
-				return ERR_PTR(-EINVAL);
-			}
-			*name = n;
-			return handler;
-		}
-	}
-	return ERR_PTR(-EOPNOTSUPP);
-}
-
 /*
  * Find the handler for the prefix and dispatch its get() operation.
  */
-- 
2.5.5
