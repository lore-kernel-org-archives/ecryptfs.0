From: Michael Chang <m9chang@uwaterloo.ca>
Subject: Re: ecryptfs with an epehemeral key
Date: Tue, 10 Dec 2013 23:34:05 -0500
Message-ID: <CAHcyQ+5AXPaS94Xe1urG_jhfb0b96nAo80j7HWNSg6rFYgvx8w@mail.gmail.com>
References: <CAB8U+h2oxfhoNgZ8jvE0DXQ0nnXz9PywkCiONv51H6n79s-uVQ@mail.gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:57449 "EHLO
	mailchk-m03.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750814Ab3LKEes (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 10 Dec 2013 23:34:48 -0500
Received: from mail-ve0-f169.google.com (mail-ve0-f169.google.com [209.85.128.169])
	(authenticated bits=0)
	by mailchk-m03.uwaterloo.ca (8.14.4/8.14.4) with ESMTP id rBB4YkhV032149
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <ecryptfs@vger.kernel.org>; Tue, 10 Dec 2013 23:34:47 -0500
Received: by mail-ve0-f169.google.com with SMTP id c14so5598388vea.14
        for <ecryptfs@vger.kernel.org>; Tue, 10 Dec 2013 20:34:45 -0800 (PST)
In-Reply-To: <CAB8U+h2oxfhoNgZ8jvE0DXQ0nnXz9PywkCiONv51H6n79s-uVQ@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eric Tschetter <echeddar@gmail.com>
Cc: ecryptfs@vger.kernel.org

What if you create the key in a file stored on tmpfs? Then it
shouldn't leave RAM, right?

On Tue, Dec 10, 2013 at 7:46 PM, Eric Tschetter <echeddar@gmail.com> wrote:
> Hello all,
>
> I apologize if this is an easy question, but I've been Googling around
> for an answer with no luck and the man pages aren't helping, so I'm
> asking here.  If this is documented somewhere, feel free to just point
> me there.
>
> For context, I want to setup an ecryptfs volume with an ephemeral key.
>  I do *not* want the key stored anywhere.  I want to never, ever be
> able to access the data again upon restart.  I actually want to be
> forced to start over from nothing upon restart.
>
> From looking at the options for starting up ecryptfs, it looks like
> they all either require the key to be in a file or available in the
> history/ps/etc.:
>
> passphrase_passwd=(passphrase)
> passphrase_passwd_file=(filename)
> passphrase_passwd_fd=(file descriptor)
> passphrase_salt=(hex value)
> openssl_keyfile=(filename)
> openssl_passwd_file=(filename)
> openssl_passwd_fd=(file descriptor)
> openssl_passwd=(password)
>
> I'd rather not even store the key in a file and then remove the file,
> because technically that file might get persisted to disk and remain
> there after the delete.  The only thing I can think of is that maybe
> there is something magical you can do with file descriptors to get it
> to store the key in memory, have a file descriptor point to that
> memory location and then destroy the fd and memory.
>
> I'm unfortunately not that well-versed in how this would work though,
> so before diving down that potential rabbit hole was hoping to get
> some guidance from people on this list.
>
> All help is appreciated.
>
> --Eric
> --
> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thanks,

Michael Chang
4B Software Engineering (Class of 2014)
University of Waterloo
