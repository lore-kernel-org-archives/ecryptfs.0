From: Sylvain Pelissier <sylvain.pelissier@gmail.com>
Subject: Re: Changing salt value
Date: Wed, 11 Feb 2015 13:50:08 +0100
Message-ID: <CAOkUe-A9=2xH62cuqssx0nT9a=CkaKzTc5V3GiwpRijPqb-bFw@mail.gmail.com>
References: <CAOkUe-CMpJNpStZTOPnASaiEA8VC3kJAqKMBon6xodRgMJ5A1A@mail.gmail.com>
	<20150210224428.GA27607@boyd>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:32952 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752081AbbBKMuJ (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Wed, 11 Feb 2015 07:50:09 -0500
Received: by mail-we0-f180.google.com with SMTP id k11so3167877wes.11
        for <ecryptfs@vger.kernel.org>; Wed, 11 Feb 2015 04:50:08 -0800 (PST)
In-Reply-To: <20150210224428.GA27607@boyd>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org

Thank you for you answer. It makes sense to have the salt value in the
same file as the wrraped key because has soon has the salt value is
lost then the key can not be unwrapped any more. Did you plan to keep
the same syntax:

satl=<salt value>

At the end or begining of the wrapped-passphrase file ? This could
help to detect the version of the wrapping tool used.

On 10 February 2015 at 23:44, Tyler Hicks <tyhicks@canonical.com> wrote:
> On 2015-02-10 10:04:07, Sylvain Pelissier wrote:
>>  Hi,
>>
>> I am trying to change the default salt value used by ecryptfs-utils to
>> wrapped the encryption key stored in
>> "/home/.ecryptfs/user/.ecryptfs/wrapped-passphrase". I'm using Ubuntu
>> 14.04 with the complete home folder encryption. I created a file
>> .ecryptfsrc in the unencrypted home folder of the user which contains:
>>
>> salt=04ae48987b177f01
>>
>> Then I wrap the passphrase key with the tool
>> ecryptfs-unwrap-passphrase, I noticed that the result has changed and
>> thus I think it uses the new salt value. However, when I replace the
>> file /home/.ecryptfs/user/.ecryptfs/wrapped-passphrase with the new
>> one, then when I log with the user credential I have the error telling
>> that the key is not in the kernel keyring.
>> Did I miss something ?
>
> Hi Slyvain - Using the .ecryptfsrc file with the encrypted home tools
> (ecryptfs-setup-private, ecryptfs-wrap-passphrase,
> ecryptfs-unwrap-passphrase, mount.ecryptfs_private, etc.,) is not
> recommended.
>
> I recognize that ecryptfs_read_salt_hex_from_rc() is called from most of
> those tools. However, I think that those call sites are incorrect in
> doing so and I'd like to eventually remove those calls.
>
> There is an unfortunate difference of usage and configuration in the
> mount.ecryptfs helper and the mount.ecryptfs_private helper. The
> .ecryptfsrc file is something that *should* be specific to the
> mount.ecryptfs mount helper so attempting to specify a salt in that file
> would be incorrect for the mount.ecryptfs_private helper.
>
> That means that there is currently not a way to specify a non-default
> salt value for use with the encrypted home tools.
>
> Dustin and I have been discussing this today. The current plan is that
> we will implement a "version 2" of the wrapped-passphrase file. It will
> contain a randomly generated salt value. Storing the salt outside of the
> wrapped-passphrase file, such as in the .ecryptfsrc, would greatly
> increase the chance that a user may migrate their wrapped-passphrase
> file to another machine (for example, while upgrading to a new laptop)
> but forget to migrate their .ecryptfsrc file. We want to include the
> salt value in the wrapped-passphrase file to reduce the chances of data
> loss those types of situations.
>
> Additionally, the ecryptfs_unwrap_passphrase() function will be modified
> to automatically migrate salt-less, "version 1" wrapped-passphrase files
> to the new "version 2" format and the file will be rewrapped with the
> new key. By doing this migration in ecryptfs_unwrap_passphrase(), it
> means that users will only need to log in through PAM and the
> pam_ecryptfs module will be able to trigger the migration.
>
> We're working on this now. Thanks for bring this issue to our attention.
>
> Tyler
