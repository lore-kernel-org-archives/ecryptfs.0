From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH 1/1] ecryptfs: Migrate to ablkcipher API
Date: Wed, 13 Jun 2012 14:17:06 -0700
Message-ID: <20120613211706.GD22116@boyd>
References: <1339589670-12189-1-git-send-email-colin.king@canonical.com>
 <1339589670-12189-2-git-send-email-colin.king@canonical.com>
 <20120613161124.GB21062@boyd>
 <CAEcckGpMt1O+2syGbCQYC5ERCmXwCCvYjTYrHEeqZtQsA-qLLg@mail.gmail.com>
 <CAEcckGqhvz4gyvTHk0bSXf7pn5yEmWk7N+jT1BGrWxwGBX9wvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0IvGJv3f9h+YhkrH"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:59216 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650Ab2FMVRM (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Wed, 13 Jun 2012 17:17:12 -0400
Content-Disposition: inline
In-Reply-To: <CAEcckGqhvz4gyvTHk0bSXf7pn5yEmWk7N+jT1BGrWxwGBX9wvQ@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Thieu Le <thieule@google.com>
Cc: ecryptfs@vger.kernel.org, Colin King <colin.king@canonical.com>


--0IvGJv3f9h+YhkrH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 13, 2012 at 11:53 AM, Thieu Le <thieule@google.com> wrote:
>
> Hi Tyler, I believe the performance improvement from the async
> interface comes from the ability to fully utilize the crypto
> hardware.
>
> Firstly, being able to submit multiple outstanding requests fills
> the crypto engine pipeline which allows it to run more efficiently
> (ie. minimal cycles are wasted waiting for the next crypto request).
> =A0This perf improvement is similar to network transfer efficiency.
> =A0Sending a 1GB file via 4K packets synchronously is not going to
> fully saturate a gigabit link but queuing a bunch of 4K packets to
> send will.

Ok, it is clicking for me now. Additionally, I imagine that the async
interface helps in the multicore/multiprocessor case.

> Secondly, if you have crypto hardware that has multiple crypto
> engines, then the multiple outstanding requests allow the crypto
> hardware to put all of those engines to work.
>
> To answer your question about page_crypt_req, it is used to track
> all of the extent_crypt_reqs for a particular page. =A0When we write a
> page, we break the page up into extents and encrypt each extent.
> =A0For each extent, we submit the encrypt request using
> extent_crypt_req. =A0To determine when the entire page has been
> encrypted, we create one page_crypt_req and associates the
> extent_crypt_req to the page by incrementing
> page_crypt_req::num_refs. =A0As the extent encrypt request completes,
> we decrement num_refs. =A0The entire page is encrypted when num_refs
> goes to zero, at which point, we end the page writeback.

Alright, that is what I had understood from reviewing the code. No
surprises there.

What I'm suggesting is to do away with the page_crypt_req and simply have
ecryptfs_encrypt_page_async() keep track of the extent_crypt_reqs for
the page it is encrypting. Its prototype would look like this:

int ecryptfs_encrypt_page_async(struct page *page);

An example of how it would be called would be something like this:

static int ecryptfs_writepage(struct page *page, struct writeback_control *=
wbc)
{
	int rc =3D 0;

	/*
	 * Refuse to write the page out if we are called from reclaim context
	 * since our writepage() path may potentially allocate memory when
	 * calling into the lower fs vfs_write() which may in turn invoke
	 * us again.
	 */
	if (current->flags & PF_MEMALLOC) {
		redirty_page_for_writepage(wbc, page);
		goto out;
	}

	set_page_writeback(page);
	rc =3D ecryptfs_encrypt_page_async(page);
	if (unlikely(rc)) {
		ecryptfs_printk(KERN_WARNING, "Error encrypting "
				"page (upper index [0x%.16lx])\n", page->index);
		ClearPageUptodate(page);
		SetPageError(page);
	} else {
		SetPageUptodate(page);
	}
	end_page_writeback(page);
out:   =20
	unlock_page(page);
	return rc;
}


> We can get rid of page_crypt_req if we can guarantee that the extent
> size and page size are the same.

We can't guarantee that but that doesn't matter because
ecryptfs_encrypt_page_async() already handles that problem. Its caller does=
n't
care if the extent size is less than the page size.

Tyler

--0IvGJv3f9h+YhkrH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCgAGBQJP2QNSAAoJENaSAD2qAscKCssP/2BcMlfXOGsqhRlLsUCjUJNk
XVTUYDib9fUIiaE6kVQmhjW3U75SVUdELNw6WWwNl/Xz64yZY1AOvUhT36k2Ydhc
2OU6L/TFRi4KarYuhv/i/NQcGDYtf3mTYyVIYs2YMutkGYDri4OljLQB+W1H04wt
gFoLkPYHpavkahHHSNj8sLzpDxNGQs6/TK+RLmevfe95FMTNUpz5U9pSwMX3wiPa
2rdqKRwWTOHGgpSOj9ybo2CmVdl7JzS3kRYxmqpA1uTTOHn/LmrV2b4O4ii3Uqci
CMwYIQcHG8nCf8zUy597tonAYGklJNszZjaLRDycatgS6YzfaCQdTXXySQqWv5D1
H8gvcaD89/lfcgZDxgblSiNAWTUvv4sbnFlSzcek5YQy0gl/2uSjLtR4BZuZfCcB
N+4ka44KdFaBgKy9Ra+LKXn9u4/5gVi9ZOrrTt8M3NFIbTd8DQ5AVWqHprpSTwDz
oAA/SCl7rBnOH2fgBL+Qd0en0j5sm5PlGmK4RGM1bUnKlDJK3yr4gNbWgg95KsGf
8KpkulW3owpoeqaT8sPVz5CWj54QOB9pGw5Hhz1R+VCbxd7AU5L00+3m6ix//OeU
CGvweeembUvmcd8yWu8ck8hXkASqyQZteeRC/CG0JjHDjMqjj1AtFOXDmsrppdno
/Fw7t7dArJlMIunJJNrB
=126w
-----END PGP SIGNATURE-----

--0IvGJv3f9h+YhkrH--
