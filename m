From: Sylvain Pelissier <sylvain.pelissier@gmail.com>
Subject: Re: bcrypt or other key derivation algorithm
Date: Mon, 18 Jan 2016 12:00:36 +0100
Message-ID: <CAOkUe-DgVJ6DPaL0UnTM7T1FzDEvWV6_HwsSvVDVTj5F_JW6vg@mail.gmail.com>
References: <148109963.231852.1453113382610.JavaMail.zimbra@halfgaar.net>
	<477778683.231885.1453114296832.JavaMail.zimbra@halfgaar.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:35248 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754161AbcARLAh convert rfc822-to-8bit (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 18 Jan 2016 06:00:37 -0500
Received: by mail-ig0-f169.google.com with SMTP id t15so53053349igr.0
        for <ecryptfs@vger.kernel.org>; Mon, 18 Jan 2016 03:00:37 -0800 (PST)
In-Reply-To: <477778683.231885.1453114296832.JavaMail.zimbra@halfgaar.net>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Wiebe Cazemier <wiebe@halfgaar.net>
Cc: ecryptfs@vger.kernel.org

Hi,

I think it is a good idea to support stronger algorithms. As a new
hashing algorithm, you can also consider Argon2 algorithm, the winner
of the Password hashing compettion (https://password-hashing.net/).
The implementation is already available:
https://github.com/p-h-c/phc-winner-argon2.
Reagrds

Sylvain

On 18 January 2016 at 11:51, Wiebe Cazemier <wiebe@halfgaar.net> wrote:
> Hi,
>
> What are the thoughts on implementing bcrypt as key derivation algorithm? I already found a TODO in the code that ecryptfs should support more algorithms than just SHA512 * 65536. I tried brute forcing this, and got no further than about 20/s, but on FPGAs/GPUs this would be a lot faster.
>
> It should be easy enough to borrow code from OpenSSH, which uses bcrypt in their secure new private key file format (ssh-keygen -o; their old format is pretty weak (MD5 once, encrypt with AES 128)).
>
> Questions:
>
> 1) The v2 wrapped does not have a field to indicate which algorithm is used (like /etc/shadow (crypt API) has). Does this necessitate a v3, which does have said field?
>
> 2) Are there objections to including BSD licensed code from OpenSSH?
>
> Regards,
>
> Wiebe
> --
> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
