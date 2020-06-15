From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] mm, treewide: Rename kzfree() to kfree_sensitive()
Date: Mon, 15 Jun 2020 21:07:53 +0300
Message-ID: <20200615180753.GJ4151@kadam>
References: <20200413211550.8307-1-longman@redhat.com>
 <20200413211550.8307-2-longman@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane-mx.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200413211550.8307-2-longman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: <ecryptfs.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>, 
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>, 
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane-mx.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Waiman Long <longman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: linux-cifs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jarkko Sakkinen <jarkko.sakkinen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-sctp-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, target-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kasan-dev-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, cocci-/FJkirnvOdkvYVN+rsErww@public.gmane.org, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-scsi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, James Morris <jmorris-gx6/JNMH7DfYtjvyW6yDsg@public.gmane.org>, Matthew Wilcox <willy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-stm32-XDFAJ8BFU24N7RejjzZ/Li2xQDfSxrLKVpNB7YpNyf8@public.gmane.org, intel-wired-lan-qjLDD68F18P21nG7glBr7A@public.gmane.org, David Rientjes <rientjes-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "Serge E. Hallyn" <serge-A9i7LUbDfNHQT0dZR+AlfA@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ecryptfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-fscrypt-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-btrfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-integrity-u79uwXL29TZNg+MwTxZMZA@public.gmane.org

On Mon, Apr 13, 2020 at 05:15:49PM -0400, Waiman Long wrote:
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 23c7500eea7d..c08bc7eb20bd 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1707,17 +1707,17 @@ void *krealloc(const void *p, size_t new_size, gfp_t flags)
>  EXPORT_SYMBOL(krealloc);
>  
>  /**
> - * kzfree - like kfree but zero memory
> + * kfree_sensitive - Clear sensitive information in memory before freeing
>   * @p: object to free memory of
>   *
>   * The memory of the object @p points to is zeroed before freed.
> - * If @p is %NULL, kzfree() does nothing.
> + * If @p is %NULL, kfree_sensitive() does nothing.
>   *
>   * Note: this function zeroes the whole allocated buffer which can be a good
>   * deal bigger than the requested buffer size passed to kmalloc(). So be
>   * careful when using this function in performance sensitive code.
>   */
> -void kzfree(const void *p)
> +void kfree_sensitive(const void *p)
>  {
>  	size_t ks;
>  	void *mem = (void *)p;
> @@ -1725,10 +1725,10 @@ void kzfree(const void *p)
>  	if (unlikely(ZERO_OR_NULL_PTR(mem)))
>  		return;
>  	ks = ksize(mem);
> -	memset(mem, 0, ks);
> +	memzero_explicit(mem, ks);
        ^^^^^^^^^^^^^^^^^^^^^^^^^
This is an unrelated bug fix.  It really needs to be pulled into a
separate patch by itself and back ported to stable kernels.

>  	kfree(mem);
>  }
> -EXPORT_SYMBOL(kzfree);
> +EXPORT_SYMBOL(kfree_sensitive);
>  
>  /**
>   * ksize - get the actual amount of memory allocated for a given object

regards,
dan carpenter
