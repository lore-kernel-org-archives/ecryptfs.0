From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: Practical use of ecryptfs, encrypted keys, and TPM: how to
 convert existing user key to encrypted key?
Date: Mon, 28 Mar 2016 13:02:03 -0400
Message-ID: <1459184523.2751.142.camel@linux.vnet.ibm.com>
References: <001301d187a0$95552f40$bfff8dc0$@codenest.com>
	 <1459177151.2751.118.camel@linux.vnet.ibm.com>
	 <003e01d18907$4bdf0b20$e39d2160$@codenest.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from e28smtp02.in.ibm.com ([125.16.236.2]:47688 "EHLO
	e28smtp02.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754086AbcC1RCP (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 28 Mar 2016 13:02:15 -0400
Received: from localhost
	by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <ecryptfs@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Mon, 28 Mar 2016 22:32:11 +0530
In-Reply-To: <003e01d18907$4bdf0b20$e39d2160$@codenest.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: James Johnston <johnstonj.public@codenest.com>
Cc: ecryptfs@vger.kernel.org, keyrings@vger.kernel.org

On Mon, 2016-03-28 at 15:34 +0000, James Johnston wrote:
> Hi Mimi,
> 
> Thanks for taking a look at this question.
> 
> > > The problem is if the TPM dies, I need to recover my data (e.g. computer dies,
> > > and need to restore from encrypted backups).  What I'm wanting to do is use a
> > > passphrase to decrypt data if the TPM is not available, to be used only in
> > > special circumstances.
> > 
> > Encrypted keys can be updated so that they're encrypted with a different
> > user or trusted key, but the key type (user | trusted) can not be
> > changed.  Allowing the key type to change would kind of defeat the
> > purpose of using a trusted key in the first place.
> 
> Agree 100% that changing the master key type from trusted to user would defeat the
> whole point.  But that's not really the request here.
> 
> What is the harm about initially populating the encrypted key type with a known
> mounting passphrase instead of random data?  For example, if the user has an
> existing ecryptfs file system they now wish to protect with the TPM?  I don't
> think it's the kernel's place to judge whether I think my payload has been
> compromised or not, or if it is sufficiently random.  I cannot think of any
> problem with this, so it seems to me, if it's not currently possible, this would
> be an area of needed improvement in the kernel to enable the proposed real-world
> use?

Yes, this would resolve the existing ecryptfs key usecase scenario, but
I don't think it is needed for the initial use case scenario of a TPM
failure.   A concern with this approach is how to safely initialize the
encrypted key payload.   Its probably not a good idea to pass it on the
command line.  Maybe prompt for it?

> I mean, as I currently understand it, the only way to use trusted & encrypted
> keys together involves randomly-generated encrypted keys, whose plaintext
> contents cannot be easily backed up since we cannot (and should not) be able
> to change the master key type.  But now the potential for data loss if the TPM
> fails seems certain, thus making this feature an interesting academic exercise
> but useless in the real world where backups are needed when real-world hardware
> stops working.  Am I missing something?

Another option would to be migrate the TPM key, which was used to seal
the trusted (asymmetric) key, to a backup server.  If something happens
to the local TPM, the trusted key could be re-sealed on a new TPM.  (I
have not tried doing this.)

Mimi

> To contrast, with LUKS or BitLocker for example, the decryption key for the
> block device can be recovered using multiple methods.  For example, a
> passphrase can be used to decrypt the main key for the drive.  Alternatively,
> one could conceivably use a different LUKS slot for use by the TPM, such as
> done by the tpm-luks project.  So I can use TPM for day-to-day use, and then
> put the passphrase in a safe offline place in case I have to recover when the
> TPM stops working.
> 
> I thought about the problem some more yesterday.  I guess one could use
> tpm_unsealdata and then ecryptfs-add-passphrase by hand from the command line.
> But then the authentication token is stored in a regular user key, not within
> the protection of an "encrypted" key type.  So the security is not as good
> because userspace can read the authentication token in plaintext at any time.
> 
> Best regards,
> 
> James Johnston
