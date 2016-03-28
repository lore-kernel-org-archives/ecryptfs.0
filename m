From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: Practical use of ecryptfs, encrypted keys, and TPM: how to
 convert existing user key to encrypted key?
Date: Mon, 28 Mar 2016 10:59:11 -0400
Message-ID: <1459177151.2751.118.camel@linux.vnet.ibm.com>
References: <001301d187a0$95552f40$bfff8dc0$@codenest.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from e28smtp07.in.ibm.com ([125.16.236.7]:43619 "EHLO
	e28smtp07.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754562AbcC1O7Y (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 28 Mar 2016 10:59:24 -0400
Received: from localhost
	by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <ecryptfs@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Mon, 28 Mar 2016 20:29:19 +0530
In-Reply-To: <001301d187a0$95552f40$bfff8dc0$@codenest.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: James Johnston <johnstonj.public@codenest.com>
Cc: ecryptfs@vger.kernel.org, keyrings@vger.kernel.org

On Sat, 2016-03-26 at 20:46 +0000, James Johnston wrote:
> Hi,
> 
> Short version of this question is:  How do I convert a user key on the keyring
> storing ecryptfs authentication token / FEFEK to an encrypted key on keyring?
> (I.e. how to add an encrypted key with user-specified plaintext data, instead
> of a randomly-generated key - such as a pre-existing mounting passphrase for
> an existing ecryptfs file system.)  Read on for why...
> 
> I'm trying to figure out how to practically use ecryptfs with a TPM, and the
> information I'm finding is generally out-of-date/obsolete.  All I've found is
> blog articles or IBM whitepapers from a few years ago that appear to use
> features that don't exist anymore / unmaintained features.  I've gathered that
> the proper way to do this now involves trusted and encrypted kernel keys, as
> per:

Support for using trusted/encrypted ecryptfs keys was added by Roberto
Sassu as soon as trusted/encrypted keys was upstreamed.  The only
documentation are those that you sited below.

>  * https://www.kernel.org/doc/Documentation/security/keys-ecryptfs.txt
>  * https://www.kernel.org/doc/Documentation/security/keys-trusted-encrypted.txt
> 
> The strategy outlined in the above documentation indicates the idea would be to
> make a new trusted key, sealed with the TPM, and then use it to make a new
> encrypted key in the ecryptfs format, specifying the trusted key as the master.
> That's easy enough to follow, and does what I'm looking for, except...
> 
> The problem is if the TPM dies, I need to recover my data (e.g. computer dies,
> and need to restore from encrypted backups).  What I'm wanting to do is use a
> passphrase to decrypt data if the TPM is not available, to be used only in
> special circumstances. 

Encrypted keys can be updated so that they're encrypted with a different
user or trusted key, but the key type (user | trusted) can not be
changed.  Allowing the key type to change would kind of defeat the
purpose of using a trusted key in the first place.

There was some initial discussions about adding support for trusted key
migration, but nothing was ever posted. 

Mimi
