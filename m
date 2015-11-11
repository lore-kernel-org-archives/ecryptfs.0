From: andreym@codeaurora.org
Subject: Re: [PATCH v1] eCryptfs: enhancing eCryptfs to be used with external
 crypto engine
Date: Wed, 11 Nov 2015 12:03:35 -0000
Message-ID: <2cc3f8be6a459fdd0252d5fbed01cfee.squirrel@www.codeaurora.org>
References: <1446970202-18514-1-git-send-email-andreym@codeaurora.org>
    <20151109175546.GB29708@boyd>
    <ffb284e4b9c148a8d0c217fef67d9156.squirrel@www.codeaurora.org>
    <20151109210536.GC29708@boyd>
    <9607bc288c2f7eb2ae7e302772cb8057.squirrel@www.codeaurora.org>
    <20151110221803.GB9683@boyd>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:59163 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752563AbbKKMDj (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Wed, 11 Nov 2015 07:03:39 -0500
In-Reply-To: <20151110221803.GB9683@boyd>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Tyler Hicks <tyhicks@canonical.com>
Cc: andreym@codeaurora.org, ecryptfs@vger.kernel.org, linaz@codeaurora.org, Andrey Markovytch <andreym@qti.qualcomm.com>, open list <linux-kernel@vger.kernel.org>

> On 2015-11-10 15:20:59, andreym@codeaurora.org wrote:
>> This is a hardware inline accelerator, meaning that it operates on much
>> lower layer, block layer and device driver layer. The HW encrypts plain
>> requests sent from block layer directly, thus doing it much more
>> efficiently rather than using crypto API.
>

> I feel like basing this on eCryptfs is an odd choice. The overhead of
> setting up an eCryptfs mount (and requiring CAP_SYS_ADMIN) and the
> duplication of page cache and dentry cache entries (for upper and lower
> caches) seems like considerable baggage for such a nifty, new hardware
> feature.
>

First of all, one of the leading companies on the mobile market uses
eCryptfs as a solution for their file-based-encryption feature and they
use it along with HW crypto engine. I believe we will soon see interest
from additional companies.

Secondly, eCryptfs is convenient in many ways for implementing
file-based-encryption and there are not so many good alternatives as of
today. You are right regarding overhead, page duplication, etc., however
enabling eCryptfs to work with HW encryption still makes it a very
efficient solution. Also, it is not just inline HW crypto engine, any HW
crypto engine operates more efficiently while working on long chunks of
data. Our suggested solution uses the existing block layer (that is part
of the standard Linux storage stack) feature that gathers number of block
to into one request and then encrypt/decrypt the data, whereas eCryptfs
can only perform the crypto operation on single pages. This feature was
tested on our platforms and demonstrated very significance performance
improvement comparing to existing SW based solutions

>> In order to use such HW efficiently with eCryptfs, eCryptfs encryption
>> has
>> to be canceled and it will need to call for external module instead that
>> will do the correct marking for the blocks to distinguish between those
>> that need to be encrypted by the HW from those that do not need.
>>
>> We are considering posting the code that will call
>> ecryptfs_register_to_events() as a separate patch, but haven't done so
>> yet. It is HW specific.
>> Currently we are only proposing framework change so that it can allow
>> for
>> external modules to be connected
>
> In that case, I cannot accept this patch. I will have no way to test the
> external module functionality and will not be able to make changes to
> that area of the code because it will not be possible for me to fix
> anything that I've broken. I won't even be able to know if I've broken
> anything.
>
> If you are able to upstream the external module code, then I'll do a
> proper review of this patch. I should note that I've only glanced at the
> patch but if feels like it should be broken up into smaller, easier to
> review patches before it can be properly reviewed.
>
> Tyler

We can upstream the external module code, however as I mentioned this
module is specific for our HW, so you won't be able to test it either.
However we can pretty easily turn it into some dummy module for testing
purposes only that will just do prints instead of HW specific calls. Would
this be sufficient ? If so, where in project tree should I put it ?

>
>>
>> > On 2015-11-09 20:56:02, andreym@codeaurora.org wrote:
>> >> Hello, Tyler
>> >>
>> >> I'll try to provide more detailed explanation, should it be
>> satisfactory
>> >> enough I will update the patch description.
>> >>
>> >> The problem with current eCryptfs is that it has total control on how
>> >> and
>> >> when the encryption is performed and this control can't be altered.
>> One
>> >> example when this can be a problem is when we want to utilize an
>> >> underlying inline HW encryption engine which allows encrypting blocks
>> >> 'on
>> >> the fly' as they are being written to the storage. In such a case
>> >> relevant
>> >> blocks just need to be marked as 'should be encrypted'. No actual
>> >> encryption should be done by eCryptfs as it will be much slower.
>> >
>> > Is this a hardware crypto accelerator? If so, why not create a crypto
>> > api driver so all subsystems can take advantage of the acceleration
>> > instead of baking support into individual subsystems?
>> >
>> >> The provided framework allows transferring this control (if needed)
>> to
>> >> some external module which will do the encryption itfelf or just mark
>> >> the
>> >> appropriate blocks.
>> >>
>> >> There is no caller for ecryptfs_register_to_events() since this
>> change
>> >> only provides framework, it doesn't provide the module itself, the
>> >> module
>> >> could be HW dependent.
>> >
>> > Will the code that you plan to call ecryptfs_register_to_events() be
>> > upstream? If so, have you posted it?
>> >
>> > Tyler
>> >
>> >> Regarding the mounting option, it merely serves as example of new
>> cipher
>> >> mode that can be served by registered module.
>> >> There is a special callback function that should be implemented by
>> the
>> >> registered module that tells whether a particular cipher is supported
>> by
>> >> it :
>> >> is_cipher_supported_cb()
>> >>
>> >> The mounting option itself is not necessary, I can remove it
>> >>
>> >> > Hello Andrey!
>> >> >
>> >> > On 2015-11-08 10:10:00, Andrey Markovytch wrote:
>> >> >> From: Andrey Markovytch <andreym@qti.qualcomm.com>
>> >> >>
>> >> >> Currently eCryptfs is responsible for page encryption/decryption.
>> >> >> This approach will not work when there is HW inline encryption.
>> >> >> The proposed change allows external module to register with
>> eCryptfs
>> >> >> and provide alternative encryption mechanism and also decide
>> whether
>> >> >> encryption should be performed at all, or deferred to a later
>> stage
>> >> via
>> >> >> the inline HW engine.
>> >> >> Additional cipher option was introduced to support the HW/external
>> >> mode
>> >> >> under that name of "aes-xts". If no external module has registered
>> >> >> to support this cipher, eCryptfs will fall back to the usual "aes"
>> >> >
>> >> > What is "HW/external mode"? There's no description in the commit
>> >> message
>> >> > and ecryptfs_register_to_events() does not have a caller so I'm not
>> >> sure
>> >> > of the purpose. Please provide more context.
>> >> >
>> >> > Despite not yet understanding the purpose of this patch, I think
>> that
>> >> I
>> >> > can safely say that "aes-xts" is not an appropriate mount option to
>> >> use
>> >> > when enabling this mode. eCryptfs may support XTS mode one day,
>> using
>> >> > the Crypto API, so "HW/external mode" should not own the mount
>> option.
>> >> >
>> >> > Tyler
>> >> >
>> >> >>
>> >> >> Signed-off-by: Lina Zarivach <linaz@codeaurora.org>
>> >> >> Signed-off-by: Andrey Markovytch <andreym@codeaurora.org>
>> >> >> ---
>> >> >>  fs/ecryptfs/Makefile          |   4 +-
>> >> >>  fs/ecryptfs/caches_utils.c    |  78 +++++++++
>> >> >>  fs/ecryptfs/crypto.c          | 200 +++++++++++++++++++----
>> >> >>  fs/ecryptfs/debug.c           |  13 ++
>> >> >>  fs/ecryptfs/ecryptfs_kernel.h |  78 +++++++++
>> >> >>  fs/ecryptfs/events.c          | 361
>> >> >> ++++++++++++++++++++++++++++++++++++++++++
>> >> >>  fs/ecryptfs/file.c            |  36 +++++
>> >> >>  fs/ecryptfs/inode.c           |  11 ++
>> >> >>  fs/ecryptfs/keystore.c        | 101 ++++++++----
>> >> >>  fs/ecryptfs/main.c            |  60 +++++--
>> >> >>  fs/ecryptfs/mmap.c            |   6 +
>> >> >>  fs/ecryptfs/super.c           |  14 +-
>> >> >>  include/linux/ecryptfs.h      |  47 ++++++
>> >> >>  13 files changed, 940 insertions(+), 69 deletions(-)
>> >> >>  create mode 100644 fs/ecryptfs/caches_utils.c
>> >> >>  create mode 100644 fs/ecryptfs/events.c
>> >> >>
>> >> >> diff --git a/fs/ecryptfs/Makefile b/fs/ecryptfs/Makefile
>> >> >> index 49678a6..995719c 100644
>> >> >> --- a/fs/ecryptfs/Makefile
>> >> >> +++ b/fs/ecryptfs/Makefile
>> >> >> @@ -4,7 +4,7 @@
>> >> >>
>> >> >>  obj-$(CONFIG_ECRYPT_FS) += ecryptfs.o
>> >> >>
>> >> >> -ecryptfs-y := dentry.o file.o inode.o main.o super.o mmap.o
>> >> >> read_write.o \
>> >> >> -	      crypto.o keystore.o kthread.o debug.o
>> >> >> +ecryptfs-y := dentry.o file.o inode.o main.o super.o mmap.o
>> >> >> read_write.o events.o \
>> >> >> +	      crypto.o keystore.o kthread.o debug.o caches_utils.o
>> >> >>
>> >> >>  ecryptfs-$(CONFIG_ECRYPT_FS_MESSAGING) += messaging.o miscdev.o
>> >> >> diff --git a/fs/ecryptfs/caches_utils.c
>> b/fs/ecryptfs/caches_utils.c
>> >> >> new file mode 100644
>> >> >> index 0000000..c599c96
>> >> >> --- /dev/null
>> >> >> +++ b/fs/ecryptfs/caches_utils.c
>> >> >> @@ -0,0 +1,78 @@
>> >> >> +/*
>> >> >> + * Copyright (c) 2015, The Linux Foundation. All rights reserved.
>> >> >> + *
>> >> >> + * This program is free software; you can redistribute it and/or
>> >> modify
>> >> >> + * it under the terms of the GNU General Public License version 2
>> >> and
>> >> >> + * only version 2 as published by the Free Software Foundation.
>> >> >> + *
>> >> >> + * This program is distributed in the hope that it will be
>> useful,
>> >> >> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> >> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> >> >> + * GNU General Public License for more details.
>> >> >> + */
>> >> >> +
>> >> >> +#include <linux/kernel.h>
>> >> >> +#include <linux/fs.h>
>> >> >> +#include <linux/spinlock.h>
>> >> >> +#include <linux/pagemap.h>
>> >> >> +#include <linux/pagevec.h>
>> >> >> +
>> >> >> +#include "../internal.h"
>> >> >> +
>> >> >> +void ecryptfs_drop_pagecache_sb(struct super_block *sb, void
>> >> *unused)
>> >> >> +{
>> >> >> +	struct inode *inode, *toput_inode = NULL;
>> >> >> +
>> >> >> +	spin_lock(&sb->s_inode_list_lock);
>> >> >> +	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
>> >> >> +		spin_lock(&inode->i_lock);
>> >> >> +		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) ||
>> >> >> +		    (inode->i_mapping->nrpages == 0)) {
>> >> >> +			spin_unlock(&inode->i_lock);
>> >> >> +			continue;
>> >> >> +		}
>> >> >> +		__iget(inode);
>> >> >> +		spin_unlock(&inode->i_lock);
>> >> >> +		spin_unlock(&sb->s_inode_list_lock);
>> >> >> +
>> >> >> +		invalidate_mapping_pages(inode->i_mapping, 0, -1);
>> >> >> +		iput(toput_inode);
>> >> >> +		toput_inode = inode;
>> >> >> +
>> >> >> +		spin_lock(&sb->s_inode_list_lock);
>> >> >> +	}
>> >> >> +	spin_unlock(&sb->s_inode_list_lock);
>> >> >> +	iput(toput_inode);
>> >> >> +}
>> >> >> +
>> >> >> +void clean_inode_pages(struct address_space *mapping,
>> >> >> +		pgoff_t start, pgoff_t end)
>> >> >> +{
>> >> >> +	struct pagevec pvec;
>> >> >> +		pgoff_t index = start;
>> >> >> +		int i;
>> >> >> +
>> >> >> +		pagevec_init(&pvec, 0);
>> >> >> +		while (index <= end && pagevec_lookup(&pvec, mapping, index,
>> >> >> +				min(end - index,
>> >> >> +					(pgoff_t)PAGEVEC_SIZE - 1) + 1)) {
>> >> >> +			for (i = 0; i < pagevec_count(&pvec); i++) {
>> >> >> +				struct page *page = pvec.pages[i];
>> >> >> +
>> >> >> +				/* We rely upon deletion
>> >> >> +				 * not changing page->index
>> >> >> +				 */
>> >> >> +				index = page->index;
>> >> >> +				if (index > end)
>> >> >> +					break;
>> >> >> +				if (!trylock_page(page))
>> >> >> +					continue;
>> >> >> +				WARN_ON(page->index != index);
>> >> >> +				zero_user(page, 0, PAGE_CACHE_SIZE);
>> >> >> +				unlock_page(page);
>> >> >> +			}
>> >> >> +			pagevec_release(&pvec);
>> >> >> +			cond_resched();
>> >> >> +			index++;
>> >> >> +		}
>> >> >> +}
>> >> >> diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
>> >> >> index 80d6901..99ebf13 100644
>> >> >> --- a/fs/ecryptfs/crypto.c
>> >> >> +++ b/fs/ecryptfs/crypto.c
>> >> >> @@ -35,6 +35,7 @@
>> >> >>  #include <linux/scatterlist.h>
>> >> >>  #include <linux/slab.h>
>> >> >>  #include <asm/unaligned.h>
>> >> >> +#include <linux/ecryptfs.h>
>> >> >>  #include "ecryptfs_kernel.h"
>> >> >>
>> >> >>  #define DECRYPT		0
>> >> >> @@ -350,9 +351,9 @@ static int crypt_scatterlist(struct
>> >> >> ecryptfs_crypt_stat *crypt_stat,
>> >> >>  	       || !(crypt_stat->flags & ECRYPTFS_STRUCT_INITIALIZED));
>> >> >>  	if (unlikely(ecryptfs_verbosity > 0)) {
>> >> >>  		ecryptfs_printk(KERN_DEBUG, "Key size [%zd]; key:\n",
>> >> >> -				crypt_stat->key_size);
>> >> >> +				ecryptfs_get_key_size_to_enc_data(crypt_stat));
>> >> >>  		ecryptfs_dump_hex(crypt_stat->key,
>> >> >> -				  crypt_stat->key_size);
>> >> >> +				ecryptfs_get_key_size_to_enc_data(crypt_stat));
>> >> >>  	}
>> >> >>
>> >> >>  	init_completion(&ecr.completion);
>> >> >> @@ -371,7 +372,7 @@ static int crypt_scatterlist(struct
>> >> >> ecryptfs_crypt_stat *crypt_stat,
>> >> >>  	/* Consider doing this once, when the file is opened */
>> >> >>  	if (!(crypt_stat->flags & ECRYPTFS_KEY_SET)) {
>> >> >>  		rc = crypto_ablkcipher_setkey(crypt_stat->tfm, crypt_stat->key,
>> >> >> -					      crypt_stat->key_size);
>> >> >> +				ecryptfs_get_key_size_to_enc_data(crypt_stat));
>> >> >>  		if (rc) {
>> >> >>  			ecryptfs_printk(KERN_ERR,
>> >> >>  					"Error setting key; rc = [%d]\n",
>> >> >> @@ -466,6 +467,31 @@ out:
>> >> >>  	return rc;
>> >> >>  }
>> >> >>
>> >> >> +static void init_ecryption_parameters(bool *hw_crypt, bool
>> >> >> *cipher_supported,
>> >> >> +				struct ecryptfs_crypt_stat *crypt_stat)
>> >> >> +{
>> >> >> +	unsigned char final[2*ECRYPTFS_MAX_CIPHER_NAME_SIZE+1];
>> >> >> +
>> >> >> +	if (!hw_crypt || !cipher_supported)
>> >> >> +		return;
>> >> >> +
>> >> >> +	*cipher_supported = false;
>> >> >> +	*hw_crypt = false;
>> >> >> +
>> >> >> +	if (get_events() && get_events()->is_cipher_supported_cb) {
>> >> >> +		*cipher_supported =
>> >> >> +			get_events()->is_cipher_supported_cb(
>> >> >> +				ecryptfs_get_full_cipher(crypt_stat->cipher,
>> >> >> +				crypt_stat->cipher_mode, final, sizeof(final)));
>> >> >> +		if (*cipher_supported) {
>> >> >> +			/* we should apply external algorythm
>> >> >> +			 * assume that is_hw_crypt() cbck is supplied
>> >> >> +			 */
>> >> >> +			*hw_crypt = get_events()->is_hw_crypt_cb();
>> >> >> +		}
>> >> >> +	}
>> >> >> +}
>> >> >> +
>> >> >>  /**
>> >> >>   * ecryptfs_encrypt_page
>> >> >>   * @page: Page mapped from the eCryptfs inode for the file;
>> contains
>> >> >> @@ -491,11 +517,18 @@ int ecryptfs_encrypt_page(struct page *page)
>> >> >>  	loff_t extent_offset;
>> >> >>  	loff_t lower_offset;
>> >> >>  	int rc = 0;
>> >> >> +	bool is_hw_crypt;
>> >> >> +	bool is_cipher_supported;
>> >> >> +
>> >> >>
>> >> >>  	ecryptfs_inode = page->mapping->host;
>> >> >>  	crypt_stat =
>> >> >>  		&(ecryptfs_inode_to_private(ecryptfs_inode)->crypt_stat);
>> >> >>  	BUG_ON(!(crypt_stat->flags & ECRYPTFS_ENCRYPTED));
>> >> >> +
>> >> >> +	init_ecryption_parameters(&is_hw_crypt,
>> >> >> +		&is_cipher_supported, crypt_stat);
>> >> >> +
>> >> >>  	enc_extent_page = alloc_page(GFP_USER);
>> >> >>  	if (!enc_extent_page) {
>> >> >>  		rc = -ENOMEM;
>> >> >> @@ -503,24 +536,51 @@ int ecryptfs_encrypt_page(struct page *page)
>> >> >>  				"encrypted extent\n");
>> >> >>  		goto out;
>> >> >>  	}
>> >> >> -
>> >> >> -	for (extent_offset = 0;
>> >> >> -	     extent_offset < (PAGE_CACHE_SIZE /
>> crypt_stat->extent_size);
>> >> >> -	     extent_offset++) {
>> >> >> -		rc = crypt_extent(crypt_stat, enc_extent_page, page,
>> >> >> -				  extent_offset, ENCRYPT);
>> >> >> -		if (rc) {
>> >> >> -			printk(KERN_ERR "%s: Error encrypting extent; "
>> >> >> -			       "rc = [%d]\n", __func__, rc);
>> >> >> -			goto out;
>> >> >> -		}
>> >> >> +	if (is_hw_crypt) {
>> >> >> +		/* no need for encryption */
>> >> >> +	} else {
>> >> >> +			for (extent_offset = 0;
>> >> >> +				extent_offset <
>> >> >> +				(PAGE_CACHE_SIZE / crypt_stat->extent_size);
>> >> >> +				extent_offset++) {
>> >> >> +
>> >> >> +				if (is_cipher_supported) {
>> >> >> +					if (!get_events()->encrypt_cb) {
>> >> >> +						rc = -EPERM;
>> >> >> +						goto out;
>> >> >> +					}
>> >> >> +					rc = get_events()->encrypt_cb(page,
>> >> >> +						enc_extent_page,
>> >> >> +						ecryptfs_inode_to_lower(
>> >> >> +							ecryptfs_inode),
>> >> >> +							extent_offset);
>> >> >> +				} else {
>> >> >> +					rc = crypt_extent(crypt_stat,
>> >> >> +						enc_extent_page, page,
>> >> >> +						extent_offset, ENCRYPT);
>> >> >> +				}
>> >> >> +				if (rc) {
>> >> >> +					ecryptfs_printk(KERN_ERR,
>> >> >> +					"%s: Error encrypting; rc = [%d]\n",
>> >> >> +					__func__, rc);
>> >> >> +					goto out;
>> >> >> +				}
>> >> >> +			}
>> >> >>  	}
>> >> >>
>> >> >>  	lower_offset = lower_offset_for_page(crypt_stat, page);
>> >> >> -	enc_extent_virt = kmap(enc_extent_page);
>> >> >> +	if (is_hw_crypt)
>> >> >> +		enc_extent_virt = kmap(page);
>> >> >> +	else
>> >> >> +		enc_extent_virt = kmap(enc_extent_page);
>> >> >> +
>> >> >>  	rc = ecryptfs_write_lower(ecryptfs_inode, enc_extent_virt,
>> >> >> lower_offset,
>> >> >>  				  PAGE_CACHE_SIZE);
>> >> >> -	kunmap(enc_extent_page);
>> >> >> +	if (!is_hw_crypt)
>> >> >> +		kunmap(enc_extent_page);
>> >> >> +	else
>> >> >> +		kunmap(page);
>> >> >> +
>> >> >>  	if (rc < 0) {
>> >> >>  		ecryptfs_printk(KERN_ERR,
>> >> >>  			"Error attempting to write lower page; rc = [%d]\n",
>> >> >> @@ -559,6 +619,8 @@ int ecryptfs_decrypt_page(struct page *page)
>> >> >>  	unsigned long extent_offset;
>> >> >>  	loff_t lower_offset;
>> >> >>  	int rc = 0;
>> >> >> +	bool is_cipher_supported;
>> >> >> +	bool is_hw_crypt;
>> >> >>
>> >> >>  	ecryptfs_inode = page->mapping->host;
>> >> >>  	crypt_stat =
>> >> >> @@ -577,13 +639,33 @@ int ecryptfs_decrypt_page(struct page *page)
>> >> >>  		goto out;
>> >> >>  	}
>> >> >>
>> >> >> +	init_ecryption_parameters(&is_hw_crypt,
>> >> >> +		&is_cipher_supported, crypt_stat);
>> >> >> +
>> >> >> +	if (is_hw_crypt) {
>> >> >> +		rc = 0;
>> >> >> +		return rc;
>> >> >> +	}
>> >> >> +
>> >> >>  	for (extent_offset = 0;
>> >> >>  	     extent_offset < (PAGE_CACHE_SIZE /
>> crypt_stat->extent_size);
>> >> >>  	     extent_offset++) {
>> >> >> -		rc = crypt_extent(crypt_stat, page, page,
>> >> >> +		if (is_cipher_supported) {
>> >> >> +			if (!get_events()->decrypt_cb) {
>> >> >> +				rc = -EPERM;
>> >> >> +				goto out;
>> >> >> +			}
>> >> >> +
>> >> >> +			rc = get_events()->decrypt_cb(page, page,
>> >> >> +				ecryptfs_inode_to_lower(ecryptfs_inode),
>> >> >> +				extent_offset);
>> >> >> +
>> >> >> +		} else
>> >> >> +			rc = crypt_extent(crypt_stat, page, page,
>> >> >>  				  extent_offset, DECRYPT);
>> >> >> +
>> >> >>  		if (rc) {
>> >> >> -			printk(KERN_ERR "%s: Error encrypting extent; "
>> >> >> +			ecryptfs_printk(KERN_ERR, "%s: Error decrypting extent;"
>> >> >>  			       "rc = [%d]\n", __func__, rc);
>> >> >>  			goto out;
>> >> >>  		}
>> >> >> @@ -612,7 +694,7 @@ int ecryptfs_init_crypt_ctx(struct
>> >> >> ecryptfs_crypt_stat *crypt_stat)
>> >> >>  			"Initializing cipher [%s]; strlen = [%d]; "
>> >> >>  			"key_size_bits = [%zd]\n",
>> >> >>  			crypt_stat->cipher, (int)strlen(crypt_stat->cipher),
>> >> >> -			crypt_stat->key_size << 3);
>> >> >> +			ecryptfs_get_key_size_to_enc_data(crypt_stat) << 3);
>> >> >>  	mutex_lock(&crypt_stat->cs_tfm_mutex);
>> >> >>  	if (crypt_stat->tfm) {
>> >> >>  		rc = 0;
>> >> >> @@ -694,7 +776,7 @@ int ecryptfs_compute_root_iv(struct
>> >> >> ecryptfs_crypt_stat *crypt_stat)
>> >> >>  		goto out;
>> >> >>  	}
>> >> >>  	rc = ecryptfs_calculate_md5(dst, crypt_stat, crypt_stat->key,
>> >> >> -				    crypt_stat->key_size);
>> >> >> +			ecryptfs_get_key_size_to_enc_data(crypt_stat));
>> >> >>  	if (rc) {
>> >> >>  		ecryptfs_printk(KERN_WARNING, "Error attempting to compute "
>> >> >>  				"MD5 while generating root IV\n");
>> >> >> @@ -721,6 +803,35 @@ static void ecryptfs_generate_new_key(struct
>> >> >> ecryptfs_crypt_stat *crypt_stat)
>> >> >>  	}
>> >> >>  }
>> >> >>
>> >> >> +static int ecryptfs_generate_new_salt(struct ecryptfs_crypt_stat
>> >> >> *crypt_stat)
>> >> >> +{
>> >> >> +	size_t salt_size = 0;
>> >> >> +	unsigned char final[2*ECRYPTFS_MAX_CIPHER_NAME_SIZE+1];
>> >> >> +
>> >> >> +	salt_size = ecryptfs_get_salt_size_for_cipher(
>> >> >> +			ecryptfs_get_full_cipher(crypt_stat->cipher,
>> >> >> +						 crypt_stat->cipher_mode,
>> >> >> +						 final, sizeof(final)));
>> >> >> +
>> >> >> +	if (salt_size == 0)
>> >> >> +		return 0;
>> >> >> +
>> >> >> +	if (!ecryptfs_check_space_for_salt(crypt_stat->key_size,
>> >> salt_size)) {
>> >> >> +		ecryptfs_printk(KERN_WARNING, "not enough space for salt\n");
>> >> >> +		crypt_stat->flags |= ECRYPTFS_SECURITY_WARNING;
>> >> >> +		return -EINVAL;
>> >> >> +	}
>> >> >> +
>> >> >> +	get_random_bytes(crypt_stat->key + crypt_stat->key_size,
>> >> salt_size);
>> >> >> +	if (unlikely(ecryptfs_verbosity > 0)) {
>> >> >> +		ecryptfs_printk(KERN_DEBUG, "Generated new session salt:\n");
>> >> >> +		ecryptfs_dump_hex(crypt_stat->key + crypt_stat->key_size,
>> >> >> +				  salt_size);
>> >> >> +	}
>> >> >> +
>> >> >> +	return 0;
>> >> >> +}
>> >> >> +
>> >> >>  /**
>> >> >>   * ecryptfs_copy_mount_wide_flags_to_inode_flags
>> >> >>   * @crypt_stat: The inode's cryptographic context
>> >> >> @@ -823,7 +934,6 @@ int ecryptfs_new_file_context(struct inode
>> >> >> *ecryptfs_inode)
>> >> >>  	struct ecryptfs_mount_crypt_stat *mount_crypt_stat =
>> >> >>  	    &ecryptfs_superblock_to_private(
>> >> >>  		    ecryptfs_inode->i_sb)->mount_crypt_stat;
>> >> >> -	int cipher_name_len;
>> >> >>  	int rc = 0;
>> >> >>
>> >> >>  	ecryptfs_set_default_crypt_stat_vals(crypt_stat,
>> mount_crypt_stat);
>> >> >> @@ -837,15 +947,19 @@ int ecryptfs_new_file_context(struct inode
>> >> >> *ecryptfs_inode)
>> >> >>  		       "to the inode key sigs; rc = [%d]\n", rc);
>> >> >>  		goto out;
>> >> >>  	}
>> >> >> -	cipher_name_len =
>> >> >> -		strlen(mount_crypt_stat->global_default_cipher_name);
>> >> >> -	memcpy(crypt_stat->cipher,
>> >> >> +	strlcpy(crypt_stat->cipher,
>> >> >>  	       mount_crypt_stat->global_default_cipher_name,
>> >> >> -	       cipher_name_len);
>> >> >> -	crypt_stat->cipher[cipher_name_len] = '\0';
>> >> >> +	       sizeof(crypt_stat->cipher));
>> >> >> +
>> >> >> +	strlcpy(crypt_stat->cipher_mode,
>> >> >> +			mount_crypt_stat->global_default_cipher_mode,
>> >> >> +			sizeof(crypt_stat->cipher_mode));
>> >> >> +
>> >> >>  	crypt_stat->key_size =
>> >> >>  		mount_crypt_stat->global_default_cipher_key_size;
>> >> >>  	ecryptfs_generate_new_key(crypt_stat);
>> >> >> +	ecryptfs_generate_new_salt(crypt_stat);
>> >> >> +
>> >> >>  	rc = ecryptfs_init_crypt_ctx(crypt_stat);
>> >> >>  	if (rc)
>> >> >>  		ecryptfs_printk(KERN_ERR, "Error initializing cryptographic "
>> >> >> @@ -971,7 +1085,8 @@ ecryptfs_cipher_code_str_map[] = {
>> >> >>  	{"twofish", RFC2440_CIPHER_TWOFISH},
>> >> >>  	{"cast6", RFC2440_CIPHER_CAST_6},
>> >> >>  	{"aes", RFC2440_CIPHER_AES_192},
>> >> >> -	{"aes", RFC2440_CIPHER_AES_256}
>> >> >> +	{"aes", RFC2440_CIPHER_AES_256},
>> >> >> +	{"aes_xts", RFC2440_CIPHER_AES_XTS_256}
>> >> >>  };
>> >> >>
>> >> >>  /**
>> >> >> @@ -999,6 +1114,11 @@ u8 ecryptfs_code_for_cipher_string(char
>> >> >> *cipher_name, size_t key_bytes)
>> >> >>  		case 32:
>> >> >>  			code = RFC2440_CIPHER_AES_256;
>> >> >>  		}
>> >> >> +	} else if (strcmp(cipher_name, "aes_xts") == 0) {
>> >> >> +		switch (key_bytes) {
>> >> >> +		case 32:
>> >> >> +			code = RFC2440_CIPHER_AES_XTS_256;
>> >> >> +		}
>> >> >>  	} else {
>> >> >>  		for (i = 0; i < ARRAY_SIZE(ecryptfs_cipher_code_str_map); i++)
>> >> >>  			if (strcmp(cipher_name, map[i].cipher_str) == 0) {
>> >> >> @@ -1038,9 +1158,24 @@ int
>> >> >> ecryptfs_read_and_validate_header_region(struct inode *inode)
>> >> >>  	u8 file_size[ECRYPTFS_SIZE_AND_MARKER_BYTES];
>> >> >>  	u8 *marker = file_size + ECRYPTFS_FILE_SIZE_BYTES;
>> >> >>  	int rc;
>> >> >> +	unsigned int ra_pages_org;
>> >> >> +	struct file *lower_file = NULL;
>> >> >> +
>> >> >> +	if (!inode)
>> >> >> +		return -EIO;
>> >> >> +	lower_file = ecryptfs_inode_to_private(inode)->lower_file;
>> >> >> +	if (!lower_file)
>> >> >> +		return -EIO;
>> >> >> +
>> >> >> +	/*disable read a head mechanism for a while */
>> >> >> +	ra_pages_org = lower_file->f_ra.ra_pages;
>> >> >> +	lower_file->f_ra.ra_pages = 0;
>> >> >>
>> >> >>  	rc = ecryptfs_read_lower(file_size, 0,
>> >> ECRYPTFS_SIZE_AND_MARKER_BYTES,
>> >> >>  				 inode);
>> >> >> +	lower_file->f_ra.ra_pages = ra_pages_org;
>> >> >> +	/* restore read a head mechanism */
>> >> >> +
>> >> >>  	if (rc < ECRYPTFS_SIZE_AND_MARKER_BYTES)
>> >> >>  		return rc >= 0 ? -EINVAL : rc;
>> >> >>  	rc = ecryptfs_validate_marker(marker);
>> >> >> @@ -1430,6 +1565,11 @@ int ecryptfs_read_metadata(struct dentry
>> >> >> *ecryptfs_dentry)
>> >> >>  	struct ecryptfs_mount_crypt_stat *mount_crypt_stat =
>> >> >>  		&ecryptfs_superblock_to_private(
>> >> >>  			ecryptfs_dentry->d_sb)->mount_crypt_stat;
>> >> >> +	unsigned int ra_pages_org;
>> >> >> +	struct file *lower_file =
>> >> >> +		ecryptfs_inode_to_private(ecryptfs_inode)->lower_file;
>> >> >> +	if (!lower_file)
>> >> >> +		return -EIO;
>> >> >>
>> >> >>  	ecryptfs_copy_mount_wide_flags_to_inode_flags(crypt_stat,
>> >> >>  						      mount_crypt_stat);
>> >> >> @@ -1441,8 +1581,14 @@ int ecryptfs_read_metadata(struct dentry
>> >> >> *ecryptfs_dentry)
>> >> >>  		       __func__);
>> >> >>  		goto out;
>> >> >>  	}
>> >> >> +	/*disable read a head mechanism */
>> >> >> +	ra_pages_org = lower_file->f_ra.ra_pages;
>> >> >> +	lower_file->f_ra.ra_pages = 0;
>> >> >> +
>> >> >>  	rc = ecryptfs_read_lower(page_virt, 0, crypt_stat->extent_size,
>> >> >>  				 ecryptfs_inode);
>> >> >> +	lower_file->f_ra.ra_pages = ra_pages_org; /* restore it back */
>> >> >> +
>> >> >>  	if (rc >= 0)
>> >> >>  		rc = ecryptfs_read_headers_virt(page_virt, crypt_stat,
>> >> >>  						ecryptfs_dentry,
>> >> >> diff --git a/fs/ecryptfs/debug.c b/fs/ecryptfs/debug.c
>> >> >> index 3d2bdf5..2b60137 100644
>> >> >> --- a/fs/ecryptfs/debug.c
>> >> >> +++ b/fs/ecryptfs/debug.c
>> >> >> @@ -119,3 +119,16 @@ void ecryptfs_dump_hex(char *data, int bytes)
>> >> >>  		printk("\n");
>> >> >>  }
>> >> >>
>> >> >> +void ecryptfs_dump_salt_hex(char *data, int key_size, char
>> *cipher)
>> >> >> +{
>> >> >> +	size_t salt_size = ecryptfs_get_salt_size_for_cipher(cipher);
>> >> >> +
>> >> >> +	if (salt_size == 0)
>> >> >> +		return;
>> >> >> +
>> >> >> +	if (!ecryptfs_check_space_for_salt(key_size, salt_size))
>> >> >> +		return;
>> >> >> +
>> >> >> +	ecryptfs_printk(KERN_DEBUG, "Decrypted session salt key:\n");
>> >> >> +	ecryptfs_dump_hex(data + key_size, salt_size);
>> >> >> +}
>> >> >> diff --git a/fs/ecryptfs/ecryptfs_kernel.h
>> >> >> b/fs/ecryptfs/ecryptfs_kernel.h
>> >> >> index 5ba029e..56297f3 100644
>> >> >> --- a/fs/ecryptfs/ecryptfs_kernel.h
>> >> >> +++ b/fs/ecryptfs/ecryptfs_kernel.h
>> >> >> @@ -245,6 +245,7 @@ struct ecryptfs_crypt_stat {
>> >> >>  	struct mutex cs_tfm_mutex;
>> >> >>  	struct mutex cs_hash_tfm_mutex;
>> >> >>  	struct mutex cs_mutex;
>> >> >> +	unsigned char cipher_mode[ECRYPTFS_MAX_CIPHER_NAME_SIZE + 1];
>> >> >>  };
>> >> >>
>> >> >>  /* inode private data. */
>> >> >> @@ -267,6 +268,8 @@ struct ecryptfs_dentry_info {
>> >> >>  	};
>> >> >>  };
>> >> >>
>> >> >> +
>> >> >> +
>> >> >>  /**
>> >> >>   * ecryptfs_global_auth_tok - A key used to encrypt all new files
>> >> under
>> >> >> the mountpoint
>> >> >>   * @flags: Status flags
>> >> >> @@ -345,6 +348,8 @@ struct ecryptfs_mount_crypt_stat {
>> >> >>  	unsigned char global_default_fn_cipher_name[
>> >> >>  		ECRYPTFS_MAX_CIPHER_NAME_SIZE + 1];
>> >> >>  	char global_default_fnek_sig[ECRYPTFS_SIG_SIZE_HEX + 1];
>> >> >> +	unsigned char
>> >> global_default_cipher_mode[ECRYPTFS_MAX_CIPHER_NAME_SIZE
>> >> >> +							 + 1];
>> >> >>  };
>> >> >>
>> >> >>  /* superblock private data. */
>> >> >> @@ -527,6 +532,53 @@ ecryptfs_dentry_to_lower_path(struct dentry
>> >> >> *dentry)
>> >> >>  	return &((struct ecryptfs_dentry_info
>> >> *)dentry->d_fsdata)->lower_path;
>> >> >>  }
>> >> >>
>> >> >> +/**
>> >> >> + * Given a cipher and mode strings, the function
>> >> >> + * concatenates them to create a new string of
>> >> >> + * <cipher>_<mode> format.
>> >> >> + */
>> >> >> +static inline unsigned char *ecryptfs_get_full_cipher(
>> >> >> +	unsigned char *cipher, unsigned char *mode,
>> >> >> +	unsigned char *final, size_t final_size)
>> >> >> +{
>> >> >> +	memset(final, 0, final_size);
>> >> >> +
>> >> >> +	if (strlen(mode) > 0) {
>> >> >> +		snprintf(final, final_size, "%s_%s", cipher, mode);
>> >> >> +		return final;
>> >> >> +	}
>> >> >> +
>> >> >> +	return cipher;
>> >> >> +}
>> >> >> +
>> >> >> +/**
>> >> >> + * Given a <cipher>[_<mode>] formatted string, the function
>> >> >> + * extracts cipher string and/or mode string.
>> >> >> + * Note: the passed cipher and/or mode strings will be
>> >> null-terminated.
>> >> >> + */
>> >> >> +static inline void ecryptfs_parse_full_cipher(
>> >> >> +	char *s, char *cipher, char *mode)
>> >> >> +{
>> >> >> +	char input[2*ECRYPTFS_MAX_CIPHER_NAME_SIZE+1+1];
>> >> >> +			/* +1 for '_'; +1 for '\0' */
>> >> >> +	char *p;
>> >> >> +	char *input_p = input;
>> >> >> +
>> >> >> +	if (s == NULL || cipher == NULL)
>> >> >> +		return;
>> >> >> +
>> >> >> +	memset(input, 0, sizeof(input));
>> >> >> +	strlcpy(input, s, sizeof(input));
>> >> >> +
>> >> >> +	p = strsep(&input_p, "_");
>> >> >> +	strlcpy(cipher, p, ECRYPTFS_MAX_CIPHER_NAME_SIZE + 1);
>> >> >> +
>> >> >> +
>> >> >> +	/* check if mode is specified */
>> >> >> +	if (input_p != NULL && mode != NULL)
>> >> >> +		strlcpy(mode, input_p, ECRYPTFS_MAX_CIPHER_NAME_SIZE + 1);
>> >> >> +}
>> >> >> +
>> >> >>  #define ecryptfs_printk(type, fmt, arg...) \
>> >> >>          __ecryptfs_printk(type "%s: " fmt, __func__, ## arg);
>> >> >>  __printf(1, 2)
>> >> >> @@ -575,6 +627,7 @@ int ecryptfs_encrypt_and_encode_filename(
>> >> >>  	const char *name, size_t name_size);
>> >> >>  struct dentry *ecryptfs_lower_dentry(struct dentry *this_dentry);
>> >> >>  void ecryptfs_dump_hex(char *data, int bytes);
>> >> >> +void ecryptfs_dump_salt_hex(char *data, int key_size, char
>> *cipher);
>> >> >>  int virt_to_scatterlist(const void *addr, int size, struct
>> >> scatterlist
>> >> >> *sg,
>> >> >>  			int sg_size);
>> >> >>  int ecryptfs_compute_root_iv(struct ecryptfs_crypt_stat
>> >> *crypt_stat);
>> >> >> @@ -718,4 +771,29 @@ int ecryptfs_set_f_namelen(long *namelen,
>> long
>> >> >> lower_namelen,
>> >> >>  int ecryptfs_derive_iv(char *iv, struct ecryptfs_crypt_stat
>> >> >> *crypt_stat,
>> >> >>  		       loff_t offset);
>> >> >>
>> >> >> +void clean_inode_pages(struct address_space *mapping,
>> >> >> +		pgoff_t start, pgoff_t end);
>> >> >> +
>> >> >> +void ecryptfs_drop_pagecache_sb(struct super_block *sb, void
>> >> *unused);
>> >> >> +
>> >> >> +void ecryptfs_free_events(void);
>> >> >> +
>> >> >> +void ecryptfs_freepage(struct page *page);
>> >> >> +
>> >> >> +struct ecryptfs_events *get_events(void);
>> >> >> +
>> >> >> +size_t ecryptfs_get_salt_size_for_cipher(const char *cipher);
>> >> >> +
>> >> >> +size_t ecryptfs_get_key_size_to_enc_data(
>> >> >> +		struct ecryptfs_crypt_stat *crypt_stat);
>> >> >> +
>> >> >> +size_t ecryptfs_get_key_size_to_store_key(
>> >> >> +		struct ecryptfs_crypt_stat *crypt_stat);
>> >> >> +
>> >> >> +size_t ecryptfs_get_key_size_to_restore_key(size_t
>> stored_key_size,
>> >> >> +		const char *cipher);
>> >> >> +
>> >> >> +bool ecryptfs_check_space_for_salt(const size_t key_size,
>> >> >> +		const size_t salt_size);
>> >> >> +
>> >> >>  #endif /* #ifndef ECRYPTFS_KERNEL_H */
>> >> >> diff --git a/fs/ecryptfs/events.c b/fs/ecryptfs/events.c
>> >> >> new file mode 100644
>> >> >> index 0000000..10a8983
>> >> >> --- /dev/null
>> >> >> +++ b/fs/ecryptfs/events.c
>> >> >> @@ -0,0 +1,361 @@
>> >> >> +/**
>> >> >> + * eCryptfs: Linux filesystem encryption layer
>> >> >> + * Copyright (c) 2015, The Linux Foundation. All rights reserved.
>> >> >> + *
>> >> >> + * This program is free software; you can redistribute it and/or
>> >> modify
>> >> >> + * it under the terms of the GNU General Public License version 2
>> >> and
>> >> >> + * only version 2 as published by the Free Software Foundation.
>> >> >> + *
>> >> >> + * This program is distributed in the hope that it will be
>> useful,
>> >> >> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> >> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> >> >> + * GNU General Public License for more details.
>> >> >> + */
>> >> >> +
>> >> >> +#include <linux/string.h>
>> >> >> +#include <linux/ecryptfs.h>
>> >> >> +#include <linux/mutex.h>
>> >> >> +#include <linux/types.h>
>> >> >> +#include <linux/slab.h>
>> >> >> +#include <linux/pagemap.h>
>> >> >> +#include <linux/random.h>
>> >> >> +#include "ecryptfs_kernel.h"
>> >> >> +
>> >> >> +static DEFINE_MUTEX(events_mutex);
>> >> >> +static struct ecryptfs_events *events_ptr;
>> >> >> +static int handle;
>> >> >> +
>> >> >> +void ecryptfs_free_events(void)
>> >> >> +{
>> >> >> +	mutex_lock(&events_mutex);
>> >> >> +	if (events_ptr != NULL) {
>> >> >> +		kfree(events_ptr);
>> >> >> +		events_ptr = NULL;
>> >> >> +	}
>> >> >> +
>> >> >> +	mutex_unlock(&events_mutex);
>> >> >> +}
>> >> >> +
>> >> >> +/**
>> >> >> + * Register to ecryptfs events, by passing callback
>> >> >> + * functions to be called upon events occurrence.
>> >> >> + * The function returns a handle to be passed
>> >> >> + * to unregister function.
>> >> >> + */
>> >> >> +int ecryptfs_register_to_events(struct ecryptfs_events *ops)
>> >> >> +{
>> >> >> +	int ret_value = 0;
>> >> >> +
>> >> >> +	if (!ops)
>> >> >> +		return -EINVAL;
>> >> >> +
>> >> >> +	mutex_lock(&events_mutex);
>> >> >> +
>> >> >> +	if (events_ptr != NULL) {
>> >> >> +		ecryptfs_printk(KERN_ERR,
>> >> >> +			"already registered!\n");
>> >> >> +		ret_value = -EPERM;
>> >> >> +		goto out;
>> >> >> +	}
>> >> >> +	events_ptr =
>> >> >> +		kzalloc(sizeof(struct ecryptfs_events), GFP_KERNEL);
>> >> >> +
>> >> >> +	if (!events_ptr) {
>> >> >> +		ecryptfs_printk(KERN_ERR, "malloc failure\n");
>> >> >> +		ret_value = -ENOMEM;
>> >> >> +		goto out;
>> >> >> +	}
>> >> >> +	/* copy the callbacks */
>> >> >> +	events_ptr->open_cb = ops->open_cb;
>> >> >> +	events_ptr->release_cb = ops->release_cb;
>> >> >> +	events_ptr->encrypt_cb = ops->encrypt_cb;
>> >> >> +	events_ptr->decrypt_cb = ops->decrypt_cb;
>> >> >> +	events_ptr->is_cipher_supported_cb =
>> >> >> +		ops->is_cipher_supported_cb;
>> >> >> +	events_ptr->is_hw_crypt_cb = ops->is_hw_crypt_cb;
>> >> >> +	events_ptr->get_salt_key_size_cb = ops->get_salt_key_size_cb;
>> >> >> +
>> >> >> +	get_random_bytes(&handle, sizeof(handle));
>> >> >> +	ret_value = handle;
>> >> >> +
>> >> >> +out:
>> >> >> +	mutex_unlock(&events_mutex);
>> >> >> +	return ret_value;
>> >> >> +}
>> >> >> +
>> >> >> +/**
>> >> >> + * Unregister from ecryptfs events.
>> >> >> + */
>> >> >> +int ecryptfs_unregister_from_events(int user_handle)
>> >> >> +{
>> >> >> +	int ret_value = 0;
>> >> >> +
>> >> >> +	mutex_lock(&events_mutex);
>> >> >> +
>> >> >> +	if (!events_ptr) {
>> >> >> +		ret_value = -EINVAL;
>> >> >> +		goto out;
>> >> >> +	}
>> >> >> +	if (user_handle != handle) {
>> >> >> +		ret_value = ECRYPTFS_INVALID_EVENTS_HANDLE;
>> >> >> +		goto out;
>> >> >> +	}
>> >> >> +
>> >> >> +	kfree(events_ptr);
>> >> >> +	events_ptr = NULL;
>> >> >> +
>> >> >> +out:
>> >> >> +	mutex_unlock(&events_mutex);
>> >> >> +	return ret_value;
>> >> >> +}
>> >> >> +
>> >> >> +/**
>> >> >> + * This function decides whether the passed file offset
>> >> >> + * belongs to ecryptfs metadata or not.
>> >> >> + * The caller must pass ecryptfs data, which was received in one
>> >> >> + * of the callback invocations.
>> >> >> + */
>> >> >> +bool ecryptfs_is_page_in_metadata(void *data, pgoff_t offset)
>> >> >> +{
>> >> >> +
>> >> >> +	struct ecryptfs_crypt_stat *stat = NULL;
>> >> >> +	bool ret = true;
>> >> >> +
>> >> >> +	if (!data) {
>> >> >> +		ecryptfs_printk(KERN_ERR, "ecryptfs_is_page_in_metadata:
>> invalid
>> >> data
>> >> >> parameter\n");
>> >> >> +		ret = false;
>> >> >> +		goto end;
>> >> >> +	}
>> >> >> +	stat = (struct ecryptfs_crypt_stat *)data;
>> >> >> +
>> >> >> +	if (stat->flags & ECRYPTFS_METADATA_IN_XATTR) {
>> >> >> +		ret = false;
>> >> >> +		goto end;
>> >> >> +	}
>> >> >> +
>> >> >> +	if (offset >= (stat->metadata_size/PAGE_CACHE_SIZE)) {
>> >> >> +		ret = false;
>> >> >> +		goto end;
>> >> >> +	}
>> >> >> +end:
>> >> >> +	return ret;
>> >> >> +}
>> >> >> +
>> >> >> +/**
>> >> >> + * Given two ecryptfs data, the function
>> >> >> + * decides whether they are equal.
>> >> >> + */
>> >> >> +inline bool ecryptfs_is_data_equal(void *data1, void *data2)
>> >> >> +{
>> >> >> +	/* pointer comparison*/
>> >> >> +	return data1 == data2;
>> >> >> +}
>> >> >> +
>> >> >> +/**
>> >> >> + * Given ecryptfs data, the function
>> >> >> + * returns appropriate key size.
>> >> >> + */
>> >> >> +size_t ecryptfs_get_key_size(void *data)
>> >> >> +{
>> >> >> +
>> >> >> +	struct ecryptfs_crypt_stat *stat = NULL;
>> >> >> +
>> >> >> +	if (!data)
>> >> >> +		return 0;
>> >> >> +
>> >> >> +	stat = (struct ecryptfs_crypt_stat *)data;
>> >> >> +	return stat->key_size;
>> >> >> +}
>> >> >> +
>> >> >> +/**
>> >> >> + * Given ecryptfs data, the function
>> >> >> + * returns appropriate salt size.
>> >> >> + *
>> >> >> + * !!! crypt_stat cipher name and mode must be initialized
>> >> >> + */
>> >> >> +size_t ecryptfs_get_salt_size(void *data)
>> >> >> +{
>> >> >> +	struct ecryptfs_crypt_stat *stat = NULL;
>> >> >> +	unsigned char final[2*ECRYPTFS_MAX_CIPHER_NAME_SIZE+1];
>> >> >> +
>> >> >> +	if (!data) {
>> >> >> +		ecryptfs_printk(KERN_ERR,
>> >> >> +				"ecryptfs_get_salt_size: invalid data parameter\n");
>> >> >> +		return 0;
>> >> >> +	}
>> >> >> +
>> >> >> +	stat = (struct ecryptfs_crypt_stat *)data;
>> >> >> +	return ecryptfs_get_salt_size_for_cipher(
>> >> >> +			ecryptfs_get_full_cipher(stat->cipher,
>> >> >> +						 stat->cipher_mode,
>> >> >> +						 final, sizeof(final)));
>> >> >> +
>> >> >> +}
>> >> >> +
>> >> >> +/**
>> >> >> + * Given ecryptfs data, the function
>> >> >> + * returns appropriate cipher.
>> >> >> + */
>> >> >> +const unsigned char *ecryptfs_get_cipher(void *data)
>> >> >> +{
>> >> >> +	unsigned char final[2*ECRYPTFS_MAX_CIPHER_NAME_SIZE+1];
>> >> >> +	struct ecryptfs_crypt_stat *stat = NULL;
>> >> >> +
>> >> >> +	if (!data) {
>> >> >> +		ecryptfs_printk(KERN_ERR,
>> >> >> +			"ecryptfs_get_cipher: invalid data parameter\n");
>> >> >> +		return NULL;
>> >> >> +	}
>> >> >> +	stat = (struct ecryptfs_crypt_stat *)data;
>> >> >> +	return ecryptfs_get_full_cipher(stat->cipher, stat->cipher_mode,
>> >> >> +			final, sizeof(final));
>> >> >> +}
>> >> >> +
>> >> >> +/**
>> >> >> + * Given ecryptfs data, the function
>> >> >> + * returns file encryption key.
>> >> >> + */
>> >> >> +const unsigned char *ecryptfs_get_key(void *data)
>> >> >> +{
>> >> >> +
>> >> >> +	struct ecryptfs_crypt_stat *stat = NULL;
>> >> >> +
>> >> >> +	if (!data) {
>> >> >> +		ecryptfs_printk(KERN_ERR,
>> >> >> +			"ecryptfs_get_key: invalid data parameter\n");
>> >> >> +		return NULL;
>> >> >> +	}
>> >> >> +	stat = (struct ecryptfs_crypt_stat *)data;
>> >> >> +	return stat->key;
>> >> >> +}
>> >> >> +
>> >> >> +/**
>> >> >> + * Given ecryptfs data, the function
>> >> >> + * returns file encryption salt.
>> >> >> + */
>> >> >> +const unsigned char *ecryptfs_get_salt(void *data)
>> >> >> +{
>> >> >> +	struct ecryptfs_crypt_stat *stat = NULL;
>> >> >> +
>> >> >> +	if (!data) {
>> >> >> +		ecryptfs_printk(KERN_ERR,
>> >> >> +			"ecryptfs_get_salt: invalid data parameter\n");
>> >> >> +		return NULL;
>> >> >> +	}
>> >> >> +	stat = (struct ecryptfs_crypt_stat *)data;
>> >> >> +	return stat->key + ecryptfs_get_salt_size(data);
>> >> >> +}
>> >> >> +
>> >> >> +/**
>> >> >> + * Returns ecryptfs events pointer
>> >> >> + */
>> >> >> +inline struct ecryptfs_events *get_events(void)
>> >> >> +{
>> >> >> +	return events_ptr;
>> >> >> +}
>> >> >> +
>> >> >> +/**
>> >> >> + * If external crypto module requires salt in addition to key,
>> >> >> + * we store it as part of key array (if there is enough space)
>> >> >> + * Checks whether a salt key can fit into array allocated for
>> >> >> + * regular key
>> >> >> + */
>> >> >> +bool ecryptfs_check_space_for_salt(const size_t key_size,
>> >> >> +		const size_t salt_size)
>> >> >> +{
>> >> >> +	if ((salt_size + key_size) > ECRYPTFS_MAX_KEY_BYTES)
>> >> >> +		return false;
>> >> >> +
>> >> >> +	return true;
>> >> >> +}
>> >> >> +
>> >> >> +/*
>> >> >> + * If there is salt that is used by external crypto module, it is
>> >> >> stored
>> >> >> + * in the same array where regular key is. Salt is going to be
>> used
>> >> by
>> >> >> + * external crypto module only, so for all internal crypto
>> >> operations
>> >> >> salt
>> >> >> + * should be ignored.
>> >> >> + *
>> >> >> + * Get key size in cases where it is going to be used for data
>> >> >> encryption
>> >> >> + * or for all other general purposes
>> >> >> + */
>> >> >> +size_t ecryptfs_get_key_size_to_enc_data(
>> >> >> +		struct ecryptfs_crypt_stat *crypt_stat)
>> >> >> +{
>> >> >> +	if (!crypt_stat)
>> >> >> +		return 0;
>> >> >> +
>> >> >> +	return crypt_stat->key_size;
>> >> >> +}
>> >> >> +
>> >> >> +/*
>> >> >> + * If there is salt that is used by external crypto module, it is
>> >> >> stored
>> >> >> + * in the same array where regular key is. Salt is going to be
>> used
>> >> by
>> >> >> + * external crypto module only, but we still need to save and
>> >> restore
>> >> >> it
>> >> >> + * (in encrypted form) as part of ecryptfs header along with the
>> >> >> regular
>> >> >> + * key.
>> >> >> + *
>> >> >> + * Get key size in cases where it is going to be stored
>> persistently
>> >> >> + *
>> >> >> + * !!! crypt_stat cipher name and mode must be initialized
>> >> >> + */
>> >> >> +size_t ecryptfs_get_key_size_to_store_key(
>> >> >> +		struct ecryptfs_crypt_stat *crypt_stat)
>> >> >> +{
>> >> >> +	size_t salt_size = 0;
>> >> >> +
>> >> >> +	if (!crypt_stat)
>> >> >> +		return 0;
>> >> >> +
>> >> >> +	salt_size = ecryptfs_get_salt_size(crypt_stat);
>> >> >> +
>> >> >> +	if (!ecryptfs_check_space_for_salt(crypt_stat->key_size,
>> >> salt_size)) {
>> >> >> +		ecryptfs_printk(KERN_WARNING,
>> >> >> +			"ecryptfs_get_key_size_to_store_key: not enough space for
>> >> salt\n");
>> >> >> +		return crypt_stat->key_size;
>> >> >> +	}
>> >> >> +
>> >> >> +	return crypt_stat->key_size + salt_size;
>> >> >> +}
>> >> >> +
>> >> >> +/*
>> >> >> + * If there is salt that is used by external crypto module, it is
>> >> >> stored
>> >> >> + * in the same array where regular key is. Salt is going to be
>> used
>> >> by
>> >> >> + * external crypto module only, but we still need to save and
>> >> restore
>> >> >> it
>> >> >> + * (in encrypted form) as part of ecryptfs header along with the
>> >> >> regular
>> >> >> + * key.
>> >> >> + *
>> >> >> + * Get key size in cases where it is going to be restored from
>> >> storage
>> >> >> + *
>> >> >> + * !!! crypt_stat cipher name and mode must be initialized
>> >> >> + */
>> >> >> +size_t ecryptfs_get_key_size_to_restore_key(size_t
>> stored_key_size,
>> >> >> +		const char *cipher)
>> >> >> +{
>> >> >> +	size_t salt_size = 0;
>> >> >> +
>> >> >> +	if (!cipher)
>> >> >> +		return 0;
>> >> >> +
>> >> >> +	salt_size = ecryptfs_get_salt_size_for_cipher(cipher);
>> >> >> +
>> >> >> +	if (salt_size >= stored_key_size) {
>> >> >> +		ecryptfs_printk(KERN_WARNING,
>> >> >> +			"ecryptfs_get_key_size_to_restore_key: salt %zu >= stred size
>> >> >> %zu\n",
>> >> >> +			salt_size, stored_key_size);
>> >> >> +
>> >> >> +		return stored_key_size;
>> >> >> +	}
>> >> >> +
>> >> >> +	return stored_key_size - salt_size;
>> >> >> +}
>> >> >> +
>> >> >> +/**
>> >> >> + * Given cipher, the function returns appropriate salt size.
>> >> >> + */
>> >> >> +size_t ecryptfs_get_salt_size_for_cipher(const char *cipher)
>> >> >> +{
>> >> >> +	if (!get_events() || !(get_events()->get_salt_key_size_cb))
>> >> >> +		return 0;
>> >> >> +
>> >> >> +	return get_events()->get_salt_key_size_cb(cipher);
>> >> >> +}
>> >> >> diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
>> >> >> index feef8a9..c346c9e 100644
>> >> >> --- a/fs/ecryptfs/file.c
>> >> >> +++ b/fs/ecryptfs/file.c
>> >> >> @@ -31,6 +31,7 @@
>> >> >>  #include <linux/security.h>
>> >> >>  #include <linux/compat.h>
>> >> >>  #include <linux/fs_stack.h>
>> >> >> +#include <linux/ecryptfs.h>
>> >> >>  #include "ecryptfs_kernel.h"
>> >> >>
>> >> >>  /**
>> >> >> @@ -184,6 +185,9 @@ static int ecryptfs_open(struct inode *inode,
>> >> struct
>> >> >> file *file)
>> >> >>  	int rc = 0;
>> >> >>  	struct ecryptfs_crypt_stat *crypt_stat = NULL;
>> >> >>  	struct dentry *ecryptfs_dentry = file->f_path.dentry;
>> >> >> +	int ret;
>> >> >> +
>> >> >> +
>> >> >>  	/* Private value of ecryptfs_dentry allocated in
>> >> >>  	 * ecryptfs_lookup() */
>> >> >>  	struct ecryptfs_file_info *file_info;
>> >> >> @@ -231,12 +235,31 @@ static int ecryptfs_open(struct inode
>> *inode,
>> >> >> struct file *file)
>> >> >>  		rc = 0;
>> >> >>  		goto out;
>> >> >>  	}
>> >> >> +
>> >> >>  	rc = read_or_initialize_metadata(ecryptfs_dentry);
>> >> >>  	if (rc)
>> >> >>  		goto out_put;
>> >> >>  	ecryptfs_printk(KERN_DEBUG, "inode w/ addr = [0x%p], i_ino = "
>> >> >>  			"[0x%.16lx] size: [0x%.16llx]\n", inode, inode->i_ino,
>> >> >>  			(unsigned long long)i_size_read(inode));
>> >> >> +
>> >> >> +	if (get_events() && get_events()->open_cb) {
>> >> >> +
>> >> >> +		ret = vfs_fsync(file, false);
>> >> >> +
>> >> >> +		if (ret)
>> >> >> +			ecryptfs_printk(KERN_ERR,
>> >> >> +				"failed to sync file ret = %d.\n", ret);
>> >> >> +
>> >> >> +		get_events()->open_cb(ecryptfs_inode_to_lower(inode),
>> >> >> +			crypt_stat);
>> >> >> +
>> >> >> +		if (crypt_stat->flags & ECRYPTFS_METADATA_IN_XATTR) {
>> >> >> +			truncate_inode_pages(inode->i_mapping, 0);
>> >> >> +			truncate_inode_pages(
>> >> >> +				ecryptfs_inode_to_lower(inode)->i_mapping, 0);
>> >> >> +		}
>> >> >> +	}
>> >> >>  	goto out;
>> >> >>  out_put:
>> >> >>  	ecryptfs_put_lower_file(inode);
>> >> >> @@ -261,9 +284,22 @@ static int ecryptfs_flush(struct file *file,
>> >> >> fl_owner_t td)
>> >> >>
>> >> >>  static int ecryptfs_release(struct inode *inode, struct file
>> *file)
>> >> >>  {
>> >> >> +
>> >> >> +	int ret;
>> >> >> +
>> >> >> +	ret = vfs_fsync(file, false);
>> >> >> +
>> >> >> +	if (ret)
>> >> >> +		pr_err("failed to sync file ret = %d.\n", ret);
>> >> >> +
>> >> >>  	ecryptfs_put_lower_file(inode);
>> >> >>  	kmem_cache_free(ecryptfs_file_info_cache,
>> >> >>  			ecryptfs_file_to_private(file));
>> >> >> +
>> >> >> +	clean_inode_pages(inode->i_mapping, 0, -1);
>> >> >> +	clean_inode_pages(ecryptfs_inode_to_lower(inode)->i_mapping, 0,
>> >> -1);
>> >> >> +	truncate_inode_pages(inode->i_mapping, 0);
>> >> >> +	truncate_inode_pages(ecryptfs_inode_to_lower(inode)->i_mapping,
>> 0);
>> >> >>  	return 0;
>> >> >>  }
>> >> >>
>> >> >> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
>> >> >> index 3c4db11..e0d72e7 100644
>> >> >> --- a/fs/ecryptfs/inode.c
>> >> >> +++ b/fs/ecryptfs/inode.c
>> >> >> @@ -261,12 +261,15 @@ out:
>> >> >>   *
>> >> >>   * Returns zero on success; non-zero on error condition
>> >> >>   */
>> >> >> +
>> >> >> +
>> >> >>  static int
>> >> >>  ecryptfs_create(struct inode *directory_inode, struct dentry
>> >> >> *ecryptfs_dentry,
>> >> >>  		umode_t mode, bool excl)
>> >> >>  {
>> >> >>  	struct inode *ecryptfs_inode;
>> >> >>  	int rc;
>> >> >> +	struct ecryptfs_crypt_stat *crypt_stat;
>> >> >>
>> >> >>  	ecryptfs_inode = ecryptfs_do_create(directory_inode,
>> >> ecryptfs_dentry,
>> >> >>  					    mode);
>> >> >> @@ -276,6 +279,7 @@ ecryptfs_create(struct inode *directory_inode,
>> >> >> struct dentry *ecryptfs_dentry,
>> >> >>  		rc = PTR_ERR(ecryptfs_inode);
>> >> >>  		goto out;
>> >> >>  	}
>> >> >> +
>> >> >>  	/* At this point, a file exists on "disk"; we need to make sure
>> >> >>  	 * that this on disk file is prepared to be an ecryptfs file */
>> >> >>  	rc = ecryptfs_initialize_file(ecryptfs_dentry, ecryptfs_inode);
>> >> >> @@ -288,6 +292,13 @@ ecryptfs_create(struct inode
>> *directory_inode,
>> >> >> struct dentry *ecryptfs_dentry,
>> >> >>  		goto out;
>> >> >>  	}
>> >> >>  	unlock_new_inode(ecryptfs_inode);
>> >> >> +
>> >> >> +	crypt_stat =
>> >> &ecryptfs_inode_to_private(ecryptfs_inode)->crypt_stat;
>> >> >> +	if (get_events() && get_events()->open_cb)
>> >> >> +		get_events()->open_cb(
>> >> >> +				ecryptfs_inode_to_lower(ecryptfs_inode),
>> >> >> +					crypt_stat);
>> >> >> +
>> >> >>  	d_instantiate(ecryptfs_dentry, ecryptfs_inode);
>> >> >>  out:
>> >> >>  	return rc;
>> >> >> diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
>> >> >> index 6bd67e2..82b99c7 100644
>> >> >> --- a/fs/ecryptfs/keystore.c
>> >> >> +++ b/fs/ecryptfs/keystore.c
>> >> >> @@ -315,7 +315,8 @@ write_tag_66_packet(char *signature, u8
>> >> cipher_code,
>> >> >>  	 *         | File Encryption Key Size | 1 or 2 bytes |
>> >> >>  	 *         | File Encryption Key      | arbitrary    |
>> >> >>  	 */
>> >> >> -	data_len = (5 + ECRYPTFS_SIG_SIZE_HEX + crypt_stat->key_size);
>> >> >> +	data_len = (5 + ECRYPTFS_SIG_SIZE_HEX +
>> >> >> +			ecryptfs_get_key_size_to_store_key(crypt_stat));
>> >> >>  	*packet = kmalloc(data_len, GFP_KERNEL);
>> >> >>  	message = *packet;
>> >> >>  	if (!message) {
>> >> >> @@ -335,8 +336,9 @@ write_tag_66_packet(char *signature, u8
>> >> cipher_code,
>> >> >>  	memcpy(&message[i], signature, ECRYPTFS_SIG_SIZE_HEX);
>> >> >>  	i += ECRYPTFS_SIG_SIZE_HEX;
>> >> >>  	/* The encrypted key includes 1 byte cipher code and 2 byte
>> >> checksum
>> >> >> */
>> >> >> -	rc = ecryptfs_write_packet_length(&message[i],
>> crypt_stat->key_size
>> >> +
>> >> >> 3,
>> >> >> -					  &packet_size_len);
>> >> >> +	rc = ecryptfs_write_packet_length(&message[i],
>> >> >> +			ecryptfs_get_key_size_to_store_key(crypt_stat) + 3,
>> >> >> +			&packet_size_len);
>> >> >>  	if (rc) {
>> >> >>  		ecryptfs_printk(KERN_ERR, "Error generating tag 66 packet "
>> >> >>  				"header; cannot generate packet length\n");
>> >> >> @@ -344,9 +346,10 @@ write_tag_66_packet(char *signature, u8
>> >> >> cipher_code,
>> >> >>  	}
>> >> >>  	i += packet_size_len;
>> >> >>  	message[i++] = cipher_code;
>> >> >> -	memcpy(&message[i], crypt_stat->key, crypt_stat->key_size);
>> >> >> -	i += crypt_stat->key_size;
>> >> >> -	for (j = 0; j < crypt_stat->key_size; j++)
>> >> >> +	memcpy(&message[i], crypt_stat->key,
>> >> >> +			ecryptfs_get_key_size_to_store_key(crypt_stat));
>> >> >> +	i += ecryptfs_get_key_size_to_store_key(crypt_stat);
>> >> >> +	for (j = 0; j < ecryptfs_get_key_size_to_store_key(crypt_stat);
>> >> j++)
>> >> >>  		checksum += crypt_stat->key[j];
>> >> >>  	message[i++] = (checksum / 256) % 256;
>> >> >>  	message[i++] = (checksum % 256);
>> >> >> @@ -918,6 +921,7 @@ ecryptfs_parse_tag_70_packet(char **filename,
>> >> size_t
>> >> >> *filename_size,
>> >> >>  	struct ecryptfs_parse_tag_70_packet_silly_stack *s;
>> >> >>  	struct key *auth_tok_key = NULL;
>> >> >>  	int rc = 0;
>> >> >> +	char full_cipher[ECRYPTFS_MAX_CIPHER_NAME_SIZE];
>> >> >>
>> >> >>  	(*packet_size) = 0;
>> >> >>  	(*filename_size) = 0;
>> >> >> @@ -977,12 +981,13 @@ ecryptfs_parse_tag_70_packet(char
>> **filename,
>> >> >> size_t *filename_size,
>> >> >>  	s->fnek_sig_hex[ECRYPTFS_SIG_SIZE_HEX] = '\0';
>> >> >>  	(*packet_size) += ECRYPTFS_SIG_SIZE;
>> >> >>  	s->cipher_code = data[(*packet_size)++];
>> >> >> -	rc = ecryptfs_cipher_code_to_string(s->cipher_string,
>> >> s->cipher_code);
>> >> >> +	rc = ecryptfs_cipher_code_to_string(full_cipher,
>> s->cipher_code);
>> >> >>  	if (rc) {
>> >> >>  		printk(KERN_WARNING "%s: Cipher code [%d] is invalid\n",
>> >> >>  		       __func__, s->cipher_code);
>> >> >>  		goto out;
>> >> >>  	}
>> >> >> +	ecryptfs_parse_full_cipher(full_cipher, s->cipher_string, 0);
>> >> >>  	rc = ecryptfs_find_auth_tok_for_sig(&auth_tok_key,
>> >> >>  					    &s->auth_tok, mount_crypt_stat,
>> >> >>  					    s->fnek_sig_hex);
>> >> >> @@ -1151,6 +1156,7 @@ decrypt_pki_encrypted_session_key(struct
>> >> >> ecryptfs_auth_tok *auth_tok,
>> >> >>  	char *payload = NULL;
>> >> >>  	size_t payload_len = 0;
>> >> >>  	int rc;
>> >> >> +	char full_cipher[ECRYPTFS_MAX_CIPHER_NAME_SIZE];
>> >> >>
>> >> >>  	rc = ecryptfs_get_auth_tok_sig(&auth_tok_sig, auth_tok);
>> >> >>  	if (rc) {
>> >> >> @@ -1184,21 +1190,31 @@ decrypt_pki_encrypted_session_key(struct
>> >> >> ecryptfs_auth_tok *auth_tok,
>> >> >>  		       rc);
>> >> >>  		goto out;
>> >> >>  	}
>> >> >> -	auth_tok->session_key.flags |= ECRYPTFS_CONTAINS_DECRYPTED_KEY;
>> >> >> -	memcpy(crypt_stat->key, auth_tok->session_key.decrypted_key,
>> >> >> -	       auth_tok->session_key.decrypted_key_size);
>> >> >> -	crypt_stat->key_size = auth_tok->session_key.decrypted_key_size;
>> >> >> -	rc = ecryptfs_cipher_code_to_string(crypt_stat->cipher,
>> >> cipher_code);
>> >> >> +
>> >> >> +	rc = ecryptfs_cipher_code_to_string(full_cipher, cipher_code);
>> >> >>  	if (rc) {
>> >> >>  		ecryptfs_printk(KERN_ERR, "Cipher code [%d] is invalid\n",
>> >> >>  				cipher_code)
>> >> >> -		goto out;
>> >> >> +					goto out;
>> >> >>  	}
>> >> >> +
>> >> >> +	auth_tok->session_key.flags |= ECRYPTFS_CONTAINS_DECRYPTED_KEY;
>> >> >> +	memcpy(crypt_stat->key, auth_tok->session_key.decrypted_key,
>> >> >> +	       auth_tok->session_key.decrypted_key_size);
>> >> >> +	crypt_stat->key_size = ecryptfs_get_key_size_to_restore_key(
>> >> >> +			auth_tok->session_key.decrypted_key_size, full_cipher);
>> >> >> +
>> >> >> +	ecryptfs_parse_full_cipher(full_cipher,
>> >> >> +		crypt_stat->cipher, crypt_stat->cipher_mode);
>> >> >> +
>> >> >>  	crypt_stat->flags |= ECRYPTFS_KEY_VALID;
>> >> >>  	if (ecryptfs_verbosity > 0) {
>> >> >>  		ecryptfs_printk(KERN_DEBUG, "Decrypted session key:\n");
>> >> >>  		ecryptfs_dump_hex(crypt_stat->key,
>> >> >>  				  crypt_stat->key_size);
>> >> >> +
>> >> >> +		ecryptfs_dump_salt_hex(crypt_stat->key, crypt_stat->key_size,
>> >> >> +				full_cipher);
>> >> >>  	}
>> >> >>  out:
>> >> >>  	kfree(msg);
>> >> >> @@ -1380,6 +1396,7 @@ parse_tag_3_packet(struct
>> ecryptfs_crypt_stat
>> >> >> *crypt_stat,
>> >> >>  	struct ecryptfs_auth_tok_list_item *auth_tok_list_item;
>> >> >>  	size_t length_size;
>> >> >>  	int rc = 0;
>> >> >> +	char full_cipher[ECRYPTFS_MAX_CIPHER_NAME_SIZE];
>> >> >>
>> >> >>  	(*packet_size) = 0;
>> >> >>  	(*new_auth_tok) = NULL;
>> >> >> @@ -1453,10 +1470,13 @@ parse_tag_3_packet(struct
>> ecryptfs_crypt_stat
>> >> >> *crypt_stat,
>> >> >>  		rc = -EINVAL;
>> >> >>  		goto out_free;
>> >> >>  	}
>> >> >> -	rc = ecryptfs_cipher_code_to_string(crypt_stat->cipher,
>> >> >> +	rc = ecryptfs_cipher_code_to_string(full_cipher,
>> >> >>  					    (u16)data[(*packet_size)]);
>> >> >>  	if (rc)
>> >> >>  		goto out_free;
>> >> >> +	ecryptfs_parse_full_cipher(full_cipher,
>> >> >> +		crypt_stat->cipher, crypt_stat->cipher_mode);
>> >> >> +
>> >> >>  	/* A little extra work to differentiate among the AES key
>> >> >>  	 * sizes; see RFC2440 */
>> >> >>  	switch(data[(*packet_size)++]) {
>> >> >> @@ -1465,7 +1485,10 @@ parse_tag_3_packet(struct
>> ecryptfs_crypt_stat
>> >> >> *crypt_stat,
>> >> >>  		break;
>> >> >>  	default:
>> >> >>  		crypt_stat->key_size =
>> >> >> -			(*new_auth_tok)->session_key.encrypted_key_size;
>> >> >> +			ecryptfs_get_key_size_to_restore_key(
>> >> >> +			(*new_auth_tok)->session_key.encrypted_key_size,
>> >> >> +			full_cipher);
>> >> >> +
>> >> >>  	}
>> >> >>  	rc = ecryptfs_init_crypt_ctx(crypt_stat);
>> >> >>  	if (rc)
>> >> >> @@ -1664,6 +1687,8 @@ static int
>> >> >>  decrypt_passphrase_encrypted_session_key(struct ecryptfs_auth_tok
>> >> >> *auth_tok,
>> >> >>  					 struct ecryptfs_crypt_stat *crypt_stat)
>> >> >>  {
>> >> >> +
>> >> >> +	unsigned char final[2*ECRYPTFS_MAX_CIPHER_NAME_SIZE+1];
>> >> >>  	struct scatterlist dst_sg[2];
>> >> >>  	struct scatterlist src_sg[2];
>> >> >>  	struct mutex *tfm_mutex;
>> >> >> @@ -1713,7 +1738,7 @@
>> decrypt_passphrase_encrypted_session_key(struct
>> >> >> ecryptfs_auth_tok *auth_tok,
>> >> >>  	mutex_lock(tfm_mutex);
>> >> >>  	rc = crypto_blkcipher_setkey(
>> >> >>  		desc.tfm, auth_tok->token.password.session_key_encryption_key,
>> >> >> -		crypt_stat->key_size);
>> >> >> +		auth_tok->token.password.session_key_encryption_key_bytes);
>> >> >>  	if (unlikely(rc < 0)) {
>> >> >>  		mutex_unlock(tfm_mutex);
>> >> >>  		printk(KERN_ERR "Error setting key for crypto context\n");
>> >> >> @@ -1736,6 +1761,10 @@
>> >> decrypt_passphrase_encrypted_session_key(struct
>> >> >> ecryptfs_auth_tok *auth_tok,
>> >> >>  				crypt_stat->key_size);
>> >> >>  		ecryptfs_dump_hex(crypt_stat->key,
>> >> >>  				  crypt_stat->key_size);
>> >> >> +		ecryptfs_dump_salt_hex(crypt_stat->key, crypt_stat->key_size,
>> >> >> +				ecryptfs_get_full_cipher(crypt_stat->cipher,
>> >> >> +					crypt_stat->cipher_mode,
>> >> >> +					final, sizeof(final)));
>> >> >>  	}
>> >> >>  out:
>> >> >>  	return rc;
>> >> >> @@ -1972,12 +2001,17 @@ pki_encrypt_session_key(struct key
>> >> >> *auth_tok_key,
>> >> >>  	size_t payload_len = 0;
>> >> >>  	struct ecryptfs_message *msg;
>> >> >>  	int rc;
>> >> >> +	unsigned char final[2*ECRYPTFS_MAX_CIPHER_NAME_SIZE+1];
>> >> >>
>> >> >>  	rc = write_tag_66_packet(auth_tok->token.private_key.signature,
>> >> >> -				 ecryptfs_code_for_cipher_string(
>> >> >> -					 crypt_stat->cipher,
>> >> >> -					 crypt_stat->key_size),
>> >> >> -				 crypt_stat, &payload, &payload_len);
>> >> >> +			ecryptfs_code_for_cipher_string(
>> >> >> +					ecryptfs_get_full_cipher(
>> >> >> +						crypt_stat->cipher,
>> >> >> +						crypt_stat->cipher_mode,
>> >> >> +						final, sizeof(final)),
>> >> >> +					ecryptfs_get_key_size_to_enc_data(
>> >> >> +						crypt_stat)),
>> >> >> +					crypt_stat, &payload, &payload_len);
>> >> >>  	up_write(&(auth_tok_key->sem));
>> >> >>  	key_put(auth_tok_key);
>> >> >>  	if (rc) {
>> >> >> @@ -2035,7 +2069,7 @@ write_tag_1_packet(char *dest, size_t
>> >> >> *remaining_bytes,
>> >> >>  	ecryptfs_from_hex(key_rec->sig,
>> >> auth_tok->token.private_key.signature,
>> >> >>  			  ECRYPTFS_SIG_SIZE);
>> >> >>  	encrypted_session_key_valid = 0;
>> >> >> -	for (i = 0; i < crypt_stat->key_size; i++)
>> >> >> +	for (i = 0; i < ecryptfs_get_key_size_to_store_key(crypt_stat);
>> >> i++)
>> >> >>  		encrypted_session_key_valid |=
>> >> >>  			auth_tok->session_key.encrypted_key[i];
>> >> >>  	if (encrypted_session_key_valid) {
>> >> >> @@ -2189,6 +2223,7 @@ write_tag_3_packet(char *dest, size_t
>> >> >> *remaining_bytes,
>> >> >>  	u8 cipher_code;
>> >> >>  	size_t packet_size_length;
>> >> >>  	size_t max_packet_size;
>> >> >> +	unsigned char final[2*ECRYPTFS_MAX_CIPHER_NAME_SIZE+1];
>> >> >>  	struct ecryptfs_mount_crypt_stat *mount_crypt_stat =
>> >> >>  		crypt_stat->mount_crypt_stat;
>> >> >>  	struct blkcipher_desc desc = {
>> >> >> @@ -2221,13 +2256,14 @@ write_tag_3_packet(char *dest, size_t
>> >> >> *remaining_bytes,
>> >> >>  			mount_crypt_stat->global_default_cipher_key_size;
>> >> >>  	if (auth_tok->session_key.encrypted_key_size == 0)
>> >> >>  		auth_tok->session_key.encrypted_key_size =
>> >> >> -			crypt_stat->key_size;
>> >> >> +			ecryptfs_get_key_size_to_store_key(crypt_stat);
>> >> >>  	if (crypt_stat->key_size == 24
>> >> >>  	    && strcmp("aes", crypt_stat->cipher) == 0) {
>> >> >>  		memset((crypt_stat->key + 24), 0, 8);
>> >> >>  		auth_tok->session_key.encrypted_key_size = 32;
>> >> >>  	} else
>> >> >> -		auth_tok->session_key.encrypted_key_size =
>> crypt_stat->key_size;
>> >> >> +		auth_tok->session_key.encrypted_key_size =
>> >> >> +				ecryptfs_get_key_size_to_store_key(crypt_stat);
>> >> >>  	key_rec->enc_key_size =
>> >> >>  		auth_tok->session_key.encrypted_key_size;
>> >> >>  	encrypted_session_key_valid = 0;
>> >> >> @@ -2251,8 +2287,8 @@ write_tag_3_packet(char *dest, size_t
>> >> >> *remaining_bytes,
>> >> >>  				auth_tok->token.password.
>> >> >>  				session_key_encryption_key_bytes);
>> >> >>  		memcpy(session_key_encryption_key,
>> >> >> -		       auth_tok->token.password.session_key_encryption_key,
>> >> >> -		       crypt_stat->key_size);
>> >> >> +		auth_tok->token.password.session_key_encryption_key,
>> >> >> +		auth_tok->token.password.session_key_encryption_key_bytes);
>> >> >>  		ecryptfs_printk(KERN_DEBUG,
>> >> >>  				"Cached session key encryption key:\n");
>> >> >>  		if (ecryptfs_verbosity > 0)
>> >> >> @@ -2285,7 +2321,7 @@ write_tag_3_packet(char *dest, size_t
>> >> >> *remaining_bytes,
>> >> >>  	}
>> >> >>  	mutex_lock(tfm_mutex);
>> >> >>  	rc = crypto_blkcipher_setkey(desc.tfm,
>> session_key_encryption_key,
>> >> >> -				     crypt_stat->key_size);
>> >> >> +		auth_tok->token.password.session_key_encryption_key_bytes);
>> >> >>  	if (rc < 0) {
>> >> >>  		mutex_unlock(tfm_mutex);
>> >> >>  		ecryptfs_printk(KERN_ERR, "Error setting key for crypto "
>> >> >> @@ -2294,7 +2330,12 @@ write_tag_3_packet(char *dest, size_t
>> >> >> *remaining_bytes,
>> >> >>  	}
>> >> >>  	rc = 0;
>> >> >>  	ecryptfs_printk(KERN_DEBUG, "Encrypting [%zd] bytes of the
>> key\n",
>> >> >> -			crypt_stat->key_size);
>> >> >> +		crypt_stat->key_size);
>> >> >> +	ecryptfs_printk(KERN_DEBUG, "Encrypting [%zd] bytes of the salt
>> >> >> key\n",
>> >> >> +		ecryptfs_get_salt_size_for_cipher(
>> >> >> +			ecryptfs_get_full_cipher(crypt_stat->cipher,
>> >> >> +				crypt_stat->cipher_mode,
>> >> >> +				final, sizeof(final))));
>> >> >>  	rc = crypto_blkcipher_encrypt(&desc, dst_sg, src_sg,
>> >> >>  				      (*key_rec).enc_key_size);
>> >> >>  	mutex_unlock(tfm_mutex);
>> >> >> @@ -2343,8 +2384,10 @@ encrypted_session_key_set:
>> >> >>  	dest[(*packet_size)++] = 0x04; /* version 4 */
>> >> >>  	/* TODO: Break from RFC2440 so that arbitrary ciphers can be
>> >> >>  	 * specified with strings */
>> >> >> -	cipher_code =
>> ecryptfs_code_for_cipher_string(crypt_stat->cipher,
>> >> >> -						      crypt_stat->key_size);
>> >> >> +	cipher_code = ecryptfs_code_for_cipher_string(
>> >> >> +			ecryptfs_get_full_cipher(crypt_stat->cipher,
>> >> >> +				crypt_stat->cipher_mode, final, sizeof(final)),
>> >> >> +			crypt_stat->key_size);
>> >> >>  	if (cipher_code == 0) {
>> >> >>  		ecryptfs_printk(KERN_WARNING, "Unable to generate code for "
>> >> >>  				"cipher [%s]\n", crypt_stat->cipher);
>> >> >> diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
>> >> >> index e83f31c..b8ab8c7 100644
>> >> >> --- a/fs/ecryptfs/main.c
>> >> >> +++ b/fs/ecryptfs/main.c
>> >> >> @@ -165,7 +165,13 @@ void ecryptfs_put_lower_file(struct inode
>> >> *inode)
>> >> >>  		fput(inode_info->lower_file);
>> >> >>  		inode_info->lower_file = NULL;
>> >> >>  		mutex_unlock(&inode_info->lower_file_mutex);
>> >> >> +
>> >> >> +		if (get_events() && get_events()->release_cb)
>> >> >> +			get_events()->release_cb(
>> >> >> +			ecryptfs_inode_to_lower(inode));
>> >> >>  	}
>> >> >> +
>> >> >> +
>> >> >>  }
>> >> >>
>> >> >>  enum { ecryptfs_opt_sig, ecryptfs_opt_ecryptfs_sig,
>> >> >> @@ -266,6 +272,7 @@ static int ecryptfs_parse_options(struct
>> >> >> ecryptfs_sb_info *sbi, char *options,
>> >> >>  	int cipher_key_bytes_set = 0;
>> >> >>  	int fn_cipher_key_bytes;
>> >> >>  	int fn_cipher_key_bytes_set = 0;
>> >> >> +	size_t salt_size = 0;
>> >> >>  	struct ecryptfs_mount_crypt_stat *mount_crypt_stat =
>> >> >>  		&sbi->mount_crypt_stat;
>> >> >>  	substring_t args[MAX_OPT_ARGS];
>> >> >> @@ -280,6 +287,7 @@ static int ecryptfs_parse_options(struct
>> >> >> ecryptfs_sb_info *sbi, char *options,
>> >> >>  	char *cipher_key_bytes_src;
>> >> >>  	char *fn_cipher_key_bytes_src;
>> >> >>  	u8 cipher_code;
>> >> >> +	unsigned char final[2*ECRYPTFS_MAX_CIPHER_NAME_SIZE+1];
>> >> >>
>> >> >>  	*check_ruid = 0;
>> >> >>
>> >> >> @@ -309,12 +317,14 @@ static int ecryptfs_parse_options(struct
>> >> >> ecryptfs_sb_info *sbi, char *options,
>> >> >>  		case ecryptfs_opt_ecryptfs_cipher:
>> >> >>  			cipher_name_src = args[0].from;
>> >> >>  			cipher_name_dst =
>> >> >> -				mount_crypt_stat->
>> >> >> -				global_default_cipher_name;
>> >> >> -			strncpy(cipher_name_dst, cipher_name_src,
>> >> >> -				ECRYPTFS_MAX_CIPHER_NAME_SIZE);
>> >> >> -			cipher_name_dst[ECRYPTFS_MAX_CIPHER_NAME_SIZE] = '\0';
>> >> >> +				mount_crypt_stat->global_default_cipher_name;
>> >> >> +
>> >> >> +			ecryptfs_parse_full_cipher(cipher_name_src,
>> >> >> +				mount_crypt_stat->global_default_cipher_name,
>> >> >> +				mount_crypt_stat->global_default_cipher_mode);
>> >> >> +
>> >> >>  			cipher_name_set = 1;
>> >> >> +
>> >> >>  			break;
>> >> >>  		case ecryptfs_opt_ecryptfs_key_bytes:
>> >> >>  			cipher_key_bytes_src = args[0].from;
>> >> >> @@ -411,24 +421,50 @@ static int ecryptfs_parse_options(struct
>> >> >> ecryptfs_sb_info *sbi, char *options,
>> >> >>  		strcpy(mount_crypt_stat->global_default_cipher_name,
>> >> >>  		       ECRYPTFS_DEFAULT_CIPHER);
>> >> >>  	}
>> >> >> +
>> >> >>  	if ((mount_crypt_stat->flags &
>> ECRYPTFS_GLOBAL_ENCRYPT_FILENAMES)
>> >> >>  	    && !fn_cipher_name_set)
>> >> >>  		strcpy(mount_crypt_stat->global_default_fn_cipher_name,
>> >> >>  		       mount_crypt_stat->global_default_cipher_name);
>> >> >> -	if (!cipher_key_bytes_set)
>> >> >> +
>> >> >> +	if (cipher_key_bytes_set) {
>> >> >> +
>> >> >> +		salt_size = ecryptfs_get_salt_size_for_cipher(
>> >> >> +				ecryptfs_get_full_cipher(
>> >> >> +				mount_crypt_stat->global_default_cipher_name,
>> >> >> +				mount_crypt_stat->global_default_cipher_mode,
>> >> >> +				final, sizeof(final)));
>> >> >> +
>> >> >> +		if (!ecryptfs_check_space_for_salt(
>> >> >> +			mount_crypt_stat->global_default_cipher_key_size,
>> >> >> +			salt_size)) {
>> >> >> +			ecryptfs_printk(
>> >> >> +				KERN_WARNING,
>> >> >> +				"eCryptfs internal error: no space for salt");
>> >> >> +		}
>> >> >> +	} else
>> >> >>  		mount_crypt_stat->global_default_cipher_key_size = 0;
>> >> >> +
>> >> >>  	if ((mount_crypt_stat->flags &
>> ECRYPTFS_GLOBAL_ENCRYPT_FILENAMES)
>> >> >>  	    && !fn_cipher_key_bytes_set)
>> >> >>  		mount_crypt_stat->global_default_fn_cipher_key_bytes =
>> >> >>  			mount_crypt_stat->global_default_cipher_key_size;
>> >> >>
>> >> >>  	cipher_code = ecryptfs_code_for_cipher_string(
>> >> >> -		mount_crypt_stat->global_default_cipher_name,
>> >> >> +			ecryptfs_get_full_cipher(
>> >> >> +				mount_crypt_stat->global_default_cipher_name,
>> >> >> +				mount_crypt_stat->global_default_cipher_mode,
>> >> >> +				final, sizeof(final)),
>> >> >>  		mount_crypt_stat->global_default_cipher_key_size);
>> >> >>  	if (!cipher_code) {
>> >> >> -		ecryptfs_printk(KERN_ERR,
>> >> >> -				"eCryptfs doesn't support cipher: %s",
>> >> >> -				mount_crypt_stat->global_default_cipher_name);
>> >> >> +		ecryptfs_printk(
>> >> >> +			KERN_ERR,
>> >> >> +			"eCryptfs doesn't support cipher: %s and key size %zu",
>> >> >> +			ecryptfs_get_full_cipher(
>> >> >> +				mount_crypt_stat->global_default_cipher_name,
>> >> >> +				mount_crypt_stat->global_default_cipher_mode,
>> >> >> +				final, sizeof(final)),
>> >> >> +			mount_crypt_stat->global_default_cipher_key_size);
>> >> >>  		rc = -EINVAL;
>> >> >>  		goto out;
>> >> >>  	}
>> >> >> @@ -488,6 +524,7 @@ static struct file_system_type
>> ecryptfs_fs_type;
>> >> >>   * @dev_name: The path to mount over
>> >> >>   * @raw_data: The options passed into the kernel
>> >> >>   */
>> >> >> +
>> >> >>  static struct dentry *ecryptfs_mount(struct file_system_type
>> >> *fs_type,
>> >> >> int flags,
>> >> >>  			const char *dev_name, void *raw_data)
>> >> >>  {
>> >> >> @@ -557,6 +594,8 @@ static struct dentry *ecryptfs_mount(struct
>> >> >> file_system_type *fs_type, int flags
>> >> >>
>> >> >>  	ecryptfs_set_superblock_lower(s, path.dentry->d_sb);
>> >> >>
>> >> >> +	ecryptfs_drop_pagecache_sb(ecryptfs_superblock_to_lower(s),
>> NULL);
>> >> >> +
>> >> >>  	/**
>> >> >>  	 * Set the POSIX ACL flag based on whether they're enabled in
>> the
>> >> >> lower
>> >> >>  	 * mount.
>> >> >> @@ -894,6 +933,7 @@ static void __exit ecryptfs_exit(void)
>> >> >>  	do_sysfs_unregistration();
>> >> >>  	unregister_filesystem(&ecryptfs_fs_type);
>> >> >>  	ecryptfs_free_kmem_caches();
>> >> >> +	ecryptfs_free_events();
>> >> >>  }
>> >> >>
>> >> >>  MODULE_AUTHOR("Michael A. Halcrow <mhalcrow@us.ibm.com>");
>> >> >> diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
>> >> >> index caba848..bdbc72d 100644
>> >> >> --- a/fs/ecryptfs/mmap.c
>> >> >> +++ b/fs/ecryptfs/mmap.c
>> >> >> @@ -552,10 +552,16 @@ static sector_t ecryptfs_bmap(struct
>> >> address_space
>> >> >> *mapping, sector_t block)
>> >> >>  	return rc;
>> >> >>  }
>> >> >>
>> >> >> +void ecryptfs_freepage(struct page *page)
>> >> >> +{
>> >> >> +	zero_user(page, 0, PAGE_CACHE_SIZE);
>> >> >> +}
>> >> >> +
>> >> >>  const struct address_space_operations ecryptfs_aops = {
>> >> >>  	.writepage = ecryptfs_writepage,
>> >> >>  	.readpage = ecryptfs_readpage,
>> >> >>  	.write_begin = ecryptfs_write_begin,
>> >> >>  	.write_end = ecryptfs_write_end,
>> >> >>  	.bmap = ecryptfs_bmap,
>> >> >> +	.freepage = ecryptfs_freepage,
>> >> >>  };
>> >> >> diff --git a/fs/ecryptfs/super.c b/fs/ecryptfs/super.c
>> >> >> index afa1b81..25e436d 100644
>> >> >> --- a/fs/ecryptfs/super.c
>> >> >> +++ b/fs/ecryptfs/super.c
>> >> >> @@ -69,6 +69,9 @@ static void ecryptfs_i_callback(struct rcu_head
>> >> *head)
>> >> >>  {
>> >> >>  	struct inode *inode = container_of(head, struct inode, i_rcu);
>> >> >>  	struct ecryptfs_inode_info *inode_info;
>> >> >> +	if (inode == NULL)
>> >> >> +		return;
>> >> >> +
>> >> >>  	inode_info = ecryptfs_inode_to_private(inode);
>> >> >>
>> >> >>  	kmem_cache_free(ecryptfs_inode_info_cache, inode_info);
>> >> >> @@ -88,9 +91,12 @@ static void ecryptfs_destroy_inode(struct inode
>> >> >> *inode)
>> >> >>  	struct ecryptfs_inode_info *inode_info;
>> >> >>
>> >> >>  	inode_info = ecryptfs_inode_to_private(inode);
>> >> >> +
>> >> >>  	BUG_ON(inode_info->lower_file);
>> >> >> +
>> >> >>  	ecryptfs_destroy_crypt_stat(&inode_info->crypt_stat);
>> >> >>  	call_rcu(&inode->i_rcu, ecryptfs_i_callback);
>> >> >> +
>> >> >>  }
>> >> >>
>> >> >>  /**
>> >> >> @@ -149,6 +155,9 @@ static int ecryptfs_show_options(struct
>> seq_file
>> >> *m,
>> >> >> struct dentry *root)
>> >> >>  	struct ecryptfs_mount_crypt_stat *mount_crypt_stat =
>> >> >>  		&ecryptfs_superblock_to_private(sb)->mount_crypt_stat;
>> >> >>  	struct ecryptfs_global_auth_tok *walker;
>> >> >> +	unsigned char final[2*ECRYPTFS_MAX_CIPHER_NAME_SIZE+1];
>> >> >> +
>> >> >> +	memset(final, 0, sizeof(final));
>> >> >>
>> >> >>  	mutex_lock(&mount_crypt_stat->global_auth_tok_list_mutex);
>> >> >>  	list_for_each_entry(walker,
>> >> >> @@ -162,7 +171,10 @@ static int ecryptfs_show_options(struct
>> seq_file
>> >> >> *m, struct dentry *root)
>> >> >>  	mutex_unlock(&mount_crypt_stat->global_auth_tok_list_mutex);
>> >> >>
>> >> >>  	seq_printf(m, ",ecryptfs_cipher=%s",
>> >> >> -		mount_crypt_stat->global_default_cipher_name);
>> >> >> +			ecryptfs_get_full_cipher(
>> >> >> +				mount_crypt_stat->global_default_cipher_name,
>> >> >> +				mount_crypt_stat->global_default_cipher_mode,
>> >> >> +				final, sizeof(final)));
>> >> >>
>> >> >>  	if (mount_crypt_stat->global_default_cipher_key_size)
>> >> >>  		seq_printf(m, ",ecryptfs_key_bytes=%zd",
>> >> >> diff --git a/include/linux/ecryptfs.h b/include/linux/ecryptfs.h
>> >> >> index 8d5ab99..55433c6 100644
>> >> >> --- a/include/linux/ecryptfs.h
>> >> >> +++ b/include/linux/ecryptfs.h
>> >> >> @@ -1,6 +1,9 @@
>> >> >>  #ifndef _LINUX_ECRYPTFS_H
>> >> >>  #define _LINUX_ECRYPTFS_H
>> >> >>
>> >> >> +struct inode;
>> >> >> +struct page;
>> >> >> +
>> >> >>  /* Version verification for shared data structures w/ userspace
>> */
>> >> >>  #define ECRYPTFS_VERSION_MAJOR 0x00
>> >> >>  #define ECRYPTFS_VERSION_MINOR 0x04
>> >> >> @@ -41,6 +44,7 @@
>> >> >>  #define RFC2440_CIPHER_AES_256 0x09
>> >> >>  #define RFC2440_CIPHER_TWOFISH 0x0a
>> >> >>  #define RFC2440_CIPHER_CAST_6 0x0b
>> >> >> +#define RFC2440_CIPHER_AES_XTS_256 0x0c
>> >> >>
>> >> >>  #define RFC2440_CIPHER_RSA 0x01
>> >> >>
>> >> >> @@ -102,4 +106,47 @@ struct ecryptfs_auth_tok {
>> >> >>  	} token;
>> >> >>  } __attribute__ ((packed));
>> >> >>
>> >> >> +#define ECRYPTFS_INVALID_EVENTS_HANDLE -1
>> >> >> +
>> >> >> +/**
>> >> >> + * ecryptfs_events struct represents a partial interface
>> >> >> + * towards ecryptfs module. If registered to ecryptfs events,
>> >> >> + * one can receive push notifications.
>> >> >> + * A first callback received from ecryptfs will probably be
>> >> >> + * about file opening (open_cb),
>> >> >> + * in which ecryptfs passes its ecryptfs_data for future usage.
>> >> >> + * This data represents a file and must be passed in every query
>> >> >> functions
>> >> >> + * such as ecryptfs_get_key_size(), ecryptfs_get_cipher() etc.
>> >> >> + */
>> >> >> +struct ecryptfs_events {
>> >> >> +	bool (*is_cipher_supported_cb)(const char *cipher);
>> >> >> +	void (*open_cb)(struct inode *inode, void *ecrytpfs_data);
>> >> >> +	void (*release_cb)(struct inode *inode);
>> >> >> +	int (*encrypt_cb)(struct page *in_page, struct page *out_page,
>> >> >> +		struct inode *inode, unsigned long extent_offset);
>> >> >> +	int (*decrypt_cb)(struct page *in_page, struct page *out_page,
>> >> >> +		struct inode *inode, unsigned long extent_offset);
>> >> >> +	bool (*is_hw_crypt_cb)(void);
>> >> >> +	size_t (*get_salt_key_size_cb)(const char *cipher);
>> >> >> +};
>> >> >> +
>> >> >> +
>> >> >> +int ecryptfs_register_to_events(struct ecryptfs_events *ops);
>> >> >> +
>> >> >> +int ecryptfs_unregister_from_events(int user_handle);
>> >> >> +
>> >> >> +const unsigned char *ecryptfs_get_key(void *ecrytpfs_data);
>> >> >> +
>> >> >> +size_t ecryptfs_get_key_size(void *ecrytpfs_data);
>> >> >> +
>> >> >> +const unsigned char *ecryptfs_get_salt(void *ecrytpfs_data);
>> >> >> +
>> >> >> +size_t ecryptfs_get_salt_size(void *ecrytpfs_data);
>> >> >> +
>> >> >> +const unsigned char *ecryptfs_get_cipher(void *ecrytpfs_data);
>> >> >> +
>> >> >> +bool ecryptfs_is_page_in_metadata(void *ecrytpfs_data, pgoff_t
>> >> offset);
>> >> >> +
>> >> >> +bool ecryptfs_is_data_equal(void *ecrytpfs_data1, void
>> >> >> *ecrytpfs_data2);
>> >> >> +
>> >> >>  #endif /* _LINUX_ECRYPTFS_H */
>> >> >> --
>> >> >> Qualcomm Israel, on behalf of Qualcomm Innovation Center, Inc.
>> >> >> The Qualcomm Innovation Center, Inc. is a member of the Code
>> Aurora
>> >> >> Forum,
>> >> >> a Linux Foundation Collaborative Project
>> >> >>
>> >> >
>> >>
>> >
>>
>
