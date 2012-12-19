From: Zeev Zilberman <zeev@annapurnalabs.com>
Subject: Re: [PATCH 1/1] ecryptfs: Migrate to ablkcipher API
Date: Wed, 19 Dec 2012 13:44:13 +0200
Message-ID: <20121219114410.GA19036@annapurnalabs.com>
References: <1339589670-12189-2-git-send-email-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from am1ehsobe004.messaging.microsoft.com ([213.199.154.207]:43565
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751369Ab2LSLmE (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Wed, 19 Dec 2012 06:42:04 -0500
Received: from mail88-am1 (localhost [127.0.0.1])	by mail88-am1-R.bigfish.com
 (Postfix) with ESMTP id 0752A802FD	for <ecryptfs@vger.kernel.org>; Wed, 19
 Dec 2012 11:42:02 +0000 (UTC)
Received: from AM1EHSMHS003.bigfish.com (unknown [10.3.201.227])	by
 mail88-am1.bigfish.com (Postfix) with ESMTP id 86E52480063	for
 <ecryptfs@vger.kernel.org>; Wed, 19 Dec 2012 11:41:57 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1339589670-12189-2-git-send-email-colin.king@canonical.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org

Hello Tyler and Colin,

I saw this discussion about the ecryptfs ablkcipher patch, but I see it was not merged.
Could you please tell if you still plan to merge it?

Meanwhile, I tried to apply the patch manually to test it.

I've encountered a problem with ecryptfs_encrypt_extent_done that is calling functions
that can sleep (kmap/kunmap). It fails with ablkcipher crypto drivers that invoke the
callback from interrupt handler bh (tasklet).
Moving the write part to a work queue (using queue_work) seems to solve it.

On the other hand the revert from writeback to writethrough cache mode seems to be
problematic in regard to performance improvement caused by using async interfaces.
The original change to writepage (that uses ecryptfs_encrypt_page_async) allowed
submitting async crypto operations and continuing without waiting for the result.
write_end uses ecryptfs_encrypt_page (and needs its return value), so we'll have to wait
for encryption (and write) to complete before continuing to the next operation.
Are you planning to return ecryptfs cache to writeback mode?

Thank you!
Zeev

> From: Colin Ian King <colin.king@xxxxxxxxxxxxx>
> 
> Forward port of Thieu Le's patch from 2.6.39.
> 
> Using ablkcipher allows eCryptfs to take full advantage of hardware
> crypto.
> 
> Change-Id: I94a6e50a8d576bf79cf73732c7b4c75629b5d40c
> 
> Signed-off-by: Thieu Le <thieule@xxxxxxxxxxxx>
> Signed-off-by: Colin Ian King <colin.king@xxxxxxxxxxxxx>
> ---
>  fs/ecryptfs/crypto.c          |  678 +++++++++++++++++++++++++++++++----------
>  fs/ecryptfs/ecryptfs_kernel.h |   38 ++-
>  fs/ecryptfs/main.c            |   10 +
>  fs/ecryptfs/mmap.c            |   87 +++++-
>  4 files changed, 636 insertions(+), 177 deletions(-)
> 
> diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
> index ea99312..7f5ff05 100644
> --- a/fs/ecryptfs/crypto.c
> +++ b/fs/ecryptfs/crypto.c
> @@ -37,16 +37,17 @@
>  #include <asm/unaligned.h>
>  #include "ecryptfs_kernel.h"
>  
> +struct kmem_cache *ecryptfs_page_crypt_req_cache;
> +struct kmem_cache *ecryptfs_extent_crypt_req_cache;
> +
>  static int
> -ecryptfs_decrypt_page_offset(struct ecryptfs_crypt_stat *crypt_stat,
> +ecryptfs_decrypt_page_offset(struct ecryptfs_extent_crypt_req *extent_crypt_req,
>  			     struct page *dst_page, int dst_offset,
> -			     struct page *src_page, int src_offset, int size,
> -			     unsigned char *iv);
> +			     struct page *src_page, int src_offset, int size);
>  static int
> -ecryptfs_encrypt_page_offset(struct ecryptfs_crypt_stat *crypt_stat,
> +ecryptfs_encrypt_page_offset(struct ecryptfs_extent_crypt_req *extent_crypt_req,
>  			     struct page *dst_page, int dst_offset,
> -			     struct page *src_page, int src_offset, int size,
> -			     unsigned char *iv);
> +			     struct page *src_page, int src_offset, int size);
>  
>  /**
>   * ecryptfs_to_hex
> @@ -166,6 +167,120 @@ out:
>  }
>  
>  /**
> + * ecryptfs_alloc_page_crypt_req - allocates a page crypt request
> + * @page: Page mapped from the eCryptfs inode for the file
> + * @completion: Function that is called when the page crypt request completes.
> + *              If this parameter is NULL, then the the
> + *              page_crypt_completion::completion member is used to indicate
> + *              the operation completion.
> + *
> + * Allocates a crypt request that is used for asynchronous page encrypt and
> + * decrypt operations.
> + */
> +struct ecryptfs_page_crypt_req *ecryptfs_alloc_page_crypt_req(
> +	struct page *page,
> +	page_crypt_completion completion_func)
> +{
> +	struct ecryptfs_page_crypt_req *page_crypt_req;
> +	page_crypt_req = kmem_cache_zalloc(ecryptfs_page_crypt_req_cache,
> +					   GFP_KERNEL);
> +	if (!page_crypt_req)
> +		goto out;
> +	page_crypt_req->page = page;
> +	page_crypt_req->completion_func = completion_func;
> +	if (!completion_func)
> +		init_completion(&page_crypt_req->completion);
> +out:
> +	return page_crypt_req;
> +}
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
> + * completion callback if one is present, or use the completion data structure.
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
> + * @page_crypt_req: Pointer to the page crypt request that owns this extent
> + *                  request
> + * @crypt_stat: Pointer to crypt_stat struct for the current inode
> + *
> + * Allocates a crypt request that is used for asynchronous extent encrypt and
> + * decrypt operations.
> + */
> +static struct ecryptfs_extent_crypt_req *ecryptfs_alloc_extent_crypt_req(
> +		struct ecryptfs_page_crypt_req *page_crypt_req,
> +		struct ecryptfs_crypt_stat *crypt_stat)
> +{
> +	struct ecryptfs_extent_crypt_req *extent_crypt_req;
> +	extent_crypt_req = kmem_cache_zalloc(ecryptfs_extent_crypt_req_cache,
> +					     GFP_KERNEL);
> +	if (!extent_crypt_req)
> +		goto out;
> +	extent_crypt_req->req =
> +		ablkcipher_request_alloc(crypt_stat->tfm, GFP_KERNEL);
> +	if (!extent_crypt_req) {
> +		kmem_cache_free(ecryptfs_extent_crypt_req_cache,
> +				extent_crypt_req);
> +		extent_crypt_req = NULL;
> +		goto out;
> +	}
> +	atomic_inc(&page_crypt_req->num_refs);
> +	extent_crypt_req->page_crypt_req = page_crypt_req;
> +	extent_crypt_req->crypt_stat = crypt_stat;
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
> +	struct ecryptfs_page_crypt_req *page_crypt_req =
> +			extent_crypt_req->page_crypt_req;
> +	BUG_ON(!page_crypt_req);
> +	num_refs = atomic_dec_return(&page_crypt_req->num_refs);
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
> @@ -243,7 +358,7 @@ void ecryptfs_destroy_crypt_stat(struct ecryptfs_crypt_stat *crypt_stat)
>  	struct ecryptfs_key_sig *key_sig, *key_sig_tmp;
>  
>  	if (crypt_stat->tfm)
> -		crypto_free_blkcipher(crypt_stat->tfm);
> +		crypto_free_ablkcipher(crypt_stat->tfm);
>  	if (crypt_stat->hash_tfm)
>  		crypto_free_hash(crypt_stat->hash_tfm);
>  	list_for_each_entry_safe(key_sig, key_sig_tmp,
> @@ -324,26 +439,23 @@ int virt_to_scatterlist(const void *addr, int size, struct scatterlist *sg,
>  
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
> -	struct blkcipher_desc desc = {
> -		.tfm = crypt_stat->tfm,
> -		.info = iv,
> -		.flags = CRYPTO_TFM_REQ_MAY_SLEEP
> -	};
>  	int rc = 0;
> -
>  	BUG_ON(!crypt_stat || !crypt_stat->tfm
>  	       || !(crypt_stat->flags & ECRYPTFS_STRUCT_INITIALIZED));
>  	if (unlikely(ecryptfs_verbosity > 0)) {
> @@ -355,20 +467,22 @@ static int encrypt_scatterlist(struct ecryptfs_crypt_stat *crypt_stat,
>  	/* Consider doing this once, when the file is opened */
>  	mutex_lock(&crypt_stat->cs_tfm_mutex);
>  	if (!(crypt_stat->flags & ECRYPTFS_KEY_SET)) {
> -		rc = crypto_blkcipher_setkey(crypt_stat->tfm, crypt_stat->key,
> -					     crypt_stat->key_size);
> +		rc = crypto_ablkcipher_setkey(crypt_stat->tfm, crypt_stat->key,
> +					      crypt_stat->key_size);
> +		if (rc) {
> +			ecryptfs_printk(KERN_ERR,
> +					"Error setting key; rc = [%d]\n",
> +					rc);
> +			mutex_unlock(&crypt_stat->cs_tfm_mutex);
> +			rc = -EINVAL;
> +			goto out;
> +		}
>  		crypt_stat->flags |= ECRYPTFS_KEY_SET;
>  	}
> -	if (rc) {
> -		ecryptfs_printk(KERN_ERR, "Error setting key; rc = [%d]\n",
> -				rc);
> -		mutex_unlock(&crypt_stat->cs_tfm_mutex);
> -		rc = -EINVAL;
> -		goto out;
> -	}
> -	ecryptfs_printk(KERN_DEBUG, "Encrypting [%d] bytes.\n", size);
> -	crypto_blkcipher_encrypt_iv(&desc, dest_sg, src_sg, size);
>  	mutex_unlock(&crypt_stat->cs_tfm_mutex);
> +	ecryptfs_printk(KERN_DEBUG, "Encrypting [%d] bytes.\n", size);
> +	ablkcipher_request_set_crypt(req, src_sg, dest_sg, size, iv);
> +	rc = crypto_ablkcipher_encrypt(req);
>  out:
>  	return rc;
>  }
> @@ -387,24 +501,26 @@ static void ecryptfs_lower_offset_for_extent(loff_t *offset, loff_t extent_num,
>  
>  /**
>   * ecryptfs_encrypt_extent
> - * @enc_extent_page: Allocated page into which to encrypt the data in
> - *                   @page
> - * @crypt_stat: crypt_stat containing cryptographic context for the
> - *              encryption operation
> - * @page: Page containing plaintext data extent to encrypt
> - * @extent_offset: Page extent offset for use in generating IV
> + * @extent_crypt_req: Crypt request that describes the extent that needs to be
> + *                    encrypted
> + * @completion: Function that is called back when the encryption is completed
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
> +	struct page *enc_extent_page = extent_crypt_req->enc_extent_page;
> +	struct ecryptfs_crypt_stat *crypt_stat = extent_crypt_req->crypt_stat;
> +	struct page *page = extent_crypt_req->page_crypt_req->page;
> +	unsigned long extent_offset = extent_crypt_req->extent_offset;
> +
>  	loff_t extent_base;
> -	char extent_iv[ECRYPTFS_MAX_IV_BYTES];
> +	char *extent_iv = extent_crypt_req->extent_iv;
>  	int rc;
>  
>  	extent_base = (((loff_t)page->index)
> @@ -417,11 +533,20 @@ static int ecryptfs_encrypt_extent(struct page *enc_extent_page,
>  			(unsigned long long)(extent_base + extent_offset), rc);
>  		goto out;
>  	}
> -	rc = ecryptfs_encrypt_page_offset(crypt_stat, enc_extent_page, 0,
> +	ablkcipher_request_set_callback(extent_crypt_req->req,
> +					CRYPTO_TFM_REQ_MAY_BACKLOG |
> +					CRYPTO_TFM_REQ_MAY_SLEEP,
> +					completion, extent_crypt_req);
> +	rc = ecryptfs_encrypt_page_offset(extent_crypt_req, enc_extent_page, 0,
>  					  page, (extent_offset
>  						 * crypt_stat->extent_size),
> -					  crypt_stat->extent_size, extent_iv);
> -	if (rc < 0) {
> +					  crypt_stat->extent_size);
> +	if (!rc) {
> +		/* Request completed synchronously */
> +		struct crypto_async_request dummy;
> +		dummy.data = extent_crypt_req;
> +		completion(&dummy, rc);
> +	} else if (rc != -EBUSY && rc != -EINPROGRESS) {
>  		printk(KERN_ERR "%s: Error attempting to encrypt page with "
>  		       "page->index = [%ld], extent_offset = [%ld]; "
>  		       "rc = [%d]\n", __func__, page->index, extent_offset,
> @@ -430,32 +555,107 @@ static int ecryptfs_encrypt_extent(struct page *enc_extent_page,
>  	}
>  	rc = 0;
>  out:
> -	return rc;
> +	if (rc) {
> +		struct crypto_async_request dummy;
> +		dummy.data = extent_crypt_req;
> +		completion(&dummy, rc);
> +	}
>  }
>  
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
> +	struct ecryptfs_extent_crypt_req *extent_crypt_req = req->data;
> +	struct ecryptfs_page_crypt_req *page_crypt_req =
> +				extent_crypt_req->page_crypt_req;
> +	char *enc_extent_virt = NULL;
> +	struct page *page = page_crypt_req->page;
> +	struct page *enc_extent_page = extent_crypt_req->enc_extent_page;
> +	struct ecryptfs_crypt_stat *crypt_stat = extent_crypt_req->crypt_stat;
> +	loff_t extent_base;
> +	unsigned long extent_offset = extent_crypt_req->extent_offset;
> +	loff_t offset;
> +	int rc = 0;
> +
> +	if (!err && unlikely(ecryptfs_verbosity > 0)) {
> +		extent_base = (((loff_t)page->index)
> +			       * (PAGE_CACHE_SIZE / crypt_stat->extent_size));
> +		ecryptfs_printk(KERN_DEBUG, "Encrypt extent [0x%.16llx]; "
> +				"rc = [%d]\n",
> +				(unsigned long long)(extent_base +
> +						     extent_offset),
> +				err);
> +		ecryptfs_printk(KERN_DEBUG, "First 8 bytes after "
> +				"encryption:\n");
> +		ecryptfs_dump_hex((char *)(page_address(enc_extent_page)), 8);
> +	} else if (err) {
> +		atomic_set(&page_crypt_req->rc, err);
> +		printk(KERN_ERR "%s: Error encrypting extent; "
> +		       "rc = [%d]\n", __func__, err);
> +		goto out;
> +	}
> +
> +	enc_extent_virt = kmap(enc_extent_page);
> +	ecryptfs_lower_offset_for_extent(
> +		&offset,
> +		((((loff_t)page->index)
> +		  * (PAGE_CACHE_SIZE
> +		     / extent_crypt_req->crypt_stat->extent_size))
> +		    + extent_crypt_req->extent_offset),
> +		extent_crypt_req->crypt_stat);
> +	rc = ecryptfs_write_lower(extent_crypt_req->inode, enc_extent_virt,
> +				  offset,
> +				  extent_crypt_req->crypt_stat->extent_size);
> +	if (rc < 0) {
> +		atomic_set(&page_crypt_req->rc, rc);
> +		ecryptfs_printk(KERN_ERR, "Error attempting "
> +				"to write lower page; rc = [%d]"
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
> + *                  (to a temporary page; not in place) and written out to
> + *                  the lower file
>   *
> - * Encrypt an eCryptfs page. This is done on a per-extent basis. Note
> - * that eCryptfs pages may straddle the lower pages -- for instance,
> - * if the file was created on a machine with an 8K page size
> - * (resulting in an 8K header), and then the file is copied onto a
> - * host with a 32K page size, then when reading page 0 of the eCryptfs
> + * Function that asynchronously encrypts an eCryptfs page.
> + * This is done on a per-extent basis.  Note that eCryptfs pages may straddle
> + * the lower pages -- for instance, if the file was created on a machine with
> + * an 8K page size (resulting in an 8K header), and then the file is copied
> + * onto a host with a 32K page size, then when reading page 0 of the eCryptfs
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
> +	struct page *page = page_crypt_req->page;
>  	struct inode *ecryptfs_inode;
>  	struct ecryptfs_crypt_stat *crypt_stat;
> -	char *enc_extent_virt;
>  	struct page *enc_extent_page = NULL;
> -	loff_t extent_offset;
> +	struct ecryptfs_extent_crypt_req *extent_crypt_req = NULL;
> +	loff_t extent_offset = 0;
>  	int rc = 0;
>  
>  	ecryptfs_inode = page->mapping->host;
> @@ -469,49 +669,94 @@ int ecryptfs_encrypt_page(struct page *page)
>  				"encrypted extent\n");
>  		goto out;
>  	}
> -	enc_extent_virt = kmap(enc_extent_page);
>  	for (extent_offset = 0;
>  	     extent_offset < (PAGE_CACHE_SIZE / crypt_stat->extent_size);
>  	     extent_offset++) {
> -		loff_t offset;
> -
> -		rc = ecryptfs_encrypt_extent(enc_extent_page, crypt_stat, page,
> -					     extent_offset);
> -		if (rc) {
> -			printk(KERN_ERR "%s: Error encrypting extent; "
> -			       "rc = [%d]\n", __func__, rc);
> -			goto out;
> -		}
> -		ecryptfs_lower_offset_for_extent(
> -			&offset, ((((loff_t)page->index)
> -				   * (PAGE_CACHE_SIZE
> -				      / crypt_stat->extent_size))
> -				  + extent_offset), crypt_stat);
> -		rc = ecryptfs_write_lower(ecryptfs_inode, enc_extent_virt,
> -					  offset, crypt_stat->extent_size);
> -		if (rc < 0) {
> -			ecryptfs_printk(KERN_ERR, "Error attempting "
> -					"to write lower page; rc = [%d]"
> -					"\n", rc);
> +		extent_crypt_req = ecryptfs_alloc_extent_crypt_req(
> +					page_crypt_req, crypt_stat);
> +		if (!extent_crypt_req) {
> +			rc = -ENOMEM;
> +			ecryptfs_printk(KERN_ERR,
> +					"Failed to allocate extent crypt "
> +					"request for encryption\n");
>  			goto out;
>  		}
> +		extent_crypt_req->inode = ecryptfs_inode;
> +		extent_crypt_req->enc_extent_page = enc_extent_page;
> +		extent_crypt_req->extent_offset = extent_offset;
> +
> +		/* Error handling is done in the completion routine. */
> +		ecryptfs_encrypt_extent(extent_crypt_req,
> +					ecryptfs_encrypt_extent_done);
>  	}
>  	rc = 0;
>  out:
> -	if (enc_extent_page) {
> -		kunmap(enc_extent_page);
> -		__free_page(enc_extent_page);
> +	/* Only call the completion routine if we did not fire off any extent
> +	 * encryption requests.  If at least one call to
> +	 * ecryptfs_encrypt_extent succeeded, it will call the completion
> +	 * routine.
> +	 */
> +	if (rc && extent_offset == 0) {
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
> +	page_crypt_req = ecryptfs_alloc_page_crypt_req(page, NULL);
> +	if (!page_crypt_req) {
> +		rc = -ENOMEM;
> +		ecryptfs_printk(KERN_ERR,
> +				"Failed to allocate page crypt request "
> +				"for encryption\n");
> +		goto out;
> +	}
> +	ecryptfs_encrypt_page_async(page_crypt_req);
> +	wait_for_completion(&page_crypt_req->completion);
> +	rc = atomic_read(&page_crypt_req->rc);
> +out:
> +	if (page_crypt_req)
> +		ecryptfs_free_page_crypt_req(page_crypt_req);
>  	return rc;
>  }
>  
> -static int ecryptfs_decrypt_extent(struct page *page,
> -				   struct ecryptfs_crypt_stat *crypt_stat,
> -				   struct page *enc_extent_page,
> -				   unsigned long extent_offset)
> +/**
> + * ecryptfs_decrypt_extent
> + * @extent_crypt_req: Crypt request that describes the extent that needs to be
> + *                    decrypted
> + * @completion: Function that is called back when the decryption is completed
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
> +	struct ecryptfs_crypt_stat *crypt_stat = extent_crypt_req->crypt_stat;
> +	struct page *page = extent_crypt_req->page_crypt_req->page;
> +	struct page *enc_extent_page = extent_crypt_req->enc_extent_page;
> +	unsigned long extent_offset = extent_crypt_req->extent_offset;
>  	loff_t extent_base;
> -	char extent_iv[ECRYPTFS_MAX_IV_BYTES];
> +	char *extent_iv = extent_crypt_req->extent_iv;
>  	int rc;
>  
>  	extent_base = (((loff_t)page->index)
> @@ -524,12 +769,21 @@ static int ecryptfs_decrypt_extent(struct page *page,
>  			(unsigned long long)(extent_base + extent_offset), rc);
>  		goto out;
>  	}
> -	rc = ecryptfs_decrypt_page_offset(crypt_stat, page,
> +	ablkcipher_request_set_callback(extent_crypt_req->req,
> +					CRYPTO_TFM_REQ_MAY_BACKLOG |
> +					CRYPTO_TFM_REQ_MAY_SLEEP,
> +					completion, extent_crypt_req);
> +	rc = ecryptfs_decrypt_page_offset(extent_crypt_req, page,
>  					  (extent_offset
>  					   * crypt_stat->extent_size),
>  					  enc_extent_page, 0,
> -					  crypt_stat->extent_size, extent_iv);
> -	if (rc < 0) {
> +					  crypt_stat->extent_size);
> +	if (!rc) {
> +		/* Request completed synchronously */
> +		struct crypto_async_request dummy;
> +		dummy.data = extent_crypt_req;
> +		completion(&dummy, rc);
> +	} else if (rc != -EBUSY && rc != -EINPROGRESS) {
>  		printk(KERN_ERR "%s: Error attempting to decrypt to page with "
>  		       "page->index = [%ld], extent_offset = [%ld]; "
>  		       "rc = [%d]\n", __func__, page->index, extent_offset,
> @@ -538,32 +792,80 @@ static int ecryptfs_decrypt_extent(struct page *page,
>  	}
>  	rc = 0;
>  out:
> -	return rc;
> +	if (rc) {
> +		struct crypto_async_request dummy;
> +		dummy.data = extent_crypt_req;
> +		completion(&dummy, rc);
> +	}
>  }
>  
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
> +	struct ecryptfs_extent_crypt_req *extent_crypt_req = req->data;
> +	struct ecryptfs_crypt_stat *crypt_stat = extent_crypt_req->crypt_stat;
> +	struct page *page = extent_crypt_req->page_crypt_req->page;
> +	unsigned long extent_offset = extent_crypt_req->extent_offset;
> +	loff_t extent_base;
> +
> +	if (!err && unlikely(ecryptfs_verbosity > 0)) {
> +		extent_base = (((loff_t)page->index)
> +			       * (PAGE_CACHE_SIZE / crypt_stat->extent_size));
> +		ecryptfs_printk(KERN_DEBUG, "Decrypt extent [0x%.16llx]; "
> +				"rc = [%d]\n",
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
> +		       "rc = [%d]\n", __func__, err);
> +	}
> +
> +	__free_page(extent_crypt_req->enc_extent_page);
> +	ecryptfs_free_extent_crypt_req(extent_crypt_req);
> +}
> +
> +/**
> + * ecryptfs_decrypt_page_async
> + * @page_crypt_req: Page level decryption request which contains the page
> + *                  mapped from the eCryptfs inode for the file; data read
> + *                  and decrypted from the lower file will be written into
> + *                  this page
>   *
> - * Decrypt an eCryptfs page. This is done on a per-extent basis. Note
> - * that eCryptfs pages may straddle the lower pages -- for instance,
> - * if the file was created on a machine with an 8K page size
> - * (resulting in an 8K header), and then the file is copied onto a
> - * host with a 32K page size, then when reading page 0 of the eCryptfs
> + * Function that asynchronously decrypts an eCryptfs page.
> + * This is done on a per-extent basis. Note that eCryptfs pages may straddle
> + * the lower pages -- for instance, if the file was created on a machine with
> + * an 8K page size (resulting in an 8K header), and then the file is copied
> + * onto a host with a 32K page size, then when reading page 0 of the eCryptfs
>   * file, 24K of page 0 of the lower file will be read and decrypted,
>   * and then 8K of page 1 of the lower file will be read and decrypted.
>   *
> - * Returns zero on success; negative on error
> + * Status code is returned in the completion routine (zero on success;
> + * negative on error).
>   */
> -int ecryptfs_decrypt_page(struct page *page)
> +void ecryptfs_decrypt_page_async(struct ecryptfs_page_crypt_req *page_crypt_req)
>  {
> +	struct page *page = page_crypt_req->page;
>  	struct inode *ecryptfs_inode;
>  	struct ecryptfs_crypt_stat *crypt_stat;
>  	char *enc_extent_virt;
>  	struct page *enc_extent_page = NULL;
> -	unsigned long extent_offset;
> +	struct ecryptfs_extent_crypt_req *extent_crypt_req = NULL;
> +	unsigned long extent_offset = 0;
>  	int rc = 0;
>  
>  	ecryptfs_inode = page->mapping->host;
> @@ -574,7 +876,7 @@ int ecryptfs_decrypt_page(struct page *page)
>  	if (!enc_extent_page) {
>  		rc = -ENOMEM;
>  		ecryptfs_printk(KERN_ERR, "Error allocating memory for "
> -				"encrypted extent\n");
> +				"decrypted extent\n");
>  		goto out;
>  	}
>  	enc_extent_virt = kmap(enc_extent_page);
> @@ -596,123 +898,174 @@ int ecryptfs_decrypt_page(struct page *page)
>  					"\n", rc);
>  			goto out;
>  		}
> -		rc = ecryptfs_decrypt_extent(page, crypt_stat, enc_extent_page,
> -					     extent_offset);
> -		if (rc) {
> -			printk(KERN_ERR "%s: Error encrypting extent; "
> -			       "rc = [%d]\n", __func__, rc);
> +
> +		extent_crypt_req = ecryptfs_alloc_extent_crypt_req(
> +					page_crypt_req, crypt_stat);
> +		if (!extent_crypt_req) {
> +			rc = -ENOMEM;
> +			ecryptfs_printk(KERN_ERR,
> +					"Failed to allocate extent crypt "
> +					"request for decryption\n");
>  			goto out;
>  		}
> +		extent_crypt_req->enc_extent_page = enc_extent_page;
> +
> +		/* Error handling is done in the completion routine. */
> +		ecryptfs_decrypt_extent(extent_crypt_req,
> +					ecryptfs_decrypt_extent_done);
>  	}
> +	rc = 0;
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
> +	if (rc && extent_offset == 0) {
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
> +	page_crypt_req = ecryptfs_alloc_page_crypt_req(page, NULL);
> +	if (!page_crypt_req) {
> +		rc = -ENOMEM;
> +		ecryptfs_printk(KERN_ERR,
> +				"Failed to allocate page crypt request "
> +				"for decryption\n");
> +		goto out;
>  	}
> +	ecryptfs_decrypt_page_async(page_crypt_req);
> +	wait_for_completion(&page_crypt_req->completion);
> +	rc = atomic_read(&page_crypt_req->rc);
> +out:
> +	if (page_crypt_req)
> +		ecryptfs_free_page_crypt_req(page_crypt_req);
>  	return rc;
>  }
>  
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
> -	struct blkcipher_desc desc = {
> -		.tfm = crypt_stat->tfm,
> -		.info = iv,
> -		.flags = CRYPTO_TFM_REQ_MAY_SLEEP
> -	};
>  	int rc = 0;
> -
> +	BUG_ON(!crypt_stat || !crypt_stat->tfm
> +	       || !(crypt_stat->flags & ECRYPTFS_STRUCT_INITIALIZED));
>  	/* Consider doing this once, when the file is opened */
>  	mutex_lock(&crypt_stat->cs_tfm_mutex);
> -	rc = crypto_blkcipher_setkey(crypt_stat->tfm, crypt_stat->key,
> -				     crypt_stat->key_size);
> -	if (rc) {
> -		ecryptfs_printk(KERN_ERR, "Error setting key; rc = [%d]\n",
> -				rc);
> -		mutex_unlock(&crypt_stat->cs_tfm_mutex);
> -		rc = -EINVAL;
> -		goto out;
> +	if (!(crypt_stat->flags & ECRYPTFS_KEY_SET)) {
> +		rc = crypto_ablkcipher_setkey(crypt_stat->tfm, crypt_stat->key,
> +					      crypt_stat->key_size);
> +		if (rc) {
> +			ecryptfs_printk(KERN_ERR,
> +					"Error setting key; rc = [%d]\n",
> +					rc);
> +			mutex_unlock(&crypt_stat->cs_tfm_mutex);
> +			rc = -EINVAL;
> +			goto out;
> +		}
> +		crypt_stat->flags |= ECRYPTFS_KEY_SET;
>  	}
> -	ecryptfs_printk(KERN_DEBUG, "Decrypting [%d] bytes.\n", size);
> -	rc = crypto_blkcipher_decrypt_iv(&desc, dest_sg, src_sg, size);
>  	mutex_unlock(&crypt_stat->cs_tfm_mutex);
> -	if (rc) {
> -		ecryptfs_printk(KERN_ERR, "Error decrypting; rc = [%d]\n",
> -				rc);
> -		goto out;
> -	}
> -	rc = size;
> +	ecryptfs_printk(KERN_DEBUG, "Decrypting [%d] bytes.\n", size);
> +	ablkcipher_request_set_crypt(req, src_sg, dest_sg, size, iv);
> +	rc = crypto_ablkcipher_decrypt(req);
>  out:
>  	return rc;
>  }
>  
>  /**
>   * ecryptfs_encrypt_page_offset
> - * @crypt_stat: The cryptographic context
> + * @extent_crypt_req: Crypt request that describes the extent that needs to be
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
> +ecryptfs_encrypt_page_offset(struct ecryptfs_extent_crypt_req *extent_crypt_req,
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
>  
>  /**
>   * ecryptfs_decrypt_page_offset
> - * @crypt_stat: The cryptographic context
> + * @extent_crypt_req: Crypt request that describes the extent that needs to be
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
> +ecryptfs_decrypt_page_offset(struct ecryptfs_extent_crypt_req *extent_crypt_req,
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
>  
>  #define ECRYPTFS_MAX_SCATTERLIST_LEN 4
> @@ -749,8 +1102,7 @@ int ecryptfs_init_crypt_ctx(struct ecryptfs_crypt_stat *crypt_stat)
>  						    crypt_stat->cipher, "cbc");
>  	if (rc)
>  		goto out_unlock;
> -	crypt_stat->tfm = crypto_alloc_blkcipher(full_alg_name, 0,
> -						 CRYPTO_ALG_ASYNC);
> +	crypt_stat->tfm = crypto_alloc_ablkcipher(full_alg_name, 0, 0);
>  	kfree(full_alg_name);
>  	if (IS_ERR(crypt_stat->tfm)) {
>  		rc = PTR_ERR(crypt_stat->tfm);
> @@ -760,7 +1112,7 @@ int ecryptfs_init_crypt_ctx(struct ecryptfs_crypt_stat *crypt_stat)
>  				crypt_stat->cipher);
>  		goto out_unlock;
>  	}
> -	crypto_blkcipher_set_flags(crypt_stat->tfm, CRYPTO_TFM_REQ_WEAK_KEY);
> +	crypto_ablkcipher_set_flags(crypt_stat->tfm, CRYPTO_TFM_REQ_WEAK_KEY);
>  	rc = 0;
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
>  
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
>  
>  struct ecryptfs_open_req {
>  #define ECRYPTFS_REQ_PROCESSED 0x00000001
> @@ -565,6 +568,30 @@ struct ecryptfs_open_req {
>  	struct list_head kthread_ctl_list;
>  };
>  
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
>  		.name = "ecryptfs_open_req_cache",
>  		.size = sizeof(struct ecryptfs_open_req),
>  	},
> +	{
> +		.cache = &ecryptfs_page_crypt_req_cache,
> +		.name = "ecryptfs_page_crypt_req_cache",
> +		.size = sizeof(struct ecryptfs_page_crypt_req),
> +	},
> +	{
> +		.cache = &ecryptfs_extent_crypt_req_cache,
> +		.name = "ecryptfs_extent_crypt_req_cache",
> +		.size = sizeof(struct ecryptfs_extent_crypt_req),
> +	},
>  };
>  
>  static void ecryptfs_free_kmem_caches(void)
> diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
> index a46b3a8..fdfd0df 100644
> --- a/fs/ecryptfs/mmap.c
> +++ b/fs/ecryptfs/mmap.c
> @@ -53,6 +53,31 @@ struct page *ecryptfs_get_locked_page(struct inode *inode, loff_t index)
>  }
>  
>  /**
> + * ecryptfs_writepage_complete
> + * @page_crypt_req: The encrypt page request that completed
> + *
> + * Calls when the requested page has been encrypted and written to the lower
> + * file system.
> + */
> +static void ecryptfs_writepage_complete(
> +		struct ecryptfs_page_crypt_req *page_crypt_req)
> +{
> +	struct page *page = page_crypt_req->page;
> +	int rc;
> +	rc = atomic_read(&page_crypt_req->rc);
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
> @@ -64,7 +89,8 @@ struct page *ecryptfs_get_locked_page(struct inode *inode, loff_t index)
>   */
>  static int ecryptfs_writepage(struct page *page, struct writeback_control *wbc)
>  {
> -	int rc;
> +	struct ecryptfs_page_crypt_req *page_crypt_req;
> +	int rc = 0;
>  
>  	/*
>  	 * Refuse to write the page out if we are called from reclaim context
> @@ -74,18 +100,20 @@ static int ecryptfs_writepage(struct page *page, struct writeback_control *wbc)
>  	 */
>  	if (current->flags & PF_MEMALLOC) {
>  		redirty_page_for_writepage(wbc, page);
> -		rc = 0;
>  		goto out;
>  	}
>  
> -	rc = ecryptfs_encrypt_page(page);
> -	if (rc) {
> -		ecryptfs_printk(KERN_WARNING, "Error encrypting "
> -				"page (upper index [0x%.16lx])\n", page->index);
> -		ClearPageUptodate(page);
> +	page_crypt_req = ecryptfs_alloc_page_crypt_req(
> +				page, ecryptfs_writepage_complete);
> +	if (unlikely(!page_crypt_req)) {
> +		rc = -ENOMEM;
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
>  
>  /**
> + * ecryptfs_readpage_complete
> + * @page_crypt_req: The decrypt page request that completed
> + *
> + * Calls when the requested page has been read and decrypted.
> + */
> +static void ecryptfs_readpage_complete(
> +		struct ecryptfs_page_crypt_req *page_crypt_req)
> +{
> +	struct page *page = page_crypt_req->page;
> +	int rc;
> +	rc = atomic_read(&page_crypt_req->rc);
> +	if (unlikely(rc)) {
> +		ecryptfs_printk(KERN_ERR, "Error decrypting page; "
> +				"rc = [%d]\n", rc);
> +		ClearPageUptodate(page);
> +		SetPageError(page);
> +	} else {
> +		SetPageUptodate(page);
> +	}
> +	ecryptfs_printk(KERN_DEBUG, "Unlocking page with index = [0x%.16lx]\n",
> +			page->index);
> +	unlock_page(page);
> +	ecryptfs_free_page_crypt_req(page_crypt_req);
> +}
> +
> +/**
>   * ecryptfs_readpage
>   * @file: An eCryptfs file
>   * @page: Page from eCryptfs inode mapping into which to stick the read data
> @@ -207,6 +261,7 @@ static int ecryptfs_readpage(struct file *file, struct page *page)
>  {
>  	struct ecryptfs_crypt_stat *crypt_stat =
>  		&ecryptfs_inode_to_private(page->mapping->host)->crypt_stat;
> +	struct ecryptfs_page_crypt_req *page_crypt_req = NULL;
>  	int rc = 0;
>  
>  	if (!crypt_stat || !(crypt_stat->flags & ECRYPTFS_ENCRYPTED)) {
> @@ -237,21 +292,27 @@ static int ecryptfs_readpage(struct file *file, struct page *page)
>  			}
>  		}
>  	} else {
> -		rc = ecryptfs_decrypt_page(page);
> -		if (rc) {
> -			ecryptfs_printk(KERN_ERR, "Error decrypting page; "
> -					"rc = [%d]\n", rc);
> +		page_crypt_req = ecryptfs_alloc_page_crypt_req(
> +					page, ecryptfs_readpage_complete);
> +		if (!page_crypt_req) {
> +			rc = -ENOMEM;
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
>  	ecryptfs_printk(KERN_DEBUG, "Unlocking page with index = [0x%.16lx]\n",
>  			page->index);
>  	unlock_page(page);
> +out_async_started:
>  	return rc;
>  }
>  
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
> the body of a message to majordomo@xxxxxxxxxxxxxxx
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

