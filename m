From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH 1/1] ecryptfs: Migrate to ablkcipher API
Date: Wed, 13 Jun 2012 09:11:25 -0700
Message-ID: <20120613161124.GB21062@boyd>
References: <1339589670-12189-1-git-send-email-colin.king@canonical.com>
 <1339589670-12189-2-git-send-email-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gatW/ieO32f1wygP"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:57687 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754433Ab2FMQLc (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Wed, 13 Jun 2012 12:11:32 -0400
Content-Disposition: inline
In-Reply-To: <1339589670-12189-2-git-send-email-colin.king@canonical.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Thieu Le <thieule@google.com>
Cc: ecryptfs@vger.kernel.org, Colin King <colin.king@canonical.com>


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2012-06-13 13:14:30, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> Forward port of Thieu Le's patch from 2.6.39.
>=20
> Using ablkcipher allows eCryptfs to take full advantage of hardware
> crypto.
>=20
> Change-Id: I94a6e50a8d576bf79cf73732c7b4c75629b5d40c
>=20
> Signed-off-by: Thieu Le <thieule@chromium.org>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  fs/ecryptfs/crypto.c          |  678 +++++++++++++++++++++++++++++++----=
------
>  fs/ecryptfs/ecryptfs_kernel.h |   38 ++-
>  fs/ecryptfs/main.c            |   10 +
>  fs/ecryptfs/mmap.c            |   87 +++++-
>  4 files changed, 636 insertions(+), 177 deletions(-)
>=20
> diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
> index ea99312..7f5ff05 100644
> --- a/fs/ecryptfs/crypto.c
> +++ b/fs/ecryptfs/crypto.c
> @@ -37,16 +37,17 @@
>  #include <asm/unaligned.h>
>  #include "ecryptfs_kernel.h"
> =20
> +struct kmem_cache *ecryptfs_page_crypt_req_cache;
> +struct kmem_cache *ecryptfs_extent_crypt_req_cache;
> +
>  static int
> -ecryptfs_decrypt_page_offset(struct ecryptfs_crypt_stat *crypt_stat,
> +ecryptfs_decrypt_page_offset(struct ecryptfs_extent_crypt_req *extent_cr=
ypt_req,
>  			     struct page *dst_page, int dst_offset,
> -			     struct page *src_page, int src_offset, int size,
> -			     unsigned char *iv);
> +			     struct page *src_page, int src_offset, int size);
>  static int
> -ecryptfs_encrypt_page_offset(struct ecryptfs_crypt_stat *crypt_stat,
> +ecryptfs_encrypt_page_offset(struct ecryptfs_extent_crypt_req *extent_cr=
ypt_req,
>  			     struct page *dst_page, int dst_offset,
> -			     struct page *src_page, int src_offset, int size,
> -			     unsigned char *iv);
> +			     struct page *src_page, int src_offset, int size);
> =20
>  /**
>   * ecryptfs_to_hex
> @@ -166,6 +167,120 @@ out:
>  }
> =20
>  /**
> + * ecryptfs_alloc_page_crypt_req - allocates a page crypt request
> + * @page: Page mapped from the eCryptfs inode for the file
> + * @completion: Function that is called when the page crypt request comp=
letes.
> + *              If this parameter is NULL, then the the
> + *              page_crypt_completion::completion member is used to indi=
cate
> + *              the operation completion.
> + *
> + * Allocates a crypt request that is used for asynchronous page encrypt =
and
> + * decrypt operations.
> + */
> +struct ecryptfs_page_crypt_req *ecryptfs_alloc_page_crypt_req(
> +	struct page *page,
> +	page_crypt_completion completion_func)
> +{
> +	struct ecryptfs_page_crypt_req *page_crypt_req;
> +	page_crypt_req =3D kmem_cache_zalloc(ecryptfs_page_crypt_req_cache,
> +					   GFP_KERNEL);
> +	if (!page_crypt_req)
> +		goto out;
> +	page_crypt_req->page =3D page;
> +	page_crypt_req->completion_func =3D completion_func;
> +	if (!completion_func)
> +		init_completion(&page_crypt_req->completion);
> +out:
> +	return page_crypt_req;
> +}

Hey Thieu - Can you explain the reasoning for the page_crypt_req? The
reason for the extent_crypt_req is obvious, but it seems to me that the
page_crypt_req just adds an unneeded layer of indirection.

ecryptfs_encrypt_page_async() could return an int indicating success or
failure and then the callers could handle the return status as needed.
No need for the page_crypt_req, special completion functions, etc.

The only reason I could see page_crypt_req helping performance is if we
implemented ecryptfs_writepages() and ecryptfs_readpages().


Which leads into another question... I'm having a hard time
understanding _how_ this patch improves performance. I haven't went
through the crypto api code to really understand what the async
interface does differently, so I'm hoping that you can explain.

We were submitting an extent to the kernel crypto api and the crypto api
call would return when the crypto operation was completed. Now we're
asynchronously submitting an extent to the kernel crypto api, the crypto
api call immediately returns, but then we wait on the crypto operation
to complete. It seems like we're doing the same thing but just using a
different interface. Colin's test results prove that it greatly helps
performance, but I'd like to better understand why.

Thanks!

Tyler

