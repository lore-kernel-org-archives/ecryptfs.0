From: "James Johnston" <johnstonj.public@codenest.com>
Subject: RE: Practical use of ecryptfs, encrypted keys, and TPM: how to convert existing user key to encrypted key?
Date: Mon, 28 Mar 2016 15:34:16 -0000
Message-ID: <003e01d18907$4bdf0b20$e39d2160$@codenest.com>
References: <001301d187a0$95552f40$bfff8dc0$@codenest.com> <1459177151.2751.118.camel@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from sender163-mail.zoho.com ([74.201.84.163]:24274 "EHLO
	sender163-mail.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752620AbcC1PeY (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 28 Mar 2016 11:34:24 -0400
In-Reply-To: <1459177151.2751.118.camel@linux.vnet.ibm.com>
Content-Language: en-us
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: 'Mimi Zohar' <zohar@linux.vnet.ibm.com>
Cc: ecryptfs@vger.kernel.org, keyrings@vger.kernel.org

Hi Mimi,

Thanks for taking a look at this question.

> > The problem is if the TPM dies, I need to recover my data (e.g. computer dies,
> > and need to restore from encrypted backups).  What I'm wanting to do is use a
> > passphrase to decrypt data if the TPM is not available, to be used only in
> > special circumstances.
> 
> Encrypted keys can be updated so that they're encrypted with a different
> user or trusted key, but the key type (user | trusted) can not be
> changed.  Allowing the key type to change would kind of defeat the
> purpose of using a trusted key in the first place.

Agree 100% that changing the master key type from trusted to user would defeat the
whole point.  But that's not really the request here.

What is the harm about initially populating the encrypted key type with a known
mounting passphrase instead of random data?  For example, if the user has an
existing ecryptfs file system they now wish to protect with the TPM?  I don't
think it's the kernel's place to judge whether I think my payload has been
compromised or not, or if it is sufficiently random.  I cannot think of any
problem with this, so it seems to me, if it's not currently possible, this would
be an area of needed improvement in the kernel to enable the proposed real-world
use?

I mean, as I currently understand it, the only way to use trusted & encrypted
keys together involves randomly-generated encrypted keys, whose plaintext
contents cannot be easily backed up since we cannot (and should not) be able
to change the master key type.  But now the potential for data loss if the TPM
fails seems certain, thus making this feature an interesting academic exercise
but useless in the real world where backups are needed when real-world hardware
stops working.  Am I missing something?

To contrast, with LUKS or BitLocker for example, the decryption key for the
block device can be recovered using multiple methods.  For example, a
passphrase can be used to decrypt the main key for the drive.  Alternatively,
one could conceivably use a different LUKS slot for use by the TPM, such as
done by the tpm-luks project.  So I can use TPM for day-to-day use, and then
put the passphrase in a safe offline place in case I have to recover when the
TPM stops working.

I thought about the problem some more yesterday.  I guess one could use
tpm_unsealdata and then ecryptfs-add-passphrase by hand from the command line.
But then the authentication token is stored in a regular user key, not within
the protection of an "encrypted" key type.  So the security is not as good
because userspace can read the authentication token in plaintext at any time.

Best regards,

James Johnston


