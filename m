From: Thieu Le <thieule@google.com>
Subject: Re: [PATCH 1/1] ecryptfs: Migrate to ablkcipher API
Date: Wed, 13 Jun 2012 15:25:28 -0700
Message-ID: <CAEcckGokBaMJEbLX3hc4oMh-X-VS_gFXO0sK+W9d1PeeoxWEBQ@mail.gmail.com>
References: <1339589670-12189-1-git-send-email-colin.king@canonical.com>
	<1339589670-12189-2-git-send-email-colin.king@canonical.com>
	<20120613161124.GB21062@boyd>
	<CAEcckGpMt1O+2syGbCQYC5ERCmXwCCvYjTYrHEeqZtQsA-qLLg@mail.gmail.com>
	<CAEcckGqhvz4gyvTHk0bSXf7pn5yEmWk7N+jT1BGrWxwGBX9wvQ@mail.gmail.com>
	<20120613211706.GD22116@boyd>
	<CAEcckGqhy9Yx9-vGYDVHBT8utsPR7cYaGjnAoRXM5ejnUonPyg@mail.gmail.com>
	<20120613222043.GE22116@boyd>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:43244 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754912Ab2FMWZ3 convert rfc822-to-8bit (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Wed, 13 Jun 2012 18:25:29 -0400
Received: by obbtb18 with SMTP id tb18so1453599obb.19
        for <ecryptfs@vger.kernel.org>; Wed, 13 Jun 2012 15:25:28 -0700 (PDT)
In-Reply-To: <20120613222043.GE22116@boyd>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Tyler Hicks <tyhicks@canonical.com>
Cc: ecryptfs@vger.kernel.org, Colin King <colin.king@canonical.com>

Kewl :)

Let me know if you have more questions.


On Wed, Jun 13, 2012 at 3:20 PM, Tyler Hicks <tyhicks@canonical.com> wr=
ote:
> On 2012-06-13 15:03:42, Thieu Le wrote:
>> On Wed, Jun 13, 2012 at 2:17 PM, Tyler Hicks <tyhicks@canonical.com>=
 wrote:
>> > On Wed, Jun 13, 2012 at 11:53 AM, Thieu Le <thieule@google.com> wr=
ote:
>> >>
>> >> Hi Tyler, I believe the performance improvement from the async
>> >> interface comes from the ability to fully utilize the crypto
>> >> hardware.
>> >>
>> >> Firstly, being able to submit multiple outstanding requests fills
>> >> the crypto engine pipeline which allows it to run more efficientl=
y
>> >> (ie. minimal cycles are wasted waiting for the next crypto reques=
t).
>> >> =A0This perf improvement is similar to network transfer efficienc=
y.
>> >> =A0Sending a 1GB file via 4K packets synchronously is not going t=
o
>> >> fully saturate a gigabit link but queuing a bunch of 4K packets t=
o
>> >> send will.
>> >
>> > Ok, it is clicking for me now. Additionally, I imagine that the as=
ync
>> > interface helps in the multicore/multiprocessor case.
>> >
>> >> Secondly, if you have crypto hardware that has multiple crypto
>> >> engines, then the multiple outstanding requests allow the crypto
>> >> hardware to put all of those engines to work.
>> >>
>> >> To answer your question about page_crypt_req, it is used to track
>> >> all of the extent_crypt_reqs for a particular page. =A0When we wr=
ite a
>> >> page, we break the page up into extents and encrypt each extent.
>> >> =A0For each extent, we submit the encrypt request using
>> >> extent_crypt_req. =A0To determine when the entire page has been
>> >> encrypted, we create one page_crypt_req and associates the
>> >> extent_crypt_req to the page by incrementing
>> >> page_crypt_req::num_refs. =A0As the extent encrypt request comple=
tes,
>> >> we decrement num_refs. =A0The entire page is encrypted when num_r=
efs
>> >> goes to zero, at which point, we end the page writeback.
>> >
>> > Alright, that is what I had understood from reviewing the code. No
>> > surprises there.
>> >
>> > What I'm suggesting is to do away with the page_crypt_req and simp=
ly have
>> > ecryptfs_encrypt_page_async() keep track of the extent_crypt_reqs =
for
>> > the page it is encrypting. Its prototype would look like this:
>> >
>> > int ecryptfs_encrypt_page_async(struct page *page);
>> >
>> > An example of how it would be called would be something like this:
>> >
>> > static int ecryptfs_writepage(struct page *page, struct writeback_=
control *wbc)
>> > {
>> > =A0 =A0 =A0 =A0int rc =3D 0;
>> >
>> > =A0 =A0 =A0 =A0/*
>> > =A0 =A0 =A0 =A0 * Refuse to write the page out if we are called fr=
om reclaim context
>> > =A0 =A0 =A0 =A0 * since our writepage() path may potentially alloc=
ate memory when
>> > =A0 =A0 =A0 =A0 * calling into the lower fs vfs_write() which may =
in turn invoke
>> > =A0 =A0 =A0 =A0 * us again.
>> > =A0 =A0 =A0 =A0 */
>> > =A0 =A0 =A0 =A0if (current->flags & PF_MEMALLOC) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0redirty_page_for_writepage(wbc, pag=
e);
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
>> > =A0 =A0 =A0 =A0}
>> >
>> > =A0 =A0 =A0 =A0set_page_writeback(page);
>> > =A0 =A0 =A0 =A0rc =3D ecryptfs_encrypt_page_async(page);
>> > =A0 =A0 =A0 =A0if (unlikely(rc)) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ecryptfs_printk(KERN_WARNING, "Erro=
r encrypting "
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"pa=
ge (upper index [0x%.16lx])\n", page->index);
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ClearPageUptodate(page);
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SetPageError(page);
>> > =A0 =A0 =A0 =A0} else {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SetPageUptodate(page);
>> > =A0 =A0 =A0 =A0}
>> > =A0 =A0 =A0 =A0end_page_writeback(page);
>> > out:
>> > =A0 =A0 =A0 =A0unlock_page(page);
>> > =A0 =A0 =A0 =A0return rc;
>> > }
>>
>> Will this make ecryptfs_encrypt_page_async() block until all of the
>> extents are encrypted and written to the lower file before returning=
?
>>
>> In the current patch, ecryptfs_encrypt_page_async() returns
>> immediately after the extents are submitted to the crypto layer.
>> ecryptfs_writepage() will also return before the encryption and writ=
e
>> to the lower file completes. =A0This allows the OS to start writing
>> other pending pages without being blocked.
>
> Ok, now I see the source of my confusion. The wait_for_completion()
> added in ecryptfs_encrypt_page() was throwing me off. I initially
> noticed that and didn't realize that wait_for_completion() was *not*
> being called in ecryptfs_writepage().
>
> I hope to give the rest of the patch a thorough review by the end of =
the
> week. Thanks for your help!
>
> Tyler
>
>>
>>
>> >
>> >
>> >> We can get rid of page_crypt_req if we can guarantee that the ext=
ent
>> >> size and page size are the same.
>> >
>> > We can't guarantee that but that doesn't matter because
>> > ecryptfs_encrypt_page_async() already handles that problem. Its ca=
ller doesn't
>> > care if the extent size is less than the page size.
>> >
>> > Tyler
>> --
>> To unsubscribe from this list: send the line "unsubscribe ecryptfs" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
