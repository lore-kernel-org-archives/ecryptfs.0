From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH 1/1] ecryptfs: Migrate to ablkcipher API
Date: Wed, 13 Jun 2012 15:20:44 -0700
Message-ID: <20120613222043.GE22116@boyd>
References: <1339589670-12189-1-git-send-email-colin.king@canonical.com>
 <1339589670-12189-2-git-send-email-colin.king@canonical.com>
 <20120613161124.GB21062@boyd>
 <CAEcckGpMt1O+2syGbCQYC5ERCmXwCCvYjTYrHEeqZtQsA-qLLg@mail.gmail.com>
 <CAEcckGqhvz4gyvTHk0bSXf7pn5yEmWk7N+jT1BGrWxwGBX9wvQ@mail.gmail.com>
 <20120613211706.GD22116@boyd>
 <CAEcckGqhy9Yx9-vGYDVHBT8utsPR7cYaGjnAoRXM5ejnUonPyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jTMWTj4UTAEmbWeb"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:59362 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753229Ab2FMWUt (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Wed, 13 Jun 2012 18:20:49 -0400
Content-Disposition: inline
In-Reply-To: <CAEcckGqhy9Yx9-vGYDVHBT8utsPR7cYaGjnAoRXM5ejnUonPyg@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Thieu Le <thieule@google.com>
Cc: ecryptfs@vger.kernel.org, Colin King <colin.king@canonical.com>


--jTMWTj4UTAEmbWeb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2012-06-13 15:03:42, Thieu Le wrote:
> On Wed, Jun 13, 2012 at 2:17 PM, Tyler Hicks <tyhicks@canonical.com> wrot=
e:
> > On Wed, Jun 13, 2012 at 11:53 AM, Thieu Le <thieule@google.com> wrote:
> >>
> >> Hi Tyler, I believe the performance improvement from the async
> >> interface comes from the ability to fully utilize the crypto
> >> hardware.
> >>
> >> Firstly, being able to submit multiple outstanding requests fills
> >> the crypto engine pipeline which allows it to run more efficiently
> >> (ie. minimal cycles are wasted waiting for the next crypto request).
> >> =A0This perf improvement is similar to network transfer efficiency.
> >> =A0Sending a 1GB file via 4K packets synchronously is not going to
> >> fully saturate a gigabit link but queuing a bunch of 4K packets to
> >> send will.
> >
> > Ok, it is clicking for me now. Additionally, I imagine that the async
> > interface helps in the multicore/multiprocessor case.
> >
> >> Secondly, if you have crypto hardware that has multiple crypto
> >> engines, then the multiple outstanding requests allow the crypto
> >> hardware to put all of those engines to work.
> >>
> >> To answer your question about page_crypt_req, it is used to track
> >> all of the extent_crypt_reqs for a particular page. =A0When we write a
> >> page, we break the page up into extents and encrypt each extent.
> >> =A0For each extent, we submit the encrypt request using
> >> extent_crypt_req. =A0To determine when the entire page has been
> >> encrypted, we create one page_crypt_req and associates the
> >> extent_crypt_req to the page by incrementing
> >> page_crypt_req::num_refs. =A0As the extent encrypt request completes,
> >> we decrement num_refs. =A0The entire page is encrypted when num_refs
> >> goes to zero, at which point, we end the page writeback.
> >
> > Alright, that is what I had understood from reviewing the code. No
> > surprises there.
> >
> > What I'm suggesting is to do away with the page_crypt_req and simply ha=
ve
> > ecryptfs_encrypt_page_async() keep track of the extent_crypt_reqs for
> > the page it is encrypting. Its prototype would look like this:
> >
> > int ecryptfs_encrypt_page_async(struct page *page);
> >
> > An example of how it would be called would be something like this:
> >
> > static int ecryptfs_writepage(struct page *page, struct writeback_contr=
ol *wbc)
> > {
> > =A0 =A0 =A0 =A0int rc =3D 0;
> >
> > =A0 =A0 =A0 =A0/*
> > =A0 =A0 =A0 =A0 * Refuse to write the page out if we are called from re=
claim context
> > =A0 =A0 =A0 =A0 * since our writepage() path may potentially allocate m=
emory when
> > =A0 =A0 =A0 =A0 * calling into the lower fs vfs_write() which may in tu=
rn invoke
> > =A0 =A0 =A0 =A0 * us again.
> > =A0 =A0 =A0 =A0 */
> > =A0 =A0 =A0 =A0if (current->flags & PF_MEMALLOC) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0redirty_page_for_writepage(wbc, page);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
> > =A0 =A0 =A0 =A0}
> >
> > =A0 =A0 =A0 =A0set_page_writeback(page);
> > =A0 =A0 =A0 =A0rc =3D ecryptfs_encrypt_page_async(page);
> > =A0 =A0 =A0 =A0if (unlikely(rc)) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ecryptfs_printk(KERN_WARNING, "Error enc=
rypting "
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"page (u=
pper index [0x%.16lx])\n", page->index);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ClearPageUptodate(page);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SetPageError(page);
> > =A0 =A0 =A0 =A0} else {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SetPageUptodate(page);
> > =A0 =A0 =A0 =A0}
> > =A0 =A0 =A0 =A0end_page_writeback(page);
> > out:
> > =A0 =A0 =A0 =A0unlock_page(page);
> > =A0 =A0 =A0 =A0return rc;
> > }
>=20
> Will this make ecryptfs_encrypt_page_async() block until all of the
> extents are encrypted and written to the lower file before returning?
>=20
> In the current patch, ecryptfs_encrypt_page_async() returns
> immediately after the extents are submitted to the crypto layer.
> ecryptfs_writepage() will also return before the encryption and write
> to the lower file completes.  This allows the OS to start writing
> other pending pages without being blocked.

