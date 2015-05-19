From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] crypto: allow to assign gfp_t for __crypto_alloc_tfm
Date: Tue, 19 May 2015 14:59:29 +0800
Message-ID: <20150519065929.GA28610@gondor.apana.org.au>
References: <1432014416-39326-1-git-send-email-jaegeuk@kernel.org>
 <20150519054945.GA28060@gondor.apana.org.au>
 <20150519062430.GA39588@jaegeuk-mac02.hsd1.ca.comcast.net>
 <20150519063211.GA28347@gondor.apana.org.au>
 <20150519065812.GA40012@jaegeuk-mac02.hsd1.ca.comcast.net>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from helcar.hengli.com.au ([209.40.204.226]:35254 "EHLO
	helcar.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbbESG7k (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 19 May 2015 02:59:40 -0400
Content-Disposition: inline
In-Reply-To: <20150519065812.GA40012@jaegeuk-mac02.hsd1.ca.comcast.net>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: davem@davemloft.net, linux-crypto@vger.kernel.org, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, ecryptfs@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, May 18, 2015 at 11:58:12PM -0700, Jaegeuk Kim wrote:
>
> > So where does the key get generated? The crypto tfm should be
> > allocated when you generate the key.
> 
> In fs/ext4/crypto.c,
> 
>  - writepage
>    - ext4_encrypt
>      - ext4_get_crypto_ctx
>        - crypto_alloc_ablkcipher
>      - ext4_page_crypto
>        - crypto_ablkcipher_setkey
>        - ablkcipher_request_alloc(GFP_NOFS)
>        - ablkcipher_request_set_crypt(PAGE_CACHE_SIZE)
>        - crypto_ablkcipher_encrypt
> 
>  - end_io
>    - crypto_free_tfm

No that's where you set the key, not where you generate the key.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
