Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1597242925
	for <ecryptfs@vger.kernel.org>; Tue,  2 Jun 2026 22:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780439869; cv=none; b=u7Nzv6Ix734o3WR3kMsKeGDYi0ynFBak2c27GFZgh1MTGk5Y8ddDOjWnC031VLjGkEUs0LZJpneCdOnLIEDtDa8wxUCl8Fe9NCzZNzOqhZ+owvEfCo4ryQlbZbRHMjktkPFwTz2A07G8M3ncXX6u7tG6fbS0fjvb/4jN3NxQboI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780439869; c=relaxed/simple;
	bh=/09c9tuHltDAZOwRId/Cytuer6/7QO+GQW7EdHWz0P4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYR3zT0LsZyro4cqHOJmv+Eu0zHOQJ7p+zLElemwpl5AzlJ6MqhvL/TtHyBQYVs3K4bis+VacYOMQPptN+3HA4+UBvnaPG28Tj7X+sE0AENAPws7EYxlD0QcxCZluAgEi8hUQvowdCE9Z6F0soQ6QU04kpi5rZxsp7RIaUjgutM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sC8q414B; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sC8q414B"
Date: Wed, 3 Jun 2026 00:37:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780439866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zAnVc+swHcj5PIiVObVDSH4w5dI/UZbGE9oqHxmlszo=;
	b=sC8q414BrFnv5BawL74kWFfF8Pfm9/nVmIeqLsmN/4sjIxbmGOiQPVyWdNsU3jurua3E+A
	KFXW4drVadt40mwdrIuFjUnakLDf8J4tRTSZffbqy4kVQ/OOMIMDbRT1ecDqFzvvrrQ1y9
	H9A6GcKnfNfyHlP8b6wL3j3sqh5lu5w=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ecryptfs: use kasprintf in
 ecryptfs_crypto_api_algify_cipher_name
Message-ID: <ah9bNrD59WiPRBRU@linux.dev>
References: <20260518073842.57501-4-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518073842.57501-4-thorsten.blum@linux.dev>
X-Migadu-Flow: FLOW_OUT

Gentle ping?

On Mon, May 18, 2026 at 09:38:45AM +0200, Thorsten Blum wrote:
> Use kasprintf() to simplify ecryptfs_crypto_api_algify_cipher_name().
> 
> Use const char * for the read-only cipher name and chaining modifier
> while at it.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  fs/ecryptfs/crypto.c | 24 +++++++-----------------
>  1 file changed, 7 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
> index 5ef67b2674ee..74b02b55e3f6 100644
> --- a/fs/ecryptfs/crypto.c
> +++ b/fs/ecryptfs/crypto.c
> @@ -49,25 +49,15 @@ void ecryptfs_from_hex(char *dst, char *src, int dst_size)
>  }
>  
>  static int ecryptfs_crypto_api_algify_cipher_name(char **algified_name,
> -						  char *cipher_name,
> -						  char *chaining_modifier)
> +						  const char *cipher_name,
> +						  const char *chaining_modifier)
>  {
> -	int cipher_name_len = strlen(cipher_name);
> -	int chaining_modifier_len = strlen(chaining_modifier);
> -	int algified_name_len;
> -	int rc;
> +	(*algified_name) = kasprintf(GFP_KERNEL, "%s(%s)", chaining_modifier,
> +				     cipher_name);
> +	if (!(*algified_name))
> +		return -ENOMEM;
>  
> -	algified_name_len = (chaining_modifier_len + cipher_name_len + 3);
> -	(*algified_name) = kmalloc(algified_name_len, GFP_KERNEL);
> -	if (!(*algified_name)) {
> -		rc = -ENOMEM;
> -		goto out;
> -	}
> -	snprintf((*algified_name), algified_name_len, "%s(%s)",
> -		 chaining_modifier, cipher_name);
> -	rc = 0;
> -out:
> -	return rc;
> +	return 0;
>  }
>  
>  /**
