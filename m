From: Thieu Le <thieule@google.com>
Subject: Re: [PATCH 1/1] ecryptfs: Migrate to ablkcipher API
Date: Wed, 13 Jun 2012 12:04:47 -0700
Message-ID: <CAEcckGqhvz4gyvTHk0bSXf7pn5yEmWk7N+jT1BGrWxwGBX9wvQ@mail.gmail.com>
References: <1339589670-12189-1-git-send-email-colin.king@canonical.com>
	<1339589670-12189-2-git-send-email-colin.king@canonical.com>
	<20120613161124.GB21062@boyd>
	<CAEcckGpMt1O+2syGbCQYC5ERCmXwCCvYjTYrHEeqZtQsA-qLLg@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:58499 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754377Ab2FMTEs convert rfc822-to-8bit (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Wed, 13 Jun 2012 15:04:48 -0400
Received: by obbtb18 with SMTP id tb18so1225058obb.19
        for <ecryptfs@vger.kernel.org>; Wed, 13 Jun 2012 12:04:48 -0700 (PDT)
In-Reply-To: <CAEcckGpMt1O+2syGbCQYC5ERCmXwCCvYjTYrHEeqZtQsA-qLLg@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Tyler Hicks <tyhicks@canonical.com>
Cc: ecryptfs@vger.kernel.org, Colin King <colin.king@canonical.com>

Resending with just plaintext.

On Wed, Jun 13, 2012 at 11:53 AM, Thieu Le <thieule@google.com> wrote:
>
> Hi Colin,
> Thank you *very* much. =A0The patch is really big and I appreciate yo=
ur efforts to move it forward. =A0The testing has been greatly needed a=
nd the numbers from this are awesome. =A0I never got a chance to test t=
his on hardware accelerated crypto that is ready for primetime before. =
=A0It is nice to see that it actually works :)
>
> Hi Tyler,
> I believe the performance improvement from the async interface comes =
from the ability to fully utilize the crypto hardware.
>
> Firstly, being able to submit multiple outstanding requests fills the=
 crypto engine pipeline which allows it to run more efficiently (ie. mi=
nimal cycles are wasted waiting for the next crypto request). =A0This p=
erf improvement is similar to network transfer efficiency. =A0Sending a=
 1GB file via 4K packets synchronously is not going to fully saturate a=
 gigabit link but queuing a bunch of 4K packets to send will.
>
> Secondly, if you have crypto hardware that has multiple crypto engine=
s, then the multiple outstanding requests allow the crypto hardware to =
put all of those engines to work.
>
> To answer your question about page_crypt_req, it is used to track all=
 of the extent_crypt_reqs for a particular page. =A0When we write a pag=
e, we break the page up into extents and encrypt each extent. =A0For ea=
ch extent, we submit the encrypt request using extent_crypt_req. =A0To =
determine when the entire page has been encrypted, we create one page_c=
rypt_req and associates the extent_crypt_req to the page by incrementin=
g page_crypt_req::num_refs. =A0As the extent encrypt request completes,=
 we decrement num_refs. =A0The entire page is encrypted when num_refs g=
oes to zero, at which point, we end the page writeback. =A0We can get r=
id of page_crypt_req if we can guarantee that the extent size and page =
size are the same.
>
> Let me know if I misunderstood your question.
>
> Thanks,
> Thieu
>
>
> On Wed, Jun 13, 2012 at 9:11 AM, Tyler Hicks <tyhicks@canonical.com> =
wrote:
>>
>> On 2012-06-13 13:14:30, Colin King wrote:
>> > From: Colin Ian King <colin.king@canonical.com>
>> >
>> > Forward port of Thieu Le's patch from 2.6.39.
>> >
>> > Using ablkcipher allows eCryptfs to take full advantage of hardwar=
e
>> > crypto.
>> >
>> > Change-Id: I94a6e50a8d576bf79cf73732c7b4c75629b5d40c
>> >
>> > Signed-off-by: Thieu Le <thieule@chromium.org>
>> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> > ---
>> > =A0fs/ecryptfs/crypto.c =A0 =A0 =A0 =A0 =A0| =A0678 ++++++++++++++=
+++++++++++++++++----------
>> > =A0fs/ecryptfs/ecryptfs_kernel.h | =A0 38 ++-
>> > =A0fs/ecryptfs/main.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 10 +
>> > =A0fs/ecryptfs/mmap.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 87 +++++-
>> > =A04 files changed, 636 insertions(+), 177 deletions(-)
>> >
>> > diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
>> > index ea99312..7f5ff05 100644
>> > --- a/fs/ecryptfs/crypto.c
>> > +++ b/fs/ecryptfs/crypto.c
>> > @@ -37,16 +37,17 @@
>> > =A0#include <asm/unaligned.h>
>> > =A0#include "ecryptfs_kernel.h"
>> >
>> > +struct kmem_cache *ecryptfs_page_crypt_req_cache;
>> > +struct kmem_cache *ecryptfs_extent_crypt_req_cache;
>> > +
>> > =A0static int
>> > -ecryptfs_decrypt_page_offset(struct ecryptfs_crypt_stat *crypt_st=
at,
>> > +ecryptfs_decrypt_page_offset(struct ecryptfs_extent_crypt_req *ex=
tent_crypt_req,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct page=
 *dst_page, int dst_offset,
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct page *=
src_page, int src_offset, int size,
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned char=
 *iv);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct page *=
src_page, int src_offset, int size);
>> > =A0static int
>> > -ecryptfs_encrypt_page_offset(struct ecryptfs_crypt_stat *crypt_st=
at,
>> > +ecryptfs_encrypt_page_offset(struct ecryptfs_extent_crypt_req *ex=
tent_crypt_req,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct page=
 *dst_page, int dst_offset,
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct page *=
src_page, int src_offset, int size,
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned char=
 *iv);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct page *=
src_page, int src_offset, int size);
>> >
>> > =A0/**
>> > =A0 * ecryptfs_to_hex
>> > @@ -166,6 +167,120 @@ out:
>> > =A0}
>> >
>> > =A0/**
>> > + * ecryptfs_alloc_page_crypt_req - allocates a page crypt request
>> > + * @page: Page mapped from the eCryptfs inode for the file
>> > + * @completion: Function that is called when the page crypt reque=
st completes.
>> > + * =A0 =A0 =A0 =A0 =A0 =A0 =A0If this parameter is NULL, then the=
 the
>> > + * =A0 =A0 =A0 =A0 =A0 =A0 =A0page_crypt_completion::completion m=
ember is used to indicate
>> > + * =A0 =A0 =A0 =A0 =A0 =A0 =A0the operation completion.
>> > + *
>> > + * Allocates a crypt request that is used for asynchronous page e=
ncrypt and
>> > + * decrypt operations.
>> > + */
>> > +struct ecryptfs_page_crypt_req *ecryptfs_alloc_page_crypt_req(
>> > + =A0 =A0 struct page *page,
>> > + =A0 =A0 page_crypt_completion completion_func)
>> > +{
>> > + =A0 =A0 struct ecryptfs_page_crypt_req *page_crypt_req;
>> > + =A0 =A0 page_crypt_req =3D kmem_cache_zalloc(ecryptfs_page_crypt=
_req_cache,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0GFP_KERNEL);
>> > + =A0 =A0 if (!page_crypt_req)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> > + =A0 =A0 page_crypt_req->page =3D page;
>> > + =A0 =A0 page_crypt_req->completion_func =3D completion_func;
>> > + =A0 =A0 if (!completion_func)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 init_completion(&page_crypt_req->complet=
ion);
>> > +out:
>> > + =A0 =A0 return page_crypt_req;
>> > +}
>>
>> Hey Thieu - Can you explain the reasoning for the page_crypt_req? Th=
e
>> reason for the extent_crypt_req is obvious, but it seems to me that =
the
>> page_crypt_req just adds an unneeded layer of indirection.
>>
>> ecryptfs_encrypt_page_async() could return an int indicating success=
 or
>> failure and then the callers could handle the return status as neede=
d.
>> No need for the page_crypt_req, special completion functions, etc.
>>
>> The only reason I could see page_crypt_req helping performance is if=
 we
>> implemented ecryptfs_writepages() and ecryptfs_readpages().
>>
>>
>> Which leads into another question... I'm having a hard time
>> understanding _how_ this patch improves performance. I haven't went
>> through the crypto api code to really understand what the async
>> interface does differently, so I'm hoping that you can explain.
>>
>> We were submitting an extent to the kernel crypto api and the crypto=
 api
>> call would return when the crypto operation was completed. Now we're
>> asynchronously submitting an extent to the kernel crypto api, the cr=
ypto
>> api call immediately returns, but then we wait on the crypto operati=
on
>> to complete. It seems like we're doing the same thing but just using=
 a
