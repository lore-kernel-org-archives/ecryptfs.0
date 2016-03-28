From: "James Johnston" <johnstonj.public@codenest.com>
Subject: RE: Practical use of ecryptfs, encrypted keys, and TPM: how to convert existing user key to encrypted key?
Date: Mon, 28 Mar 2016 23:25:11 -0000
Message-ID: <007801d18949$141d56a0$3c5803e0$@codenest.com>
References: <001301d187a0$95552f40$bfff8dc0$@codenest.com>	 <1459177151.2751.118.camel@linux.vnet.ibm.com>	 <003e01d18907$4bdf0b20$e39d2160$@codenest.com> <1459184523.2751.142.camel@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from sender163-mail.zoho.com ([74.201.84.163]:24834 "EHLO
	sender163-mail.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753317AbcC1XZS (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 28 Mar 2016 19:25:18 -0400
In-Reply-To: <1459184523.2751.142.camel@linux.vnet.ibm.com>
Content-Language: en-us
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: 'Mimi Zohar' <zohar@linux.vnet.ibm.com>
Cc: ecryptfs@vger.kernel.org, keyrings@vger.kernel.org

> > > > The problem is if the TPM dies, I need to recover my data (e.g. computer dies,
> > > > and need to restore from encrypted backups).  What I'm wanting to do is use a
> > > > passphrase to decrypt data if the TPM is not available, to be used only in
> > > > special circumstances.
> > >
> > > Encrypted keys can be updated so that they're encrypted with a different
> > > user or trusted key, but the key type (user | trusted) can not be
> > > changed.  Allowing the key type to change would kind of defeat the
> > > purpose of using a trusted key in the first place.
> >
> > Agree 100% that changing the master key type from trusted to user would defeat the
> > whole point.  But that's not really the request here.
> >
> > What is the harm about initially populating the encrypted key type with a known
> > mounting passphrase instead of random data?  For example, if the user has an
> > existing ecryptfs file system they now wish to protect with the TPM?  I don't
> > think it's the kernel's place to judge whether I think my payload has been
> > compromised or not, or if it is sufficiently random.  I cannot think of any
> > problem with this, so it seems to me, if it's not currently possible, this would
> > be an area of needed improvement in the kernel to enable the proposed real-world
> > use?
> 
> Yes, this would resolve the existing ecryptfs key usecase scenario, but
> I don't think it is needed for the initial use case scenario of a TPM
> failure.   A concern with this approach is how to safely initialize the
> encrypted key payload.   Its probably not a good idea to pass it on the
> command line.  Maybe prompt for it?

To clarify, there's not currently a way to do this then, right?  (i.e. I didn't
miss anything?)  After my initial e-mail, I examined kernel sources and I
couldn't spot anything that wasn't in the documentation, but I wanted to be
sure.

What if you just used a user key payload?  For example, specifying another key
instead of the key size like this:

    keyctl add encrypted mykey "new default trusted:master user:payload"

would read the payload of "payload" user key and use it as plaintext of the new
encrypted key, instead of generating a random key.  If <format> is ecryptfs,
then the user key would be expected to be an authentication token added to the
kernel by ecryptfs-add-passphrase (which handles prompting user).

James

