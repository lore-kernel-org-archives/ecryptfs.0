From: Tyler C Hicks <tyhicks@canonical.com>
Subject: Re: ecryptfs and fanotify
Date: Tue, 14 Aug 2012 13:27:40 -0700
Message-ID: <20120814202739.GD5215@boyd>
References: <5d3d0cdc-50db-4d60-8f9d-701acdbb86b0@ABN-EXCH1A.green.sophos>
 <CANT6BaPhaAOv3hg9CgoDa9JTp9vN60zf8bdAQX+dFp6YLSUwnA@mail.gmail.com>
 <F85176E33E12BA45BD553324E7858B300CE0A5@abn-exch1b.green.sophos>
 <20120814093124.GA12898@astaro.com>
 <502A2D77.50805@sophos.com>
 <94863d0d-4a43-427e-8c75-a6f8ced15ffa@ABN-EXCH1A.green.sophos>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zS7rBR6csb6tI2e1"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:59641 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756275Ab2HNU1u (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 14 Aug 2012 16:27:50 -0400
Content-Disposition: inline
In-Reply-To: <94863d0d-4a43-427e-8c75-a6f8ced15ffa@ABN-EXCH1A.green.sophos>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Douglas Leeder <douglas.leeder@sophos.com>
Cc: Florian Westphal <Florian.Westphal@sophos.com>, Dustin Kirkland <dustin.kirkland@gazzang.com>, Eric Paris <eparis@redhat.com>, "malware-list@dmesg.printk.net" <malware-list@dmesg.printk.net>, Eddie Garcia <eddie.garcia@gazzang.com>, Sergio Pena <sergio.pena@gazzang.com>, "ecryptfs@vger.kernel.org" <ecryptfs@vger.kernel.org>