Ok, now I see the source of my confusion. The wait_for_completion()
added in ecryptfs_encrypt_page() was throwing me off. I initially
noticed that and didn't realize that wait_for_completion() was *not*
being called in ecryptfs_writepage().

I hope to give the rest of the patch a thorough review by the end of the
week. Thanks for your help!

Tyler

>=20
>=20
> >
> >
> >> We can get rid of page_crypt_req if we can guarantee that the extent
> >> size and page size are the same.
> >
> > We can't guarantee that but that doesn't matter because
> > ecryptfs_encrypt_page_async() already handles that problem. Its caller =
doesn't
> > care if the extent size is less than the page size.
> >
> > Tyler
> --
> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--jTMWTj4UTAEmbWeb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCgAGBQJP2RI7AAoJENaSAD2qAscK0gIQAIwspCUN9UsTr06FAVxACRGf
KIUejOYo/EMljnrx8Kd9a+p9KMFxY4Jptib4pwtYzlCsT+PcWi/GVLoj8wuXNn7X
vscsdt7mRC1oHVSghw6ccWWZ7HzWJxJoFUwr/+zS0kAUZ+yPycved3j2lNWaPVLQ
hkG51WGQdIU3T8LLYyXFVi8S60jkcnuh7LUbXeM2WJTRQgJ0IT7j8hbi6nDWsMye
az8ExHfPko6v5Vy2p5QPO3MKN87cbraP2F16NNebO01p5/oUk0xoSJROwZaKkJDD
gJkEqQlcOPxAJhL2ykJg+F4h1MP6uvnnfL674qwHqvwOkHa06+/Hd+egnNRo9ppO
N49UraaqBB6kZEKcC0k2b73jk/fsmbTr9TbHizXw/sQnvhP7VC0cGqaAU2BZKmck
PkrtVX9BEA2i4s7oOxlMNy8BZ2Kvp4pWMeffO0iRVdKUq6+chd5bDJH00X+OM/wy
m/uN49NhAq/OpaczskKsNrMKT5OluiPNb4NhIb5hq+kcd4Nikd16V6h6RenfTALL
Fq6UUwExVdiJof3c+/NOrsTe6wmjbodkPraSAXbJgjekxT++mVfgEJ+IaRaQGHRD
AHSwrlnbrdCEsRbYVrmNFlhL4N1I0mxStYgnAhT0HKbbx1M7qgzEImRpEe6Owz26
I1gb5N5qT2EiD/doVU2Y
=W7NW
-----END PGP SIGNATURE-----

--jTMWTj4UTAEmbWeb--