>> different interface. Colin's test results prove that it greatly help=
s
>> performance, but I'd like to better understand why.
>>
>> Thanks!
>>
>> Tyler
>>
>> > +
>> > +/**
>> > + * ecryptfs_free_page_crypt_req - deallocates a page crypt reques=
t
>> > + * @page_crypt_req: Request to deallocate
>> > + *
>> > + * Deallocates a page crypt request. =A0This request must have be=
en
>> > + * previously allocated by ecryptfs_alloc_page_crypt_req().
>> > + */
>> > +void ecryptfs_free_page_crypt_req(
>> > + =A0 =A0 struct ecryptfs_page_crypt_req *page_crypt_req)
>> > +{
>> > + =A0 =A0 kmem_cache_free(ecryptfs_page_crypt_req_cache, page_cryp=
t_req);
>> > +}
>> > +
>> > +/**
>> > + * ecryptfs_complete_page_crypt_req - completes a page crypt requ=
est
>> > + * @page_crypt_req: Request to complete
>> > + *
>> > + * Completes the specified page crypt request by either invoking =
the
>> > + * completion callback if one is present, or use the completion d=
ata structure.
>> > + */
>> > +static void ecryptfs_complete_page_crypt_req(
>> > + =A0 =A0 =A0 =A0 =A0 =A0 struct ecryptfs_page_crypt_req *page_cry=
pt_req)
>> > +{
>> > + =A0 =A0 if (page_crypt_req->completion_func)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 page_crypt_req->completion_func(page_cry=
pt_req);
>> > + =A0 =A0 else
>> > + =A0 =A0 =A0 =A0 =A0 =A0 complete(&page_crypt_req->completion);
>> > +}
>> > +
>> > +/**
>> > + * ecryptfs_alloc_extent_crypt_req - allocates an extent crypt re=
quest
>> > + * @page_crypt_req: Pointer to the page crypt request that owns t=
his extent
>> > + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0request
>> > + * @crypt_stat: Pointer to crypt_stat struct for the current inod=
e
>> > + *
>> > + * Allocates a crypt request that is used for asynchronous extent=
 encrypt and
>> > + * decrypt operations.
>> > + */
>> > +static struct ecryptfs_extent_crypt_req *ecryptfs_alloc_extent_cr=
ypt_req(
>> > + =A0 =A0 =A0 =A0 =A0 =A0 struct ecryptfs_page_crypt_req *page_cry=
pt_req,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 struct ecryptfs_crypt_stat *crypt_stat)
>> > +{
>> > + =A0 =A0 struct ecryptfs_extent_crypt_req *extent_crypt_req;
>> > + =A0 =A0 extent_crypt_req =3D kmem_cache_zalloc(ecryptfs_extent_c=
rypt_req_cache,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0GFP_KERNEL);
>> > + =A0 =A0 if (!extent_crypt_req)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> > + =A0 =A0 extent_crypt_req->req =3D
>> > + =A0 =A0 =A0 =A0 =A0 =A0 ablkcipher_request_alloc(crypt_stat->tfm=
, GFP_KERNEL);
>> > + =A0 =A0 if (!extent_crypt_req) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 kmem_cache_free(ecryptfs_extent_crypt_re=
q_cache,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 extent_c=
rypt_req);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 extent_crypt_req =3D NULL;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> > + =A0 =A0 }
>> > + =A0 =A0 atomic_inc(&page_crypt_req->num_refs);
>> > + =A0 =A0 extent_crypt_req->page_crypt_req =3D page_crypt_req;
>> > + =A0 =A0 extent_crypt_req->crypt_stat =3D crypt_stat;
>> > + =A0 =A0 ablkcipher_request_set_tfm(extent_crypt_req->req, crypt_=
stat->tfm);
>> > +out:
>> > + =A0 =A0 return extent_crypt_req;
>> > +}
>> > +
>> > +/**
>> > + * ecryptfs_free_extent_crypt_req - deallocates an extent crypt r=
equest
>> > + * @extent_crypt_req: Request to deallocate
>> > + *
>> > + * Deallocates an extent crypt request. =A0This request must have=
 been
>> > + * previously allocated by ecryptfs_alloc_extent_crypt_req().
>> > + * If the extent crypt is the last operation for the page crypt r=
equest,
>> > + * this function calls the page crypt completion function.
>> > + */
>> > +static void ecryptfs_free_extent_crypt_req(
>> > + =A0 =A0 =A0 =A0 =A0 =A0 struct ecryptfs_extent_crypt_req *extent=
_crypt_req)
>> > +{
>> > + =A0 =A0 int num_refs;
>> > + =A0 =A0 struct ecryptfs_page_crypt_req *page_crypt_req =3D
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 extent_crypt_req->page_c=
rypt_req;
>> > + =A0 =A0 BUG_ON(!page_crypt_req);
>> > + =A0 =A0 num_refs =3D atomic_dec_return(&page_crypt_req->num_refs=
);
>> > + =A0 =A0 if (!num_refs)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 ecryptfs_complete_page_crypt_req(page_cr=
ypt_req);
>> > + =A0 =A0 ablkcipher_request_free(extent_crypt_req->req);
>> > + =A0 =A0 kmem_cache_free(ecryptfs_extent_crypt_req_cache, extent_=
crypt_req);
>> > +}
>> > +
>> > +/**
>> > =A0 * ecryptfs_derive_iv
>> > =A0 * @iv: destination for the derived iv vale
>> > =A0 * @crypt_stat: Pointer to crypt_stat struct for the current in=
ode
>> > @@ -243,7 +358,7 @@ void ecryptfs_destroy_crypt_stat(struct ecrypt=
fs_crypt_stat *crypt_stat)
>> > =A0 =A0 =A0 struct ecryptfs_key_sig *key_sig, *key_sig_tmp;
>> >
>> > =A0 =A0 =A0 if (crypt_stat->tfm)
>> > - =A0 =A0 =A0 =A0 =A0 =A0 crypto_free_blkcipher(crypt_stat->tfm);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 crypto_free_ablkcipher(crypt_stat->tfm);
>> > =A0 =A0 =A0 if (crypt_stat->hash_tfm)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 crypto_free_hash(crypt_stat->hash_tfm)=
;
>> > =A0 =A0 =A0 list_for_each_entry_safe(key_sig, key_sig_tmp,
>> > @@ -324,26 +439,23 @@ int virt_to_scatterlist(const void *addr, in=
t size, struct scatterlist *sg,
>> >
>> > =A0/**
>> > =A0 * encrypt_scatterlist
>> > - * @crypt_stat: Pointer to the crypt_stat struct to initialize.
>> > + * @crypt_stat: Cryptographic context
>> > + * @req: Async blkcipher request
>> > =A0 * @dest_sg: Destination of encrypted data
>> > =A0 * @src_sg: Data to be encrypted
>> > =A0 * @size: Length of data to be encrypted
>> > =A0 * @iv: iv to use during encryption
>> > =A0 *
>> > - * Returns the number of bytes encrypted; negative value on error
>> > + * Returns zero if the encryption request was started successfull=
y, else
>> > + * non-zero.
>> > =A0 */
>> > =A0static int encrypt_scatterlist(struct ecryptfs_crypt_stat *cryp=
t_stat,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct ab=
lkcipher_request *req,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct =
scatterlist *dest_sg,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct =
scatterlist *src_sg, int size,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigne=
d char *iv)
>> > =A0{
>> > - =A0 =A0 struct blkcipher_desc desc =3D {
>> > - =A0 =A0 =A0 =A0 =A0 =A0 .tfm =3D crypt_stat->tfm,
>> > - =A0 =A0 =A0 =A0 =A0 =A0 .info =3D iv,
>> > - =A0 =A0 =A0 =A0 =A0 =A0 .flags =3D CRYPTO_TFM_REQ_MAY_SLEEP
>> > - =A0 =A0 };
>> > =A0 =A0 =A0 int rc =3D 0;
>> > -
>> > =A0 =A0 =A0 BUG_ON(!crypt_stat || !crypt_stat->tfm
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0|| !(crypt_stat->flags & ECRYPTFS_STRUC=
T_INITIALIZED));
>> > =A0 =A0 =A0 if (unlikely(ecryptfs_verbosity > 0)) {
>> > @@ -355,20 +467,22 @@ static int encrypt_scatterlist(struct ecrypt=
fs_crypt_stat *crypt_stat,
>> > =A0 =A0 =A0 /* Consider doing this once, when the file is opened *=
/
>> > =A0 =A0 =A0 mutex_lock(&crypt_stat->cs_tfm_mutex);
>> > =A0 =A0 =A0 if (!(crypt_stat->flags & ECRYPTFS_KEY_SET)) {
>> > - =A0 =A0 =A0 =A0 =A0 =A0 rc =3D crypto_blkcipher_setkey(crypt_sta=
t->tfm, crypt_stat->key,
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0crypt_stat->key_size);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 rc =3D crypto_ablkcipher_setkey(crypt_st=
at->tfm, crypt_stat->key,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 crypt_stat->key_size);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 if (rc) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ecryptfs_printk(KERN_ERR=
,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 "Error setting key; rc =3D [%d]\n",
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 rc);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&crypt_stat=
->cs_tfm_mutex);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D -EINVAL;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 }
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 crypt_stat->flags |=3D ECRYPTFS_KEY_SE=
T;
>> > =A0 =A0 =A0 }
>> > - =A0 =A0 if (rc) {
>> > - =A0 =A0 =A0 =A0 =A0 =A0 ecryptfs_printk(KERN_ERR, "Error setting=
 key; rc =3D [%d]\n",
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc);
>> > - =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&crypt_stat->cs_tfm_mutex);
>> > - =A0 =A0 =A0 =A0 =A0 =A0 rc =3D -EINVAL;
>> > - =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> > - =A0 =A0 }
>> > - =A0 =A0 ecryptfs_printk(KERN_DEBUG, "Encrypting [%d] bytes.\n", =
size);
>> > - =A0 =A0 crypto_blkcipher_encrypt_iv(&desc, dest_sg, src_sg, size=
);
>> > =A0 =A0 =A0 mutex_unlock(&crypt_stat->cs_tfm_mutex);
>> > + =A0 =A0 ecryptfs_printk(KERN_DEBUG, "Encrypting [%d] bytes.\n", =
size);
>> > + =A0 =A0 ablkcipher_request_set_crypt(req, src_sg, dest_sg, size,=
 iv);
>> > + =A0 =A0 rc =3D crypto_ablkcipher_encrypt(req);
>> > =A0out:
>> > =A0 =A0 =A0 return rc;
>> > =A0}
>> > @@ -387,24 +501,26 @@ static void ecryptfs_lower_offset_for_extent=
(loff_t *offset, loff_t extent_num,
>> >
>> > =A0/**
>> > =A0 * ecryptfs_encrypt_extent
>> > - * @enc_extent_page: Allocated page into which to encrypt the dat=
a in
>> > - * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 @page
>> > - * @crypt_stat: crypt_stat containing cryptographic context for t=
he
>> > - * =A0 =A0 =A0 =A0 =A0 =A0 =A0encryption operation
>> > - * @page: Page containing plaintext data extent to encrypt
>> > - * @extent_offset: Page extent offset for use in generating IV
>> > + * @extent_crypt_req: Crypt request that describes the extent tha=
t needs to be
>> > + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0encrypted
>> > + * @completion: Function that is called back when the encryption =
is completed
>> > =A0 *
>> > =A0 * Encrypts one extent of data.
>> > =A0 *
>> > - * Return zero on success; non-zero otherwise
>> > + * Status code is returned in the completion routine (zero on suc=
cess;
>> > + * non-zero otherwise).
>> > =A0 */
>> > -static int ecryptfs_encrypt_extent(struct page *enc_extent_page,
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s=
truct ecryptfs_crypt_stat *crypt_stat,
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s=
truct page *page,
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u=
nsigned long extent_offset)
>> > +static void ecryptfs_encrypt_extent(
>> > + =A0 =A0 =A0 =A0 =A0 =A0 struct ecryptfs_extent_crypt_req *extent=
_crypt_req,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 crypto_completion_t completion)
>> > =A0{
>> > + =A0 =A0 struct page *enc_extent_page =3D extent_crypt_req->enc_e=
xtent_page;
>> > + =A0 =A0 struct ecryptfs_crypt_stat *crypt_stat =3D extent_crypt_=
req->crypt_stat;
>> > + =A0 =A0 struct page *page =3D extent_crypt_req->page_crypt_req->=
page;
>> > + =A0 =A0 unsigned long extent_offset =3D extent_crypt_req->extent=
_offset;
>> > +
>> > =A0 =A0 =A0 loff_t extent_base;
>> > - =A0 =A0 char extent_iv[ECRYPTFS_MAX_IV_BYTES];
>> > + =A0 =A0 char *extent_iv =3D extent_crypt_req->extent_iv;
>> > =A0 =A0 =A0 int rc;
>> >
>> > =A0 =A0 =A0 extent_base =3D (((loff_t)page->index)
>> > @@ -417,11 +533,20 @@ static int ecryptfs_encrypt_extent(struct pa=
ge *enc_extent_page,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long long)(e=
xtent_base + extent_offset), rc);
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> > =A0 =A0 =A0 }
>> > - =A0 =A0 rc =3D ecryptfs_encrypt_page_offset(crypt_stat, enc_exte=
nt_page, 0,
>> > + =A0 =A0 ablkcipher_request_set_callback(extent_crypt_req->req,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 CRYPTO_TFM_REQ_MAY_BACKLOG |
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 CRYPTO_TFM_REQ_MAY_SLEEP,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 completion, extent_crypt_req);
>> > + =A0 =A0 rc =3D ecryptfs_encrypt_page_offset(extent_crypt_req, en=
c_extent_page, 0,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 page, (extent_offset
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0* crypt_stat->extent_size),
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 crypt_stat->extent_size, extent_iv);
>> > - =A0 =A0 if (rc < 0) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 crypt_stat->extent_size);
>> > + =A0 =A0 if (!rc) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 /* Request completed synchronously */
>> > + =A0 =A0 =A0 =A0 =A0 =A0 struct crypto_async_request dummy;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 dummy.data =3D extent_crypt_req;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 completion(&dummy, rc);
>> > + =A0 =A0 } else if (rc !=3D -EBUSY && rc !=3D -EINPROGRESS) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "%s: Error attempting =
to encrypt page with "
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"page->index =3D [%ld],=
 extent_offset =3D [%ld]; "
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"rc =3D [%d]\n", __func=
__, page->index, extent_offset,
>> > @@ -430,32 +555,107 @@ static int ecryptfs_encrypt_extent(struct p=
age *enc_extent_page,
>> > =A0 =A0 =A0 }
>> > =A0 =A0 =A0 rc =3D 0;
>> > =A0out:
>> > - =A0 =A0 return rc;
>> > + =A0 =A0 if (rc) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 struct crypto_async_request dummy;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 dummy.data =3D extent_crypt_req;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 completion(&dummy, rc);
>> > + =A0 =A0 }
>> > =A0}
>> >
>> > =A0/**
>> > - * ecryptfs_encrypt_page
>> > - * @page: Page mapped from the eCryptfs inode for the file; conta=
ins
>> > - * =A0 =A0 =A0 =A0decrypted content that needs to be encrypted (t=
o a temporary
>> > - * =A0 =A0 =A0 =A0page; not in place) and written out to the lowe=
r file
>> > + * ecryptfs_encrypt_extent_done
>> > + * @req: The original extent encrypt request
>> > + * @err: Result of the encryption operation
>> > + *
>> > + * This function is called when the extent encryption is complete=
d.
>> > + */
>> > +static void ecryptfs_encrypt_extent_done(
>> > + =A0 =A0 =A0 =A0 =A0 =A0 struct crypto_async_request *req,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 int err)
>> > +{
>> > + =A0 =A0 struct ecryptfs_extent_crypt_req *extent_crypt_req =3D r=
eq->data;
>> > + =A0 =A0 struct ecryptfs_page_crypt_req *page_crypt_req =3D
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 extent_c=
rypt_req->page_crypt_req;
>> > + =A0 =A0 char *enc_extent_virt =3D NULL;
>> > + =A0 =A0 struct page *page =3D page_crypt_req->page;
>> > + =A0 =A0 struct page *enc_extent_page =3D extent_crypt_req->enc_e=
xtent_page;
>> > + =A0 =A0 struct ecryptfs_crypt_stat *crypt_stat =3D extent_crypt_=
req->crypt_stat;
>> > + =A0 =A0 loff_t extent_base;
>> > + =A0 =A0 unsigned long extent_offset =3D extent_crypt_req->extent=
_offset;
>> > + =A0 =A0 loff_t offset;
>> > + =A0 =A0 int rc =3D 0;
>> > +
>> > + =A0 =A0 if (!err && unlikely(ecryptfs_verbosity > 0)) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 extent_base =3D (((loff_t)page->index)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* (PAGE_C=
ACHE_SIZE / crypt_stat->extent_size));
>> > + =A0 =A0 =A0 =A0 =A0 =A0 ecryptfs_printk(KERN_DEBUG, "Encrypt ext=
ent [0x%.16llx]; "
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "rc =3D =
[%d]\n",
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigne=
d long long)(extent_base +
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0extent_offset),
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 ecryptfs_printk(KERN_DEBUG, "First 8 byt=
es after "
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "encrypt=
ion:\n");
>> > + =A0 =A0 =A0 =A0 =A0 =A0 ecryptfs_dump_hex((char *)(page_address(=
enc_extent_page)), 8);
>> > + =A0 =A0 } else if (err) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 atomic_set(&page_crypt_req->rc, err);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "%s: Error encrypting ex=
tent; "
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"rc =3D [%d]\n", __func__=
, err);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> > + =A0 =A0 }
>> > +
>> > + =A0 =A0 enc_extent_virt =3D kmap(enc_extent_page);
>> > + =A0 =A0 ecryptfs_lower_offset_for_extent(
>> > + =A0 =A0 =A0 =A0 =A0 =A0 &offset,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 ((((loff_t)page->index)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 * (PAGE_CACHE_SIZE
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/ extent_crypt_req->crypt_sta=
t->extent_size))
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 + extent_crypt_req->extent_offse=
t),
>> > + =A0 =A0 =A0 =A0 =A0 =A0 extent_crypt_req->crypt_stat);
>> > + =A0 =A0 rc =3D ecryptfs_write_lower(extent_crypt_req->inode, enc=
_extent_virt,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 offs=
et,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 exte=
nt_crypt_req->crypt_stat->extent_size);
>> > + =A0 =A0 if (rc < 0) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 atomic_set(&page_crypt_req->rc, rc);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 ecryptfs_printk(KERN_ERR, "Error attempt=
ing "
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "to writ=
e lower page; rc =3D [%d]"
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "\n", rc=
);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> > + =A0 =A0 }
>> > +out:
>> > + =A0 =A0 if (enc_extent_virt)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 kunmap(enc_extent_page);
>> > + =A0 =A0 __free_page(enc_extent_page);
>> > + =A0 =A0 ecryptfs_free_extent_crypt_req(extent_crypt_req);
>> > +}
>> > +
>> > +/**
>> > + * ecryptfs_encrypt_page_async
>> > + * @page_crypt_req: Page level encryption request which contains =
the page
>> > + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mapped from the eCryptfs in=
ode for the file; the page
>> > + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0contains decrypted content =
that needs to be encrypted
>> > + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(to a temporary page; not i=
n place) and written out to
>> > + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0the lower file
>> > =A0 *
>> > - * Encrypt an eCryptfs page. This is done on a per-extent basis. =
Note
>> > - * that eCryptfs pages may straddle the lower pages -- for instan=
ce,
>> > - * if the file was created on a machine with an 8K page size
>> > - * (resulting in an 8K header), and then the file is copied onto =
a
>> > - * host with a 32K page size, then when reading page 0 of the eCr=
yptfs
>> > + * Function that asynchronously encrypts an eCryptfs page.
>> > + * This is done on a per-extent basis. =A0Note that eCryptfs page=
s may straddle
>> > + * the lower pages -- for instance, if the file was created on a =
machine with
>> > + * an 8K page size (resulting in an 8K header), and then the file=
 is copied
>> > + * onto a host with a 32K page size, then when reading page 0 of =
the eCryptfs
>> > =A0 * file, 24K of page 0 of the lower file will be read and decry=
pted,
>> > =A0 * and then 8K of page 1 of the lower file will be read and dec=
rypted.
>> > =A0 *
>> > - * Returns zero on success; negative on error
>> > + * Status code is returned in the completion routine (zero on suc=
cess;
>> > + * negative on error).
>> > =A0 */
>> > -int ecryptfs_encrypt_page(struct page *page)
>> > +void ecryptfs_encrypt_page_async(
>> > + =A0 =A0 struct ecryptfs_page_crypt_req *page_crypt_req)
>> > =A0{
>> > + =A0 =A0 struct page *page =3D page_crypt_req->page;
>> > =A0 =A0 =A0 struct inode *ecryptfs_inode;
>> > =A0 =A0 =A0 struct ecryptfs_crypt_stat *crypt_stat;
>> > - =A0 =A0 char *enc_extent_virt;
>> > =A0 =A0 =A0 struct page *enc_extent_page =3D NULL;
>> > - =A0 =A0 loff_t extent_offset;
>> > + =A0 =A0 struct ecryptfs_extent_crypt_req *extent_crypt_req =3D N=
ULL;
>> > + =A0 =A0 loff_t extent_offset =3D 0;
>> > =A0 =A0 =A0 int rc =3D 0;
>> >
>> > =A0 =A0 =A0 ecryptfs_inode =3D page->mapping->host;
>> > @@ -469,49 +669,94 @@ int ecryptfs_encrypt_page(struct page *page)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "encry=
pted extent\n");
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> > =A0 =A0 =A0 }
>> > - =A0 =A0 enc_extent_virt =3D kmap(enc_extent_page);
>> > =A0 =A0 =A0 for (extent_offset =3D 0;
>> > =A0 =A0 =A0 =A0 =A0 =A0extent_offset < (PAGE_CACHE_SIZE / crypt_st=
at->extent_size);
>> > =A0 =A0 =A0 =A0 =A0 =A0extent_offset++) {
>> > - =A0 =A0 =A0 =A0 =A0 =A0 loff_t offset;
>> > -
>> > - =A0 =A0 =A0 =A0 =A0 =A0 rc =3D ecryptfs_encrypt_extent(enc_exten=
t_page, crypt_stat, page,
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0extent_offset);
>> > - =A0 =A0 =A0 =A0 =A0 =A0 if (rc) {
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "%s: Err=
or encrypting extent; "
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"rc =3D [=
%d]\n", __func__, rc);
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> > - =A0 =A0 =A0 =A0 =A0 =A0 }
>> > - =A0 =A0 =A0 =A0 =A0 =A0 ecryptfs_lower_offset_for_extent(
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &offset, ((((loff_t)page=
->index)
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*=
 (PAGE_CACHE_SIZE
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 / crypt_stat->extent_size))
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 + ex=
tent_offset), crypt_stat);
>> > - =A0 =A0 =A0 =A0 =A0 =A0 rc =3D ecryptfs_write_lower(ecryptfs_ino=
de, enc_extent_virt,
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 offset, crypt_stat->extent_size);
>> > - =A0 =A0 =A0 =A0 =A0 =A0 if (rc < 0) {
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ecryptfs_printk(KERN_ERR=
, "Error attempting "
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 "to write lower page; rc =3D [%d]"
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 "\n", rc);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 extent_crypt_req =3D ecryptfs_alloc_exte=
nt_crypt_req(
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 page_crypt_req, crypt_stat);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 if (!extent_crypt_req) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D -ENOMEM;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ecryptfs_printk(KERN_ERR=
,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 "Failed to allocate extent crypt "
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 "request for encryption\n");
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> > + =A0 =A0 =A0 =A0 =A0 =A0 extent_crypt_req->inode =3D ecryptfs_ino=
de;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 extent_crypt_req->enc_extent_page =3D en=
c_extent_page;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 extent_crypt_req->extent_offset =3D exte=
nt_offset;
>> > +
>> > + =A0 =A0 =A0 =A0 =A0 =A0 /* Error handling is done in the complet=
ion routine. */
>> > + =A0 =A0 =A0 =A0 =A0 =A0 ecryptfs_encrypt_extent(extent_crypt_req=
,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 ecryptfs_encrypt_extent_done);
>> > =A0 =A0 =A0 }
>> > =A0 =A0 =A0 rc =3D 0;
>> > =A0out:
>> > - =A0 =A0 if (enc_extent_page) {
>> > - =A0 =A0 =A0 =A0 =A0 =A0 kunmap(enc_extent_page);
>> > - =A0 =A0 =A0 =A0 =A0 =A0 __free_page(enc_extent_page);
>> > + =A0 =A0 /* Only call the completion routine if we did not fire o=
ff any extent
>> > + =A0 =A0 =A0* encryption requests. =A0If at least one call to
>> > + =A0 =A0 =A0* ecryptfs_encrypt_extent succeeded, it will call the=
 completion
>> > + =A0 =A0 =A0* routine.
>> > + =A0 =A0 =A0*/
>> > + =A0 =A0 if (rc && extent_offset =3D=3D 0) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 if (enc_extent_page)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __free_page(enc_extent_p=
age);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 atomic_set(&page_crypt_req->rc, rc);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 ecryptfs_complete_page_crypt_req(page_cr=
ypt_req);
>> > =A0 =A0 =A0 }
>> > +}
>> > +
>> > +/**
>> > + * ecryptfs_encrypt_page
>> > + * @page: Page mapped from the eCryptfs inode for the file; conta=
ins
>> > + * =A0 =A0 =A0 =A0decrypted content that needs to be encrypted (t=
o a temporary
>> > + * =A0 =A0 =A0 =A0page; not in place) and written out to the lowe=
r file
>> > + *
>> > + * Encrypts an eCryptfs page synchronously.
>> > + *
>> > + * Returns zero on success; negative on error
>> > + */
>> > +int ecryptfs_encrypt_page(struct page *page)
>> > +{
>> > + =A0 =A0 struct ecryptfs_page_crypt_req *page_crypt_req;
>> > + =A0 =A0 int rc;
>> > +
>> > + =A0 =A0 page_crypt_req =3D ecryptfs_alloc_page_crypt_req(page, N=
ULL);
>> > + =A0 =A0 if (!page_crypt_req) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 rc =3D -ENOMEM;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 ecryptfs_printk(KERN_ERR,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Failed =
to allocate page crypt request "
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "for enc=
ryption\n");
>> > + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> > + =A0 =A0 }
>> > + =A0 =A0 ecryptfs_encrypt_page_async(page_crypt_req);
>> > + =A0 =A0 wait_for_completion(&page_crypt_req->completion);
>> > + =A0 =A0 rc =3D atomic_read(&page_crypt_req->rc);
>> > +out:
>> > + =A0 =A0 if (page_crypt_req)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 ecryptfs_free_page_crypt_req(page_crypt_=
req);
>> > =A0 =A0 =A0 return rc;
>> > =A0}
>> >
>> > -static int ecryptfs_decrypt_extent(struct page *page,
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s=
truct ecryptfs_crypt_stat *crypt_stat,
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s=
truct page *enc_extent_page,
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u=
nsigned long extent_offset)
>> > +/**
>> > + * ecryptfs_decrypt_extent
>> > + * @extent_crypt_req: Crypt request that describes the extent tha=
t needs to be
>> > + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0decrypted
>> > + * @completion: Function that is called back when the decryption =
is completed
>> > + *
>> > + * Decrypts one extent of data.
>> > + *
>> > + * Status code is returned in the completion routine (zero on suc=
cess;
>> > + * non-zero otherwise).
>> > + */
>> > +static void ecryptfs_decrypt_extent(
>> > + =A0 =A0 =A0 =A0 =A0 =A0 struct ecryptfs_extent_crypt_req *extent=
_crypt_req,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 crypto_completion_t completion)
>> > =A0{
>> > + =A0 =A0 struct ecryptfs_crypt_stat *crypt_stat =3D extent_crypt_=
req->crypt_stat;
>> > + =A0 =A0 struct page *page =3D extent_crypt_req->page_crypt_req->=
page;
>> > + =A0 =A0 struct page *enc_extent_page =3D extent_crypt_req->enc_e=
xtent_page;
>> > + =A0 =A0 unsigned long extent_offset =3D extent_crypt_req->extent=
_offset;
>> > =A0 =A0 =A0 loff_t extent_base;
>> > - =A0 =A0 char extent_iv[ECRYPTFS_MAX_IV_BYTES];
>> > + =A0 =A0 char *extent_iv =3D extent_crypt_req->extent_iv;
>> > =A0 =A0 =A0 int rc;
>> >
>> > =A0 =A0 =A0 extent_base =3D (((loff_t)page->index)
>> > @@ -524,12 +769,21 @@ static int ecryptfs_decrypt_extent(struct pa=
ge *page,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long long)(e=
xtent_base + extent_offset), rc);
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> > =A0 =A0 =A0 }
>> > - =A0 =A0 rc =3D ecryptfs_decrypt_page_offset(crypt_stat, page,
>> > + =A0 =A0 ablkcipher_request_set_callback(extent_crypt_req->req,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 CRYPTO_TFM_REQ_MAY_BACKLOG |
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 CRYPTO_TFM_REQ_MAY_SLEEP,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 completion, extent_crypt_req);
>> > + =A0 =A0 rc =3D ecryptfs_decrypt_page_offset(extent_crypt_req, pa=
ge,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 (extent_offset
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0* crypt_stat->extent_size),
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 enc_extent_page, 0,
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 crypt_stat->extent_size, extent_iv);
>> > - =A0 =A0 if (rc < 0) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 crypt_stat->extent_size);
>> > + =A0 =A0 if (!rc) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 /* Request completed synchronously */
>> > + =A0 =A0 =A0 =A0 =A0 =A0 struct crypto_async_request dummy;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 dummy.data =3D extent_crypt_req;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 completion(&dummy, rc);
>> > + =A0 =A0 } else if (rc !=3D -EBUSY && rc !=3D -EINPROGRESS) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "%s: Error attempting =
to decrypt to page with "
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"page->index =3D [%ld],=
 extent_offset =3D [%ld]; "
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"rc =3D [%d]\n", __func=
__, page->index, extent_offset,
>> > @@ -538,32 +792,80 @@ static int ecryptfs_decrypt_extent(struct pa=
ge *page,
>> > =A0 =A0 =A0 }
>> > =A0 =A0 =A0 rc =3D 0;
>> > =A0out:
>> > - =A0 =A0 return rc;
>> > + =A0 =A0 if (rc) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 struct crypto_async_request dummy;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 dummy.data =3D extent_crypt_req;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 completion(&dummy, rc);
>> > + =A0 =A0 }
>> > =A0}
>> >
>> > =A0/**
>> > - * ecryptfs_decrypt_page
>> > - * @page: Page mapped from the eCryptfs inode for the file; data =
read
>> > - * =A0 =A0 =A0 =A0and decrypted from the lower file will be writt=
en into this
>> > - * =A0 =A0 =A0 =A0page
>> > + * ecryptfs_decrypt_extent_done
>> > + * @extent_crypt_req: The original extent decrypt request
>> > + * @err: Result of the decryption operation
>> > + *
>> > + * This function is called when the extent decryption is complete=
d.
>> > + */
>> > +static void ecryptfs_decrypt_extent_done(
>> > + =A0 =A0 =A0 =A0 =A0 =A0 struct crypto_async_request *req,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 int err)
>> > +{
>> > + =A0 =A0 struct ecryptfs_extent_crypt_req *extent_crypt_req =3D r=
eq->data;
>> > + =A0 =A0 struct ecryptfs_crypt_stat *crypt_stat =3D extent_crypt_=
req->crypt_stat;
>> > + =A0 =A0 struct page *page =3D extent_crypt_req->page_crypt_req->=
page;
>> > + =A0 =A0 unsigned long extent_offset =3D extent_crypt_req->extent=
_offset;
>> > + =A0 =A0 loff_t extent_base;
>> > +
>> > + =A0 =A0 if (!err && unlikely(ecryptfs_verbosity > 0)) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 extent_base =3D (((loff_t)page->index)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* (PAGE_C=
ACHE_SIZE / crypt_stat->extent_size));
>> > + =A0 =A0 =A0 =A0 =A0 =A0 ecryptfs_printk(KERN_DEBUG, "Decrypt ext=
ent [0x%.16llx]; "
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "rc =3D =
[%d]\n",
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigne=
d long long)(extent_base +
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0extent_offset),
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 ecryptfs_printk(KERN_DEBUG, "First 8 byt=
es after "
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "decrypt=
ion:\n");
>> > + =A0 =A0 =A0 =A0 =A0 =A0 ecryptfs_dump_hex((char *)(page_address(=
page)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0+ (extent_offset
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 * crypt_stat->extent_size)), 8);
>> > + =A0 =A0 } else if (err) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 atomic_set(&extent_crypt_req->page_crypt=
_req->rc, err);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "%s: Error decrypting ex=
tent; "
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"rc =3D [%d]\n", __func__=
, err);
>> > + =A0 =A0 }
>> > +
>> > + =A0 =A0 __free_page(extent_crypt_req->enc_extent_page);
>> > + =A0 =A0 ecryptfs_free_extent_crypt_req(extent_crypt_req);
>> > +}
>> > +
>> > +/**
>> > + * ecryptfs_decrypt_page_async
>> > + * @page_crypt_req: Page level decryption request which contains =
the page
>> > + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mapped from the eCryptfs in=
ode for the file; data read
>> > + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0and decrypted from the lowe=
r file will be written into
>> > + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0this page
>> > =A0 *
>> > - * Decrypt an eCryptfs page. This is done on a per-extent basis. =
Note
>> > - * that eCryptfs pages may straddle the lower pages -- for instan=
ce,
>> > - * if the file was created on a machine with an 8K page size
>> > - * (resulting in an 8K header), and then the file is copied onto =
a
>> > - * host with a 32K page size, then when reading page 0 of the eCr=
yptfs
>> > + * Function that asynchronously decrypts an eCryptfs page.
>> > + * This is done on a per-extent basis. Note that eCryptfs pages m=
ay straddle
>> > + * the lower pages -- for instance, if the file was created on a =
machine with
>> > + * an 8K page size (resulting in an 8K header), and then the file=
 is copied
>> > + * onto a host with a 32K page size, then when reading page 0 of =
the eCryptfs
>> > =A0 * file, 24K of page 0 of the lower file will be read and decry=
pted,
>> > =A0 * and then 8K of page 1 of the lower file will be read and dec=
rypted.
>> > =A0 *
>> > - * Returns zero on success; negative on error
>> > + * Status code is returned in the completion routine (zero on suc=
cess;
>> > + * negative on error).
>> > =A0 */
>> > -int ecryptfs_decrypt_page(struct page *page)
>> > +void ecryptfs_decrypt_page_async(struct ecryptfs_page_crypt_req *=
page_crypt_req)
>> > =A0{
>> > + =A0 =A0 struct page *page =3D page_crypt_req->page;
>> > =A0 =A0 =A0 struct inode *ecryptfs_inode;
>> > =A0 =A0 =A0 struct ecryptfs_crypt_stat *crypt_stat;
>> > =A0 =A0 =A0 char *enc_extent_virt;
>> > =A0 =A0 =A0 struct page *enc_extent_page =3D NULL;
>> > - =A0 =A0 unsigned long extent_offset;
>> > + =A0 =A0 struct ecryptfs_extent_crypt_req *extent_crypt_req =3D N=
ULL;
>> > + =A0 =A0 unsigned long extent_offset =3D 0;
>> > =A0 =A0 =A0 int rc =3D 0;
>> >
>> > =A0 =A0 =A0 ecryptfs_inode =3D page->mapping->host;
>> > @@ -574,7 +876,7 @@ int ecryptfs_decrypt_page(struct page *page)
>> > =A0 =A0 =A0 if (!enc_extent_page) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D -ENOMEM;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 ecryptfs_printk(KERN_ERR, "Error alloc=
ating memory for "
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "encrypt=
ed extent\n");
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "decrypt=
ed extent\n");
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> > =A0 =A0 =A0 }
>> > =A0 =A0 =A0 enc_extent_virt =3D kmap(enc_extent_page);
>> > @@ -596,123 +898,174 @@ int ecryptfs_decrypt_page(struct page *pag=
e)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "\n", rc);
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> > - =A0 =A0 =A0 =A0 =A0 =A0 rc =3D ecryptfs_decrypt_extent(page, cry=
pt_stat, enc_extent_page,
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0extent_offset);
>> > - =A0 =A0 =A0 =A0 =A0 =A0 if (rc) {
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "%s: Err=
or encrypting extent; "
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"rc =3D [=
%d]\n", __func__, rc);
>> > +
>> > + =A0 =A0 =A0 =A0 =A0 =A0 extent_crypt_req =3D ecryptfs_alloc_exte=
nt_crypt_req(
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 page_crypt_req, crypt_stat);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 if (!extent_crypt_req) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D -ENOMEM;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ecryptfs_printk(KERN_ERR=
,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 "Failed to allocate extent crypt "
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 "request for decryption\n");
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> > + =A0 =A0 =A0 =A0 =A0 =A0 extent_crypt_req->enc_extent_page =3D en=
c_extent_page;
>> > +
>> > + =A0 =A0 =A0 =A0 =A0 =A0 /* Error handling is done in the complet=
ion routine. */
>> > + =A0 =A0 =A0 =A0 =A0 =A0 ecryptfs_decrypt_extent(extent_crypt_req=
,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 ecryptfs_decrypt_extent_done);
>> > =A0 =A0 =A0 }
>> > + =A0 =A0 rc =3D 0;
>> > =A0out:
>> > - =A0 =A0 if (enc_extent_page) {
>> > + =A0 =A0 if (enc_extent_page)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 kunmap(enc_extent_page);
>> > - =A0 =A0 =A0 =A0 =A0 =A0 __free_page(enc_extent_page);
>> > +
>> > + =A0 =A0 /* Only call the completion routine if we did not fire o=
ff any extent
>> > + =A0 =A0 =A0* decryption requests. =A0If at least one call to
>> > + =A0 =A0 =A0* ecryptfs_decrypt_extent succeeded, it will call the=
 completion
>> > + =A0 =A0 =A0* routine.
>> > + =A0 =A0 =A0*/
>> > + =A0 =A0 if (rc && extent_offset =3D=3D 0) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 atomic_set(&page_crypt_req->rc, rc);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 ecryptfs_complete_page_crypt_req(page_cr=
ypt_req);
>> > + =A0 =A0 }
>> > +}
>> > +
>> > +/**
>> > + * ecryptfs_decrypt_page
>> > + * @page: Page mapped from the eCryptfs inode for the file; data =
read
>> > + * =A0 =A0 =A0 =A0and decrypted from the lower file will be writt=
en into this
>> > + * =A0 =A0 =A0 =A0page
>> > + *
>> > + * Decrypts an eCryptfs page synchronously.
>> > + *
>> > + * Returns zero on success; negative on error
>> > + */
>> > +int ecryptfs_decrypt_page(struct page *page)
>> > +{
>> > + =A0 =A0 struct ecryptfs_page_crypt_req *page_crypt_req;
>> > + =A0 =A0 int rc;
>> > +
>> > + =A0 =A0 page_crypt_req =3D ecryptfs_alloc_page_crypt_req(page, N=
ULL);
>> > + =A0 =A0 if (!page_crypt_req) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 rc =3D -ENOMEM;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 ecryptfs_printk(KERN_ERR,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Failed =
to allocate page crypt request "
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "for dec=
ryption\n");
>> > + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> > =A0 =A0 =A0 }
>> > + =A0 =A0 ecryptfs_decrypt_page_async(page_crypt_req);
>> > + =A0 =A0 wait_for_completion(&page_crypt_req->completion);
>> > + =A0 =A0 rc =3D atomic_read(&page_crypt_req->rc);
>> > +out:
>> > + =A0 =A0 if (page_crypt_req)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 ecryptfs_free_page_crypt_req(page_crypt_=
req);
>> > =A0 =A0 =A0 return rc;
>> > =A0}
>> >
>> > =A0/**
>> > =A0 * decrypt_scatterlist
>> > =A0 * @crypt_stat: Cryptographic context
>> > + * @req: Async blkcipher request
>> > =A0 * @dest_sg: The destination scatterlist to decrypt into
>> > =A0 * @src_sg: The source scatterlist to decrypt from
>> > =A0 * @size: The number of bytes to decrypt
>> > =A0 * @iv: The initialization vector to use for the decryption
>> > =A0 *
>> > - * Returns the number of bytes decrypted; negative value on error
>> > + * Returns zero if the decryption request was started successfull=
y, else
>> > + * non-zero.
>> > =A0 */
>> > =A0static int decrypt_scatterlist(struct ecryptfs_crypt_stat *cryp=
t_stat,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct ab=
lkcipher_request *req,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct =
scatterlist *dest_sg,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct =
scatterlist *src_sg, int size,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigne=
d char *iv)
>> > =A0{
>> > - =A0 =A0 struct blkcipher_desc desc =3D {
>> > - =A0 =A0 =A0 =A0 =A0 =A0 .tfm =3D crypt_stat->tfm,
>> > - =A0 =A0 =A0 =A0 =A0 =A0 .info =3D iv,
>> > - =A0 =A0 =A0 =A0 =A0 =A0 .flags =3D CRYPTO_TFM_REQ_MAY_SLEEP
>> > - =A0 =A0 };
>> > =A0 =A0 =A0 int rc =3D 0;
>> > -
>> > + =A0 =A0 BUG_ON(!crypt_stat || !crypt_stat->tfm
>> > + =A0 =A0 =A0 =A0 =A0 =A0|| !(crypt_stat->flags & ECRYPTFS_STRUCT_=
INITIALIZED));
>> > =A0 =A0 =A0 /* Consider doing this once, when the file is opened *=
/
>> > =A0 =A0 =A0 mutex_lock(&crypt_stat->cs_tfm_mutex);
>> > - =A0 =A0 rc =3D crypto_blkcipher_setkey(crypt_stat->tfm, crypt_st=
at->key,
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0crypt_stat->key_size);
>> > - =A0 =A0 if (rc) {
>> > - =A0 =A0 =A0 =A0 =A0 =A0 ecryptfs_printk(KERN_ERR, "Error setting=
 key; rc =3D [%d]\n",
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc);
>> > - =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&crypt_stat->cs_tfm_mutex);
>> > - =A0 =A0 =A0 =A0 =A0 =A0 rc =3D -EINVAL;
>> > - =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> > + =A0 =A0 if (!(crypt_stat->flags & ECRYPTFS_KEY_SET)) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 rc =3D crypto_ablkcipher_setkey(crypt_st=
at->tfm, crypt_stat->key,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 crypt_stat->key_size);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 if (rc) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ecryptfs_printk(KERN_ERR=
,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 "Error setting key; rc =3D [%d]\n",
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 rc);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&crypt_stat=
->cs_tfm_mutex);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D -EINVAL;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 }
>> > + =A0 =A0 =A0 =A0 =A0 =A0 crypt_stat->flags |=3D ECRYPTFS_KEY_SET;
>> > =A0 =A0 =A0 }
>> > - =A0 =A0 ecryptfs_printk(KERN_DEBUG, "Decrypting [%d] bytes.\n", =
size);
>> > - =A0 =A0 rc =3D crypto_blkcipher_decrypt_iv(&desc, dest_sg, src_s=
g, size);
>> > =A0 =A0 =A0 mutex_unlock(&crypt_stat->cs_tfm_mutex);
>> > - =A0 =A0 if (rc) {
>> > - =A0 =A0 =A0 =A0 =A0 =A0 ecryptfs_printk(KERN_ERR, "Error decrypt=
ing; rc =3D [%d]\n",
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc);
>> > - =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> > - =A0 =A0 }
>> > - =A0 =A0 rc =3D size;
>> > + =A0 =A0 ecryptfs_printk(KERN_DEBUG, "Decrypting [%d] bytes.\n", =
size);
>> > + =A0 =A0 ablkcipher_request_set_crypt(req, src_sg, dest_sg, size,=
 iv);
>> > + =A0 =A0 rc =3D crypto_ablkcipher_decrypt(req);
>> > =A0out:
>> > =A0 =A0 =A0 return rc;
>> > =A0}
>> >
>> > =A0/**
>> > =A0 * ecryptfs_encrypt_page_offset
>> > - * @crypt_stat: The cryptographic context
>> > + * @extent_crypt_req: Crypt request that describes the extent tha=
t needs to be
>> > + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0encrypted
>> > =A0 * @dst_page: The page to encrypt into
>> > =A0 * @dst_offset: The offset in the page to encrypt into
>> > =A0 * @src_page: The page to encrypt from
>> > =A0 * @src_offset: The offset in the page to encrypt from
>> > =A0 * @size: The number of bytes to encrypt
>> > - * @iv: The initialization vector to use for the encryption
>> > =A0 *
>> > - * Returns the number of bytes encrypted
>> > + * Returns zero if the encryption started successfully, else non-=
zero.
>> > + * Encryption status is returned in the completion routine.
>> > =A0 */
>> > =A0static int
>> > -ecryptfs_encrypt_page_offset(struct ecryptfs_crypt_stat *crypt_st=
at,
>> > +ecryptfs_encrypt_page_offset(struct ecryptfs_extent_crypt_req *ex=
tent_crypt_req,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct page=
 *dst_page, int dst_offset,
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct page *=
src_page, int src_offset, int size,
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned char=
 *iv)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct page *=
src_page, int src_offset, int size)
>> > =A0{
>> > - =A0 =A0 struct scatterlist src_sg, dst_sg;
>> > -
>> > - =A0 =A0 sg_init_table(&src_sg, 1);
>> > - =A0 =A0 sg_init_table(&dst_sg, 1);
>> > -
>> > - =A0 =A0 sg_set_page(&src_sg, src_page, size, src_offset);
>> > - =A0 =A0 sg_set_page(&dst_sg, dst_page, size, dst_offset);
>> > - =A0 =A0 return encrypt_scatterlist(crypt_stat, &dst_sg, &src_sg,=
 size, iv);
>> > + =A0 =A0 sg_init_table(&extent_crypt_req->src_sg, 1);
>> > + =A0 =A0 sg_init_table(&extent_crypt_req->dst_sg, 1);
>> > +
>> > + =A0 =A0 sg_set_page(&extent_crypt_req->src_sg, src_page, size, s=
rc_offset);
>> > + =A0 =A0 sg_set_page(&extent_crypt_req->dst_sg, dst_page, size, d=
st_offset);
>> > + =A0 =A0 return encrypt_scatterlist(extent_crypt_req->crypt_stat,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0e=
xtent_crypt_req->req,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&=
extent_crypt_req->dst_sg,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&=
extent_crypt_req->src_sg,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s=
ize,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0e=
xtent_crypt_req->extent_iv);
>> > =A0}
>> >
>> > =A0/**
>> > =A0 * ecryptfs_decrypt_page_offset
>> > - * @crypt_stat: The cryptographic context
>> > + * @extent_crypt_req: Crypt request that describes the extent tha=
t needs to be
>> > + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0decrypted
>> > =A0 * @dst_page: The page to decrypt into
>> > =A0 * @dst_offset: The offset in the page to decrypt into
>> > =A0 * @src_page: The page to decrypt from
>> > =A0 * @src_offset: The offset in the page to decrypt from
>> > =A0 * @size: The number of bytes to decrypt
>> > - * @iv: The initialization vector to use for the decryption
>> > =A0 *
>> > - * Returns the number of bytes decrypted
>> > + * Decryption status is returned in the completion routine.
>> > =A0 */
>> > =A0static int
>> > -ecryptfs_decrypt_page_offset(struct ecryptfs_crypt_stat *crypt_st=
at,
>> > +ecryptfs_decrypt_page_offset(struct ecryptfs_extent_crypt_req *ex=
tent_crypt_req,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct page=
 *dst_page, int dst_offset,
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct page *=
src_page, int src_offset, int size,
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned char=
 *iv)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct page *=
src_page, int src_offset, int size)
>> > =A0{
>> > - =A0 =A0 struct scatterlist src_sg, dst_sg;
>> > -
>> > - =A0 =A0 sg_init_table(&src_sg, 1);
>> > - =A0 =A0 sg_set_page(&src_sg, src_page, size, src_offset);
>> > -
>> > - =A0 =A0 sg_init_table(&dst_sg, 1);
>> > - =A0 =A0 sg_set_page(&dst_sg, dst_page, size, dst_offset);
>> > -
>> > - =A0 =A0 return decrypt_scatterlist(crypt_stat, &dst_sg, &src_sg,=
 size, iv);
>> > + =A0 =A0 sg_init_table(&extent_crypt_req->src_sg, 1);
>> > + =A0 =A0 sg_set_page(&extent_crypt_req->src_sg, src_page, size, s=
rc_offset);
>> > +
>> > + =A0 =A0 sg_init_table(&extent_crypt_req->dst_sg, 1);
>> > + =A0 =A0 sg_set_page(&extent_crypt_req->dst_sg, dst_page, size, d=
st_offset);
>> > +
>> > + =A0 =A0 return decrypt_scatterlist(extent_crypt_req->crypt_stat,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0e=
xtent_crypt_req->req,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&=
extent_crypt_req->dst_sg,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&=
extent_crypt_req->src_sg,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s=
ize,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0e=
xtent_crypt_req->extent_iv);
>> > =A0}
>> >
>> > =A0#define ECRYPTFS_MAX_SCATTERLIST_LEN 4
>> > @@ -749,8 +1102,7 @@ int ecryptfs_init_crypt_ctx(struct ecryptfs_c=
rypt_stat *crypt_stat)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 crypt_stat->cipher, "cbc");
>> > =A0 =A0 =A0 if (rc)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_unlock;
>> > - =A0 =A0 crypt_stat->tfm =3D crypto_alloc_blkcipher(full_alg_name=
, 0,
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0CRYPTO_ALG_ASYNC);
>> > + =A0 =A0 crypt_stat->tfm =3D crypto_alloc_ablkcipher(full_alg_nam=
e, 0, 0);
>> > =A0 =A0 =A0 kfree(full_alg_name);
>> > =A0 =A0 =A0 if (IS_ERR(crypt_stat->tfm)) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D PTR_ERR(crypt_stat->tfm);
>> > @@ -760,7 +1112,7 @@ int ecryptfs_init_crypt_ctx(struct ecryptfs_c=
rypt_stat *crypt_stat)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 crypt_=
stat->cipher);
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_unlock;
>> > =A0 =A0 =A0 }
>> > - =A0 =A0 crypto_blkcipher_set_flags(crypt_stat->tfm, CRYPTO_TFM_R=
EQ_WEAK_KEY);
>> > + =A0 =A0 crypto_ablkcipher_set_flags(crypt_stat->tfm, CRYPTO_TFM_=
REQ_WEAK_KEY);
>> > =A0 =A0 =A0 rc =3D 0;
>> > =A0out_unlock:
>> > =A0 =A0 =A0 mutex_unlock(&crypt_stat->cs_tfm_mutex);
>> > diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_=
kernel.h
>> > index 867b64c..1d3449e 100644
>> > --- a/fs/ecryptfs/ecryptfs_kernel.h
>> > +++ b/fs/ecryptfs/ecryptfs_kernel.h
>> > @@ -38,6 +38,7 @@
>> > =A0#include <linux/nsproxy.h>
>> > =A0#include <linux/backing-dev.h>
>> > =A0#include <linux/ecryptfs.h>
>> > +#include <linux/crypto.h>
>> >
>> > =A0#define ECRYPTFS_DEFAULT_IV_BYTES 16
>> > =A0#define ECRYPTFS_DEFAULT_EXTENT_SIZE 4096
>> > @@ -220,7 +221,7 @@ struct ecryptfs_crypt_stat {
>> > =A0 =A0 =A0 size_t extent_shift;
>> > =A0 =A0 =A0 unsigned int extent_mask;
>> > =A0 =A0 =A0 struct ecryptfs_mount_crypt_stat *mount_crypt_stat;
>> > - =A0 =A0 struct crypto_blkcipher *tfm;
>> > + =A0 =A0 struct crypto_ablkcipher *tfm;
>> > =A0 =A0 =A0 struct crypto_hash *hash_tfm; /* Crypto context for ge=
nerating
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0* the initialization vectors */
>> > =A0 =A0 =A0 unsigned char cipher[ECRYPTFS_MAX_CIPHER_NAME_SIZE];
>> > @@ -551,6 +552,8 @@ extern struct kmem_cache *ecryptfs_key_sig_cac=
he;
>> > =A0extern struct kmem_cache *ecryptfs_global_auth_tok_cache;
>> > =A0extern struct kmem_cache *ecryptfs_key_tfm_cache;
>> > =A0extern struct kmem_cache *ecryptfs_open_req_cache;
>> > +extern struct kmem_cache *ecryptfs_page_crypt_req_cache;
>> > +extern struct kmem_cache *ecryptfs_extent_crypt_req_cache;
>> >
>> > =A0struct ecryptfs_open_req {
>> > =A0#define ECRYPTFS_REQ_PROCESSED 0x00000001
>> > @@ -565,6 +568,30 @@ struct ecryptfs_open_req {
>> > =A0 =A0 =A0 struct list_head kthread_ctl_list;
>> > =A0};
>> >
>> > +struct ecryptfs_page_crypt_req;
>> > +typedef void (*page_crypt_completion)(
>> > + =A0 =A0 struct ecryptfs_page_crypt_req *page_crypt_req);
>> > +
>> > +struct ecryptfs_page_crypt_req {
>> > + =A0 =A0 struct page *page;
>> > + =A0 =A0 atomic_t num_refs;
>> > + =A0 =A0 atomic_t rc;
>> > + =A0 =A0 page_crypt_completion completion_func;
>> > + =A0 =A0 struct completion completion;
>> > +};
>> > +
>> > +struct ecryptfs_extent_crypt_req {
>> > + =A0 =A0 struct ecryptfs_page_crypt_req *page_crypt_req;
>> > + =A0 =A0 struct ablkcipher_request *req;
>> > + =A0 =A0 struct ecryptfs_crypt_stat *crypt_stat;
>> > + =A0 =A0 struct inode *inode;
>> > + =A0 =A0 struct page *enc_extent_page;
>> > + =A0 =A0 char extent_iv[ECRYPTFS_MAX_IV_BYTES];
>> > + =A0 =A0 unsigned long extent_offset;
>> > + =A0 =A0 struct scatterlist src_sg;
>> > + =A0 =A0 struct scatterlist dst_sg;
>> > +};
>> > +
>> > =A0struct inode *ecryptfs_get_inode(struct inode *lower_inode,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0str=
uct super_block *sb);
>> > =A0void ecryptfs_i_size_init(const char *page_virt, struct inode *=
inode);
>> > @@ -591,8 +618,17 @@ void ecryptfs_destroy_mount_crypt_stat(
>> > =A0 =A0 =A0 struct ecryptfs_mount_crypt_stat *mount_crypt_stat);
>> > =A0int ecryptfs_init_crypt_ctx(struct ecryptfs_crypt_stat *crypt_s=
tat);
>> > =A0int ecryptfs_write_inode_size_to_metadata(struct inode *ecryptf=
s_inode);
>> > +struct ecryptfs_page_crypt_req *ecryptfs_alloc_page_crypt_req(
>> > + =A0 =A0 struct page *page,
>> > + =A0 =A0 page_crypt_completion completion_func);
>> > +void ecryptfs_free_page_crypt_req(
>> > + =A0 =A0 struct ecryptfs_page_crypt_req *page_crypt_req);
>> > =A0int ecryptfs_encrypt_page(struct page *page);
>> > +void ecryptfs_encrypt_page_async(
>> > + =A0 =A0 struct ecryptfs_page_crypt_req *page_crypt_req);
>> > =A0int ecryptfs_decrypt_page(struct page *page);
>> > +void ecryptfs_decrypt_page_async(
>> > + =A0 =A0 struct ecryptfs_page_crypt_req *page_crypt_req);
>> > =A0int ecryptfs_write_metadata(struct dentry *ecryptfs_dentry,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct inode *=
ecryptfs_inode);
>> > =A0int ecryptfs_read_metadata(struct dentry *ecryptfs_dentry);
>> > diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
>> > index 6895493..58523b9 100644
>> > --- a/fs/ecryptfs/main.c
>> > +++ b/fs/ecryptfs/main.c
>> > @@ -687,6 +687,16 @@ static struct ecryptfs_cache_info {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "ecryptfs_open_req_cache",
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 .size =3D sizeof(struct ecryptfs_open_=
req),
>> > =A0 =A0 =A0 },
>> > + =A0 =A0 {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 .cache =3D &ecryptfs_page_crypt_req_cach=
e,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "ecryptfs_page_crypt_req_cache=
",
>> > + =A0 =A0 =A0 =A0 =A0 =A0 .size =3D sizeof(struct ecryptfs_page_cr=
ypt_req),
>> > + =A0 =A0 },
>> > + =A0 =A0 {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 .cache =3D &ecryptfs_extent_crypt_req_ca=
che,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "ecryptfs_extent_crypt_req_cac=
he",
>> > + =A0 =A0 =A0 =A0 =A0 =A0 .size =3D sizeof(struct ecryptfs_extent_=
crypt_req),
>> > + =A0 =A0 },
>> > =A0};
>> >
>> > =A0static void ecryptfs_free_kmem_caches(void)
>> > diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
>> > index a46b3a8..fdfd0df 100644
>> > --- a/fs/ecryptfs/mmap.c
>> > +++ b/fs/ecryptfs/mmap.c
>> > @@ -53,6 +53,31 @@ struct page *ecryptfs_get_locked_page(struct in=
ode *inode, loff_t index)
>> > =A0}
>> >
>> > =A0/**
>> > + * ecryptfs_writepage_complete
>> > + * @page_crypt_req: The encrypt page request that completed
>> > + *
>> > + * Calls when the requested page has been encrypted and written t=
o the lower
>> > + * file system.
>> > + */
>> > +static void ecryptfs_writepage_complete(
>> > + =A0 =A0 =A0 =A0 =A0 =A0 struct ecryptfs_page_crypt_req *page_cry=
pt_req)
>> > +{
>> > + =A0 =A0 struct page *page =3D page_crypt_req->page;
>> > + =A0 =A0 int rc;
>> > + =A0 =A0 rc =3D atomic_read(&page_crypt_req->rc);
>> > + =A0 =A0 if (unlikely(rc)) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 ecryptfs_printk(KERN_WARNING, "Error enc=
rypting "
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "page (u=
pper index [0x%.16lx])\n", page->index);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 ClearPageUptodate(page);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 SetPageError(page);
>> > + =A0 =A0 } else {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 SetPageUptodate(page);
>> > + =A0 =A0 }
>> > + =A0 =A0 end_page_writeback(page);
>> > + =A0 =A0 ecryptfs_free_page_crypt_req(page_crypt_req);
>> > +}
>> > +
>> > +/**
>> > =A0 * ecryptfs_writepage
>> > =A0 * @page: Page that is locked before this call is made
>> > =A0 *
>> > @@ -64,7 +89,8 @@ struct page *ecryptfs_get_locked_page(struct ino=
de *inode, loff_t index)
>> > =A0 */
>> > =A0static int ecryptfs_writepage(struct page *page, struct writeba=
ck_control *wbc)
>> > =A0{
>> > - =A0 =A0 int rc;
>> > + =A0 =A0 struct ecryptfs_page_crypt_req *page_crypt_req;
>> > + =A0 =A0 int rc =3D 0;
>> >
>> > =A0 =A0 =A0 /*
>> > =A0 =A0 =A0 =A0* Refuse to write the page out if we are called fro=
m reclaim context
>> > @@ -74,18 +100,20 @@ static int ecryptfs_writepage(struct page *pa=
ge, struct writeback_control *wbc)
>> > =A0 =A0 =A0 =A0*/
>> > =A0 =A0 =A0 if (current->flags & PF_MEMALLOC) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 redirty_page_for_writepage(wbc, page);
>> > - =A0 =A0 =A0 =A0 =A0 =A0 rc =3D 0;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> > =A0 =A0 =A0 }
>> >
>> > - =A0 =A0 rc =3D ecryptfs_encrypt_page(page);
>> > - =A0 =A0 if (rc) {
>> > - =A0 =A0 =A0 =A0 =A0 =A0 ecryptfs_printk(KERN_WARNING, "Error enc=
rypting "
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "page (u=
pper index [0x%.16lx])\n", page->index);
>> > - =A0 =A0 =A0 =A0 =A0 =A0 ClearPageUptodate(page);
>> > + =A0 =A0 page_crypt_req =3D ecryptfs_alloc_page_crypt_req(
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 page, ec=
ryptfs_writepage_complete);
>> > + =A0 =A0 if (unlikely(!page_crypt_req)) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 rc =3D -ENOMEM;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 ecryptfs_printk(KERN_ERR,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Failed =
to allocate page crypt request "
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "for enc=
ryption\n");
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> > =A0 =A0 =A0 }
>> > - =A0 =A0 SetPageUptodate(page);
>> > + =A0 =A0 set_page_writeback(page);
>> > + =A0 =A0 ecryptfs_encrypt_page_async(page_crypt_req);
>> > =A0out:
>> > =A0 =A0 =A0 unlock_page(page);
>> > =A0 =A0 =A0 return rc;
>> > @@ -195,6 +223,32 @@ out:
>> > =A0}
>> >
>> > =A0/**
>> > + * ecryptfs_readpage_complete
>> > + * @page_crypt_req: The decrypt page request that completed
>> > + *
>> > + * Calls when the requested page has been read and decrypted.
>> > + */
>> > +static void ecryptfs_readpage_complete(
>> > + =A0 =A0 =A0 =A0 =A0 =A0 struct ecryptfs_page_crypt_req *page_cry=
pt_req)
>> > +{
>> > + =A0 =A0 struct page *page =3D page_crypt_req->page;
>> > + =A0 =A0 int rc;
>> > + =A0 =A0 rc =3D atomic_read(&page_crypt_req->rc);
>> > + =A0 =A0 if (unlikely(rc)) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 ecryptfs_printk(KERN_ERR, "Error decrypt=
ing page; "
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "rc =3D =
[%d]\n", rc);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 ClearPageUptodate(page);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 SetPageError(page);
>> > + =A0 =A0 } else {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 SetPageUptodate(page);
>> > + =A0 =A0 }
>> > + =A0 =A0 ecryptfs_printk(KERN_DEBUG, "Unlocking page with index =3D=
 [0x%.16lx]\n",
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 page->index);
>> > + =A0 =A0 unlock_page(page);
>> > + =A0 =A0 ecryptfs_free_page_crypt_req(page_crypt_req);
>> > +}
>> > +
>> > +/**
>> > =A0 * ecryptfs_readpage
>> > =A0 * @file: An eCryptfs file
>> > =A0 * @page: Page from eCryptfs inode mapping into which to stick =
the read data
>> > @@ -207,6 +261,7 @@ static int ecryptfs_readpage(struct file *file=
, struct page *page)
>> > =A0{
>> > =A0 =A0 =A0 struct ecryptfs_crypt_stat *crypt_stat =3D
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 &ecryptfs_inode_to_private(page->mappi=
ng->host)->crypt_stat;
>> > + =A0 =A0 struct ecryptfs_page_crypt_req *page_crypt_req =3D NULL;
>> > =A0 =A0 =A0 int rc =3D 0;
>> >
>> > =A0 =A0 =A0 if (!crypt_stat || !(crypt_stat->flags & ECRYPTFS_ENCR=
YPTED)) {
>> > @@ -237,21 +292,27 @@ static int ecryptfs_readpage(struct file *fi=
le, struct page *page)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> > =A0 =A0 =A0 } else {
>> > - =A0 =A0 =A0 =A0 =A0 =A0 rc =3D ecryptfs_decrypt_page(page);
>> > - =A0 =A0 =A0 =A0 =A0 =A0 if (rc) {
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ecryptfs_printk(KERN_ERR=
, "Error decrypting page; "
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 "rc =3D [%d]\n", rc);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 page_crypt_req =3D ecryptfs_alloc_page_c=
rypt_req(
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 page, ecryptfs_readpage_complete);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 if (!page_crypt_req) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D -ENOMEM;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ecryptfs_printk(KERN_ERR=
,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 "Failed to allocate page crypt request "
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 "for decryption\n");
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> > + =A0 =A0 =A0 =A0 =A0 =A0 ecryptfs_decrypt_page_async(page_crypt_r=
eq);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 goto out_async_started;
>> > =A0 =A0 =A0 }
>> > =A0out:
>> > - =A0 =A0 if (rc)
>> > + =A0 =A0 if (unlikely(rc))
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 ClearPageUptodate(page);
>> > =A0 =A0 =A0 else
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 SetPageUptodate(page);
>> > =A0 =A0 =A0 ecryptfs_printk(KERN_DEBUG, "Unlocking page with index=
 =3D [0x%.16lx]\n",
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 page->index);
>> > =A0 =A0 =A0 unlock_page(page);
>> > +out_async_started:
>> > =A0 =A0 =A0 return rc;
>> > =A0}
>> >
>> > --
>> > 1.7.9.5
>> >
>
>