--zS7rBR6csb6tI2e1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2012-08-14 17:01:14, Douglas Leeder wrote:
> On 14/08/12 11:50, Douglas Leeder wrote:
> >On 14/08/12 10:31, Florian Westphal wrote:
> >>Douglas Leeder <douglas.leeder@sophos.com> wrote:
> >>>So as, I sent later, making fanotify only return one file event per
> >>>fanotify read(), So that suggests that the request is getting stuck
> >>>in a cycle or adding a request.
> >>>
> >>>Florian has also been looking at this problem, and has pointed out
> >>>that FMODE_NONOTIFY should prevent the loop seen in the backtrace, so
> >>>I'm wondering if it's getting lost somewhere in ecryptfs. Or perhaps
> >>>it needs to be explicitly propagated to the open request for the
> >>>lower file?
> >>
> >>Douglas, can you reproduce the problem with this patch applied?
> >>
> >>diff --git a/fs/ecryptfs/kthread.c b/fs/ecryptfs/kthread.c
> >>index 809e67d..1d8a53b 100644
> >>--- a/fs/ecryptfs/kthread.c
> >>+++ b/fs/ecryptfs/kthread.c
> >>@@ -74,7 +74,7 @@ static int ecryptfs_threadfn(void *ignored)
> >>                             kthread_ctl_list);
> >>              list_del(&req->kthread_ctl_list);
> >>              *req->lower_file =3D dentry_open(&req->path,
> >>-                (O_RDWR | O_LARGEFILE), current_cred());
> >>+                (O_RDWR | O_LARGEFILE | FMODE_NONOTIFY),
> >>current_cred());
> >>              complete(&req->done);
> >>          }
> >>          mutex_unlock(&ecryptfs_kthread_ctl.mux);
> >>@@ -133,7 +133,7 @@ int ecryptfs_privileged_open(struct file
> >>**lower_file,
> >>                   const struct cred *cred)
> >>  {
> >>      struct ecryptfs_open_req req;
> >>-    int flags =3D O_LARGEFILE;
> >>+    int flags =3D O_LARGEFILE|FMODE_NONOTIFY;
> >>      int rc =3D 0;
> >>
> >>      init_completion(&req.done);
> >>
> >
> >That patch also seems to fix the problem - at least for AV scanning:
> >1) The encrypted files don't show up in the user-space test program.
> >2) Using the FanotifyMultiThreadScanner (old) from the git tree doesn't
> >lock up. (With the single event read() patch removed for the moment).
> >
> >
> >However I don't think this is a sufficient solution for general fanotify.
> >For example an HSM may need to get the fanotify event to restore the
> >encrypted file to disk.
> >Or a file-access recorder (e.g. http://www.piware.de/tag/fanotify/ )
> >will want all the accesses, including those 'generated' by the
> >fanotify_read() call itself.
> >
> >Talpa, in this case, has it easier, since it is only used for AV, it can
> >ignore any accesses that it's caused.
> >
> >What we might be able to do is set FMODE_NONOTIFY for the lower access
> >if the upper access had it set? Since HSM and fatrace don't want to
> >access the contents when they intercept.
> >
> >I guess HSM and fatrace might not intercept ecryptfs mounts anyway,
> >since they don't directly access the disk?
> >
>=20
> So I've looked at the path required for that and I guess it involves
> passing file->f_flags from ecryptfs_open through:
>  * ecryptfs_get_lower_file (main.c)
>  * ecryptfs_init_lower_file (main.c)
>  * ecryptfs_privileged_open (kthread.c)
>=20
> Does that look like the correct to you, Tyler?

Yeah, that should be the full list.

However, I don't think this approach will work with the current
eCryptfs design. eCryptfs only keeps one lower file open per inode. That
means that there could be 10 file descriptors opened for a given
eCryptfs file but there is still only one lower file opened that
everything is multiplexed through.

I don't like the design, but it has been that way for years and I
haven't touched it. For your approach to work, I think eCryptfs would
need to be changed to have a 1-to-1 mapping of upper files to lower
files.

Tyler

>=20
> I think HSM and fatrace usages won't request the file be opened, so
> won't trigger that path though fanotify.
>=20
> --
> Douglas Leeder, Senior Software Engineer
>=20
> ________________________________
>=20
> Sophos Limited, The Pentagon, Abingdon Science Park, Abingdon, OX14 3YP, =
United Kingdom.
> Company Reg No 2096520. VAT Reg No GB 991 2418 08.

--zS7rBR6csb6tI2e1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCgAGBQJQKrS7AAoJENaSAD2qAscKaT0P/0a2/5glZQanoM5D4oVtq1iT
UEvUXIF8gEqxOeiduh7eGpOm+CyFnsOvu5oILPbwcVklI115GkCf+GeOjv4yohdM
aNJsRWEdl1Jv7JNMWLmYo2Xo1Snahcx3zqLyOnQVnOg403wCti41KdmJ9Galv4Dm
o/KAk4S6kC7JeOjLocLa+oF5mnkNuDyba6nnKN7f3WKmjAsbN1eDWMRVkLeau9Nq
5QyFOTkFp0YbbJ6nmUkeE0Gbj9BrEez/Y0jUn4HvYh6PotC7UZ7iY9xSUnhn7QAi
rAMmMUyiQuNokxnOzsarqSuoM1t++/8W34dQh1j2Zdn6J5djKq264EVEjO5I9v83
xI8qNfkjrf71lijB1EsZDZ5UxjB/Ji1RrDtzYx9bk078+VWyTgfYRZw3b6qYAtds
VmJODHPDNe/Gvplr/Pe1XkDnIXSZoClQZG5iVxz8l0xr0nErHAOanM1uGNppLdKu
GmT4K5D8zltRKRtZrLHf4c/Gw1up6422XYZ3mbju06IrkNFeOH+ZI3/2nQqtBW4Z
eJFFFy9WDhf5FjM9nVqiGdHa+ECeeCndS1lF84b8Ga8nVXi5OIclj76NySs3odvW
FGVxNjjdwDMdd8xcb2EFJx+opTB6Uj5ASlFJw5J0Xcbwq8tofoV/IAQo2MYJPqAc
/JCcUwNMAKjj18oC5pI5
=ZCPf
-----END PGP SIGNATURE-----

--zS7rBR6csb6tI2e1--