> +
> +/**
> + * ecryptfs_free_page_crypt_req - deallocates a page crypt request
> + * @page_crypt_req: Request to deallocate
> + *
> + * Deallocates a page crypt request.  This request must have been
> + * previously allocated by ecryptfs_alloc_page_crypt_req().
> + */
> +void ecryptfs_free_page_crypt_req(
> +	struct ecryptfs_page_crypt_req *page_crypt_req)
> +{
> +	kmem_cache_free(ecryptfs_page_crypt_req_cache, page_crypt_req);
> +}
> +
> +/**
> + * ecryptfs_complete_page_crypt_req - completes a page crypt request
> + * @page_crypt_req: Request to complete
> + *
> + * Completes the specified page crypt request by either invoking the
> + * completion callback if one is present, or use the completion data str=
ucture.
> + */
> +static void ecryptfs_complete_page_crypt_req(
> +		struct ecryptfs_page_crypt_req *page_crypt_req)
> +{
> +	if (page_crypt_req->completion_func)
> +		page_crypt_req->completion_func(page_crypt_req);
> +	else
> +		complete(&page_crypt_req->completion);
> +}
> +
> +/**
> + * ecryptfs_alloc_extent_crypt_req - allocates an extent crypt request
> + * @page_crypt_req: Pointer to the page crypt request that owns this ext=
ent
> + *                  request
> + * @crypt_stat: Pointer to crypt_stat struct for the current inode
> + *
> + * Allocates a crypt request that is used for asynchronous extent encryp=
t and
> + * decrypt operations.
> + */
> +static struct ecryptfs_extent_crypt_req *ecryptfs_alloc_extent_crypt_req(
> +		struct ecryptfs_page_crypt_req *page_crypt_req,
> +		struct ecryptfs_crypt_stat *crypt_stat)
> +{
> +	struct ecryptfs_extent_crypt_req *extent_crypt_req;
> +	extent_crypt_req =3D kmem_cache_zalloc(ecryptfs_extent_crypt_req_cache,
> +					     GFP_KERNEL);
> +	if (!extent_crypt_req)
> +		goto out;
> +	extent_crypt_req->req =3D
> +		ablkcipher_request_alloc(crypt_stat->tfm, GFP_KERNEL);
> +	if (!extent_crypt_req) {
> +		kmem_cache_free(ecryptfs_extent_crypt_req_cache,
> +				extent_crypt_req);
> +		extent_crypt_req =3D NULL;
> +		goto out;
> +	}
> +	atomic_inc(&page_crypt_req->num_refs);
> +	extent_crypt_req->page_crypt_req =3D page_crypt_req;
> +	extent_crypt_req->crypt_stat =3D crypt_stat;
> +	ablkcipher_request_set_tfm(extent_crypt_req->req, crypt_stat->tfm);
> +out:
> +	return extent_crypt_req;
> +}
> +
> +/**
> + * ecryptfs_free_extent_crypt_req - deallocates an extent crypt request
> + * @extent_crypt_req: Request to deallocate
> + *
> + * Deallocates an extent crypt request.  This request must have been
> + * previously allocated by ecryptfs_alloc_extent_crypt_req().
> + * If the extent crypt is the last operation for the page crypt request,
> + * this function calls the page crypt completion function.
> + */
> +static void ecryptfs_free_extent_crypt_req(
> +		struct ecryptfs_extent_crypt_req *extent_crypt_req)
> +{
> +	int num_refs;
> +	struct ecryptfs_page_crypt_req *page_crypt_req =3D
> +			extent_crypt_req->page_crypt_req;
> +	BUG_ON(!page_crypt_req);
> +	num_refs =3D atomic_dec_return(&page_crypt_req->num_refs);
> +	if (!num_refs)
> +		ecryptfs_complete_page_crypt_req(page_crypt_req);
> +	ablkcipher_request_free(extent_crypt_req->req);
> +	kmem_cache_free(ecryptfs_extent_crypt_req_cache, extent_crypt_req);
> +}
> +
> +/**
>   * ecryptfs_derive_iv
>   * @iv: destination for the derived iv vale
>   * @crypt_stat: Pointer to crypt_stat struct for the current inode
> @@ -243,7 +358,7 @@ void ecryptfs_destroy_crypt_stat(struct ecryptfs_cryp=
t_stat *crypt_stat)
>  	struct ecryptfs_key_sig *key_sig, *key_sig_tmp;
> =20
>  	if (crypt_stat->tfm)
> -		crypto_free_blkcipher(crypt_stat->tfm);
> +		crypto_free_ablkcipher(crypt_stat->tfm);
>  	if (crypt_stat->hash_tfm)
>  		crypto_free_hash(crypt_stat->hash_tfm);
>  	list_for_each_entry_safe(key_sig, key_sig_tmp,
> @@ -324,26 +439,23 @@ int virt_to_scatterlist(const void *addr, int size,=
 struct scatterlist *sg,
> =20
>  /**
>   * encrypt_scatterlist
> - * @crypt_stat: Pointer to the crypt_stat struct to initialize.
> + * @crypt_stat: Cryptographic context
> + * @req: Async blkcipher request
>   * @dest_sg: Destination of encrypted data
>   * @src_sg: Data to be encrypted
>   * @size: Length of data to be encrypted
>   * @iv: iv to use during encryption
>   *
> - * Returns the number of bytes encrypted; negative value on error
> + * Returns zero if the encryption request was started successfully, else
> + * non-zero.
>   */
>  static int encrypt_scatterlist(struct ecryptfs_crypt_stat *crypt_stat,
> +			       struct ablkcipher_request *req,
>  			       struct scatterlist *dest_sg,
>  			       struct scatterlist *src_sg, int size,
>  			       unsigned char *iv)
>  {
> -	struct blkcipher_desc desc =3D {
> -		.tfm =3D crypt_stat->tfm,
> -		.info =3D iv,
> -		.flags =3D CRYPTO_TFM_REQ_MAY_SLEEP
> -	};
>  	int rc =3D 0;
> -
>  	BUG_ON(!crypt_stat || !crypt_stat->tfm
>  	       || !(crypt_stat->flags & ECRYPTFS_STRUCT_INITIALIZED));
>  	if (unlikely(ecryptfs_verbosity > 0)) {
> @@ -355,20 +467,22 @@ static int encrypt_scatterlist(struct ecryptfs_cryp=
t_stat *crypt_stat,
>  	/* Consider doing this once, when the file is opened */
>  	mutex_lock(&crypt_stat->cs_tfm_mutex);
>  	if (!(crypt_stat->flags & ECRYPTFS_KEY_SET)) {
> -		rc =3D crypto_blkcipher_setkey(crypt_stat->tfm, crypt_stat->key,
> -					     crypt_stat->key_size);
> +		rc =3D crypto_ablkcipher_setkey(crypt_stat->tfm, crypt_stat->key,
> +					      crypt_stat->key_size);
> +		if (rc) {
> +			ecryptfs_printk(KERN_ERR,
> +					"Error setting key; rc =3D [%d]\n",
> +					rc);
> +			mutex_unlock(&crypt_stat->cs_tfm_mutex);
> +			rc =3D -EINVAL;
> +			goto out;
> +		}
>  		crypt_stat->flags |=3D ECRYPTFS_KEY_SET;
>  	}
> -	if (rc) {
> -		ecryptfs_printk(KERN_ERR, "Error setting key; rc =3D [%d]\n",
> -				rc);
> -		mutex_unlock(&crypt_stat->cs_tfm_mutex);
> -		rc =3D -EINVAL;
> -		goto out;
> -	}
> -	ecryptfs_printk(KERN_DEBUG, "Encrypting [%d] bytes.\n", size);
> -	crypto_blkcipher_encrypt_iv(&desc, dest_sg, src_sg, size);
>  	mutex_unlock(&crypt_stat->cs_tfm_mutex);
> +	ecryptfs_printk(KERN_DEBUG, "Encrypting [%d] bytes.\n", size);
> +	ablkcipher_request_set_crypt(req, src_sg, dest_sg, size, iv);
> +	rc =3D crypto_ablkcipher_encrypt(req);
>  out:
>  	return rc;
>  }
> @@ -387,24 +501,26 @@ static void ecryptfs_lower_offset_for_extent(loff_t=
 *offset, loff_t extent_num,
> =20
>  /**
>   * ecryptfs_encrypt_extent
> - * @enc_extent_page: Allocated page into which to encrypt the data in
> - *                   @page
> - * @crypt_stat: crypt_stat containing cryptographic context for the
> - *              encryption operation
> - * @page: Page containing plaintext data extent to encrypt
> - * @extent_offset: Page extent offset for use in generating IV
> + * @extent_crypt_req: Crypt request that describes the extent that needs=
 to be
> + *                    encrypted
> + * @completion: Function that is called back when the encryption is comp=
leted
>   *
>   * Encrypts one extent of data.
>   *
> - * Return zero on success; non-zero otherwise
> + * Status code is returned in the completion routine (zero on success;
> + * non-zero otherwise).
>   */
> -static int ecryptfs_encrypt_extent(struct page *enc_extent_page,
> -				   struct ecryptfs_crypt_stat *crypt_stat,
> -				   struct page *page,
> -				   unsigned long extent_offset)
> +static void ecryptfs_encrypt_extent(
> +		struct ecryptfs_extent_crypt_req *extent_crypt_req,
> +		crypto_completion_t completion)
>  {
> +	struct page *enc_extent_page =3D extent_crypt_req->enc_extent_page;
> +	struct ecryptfs_crypt_stat *crypt_stat =3D extent_crypt_req->crypt_stat;
> +	struct page *page =3D extent_crypt_req->page_crypt_req->page;
> +	unsigned long extent_offset =3D extent_crypt_req->extent_offset;
> +
>  	loff_t extent_base;
> -	char extent_iv[ECRYPTFS_MAX_IV_BYTES];
> +	char *extent_iv =3D extent_crypt_req->extent_iv;
>  	int rc;
> =20
>  	extent_base =3D (((loff_t)page->index)
> @@ -417,11 +533,20 @@ static int ecryptfs_encrypt_extent(struct page *enc=
_extent_page,
>  			(unsigned long long)(extent_base + extent_offset), rc);
>  		goto out;
>  	}
> -	rc =3D ecryptfs_encrypt_page_offset(crypt_stat, enc_extent_page, 0,
> +	ablkcipher_request_set_callback(extent_crypt_req->req,
> +					CRYPTO_TFM_REQ_MAY_BACKLOG |
> +					CRYPTO_TFM_REQ_MAY_SLEEP,
> +					completion, extent_crypt_req);
> +	rc =3D ecryptfs_encrypt_page_offset(extent_crypt_req, enc_extent_page, =
0,
>  					  page, (extent_offset
>  						 * crypt_stat->extent_size),
> -					  crypt_stat->extent_size, extent_iv);
> -	if (rc < 0) {
> +					  crypt_stat->extent_size);
> +	if (!rc) {
> +		/* Request completed synchronously */
> +		struct crypto_async_request dummy;
> +		dummy.data =3D extent_crypt_req;
> +		completion(&dummy, rc);
> +	} else if (rc !=3D -EBUSY && rc !=3D -EINPROGRESS) {
>  		printk(KERN_ERR "%s: Error attempting to encrypt page with "
>  		       "page->index =3D [%ld], extent_offset =3D [%ld]; "
>  		       "rc =3D [%d]\n", __func__, page->index, extent_offset,
> @@ -430,32 +555,107 @@ static int ecryptfs_encrypt_extent(struct page *en=
c_extent_page,
>  	}
>  	rc =3D 0;
>  out:
> -	return rc;
> +	if (rc) {
> +		struct crypto_async_request dummy;
> +		dummy.data =3D extent_crypt_req;
> +		completion(&dummy, rc);
> +	}
>  }
> =20
>  /**
> - * ecryptfs_encrypt_page
> - * @page: Page mapped from the eCryptfs inode for the file; contains
> - *        decrypted content that needs to be encrypted (to a temporary
> - *        page; not in place) and written out to the lower file
> + * ecryptfs_encrypt_extent_done
> + * @req: The original extent encrypt request
> + * @err: Result of the encryption operation
> + *
> + * This function is called when the extent encryption is completed.
> + */
> +static void ecryptfs_encrypt_extent_done(
> +		struct crypto_async_request *req,
> +		int err)
> +{
> +	struct ecryptfs_extent_crypt_req *extent_crypt_req =3D req->data;
> +	struct ecryptfs_page_crypt_req *page_crypt_req =3D
> +				extent_crypt_req->page_crypt_req;
> +	char *enc_extent_virt =3D NULL;
> +	struct page *page =3D page_crypt_req->page;
> +	struct page *enc_extent_page =3D extent_crypt_req->enc_extent_page;
> +	struct ecryptfs_crypt_stat *crypt_stat =3D extent_crypt_req->crypt_stat;
> +	loff_t extent_base;
> +	unsigned long extent_offset =3D extent_crypt_req->extent_offset;
> +	loff_t offset;
> +	int rc =3D 0;
> +
> +	if (!err && unlikely(ecryptfs_verbosity > 0)) {
> +		extent_base =3D (((loff_t)page->index)
> +			       * (PAGE_CACHE_SIZE / crypt_stat->extent_size));
> +		ecryptfs_printk(KERN_DEBUG, "Encrypt extent [0x%.16llx]; "
> +				"rc =3D [%d]\n",
> +				(unsigned long long)(extent_base +
> +						     extent_offset),
> +				err);
> +		ecryptfs_printk(KERN_DEBUG, "First 8 bytes after "
> +				"encryption:\n");
> +		ecryptfs_dump_hex((char *)(page_address(enc_extent_page)), 8);
> +	} else if (err) {
> +		atomic_set(&page_crypt_req->rc, err);
> +		printk(KERN_ERR "%s: Error encrypting extent; "
> +		       "rc =3D [%d]\n", __func__, err);
> +		goto out;
> +	}
> +
> +	enc_extent_virt =3D kmap(enc_extent_page);
> +	ecryptfs_lower_offset_for_extent(
> +		&offset,
> +		((((loff_t)page->index)
> +		  * (PAGE_CACHE_SIZE
> +		     / extent_crypt_req->crypt_stat->extent_size))
> +		    + extent_crypt_req->extent_offset),
> +		extent_crypt_req->crypt_stat);
> +	rc =3D ecryptfs_write_lower(extent_crypt_req->inode, enc_extent_virt,
> +				  offset,
> +				  extent_crypt_req->crypt_stat->extent_size);
> +	if (rc < 0) {
> +		atomic_set(&page_crypt_req->rc, rc);
> +		ecryptfs_printk(KERN_ERR, "Error attempting "
> +				"to write lower page; rc =3D [%d]"
> +				"\n", rc);
> +		goto out;
> +	}
> +out:
> +	if (enc_extent_virt)
> +		kunmap(enc_extent_page);
> +	__free_page(enc_extent_page);
> +	ecryptfs_free_extent_crypt_req(extent_crypt_req);
> +}
> +
> +/**
> + * ecryptfs_encrypt_page_async
> + * @page_crypt_req: Page level encryption request which contains the page
> + *                  mapped from the eCryptfs inode for the file; the page
> + *                  contains decrypted content that needs to be encrypted
> + *                  (to a temporary page; not in place) and written out =
to
> + *                  the lower file
>   *
> - * Encrypt an eCryptfs page. This is done on a per-extent basis. Note
> - * that eCryptfs pages may straddle the lower pages -- for instance,
> - * if the file was created on a machine with an 8K page size
> - * (resulting in an 8K header), and then the file is copied onto a
> - * host with a 32K page size, then when reading page 0 of the eCryptfs
> + * Function that asynchronously encrypts an eCryptfs page.
> + * This is done on a per-extent basis.  Note that eCryptfs pages may str=
addle
> + * the lower pages -- for instance, if the file was created on a machine=
 with
> + * an 8K page size (resulting in an 8K header), and then the file is cop=
ied
> + * onto a host with a 32K page size, then when reading page 0 of the eCr=
yptfs
>   * file, 24K of page 0 of the lower file will be read and decrypted,
>   * and then 8K of page 1 of the lower file will be read and decrypted.
>   *
> - * Returns zero on success; negative on error
> + * Status code is returned in the completion routine (zero on success;
> + * negative on error).
>   */
> -int ecryptfs_encrypt_page(struct page *page)
> +void ecryptfs_encrypt_page_async(
> +	struct ecryptfs_page_crypt_req *page_crypt_req)
>  {
> +	struct page *page =3D page_crypt_req->page;
>  	struct inode *ecryptfs_inode;
>  	struct ecryptfs_crypt_stat *crypt_stat;
> -	char *enc_extent_virt;
>  	struct page *enc_extent_page =3D NULL;
> -	loff_t extent_offset;
> +	struct ecryptfs_extent_crypt_req *extent_crypt_req =3D NULL;
> +	loff_t extent_offset =3D 0;
>  	int rc =3D 0;
> =20
>  	ecryptfs_inode =3D page->mapping->host;
> @@ -469,49 +669,94 @@ int ecryptfs_encrypt_page(struct page *page)
>  				"encrypted extent\n");
>  		goto out;
>  	}
> -	enc_extent_virt =3D kmap(enc_extent_page);
>  	for (extent_offset =3D 0;
>  	     extent_offset < (PAGE_CACHE_SIZE / crypt_stat->extent_size);
>  	     extent_offset++) {
> -		loff_t offset;
> -
> -		rc =3D ecryptfs_encrypt_extent(enc_extent_page, crypt_stat, page,
> -					     extent_offset);
> -		if (rc) {
> -			printk(KERN_ERR "%s: Error encrypting extent; "
> -			       "rc =3D [%d]\n", __func__, rc);
> -			goto out;
> -		}
> -		ecryptfs_lower_offset_for_extent(
> -			&offset, ((((loff_t)page->index)
> -				   * (PAGE_CACHE_SIZE
> -				      / crypt_stat->extent_size))
> -				  + extent_offset), crypt_stat);
> -		rc =3D ecryptfs_write_lower(ecryptfs_inode, enc_extent_virt,
> -					  offset, crypt_stat->extent_size);
> -		if (rc < 0) {
> -			ecryptfs_printk(KERN_ERR, "Error attempting "
> -					"to write lower page; rc =3D [%d]"
> -					"\n", rc);
> +		extent_crypt_req =3D ecryptfs_alloc_extent_crypt_req(
> +					page_crypt_req, crypt_stat);
> +		if (!extent_crypt_req) {
> +			rc =3D -ENOMEM;
> +			ecryptfs_printk(KERN_ERR,
> +					"Failed to allocate extent crypt "
> +					"request for encryption\n");
>  			goto out;
>  		}
> +		extent_crypt_req->inode =3D ecryptfs_inode;
> +		extent_crypt_req->enc_extent_page =3D enc_extent_page;
> +		extent_crypt_req->extent_offset =3D extent_offset;
> +
> +		/* Error handling is done in the completion routine. */
> +		ecryptfs_encrypt_extent(extent_crypt_req,
> +					ecryptfs_encrypt_extent_done);
>  	}
>  	rc =3D 0;
>  out:
> -	if (enc_extent_page) {
> -		kunmap(enc_extent_page);
> -		__free_page(enc_extent_page);
> +	/* Only call the completion routine if we did not fire off any extent
> +	 * encryption requests.  If at least one call to
> +	 * ecryptfs_encrypt_extent succeeded, it will call the completion
> +	 * routine.
> +	 */
> +	if (rc && extent_offset =3D=3D 0) {
> +		if (enc_extent_page)
> +			__free_page(enc_extent_page);
> +		atomic_set(&page_crypt_req->rc, rc);
> +		ecryptfs_complete_page_crypt_req(page_crypt_req);
>  	}
> +}
> +
> +/**
> + * ecryptfs_encrypt_page
> + * @page: Page mapped from the eCryptfs inode for the file; contains
> + *        decrypted content that needs to be encrypted (to a temporary
> + *        page; not in place) and written out to the lower file
> + *
> + * Encrypts an eCryptfs page synchronously.
> + *
> + * Returns zero on success; negative on error
> + */
> +int ecryptfs_encrypt_page(struct page *page)
> +{
> +	struct ecryptfs_page_crypt_req *page_crypt_req;
> +	int rc;
> +
> +	page_crypt_req =3D ecryptfs_alloc_page_crypt_req(page, NULL);
> +	if (!page_crypt_req) {
> +		rc =3D -ENOMEM;
> +		ecryptfs_printk(KERN_ERR,
> +				"Failed to allocate page crypt request "
> +				"for encryption\n");
> +		goto out;
> +	}
> +	ecryptfs_encrypt_page_async(page_crypt_req);
> +	wait_for_completion(&page_crypt_req->completion);
> +	rc =3D atomic_read(&page_crypt_req->rc);
> +out:
> +	if (page_crypt_req)
> +		ecryptfs_free_page_crypt_req(page_crypt_req);
>  	return rc;
>  }
> =20
> -static int ecryptfs_decrypt_extent(struct page *page,
> -				   struct ecryptfs_crypt_stat *crypt_stat,
> -				   struct page *enc_extent_page,
> -				   unsigned long extent_offset)
> +/**
> + * ecryptfs_decrypt_extent
> + * @extent_crypt_req: Crypt request that describes the extent that needs=
 to be
> + *                    decrypted
> + * @completion: Function that is called back when the decryption is comp=
leted
> + *
> + * Decrypts one extent of data.
> + *
> + * Status code is returned in the completion routine (zero on success;
> + * non-zero otherwise).
> + */
> +static void ecryptfs_decrypt_extent(
> +		struct ecryptfs_extent_crypt_req *extent_crypt_req,
> +		crypto_completion_t completion)
>  {
> +	struct ecryptfs_crypt_stat *crypt_stat =3D extent_crypt_req->crypt_stat;
> +	struct page *page =3D extent_crypt_req->page_crypt_req->page;
> +	struct page *enc_extent_page =3D extent_crypt_req->enc_extent_page;
> +	unsigned long extent_offset =3D extent_crypt_req->extent_offset;
>  	loff_t extent_base;
> -	char extent_iv[ECRYPTFS_MAX_IV_BYTES];
> +	char *extent_iv =3D extent_crypt_req->extent_iv;
>  	int rc;
> =20
>  	extent_base =3D (((loff_t)page->index)
> @@ -524,12 +769,21 @@ static int ecryptfs_decrypt_extent(struct page *pag=
e,
>  			(unsigned long long)(extent_base + extent_offset), rc);
>  		goto out;
>  	}
> -	rc =3D ecryptfs_decrypt_page_offset(crypt_stat, page,
> +	ablkcipher_request_set_callback(extent_crypt_req->req,
> +					CRYPTO_TFM_REQ_MAY_BACKLOG |
> +					CRYPTO_TFM_REQ_MAY_SLEEP,
> +					completion, extent_crypt_req);
> +	rc =3D ecryptfs_decrypt_page_offset(extent_crypt_req, page,
>  					  (extent_offset
>  					   * crypt_stat->extent_size),
>  					  enc_extent_page, 0,
> -					  crypt_stat->extent_size, extent_iv);
> -	if (rc < 0) {
> +					  crypt_stat->extent_size);
> +	if (!rc) {
> +		/* Request completed synchronously */
> +		struct crypto_async_request dummy;
> +		dummy.data =3D extent_crypt_req;
> +		completion(&dummy, rc);
> +	} else if (rc !=3D -EBUSY && rc !=3D -EINPROGRESS) {
>  		printk(KERN_ERR "%s: Error attempting to decrypt to page with "
>  		       "page->index =3D [%ld], extent_offset =3D [%ld]; "
>  		       "rc =3D [%d]\n", __func__, page->index, extent_offset,
> @@ -538,32 +792,80 @@ static int ecryptfs_decrypt_extent(struct page *pag=
e,
>  	}
>  	rc =3D 0;
>  out:
> -	return rc;
> +	if (rc) {
> +		struct crypto_async_request dummy;
> +		dummy.data =3D extent_crypt_req;
> +		completion(&dummy, rc);
> +	}
>  }
> =20
>  /**
> - * ecryptfs_decrypt_page
> - * @page: Page mapped from the eCryptfs inode for the file; data read
> - *        and decrypted from the lower file will be written into this
> - *        page
> + * ecryptfs_decrypt_extent_done
> + * @extent_crypt_req: The original extent decrypt request
> + * @err: Result of the decryption operation
> + *
> + * This function is called when the extent decryption is completed.
> + */
> +static void ecryptfs_decrypt_extent_done(
> +		struct crypto_async_request *req,
> +		int err)
> +{
> +	struct ecryptfs_extent_crypt_req *extent_crypt_req =3D req->data;
> +	struct ecryptfs_crypt_stat *crypt_stat =3D extent_crypt_req->crypt_stat;
> +	struct page *page =3D extent_crypt_req->page_crypt_req->page;
> +	unsigned long extent_offset =3D extent_crypt_req->extent_offset;
> +	loff_t extent_base;
> +
> +	if (!err && unlikely(ecryptfs_verbosity > 0)) {
> +		extent_base =3D (((loff_t)page->index)
> +			       * (PAGE_CACHE_SIZE / crypt_stat->extent_size));
> +		ecryptfs_printk(KERN_DEBUG, "Decrypt extent [0x%.16llx]; "
> +				"rc =3D [%d]\n",
> +				(unsigned long long)(extent_base +
> +						     extent_offset),
> +				err);
> +		ecryptfs_printk(KERN_DEBUG, "First 8 bytes after "
> +				"decryption:\n");
> +		ecryptfs_dump_hex((char *)(page_address(page)
> +					   + (extent_offset
> +					      * crypt_stat->extent_size)), 8);
> +	} else if (err) {
> +		atomic_set(&extent_crypt_req->page_crypt_req->rc, err);
> +		printk(KERN_ERR "%s: Error decrypting extent; "
> +		       "rc =3D [%d]\n", __func__, err);
> +	}
> +
> +	__free_page(extent_crypt_req->enc_extent_page);
> +	ecryptfs_free_extent_crypt_req(extent_crypt_req);
> +}
> +
> +/**
> + * ecryptfs_decrypt_page_async
> + * @page_crypt_req: Page level decryption request which contains the page
> + *                  mapped from the eCryptfs inode for the file; data re=
ad
> + *                  and decrypted from the lower file will be written in=
to
> + *                  this page
>   *
> - * Decrypt an eCryptfs page. This is done on a per-extent basis. Note
> - * that eCryptfs pages may straddle the lower pages -- for instance,
> - * if the file was created on a machine with an 8K page size
> - * (resulting in an 8K header), and then the file is copied onto a
> - * host with a 32K page size, then when reading page 0 of the eCryptfs
> + * Function that asynchronously decrypts an eCryptfs page.
> + * This is done on a per-extent basis. Note that eCryptfs pages may stra=
ddle
> + * the lower pages -- for instance, if the file was created on a machine=
 with
> + * an 8K page size (resulting in an 8K header), and then the file is cop=
ied
> + * onto a host with a 32K page size, then when reading page 0 of the eCr=
yptfs
>   * file, 24K of page 0 of the lower file will be read and decrypted,
>   * and then 8K of page 1 of the lower file will be read and decrypted.
>   *
> - * Returns zero on success; negative on error
> + * Status code is returned in the completion routine (zero on success;
> + * negative on error).
>   */
> -int ecryptfs_decrypt_page(struct page *page)
> +void ecryptfs_decrypt_page_async(struct ecryptfs_page_crypt_req *page_cr=
ypt_req)
>  {
> +	struct page *page =3D page_crypt_req->page;
>  	struct inode *ecryptfs_inode;
>  	struct ecryptfs_crypt_stat *crypt_stat;
>  	char *enc_extent_virt;
>  	struct page *enc_extent_page =3D NULL;
> -	unsigned long extent_offset;
> +	struct ecryptfs_extent_crypt_req *extent_crypt_req =3D NULL;
> +	unsigned long extent_offset =3D 0;
>  	int rc =3D 0;
> =20
>  	ecryptfs_inode =3D page->mapping->host;
> @@ -574,7 +876,7 @@ int ecryptfs_decrypt_page(struct page *page)
>  	if (!enc_extent_page) {
>  		rc =3D -ENOMEM;
>  		ecryptfs_printk(KERN_ERR, "Error allocating memory for "
> -				"encrypted extent\n");
> +				"decrypted extent\n");
>  		goto out;
>  	}
>  	enc_extent_virt =3D kmap(enc_extent_page);
> @@ -596,123 +898,174 @@ int ecryptfs_decrypt_page(struct page *page)
>  					"\n", rc);
>  			goto out;
>  		}
> -		rc =3D ecryptfs_decrypt_extent(page, crypt_stat, enc_extent_page,
> -					     extent_offset);
> -		if (rc) {
> -			printk(KERN_ERR "%s: Error encrypting extent; "
> -			       "rc =3D [%d]\n", __func__, rc);
> +
> +		extent_crypt_req =3D ecryptfs_alloc_extent_crypt_req(
> +					page_crypt_req, crypt_stat);
> +		if (!extent_crypt_req) {
> +			rc =3D -ENOMEM;
> +			ecryptfs_printk(KERN_ERR,
> +					"Failed to allocate extent crypt "
> +					"request for decryption\n");
>  			goto out;
>  		}
> +		extent_crypt_req->enc_extent_page =3D enc_extent_page;
> +
> +		/* Error handling is done in the completion routine. */
> +		ecryptfs_decrypt_extent(extent_crypt_req,
> +					ecryptfs_decrypt_extent_done);
>  	}
> +	rc =3D 0;
>  out:
> -	if (enc_extent_page) {
> +	if (enc_extent_page)
>  		kunmap(enc_extent_page);
> -		__free_page(enc_extent_page);
> +
> +	/* Only call the completion routine if we did not fire off any extent
> +	 * decryption requests.  If at least one call to
> +	 * ecryptfs_decrypt_extent succeeded, it will call the completion
> +	 * routine.
> +	 */
> +	if (rc && extent_offset =3D=3D 0) {
> +		atomic_set(&page_crypt_req->rc, rc);
> +		ecryptfs_complete_page_crypt_req(page_crypt_req);
> +	}
> +}
> +
> +/**
> + * ecryptfs_decrypt_page
> + * @page: Page mapped from the eCryptfs inode for the file; data read
> + *        and decrypted from the lower file will be written into this
> + *        page
> + *
> + * Decrypts an eCryptfs page synchronously.
> + *
> + * Returns zero on success; negative on error
> + */
> +int ecryptfs_decrypt_page(struct page *page)
> +{
> +	struct ecryptfs_page_crypt_req *page_crypt_req;
> +	int rc;
> +
> +	page_crypt_req =3D ecryptfs_alloc_page_crypt_req(page, NULL);
> +	if (!page_crypt_req) {
> +		rc =3D -ENOMEM;
> +		ecryptfs_printk(KERN_ERR,
> +				"Failed to allocate page crypt request "
> +				"for decryption\n");
> +		goto out;
>  	}
> +	ecryptfs_decrypt_page_async(page_crypt_req);
> +	wait_for_completion(&page_crypt_req->completion);
> +	rc =3D atomic_read(&page_crypt_req->rc);
> +out:
> +	if (page_crypt_req)
> +		ecryptfs_free_page_crypt_req(page_crypt_req);
>  	return rc;
>  }
> =20
>  /**
>   * decrypt_scatterlist
>   * @crypt_stat: Cryptographic context
> + * @req: Async blkcipher request
>   * @dest_sg: The destination scatterlist to decrypt into
>   * @src_sg: The source scatterlist to decrypt from
>   * @size: The number of bytes to decrypt
>   * @iv: The initialization vector to use for the decryption
>   *
> - * Returns the number of bytes decrypted; negative value on error
> + * Returns zero if the decryption request was started successfully, else
> + * non-zero.
>   */
>  static int decrypt_scatterlist(struct ecryptfs_crypt_stat *crypt_stat,
> +			       struct ablkcipher_request *req,
>  			       struct scatterlist *dest_sg,
>  			       struct scatterlist *src_sg, int size,
>  			       unsigned char *iv)
>  {
> -	struct blkcipher_desc desc =3D {
> -		.tfm =3D crypt_stat->tfm,
> -		.info =3D iv,
> -		.flags =3D CRYPTO_TFM_REQ_MAY_SLEEP
> -	};
>  	int rc =3D 0;
> -
> +	BUG_ON(!crypt_stat || !crypt_stat->tfm
> +	       || !(crypt_stat->flags & ECRYPTFS_STRUCT_INITIALIZED));
>  	/* Consider doing this once, when the file is opened */
>  	mutex_lock(&crypt_stat->cs_tfm_mutex);
> -	rc =3D crypto_blkcipher_setkey(crypt_stat->tfm, crypt_stat->key,
> -				     crypt_stat->key_size);
> -	if (rc) {
> -		ecryptfs_printk(KERN_ERR, "Error setting key; rc =3D [%d]\n",
> -				rc);
> -		mutex_unlock(&crypt_stat->cs_tfm_mutex);
> -		rc =3D -EINVAL;
> -		goto out;
> +	if (!(crypt_stat->flags & ECRYPTFS_KEY_SET)) {
> +		rc =3D crypto_ablkcipher_setkey(crypt_stat->tfm, crypt_stat->key,
> +					      crypt_stat->key_size);
> +		if (rc) {
> +			ecryptfs_printk(KERN_ERR,
> +					"Error setting key; rc =3D [%d]\n",
> +					rc);
> +			mutex_unlock(&crypt_stat->cs_tfm_mutex);
> +			rc =3D -EINVAL;
> +			goto out;
> +		}
> +		crypt_stat->flags |=3D ECRYPTFS_KEY_SET;
>  	}
> -	ecryptfs_printk(KERN_DEBUG, "Decrypting [%d] bytes.\n", size);
> -	rc =3D crypto_blkcipher_decrypt_iv(&desc, dest_sg, src_sg, size);
>  	mutex_unlock(&crypt_stat->cs_tfm_mutex);
> -	if (rc) {
> -		ecryptfs_printk(KERN_ERR, "Error decrypting; rc =3D [%d]\n",
> -				rc);
> -		goto out;
> -	}
> -	rc =3D size;
> +	ecryptfs_printk(KERN_DEBUG, "Decrypting [%d] bytes.\n", size);
> +	ablkcipher_request_set_crypt(req, src_sg, dest_sg, size, iv);
> +	rc =3D crypto_ablkcipher_decrypt(req);
>  out:
>  	return rc;
>  }
> =20
>  /**
>   * ecryptfs_encrypt_page_offset
> - * @crypt_stat: The cryptographic context
> + * @extent_crypt_req: Crypt request that describes the extent that needs=
 to be
> + *                    encrypted
>   * @dst_page: The page to encrypt into
>   * @dst_offset: The offset in the page to encrypt into
>   * @src_page: The page to encrypt from
>   * @src_offset: The offset in the page to encrypt from
>   * @size: The number of bytes to encrypt
> - * @iv: The initialization vector to use for the encryption
>   *
> - * Returns the number of bytes encrypted
> + * Returns zero if the encryption started successfully, else non-zero.
> + * Encryption status is returned in the completion routine.
>   */
>  static int
> -ecryptfs_encrypt_page_offset(struct ecryptfs_crypt_stat *crypt_stat,
> +ecryptfs_encrypt_page_offset(struct ecryptfs_extent_crypt_req *extent_cr=
ypt_req,
>  			     struct page *dst_page, int dst_offset,
> -			     struct page *src_page, int src_offset, int size,
> -			     unsigned char *iv)
> +			     struct page *src_page, int src_offset, int size)
>  {
> -	struct scatterlist src_sg, dst_sg;
> -
> -	sg_init_table(&src_sg, 1);
> -	sg_init_table(&dst_sg, 1);
> -
> -	sg_set_page(&src_sg, src_page, size, src_offset);
> -	sg_set_page(&dst_sg, dst_page, size, dst_offset);
> -	return encrypt_scatterlist(crypt_stat, &dst_sg, &src_sg, size, iv);
> +	sg_init_table(&extent_crypt_req->src_sg, 1);
> +	sg_init_table(&extent_crypt_req->dst_sg, 1);
> +
> +	sg_set_page(&extent_crypt_req->src_sg, src_page, size, src_offset);
> +	sg_set_page(&extent_crypt_req->dst_sg, dst_page, size, dst_offset);
> +	return encrypt_scatterlist(extent_crypt_req->crypt_stat,
> +				   extent_crypt_req->req,
> +				   &extent_crypt_req->dst_sg,
> +				   &extent_crypt_req->src_sg,
> +				   size,
> +				   extent_crypt_req->extent_iv);
>  }
> =20
>  /**
>   * ecryptfs_decrypt_page_offset
> - * @crypt_stat: The cryptographic context
> + * @extent_crypt_req: Crypt request that describes the extent that needs=
 to be
> + *                    decrypted
>   * @dst_page: The page to decrypt into
>   * @dst_offset: The offset in the page to decrypt into
>   * @src_page: The page to decrypt from
>   * @src_offset: The offset in the page to decrypt from
>   * @size: The number of bytes to decrypt
> - * @iv: The initialization vector to use for the decryption
>   *
> - * Returns the number of bytes decrypted
> + * Decryption status is returned in the completion routine.
>   */
>  static int
> -ecryptfs_decrypt_page_offset(struct ecryptfs_crypt_stat *crypt_stat,
> +ecryptfs_decrypt_page_offset(struct ecryptfs_extent_crypt_req *extent_cr=
ypt_req,
>  			     struct page *dst_page, int dst_offset,
> -			     struct page *src_page, int src_offset, int size,
> -			     unsigned char *iv)
> +			     struct page *src_page, int src_offset, int size)
>  {
> -	struct scatterlist src_sg, dst_sg;
> -
> -	sg_init_table(&src_sg, 1);
> -	sg_set_page(&src_sg, src_page, size, src_offset);
> -
> -	sg_init_table(&dst_sg, 1);
> -	sg_set_page(&dst_sg, dst_page, size, dst_offset);
> -
> -	return decrypt_scatterlist(crypt_stat, &dst_sg, &src_sg, size, iv);
> +	sg_init_table(&extent_crypt_req->src_sg, 1);
> +	sg_set_page(&extent_crypt_req->src_sg, src_page, size, src_offset);
> +
> +	sg_init_table(&extent_crypt_req->dst_sg, 1);
> +	sg_set_page(&extent_crypt_req->dst_sg, dst_page, size, dst_offset);
> +
> +	return decrypt_scatterlist(extent_crypt_req->crypt_stat,
> +				   extent_crypt_req->req,
> +				   &extent_crypt_req->dst_sg,
> +				   &extent_crypt_req->src_sg,
> +				   size,
> +				   extent_crypt_req->extent_iv);
>  }
> =20
>  #define ECRYPTFS_MAX_SCATTERLIST_LEN 4
> @@ -749,8 +1102,7 @@ int ecryptfs_init_crypt_ctx(struct ecryptfs_crypt_st=
at *crypt_stat)
>  						    crypt_stat->cipher, "cbc");
>  	if (rc)
>  		goto out_unlock;
> -	crypt_stat->tfm =3D crypto_alloc_blkcipher(full_alg_name, 0,
> -						 CRYPTO_ALG_ASYNC);
> +	crypt_stat->tfm =3D crypto_alloc_ablkcipher(full_alg_name, 0, 0);
>  	kfree(full_alg_name);
>  	if (IS_ERR(crypt_stat->tfm)) {
>  		rc =3D PTR_ERR(crypt_stat->tfm);
> @@ -760,7 +1112,7 @@ int ecryptfs_init_crypt_ctx(struct ecryptfs_crypt_st=
at *crypt_stat)
>  				crypt_stat->cipher);
>  		goto out_unlock;
>  	}
> -	crypto_blkcipher_set_flags(crypt_stat->tfm, CRYPTO_TFM_REQ_WEAK_KEY);
> +	crypto_ablkcipher_set_flags(crypt_stat->tfm, CRYPTO_TFM_REQ_WEAK_KEY);
>  	rc =3D 0;
>  out_unlock:
>  	mutex_unlock(&crypt_stat->cs_tfm_mutex);
> diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
> index 867b64c..1d3449e 100644
> --- a/fs/ecryptfs/ecryptfs_kernel.h
> +++ b/fs/ecryptfs/ecryptfs_kernel.h
> @@ -38,6 +38,7 @@
>  #include <linux/nsproxy.h>
>  #include <linux/backing-dev.h>
>  #include <linux/ecryptfs.h>
> +#include <linux/crypto.h>
> =20
>  #define ECRYPTFS_DEFAULT_IV_BYTES 16
>  #define ECRYPTFS_DEFAULT_EXTENT_SIZE 4096
> @@ -220,7 +221,7 @@ struct ecryptfs_crypt_stat {
>  	size_t extent_shift;
>  	unsigned int extent_mask;
>  	struct ecryptfs_mount_crypt_stat *mount_crypt_stat;
> -	struct crypto_blkcipher *tfm;
> +	struct crypto_ablkcipher *tfm;
>  	struct crypto_hash *hash_tfm; /* Crypto context for generating
>  				       * the initialization vectors */
>  	unsigned char cipher[ECRYPTFS_MAX_CIPHER_NAME_SIZE];
> @@ -551,6 +552,8 @@ extern struct kmem_cache *ecryptfs_key_sig_cache;
>  extern struct kmem_cache *ecryptfs_global_auth_tok_cache;
>  extern struct kmem_cache *ecryptfs_key_tfm_cache;
>  extern struct kmem_cache *ecryptfs_open_req_cache;
> +extern struct kmem_cache *ecryptfs_page_crypt_req_cache;
> +extern struct kmem_cache *ecryptfs_extent_crypt_req_cache;
> =20
>  struct ecryptfs_open_req {
>  #define ECRYPTFS_REQ_PROCESSED 0x00000001
> @@ -565,6 +568,30 @@ struct ecryptfs_open_req {
>  	struct list_head kthread_ctl_list;
>  };
> =20
> +struct ecryptfs_page_crypt_req;
> +typedef void (*page_crypt_completion)(
> +	struct ecryptfs_page_crypt_req *page_crypt_req);
> +
> +struct ecryptfs_page_crypt_req {
> +	struct page *page;
> +	atomic_t num_refs;
> +	atomic_t rc;
> +	page_crypt_completion completion_func;
> +	struct completion completion;
> +};
> +
> +struct ecryptfs_extent_crypt_req {
> +	struct ecryptfs_page_crypt_req *page_crypt_req;
> +	struct ablkcipher_request *req;
> +	struct ecryptfs_crypt_stat *crypt_stat;
> +	struct inode *inode;
> +	struct page *enc_extent_page;
> +	char extent_iv[ECRYPTFS_MAX_IV_BYTES];
> +	unsigned long extent_offset;
> +	struct scatterlist src_sg;
> +	struct scatterlist dst_sg;
> +};
> +
>  struct inode *ecryptfs_get_inode(struct inode *lower_inode,
>  				 struct super_block *sb);
>  void ecryptfs_i_size_init(const char *page_virt, struct inode *inode);
> @@ -591,8 +618,17 @@ void ecryptfs_destroy_mount_crypt_stat(
>  	struct ecryptfs_mount_crypt_stat *mount_crypt_stat);
>  int ecryptfs_init_crypt_ctx(struct ecryptfs_crypt_stat *crypt_stat);
>  int ecryptfs_write_inode_size_to_metadata(struct inode *ecryptfs_inode);
> +struct ecryptfs_page_crypt_req *ecryptfs_alloc_page_crypt_req(
> +	struct page *page,
> +	page_crypt_completion completion_func);
> +void ecryptfs_free_page_crypt_req(
> +	struct ecryptfs_page_crypt_req *page_crypt_req);
>  int ecryptfs_encrypt_page(struct page *page);
> +void ecryptfs_encrypt_page_async(
> +	struct ecryptfs_page_crypt_req *page_crypt_req);
>  int ecryptfs_decrypt_page(struct page *page);
> +void ecryptfs_decrypt_page_async(
> +	struct ecryptfs_page_crypt_req *page_crypt_req);
>  int ecryptfs_write_metadata(struct dentry *ecryptfs_dentry,
>  			    struct inode *ecryptfs_inode);
>  int ecryptfs_read_metadata(struct dentry *ecryptfs_dentry);
> diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
> index 6895493..58523b9 100644
> --- a/fs/ecryptfs/main.c
> +++ b/fs/ecryptfs/main.c
> @@ -687,6 +687,16 @@ static struct ecryptfs_cache_info {
>  		.name =3D "ecryptfs_open_req_cache",
>  		.size =3D sizeof(struct ecryptfs_open_req),
>  	},
> +	{
> +		.cache =3D &ecryptfs_page_crypt_req_cache,
> +		.name =3D "ecryptfs_page_crypt_req_cache",
> +		.size =3D sizeof(struct ecryptfs_page_crypt_req),
> +	},
> +	{
> +		.cache =3D &ecryptfs_extent_crypt_req_cache,
> +		.name =3D "ecryptfs_extent_crypt_req_cache",
> +		.size =3D sizeof(struct ecryptfs_extent_crypt_req),
> +	},
>  };
> =20
>  static void ecryptfs_free_kmem_caches(void)
> diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
> index a46b3a8..fdfd0df 100644
> --- a/fs/ecryptfs/mmap.c
> +++ b/fs/ecryptfs/mmap.c
> @@ -53,6 +53,31 @@ struct page *ecryptfs_get_locked_page(struct inode *in=
ode, loff_t index)
>  }
> =20
>  /**
> + * ecryptfs_writepage_complete
> + * @page_crypt_req: The encrypt page request that completed
> + *
> + * Calls when the requested page has been encrypted and written to the l=
ower
> + * file system.
> + */
> +static void ecryptfs_writepage_complete(
> +		struct ecryptfs_page_crypt_req *page_crypt_req)
> +{
> +	struct page *page =3D page_crypt_req->page;
> +	int rc;
> +	rc =3D atomic_read(&page_crypt_req->rc);
> +	if (unlikely(rc)) {
> +		ecryptfs_printk(KERN_WARNING, "Error encrypting "
> +				"page (upper index [0x%.16lx])\n", page->index);
> +		ClearPageUptodate(page);
> +		SetPageError(page);
> +	} else {
> +		SetPageUptodate(page);
> +	}
> +	end_page_writeback(page);
> +	ecryptfs_free_page_crypt_req(page_crypt_req);
> +}
> +
> +/**
>   * ecryptfs_writepage
>   * @page: Page that is locked before this call is made
>   *
> @@ -64,7 +89,8 @@ struct page *ecryptfs_get_locked_page(struct inode *ino=
de, loff_t index)
>   */
>  static int ecryptfs_writepage(struct page *page, struct writeback_contro=
l *wbc)
>  {
> -	int rc;
> +	struct ecryptfs_page_crypt_req *page_crypt_req;
> +	int rc =3D 0;
> =20
>  	/*
>  	 * Refuse to write the page out if we are called from reclaim context
> @@ -74,18 +100,20 @@ static int ecryptfs_writepage(struct page *page, str=
uct writeback_control *wbc)
>  	 */
>  	if (current->flags & PF_MEMALLOC) {
>  		redirty_page_for_writepage(wbc, page);
> -		rc =3D 0;
>  		goto out;
>  	}
> =20
> -	rc =3D ecryptfs_encrypt_page(page);
> -	if (rc) {
> -		ecryptfs_printk(KERN_WARNING, "Error encrypting "
> -				"page (upper index [0x%.16lx])\n", page->index);
> -		ClearPageUptodate(page);
> +	page_crypt_req =3D ecryptfs_alloc_page_crypt_req(
> +				page, ecryptfs_writepage_complete);
> +	if (unlikely(!page_crypt_req)) {
> +		rc =3D -ENOMEM;
> +		ecryptfs_printk(KERN_ERR,
> +				"Failed to allocate page crypt request "
> +				"for encryption\n");
>  		goto out;
>  	}
> -	SetPageUptodate(page);
> +	set_page_writeback(page);
> +	ecryptfs_encrypt_page_async(page_crypt_req);
>  out:
>  	unlock_page(page);
>  	return rc;
> @@ -195,6 +223,32 @@ out:
>  }
> =20
>  /**
> + * ecryptfs_readpage_complete
> + * @page_crypt_req: The decrypt page request that completed
> + *
> + * Calls when the requested page has been read and decrypted.
> + */
> +static void ecryptfs_readpage_complete(
> +		struct ecryptfs_page_crypt_req *page_crypt_req)
> +{
> +	struct page *page =3D page_crypt_req->page;
> +	int rc;
> +	rc =3D atomic_read(&page_crypt_req->rc);
> +	if (unlikely(rc)) {
> +		ecryptfs_printk(KERN_ERR, "Error decrypting page; "
> +				"rc =3D [%d]\n", rc);
> +		ClearPageUptodate(page);
> +		SetPageError(page);
> +	} else {
> +		SetPageUptodate(page);
> +	}
> +	ecryptfs_printk(KERN_DEBUG, "Unlocking page with index =3D [0x%.16lx]\n=
",
> +			page->index);
> +	unlock_page(page);
> +	ecryptfs_free_page_crypt_req(page_crypt_req);
> +}
> +
> +/**
>   * ecryptfs_readpage
>   * @file: An eCryptfs file
>   * @page: Page from eCryptfs inode mapping into which to stick the read =
data
> @@ -207,6 +261,7 @@ static int ecryptfs_readpage(struct file *file, struc=
t page *page)
>  {
>  	struct ecryptfs_crypt_stat *crypt_stat =3D
>  		&ecryptfs_inode_to_private(page->mapping->host)->crypt_stat;
> +	struct ecryptfs_page_crypt_req *page_crypt_req =3D NULL;
>  	int rc =3D 0;
> =20
>  	if (!crypt_stat || !(crypt_stat->flags & ECRYPTFS_ENCRYPTED)) {
> @@ -237,21 +292,27 @@ static int ecryptfs_readpage(struct file *file, str=
uct page *page)
>  			}
>  		}
>  	} else {
> -		rc =3D ecryptfs_decrypt_page(page);
> -		if (rc) {
> -			ecryptfs_printk(KERN_ERR, "Error decrypting page; "
> -					"rc =3D [%d]\n", rc);
> +		page_crypt_req =3D ecryptfs_alloc_page_crypt_req(
> +					page, ecryptfs_readpage_complete);
> +		if (!page_crypt_req) {
> +			rc =3D -ENOMEM;
> +			ecryptfs_printk(KERN_ERR,
> +					"Failed to allocate page crypt request "
> +					"for decryption\n");
>  			goto out;
>  		}
> +		ecryptfs_decrypt_page_async(page_crypt_req);
> +		goto out_async_started;
>  	}
>  out:
> -	if (rc)
> +	if (unlikely(rc))
>  		ClearPageUptodate(page);
>  	else
>  		SetPageUptodate(page);
>  	ecryptfs_printk(KERN_DEBUG, "Unlocking page with index =3D [0x%.16lx]\n=
",
>  			page->index);
>  	unlock_page(page);
> +out_async_started:
>  	return rc;
>  }
> =20
> --=20
> 1.7.9.5
>=20

--gatW/ieO32f1wygP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCgAGBQJP2LusAAoJENaSAD2qAscKQ+AQAI0QqwUxmuAGLQ3gJmziJ6Eq
OoHYBkzs7AXv80n5GIvNj81NsCPPUJ30NVAZPe+RHl5Sw1X+I75f5mBxcg37YPdf
KBTBTmHX+SAqWSSmkdyhPaHo1wRpT/SdVz31qEpAg8qIrNehNAb4RBbGs6Vb3osm
KujupmsGtVVaS1xl2DbmoAQNdEztdFV3k9gNRDwBAR/0YXBfQwFwPtncv7lpnlT+
qrPqf+5bbM2IgRl1dm2AD8J3rxUSAC5hH+jkuky2/BQd66wRx2JWDUjsHr8145zN
kgmgZ2SykDfVRsCbSg4qw6QadsaaVK3Vnn6mlUY6awcADA1/5c+SurMvdRNxL6VV
3+rmIKYVB/JbkxAtdtD2SrYAhez/P3iHdMLO67qjSbJjbDJ6UTUvF505El66f22y
phq3r7bzAA2XJ3/fuVDf4mpdyrGZPBaXNwNE3b+KOcZa4sBJ0l31S+1ZQxaHQBEF
xzHP866Taw9idJXVSeM4JN1Psqg8RYNt50o2XejWijr4Jw4HNZ0pFOxAxIqD0NJZ
UmHakjzuGuAL3nP26DyclgJLdpbv6GPJTzEorcEazD12qDrI/VHx8LxJgO1/NMHM
Zvhr59E0U+2gbCo198LeQc8qCQ8UIDE9gEyb9mUA81gI0RCZivOhPTqa02OIo4W4
cLMmNWsdX+jPK0ZPbR3/
=TkjF
-----END PGP SIGNATURE-----

--gatW/ieO32f1wygP--
