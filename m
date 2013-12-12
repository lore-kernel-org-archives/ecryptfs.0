From: Eric Tschetter <echeddar@gmail.com>
Subject: Re: ecryptfs with an epehemeral key
Date: Wed, 11 Dec 2013 18:12:05 -0600
Message-ID: <CAB8U+h0_fhEgxHBcdK9PwYGyZhQVqr=mi1XgVXdGYioOrVeEHA@mail.gmail.com>
References: <CAB8U+h2oxfhoNgZ8jvE0DXQ0nnXz9PywkCiONv51H6n79s-uVQ@mail.gmail.com>
	<CAHcyQ+5AXPaS94Xe1urG_jhfb0b96nAo80j7HWNSg6rFYgvx8w@mail.gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:33887 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000Ab3LLAMG (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Wed, 11 Dec 2013 19:12:06 -0500
Received: by mail-wg0-f45.google.com with SMTP id y10so7128802wgg.0
        for <ecryptfs@vger.kernel.org>; Wed, 11 Dec 2013 16:12:05 -0800 (PST)
In-Reply-To: <CAHcyQ+5AXPaS94Xe1urG_jhfb0b96nAo80j7HWNSg6rFYgvx8w@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Chang <m9chang@uwaterloo.ca>
Cc: ecryptfs@vger.kernel.org

Just to close the loop with the list.  I thought the tempfs idea was
good and that took me down learning about that.  Which ended up with
me actually running into some docs on using luks and dm-crypt to do an
encrypted volume via /etc/fstab and /etc/crypttab, which seemed like a
plenty good enough solution for what I wanted, so that's what I'm
currently pursuing.

In all the documentation for the cryptsetup stuff, they use
'/dev/urandom' as the "key file" for things like temporary partitions
and swap encryption.  I'm not sure if that would work with ecryptfs as
well, but just thought I'd throw it out there.

--Eric

On Tue, Dec 10, 2013 at 10:34 PM, Michael Chang <m9chang@uwaterloo.ca> wrote:
> What if you create the key in a file stored on tmpfs? Then it
> shouldn't leave RAM, right?
>
> On Tue, Dec 10, 2013 at 7:46 PM, Eric Tschetter <echeddar@gmail.com> wrote:
>> Hello all,
>>
>> I apologize if this is an easy question, but I've been Googling around
>> for an answer with no luck and the man pages aren't helping, so I'm
>> asking here.  If this is documented somewhere, feel free to just point
>> me there.
>>
>> For context, I want to setup an ecryptfs volume with an ephemeral key.
>>  I do *not* want the key stored anywhere.  I want to never, ever be
>> able to access the data again upon restart.  I actually want to be
>> forced to start over from nothing upon restart.
>>
>> From looking at the options for starting up ecryptfs, it looks like
>> they all either require the key to be in a file or available in the
>> history/ps/etc.:
>>
>> passphrase_passwd=(passphrase)
>> passphrase_passwd_file=(filename)
>> passphrase_passwd_fd=(file descriptor)
>> passphrase_salt=(hex value)
>> openssl_keyfile=(filename)
>> openssl_passwd_file=(filename)
>> openssl_passwd_fd=(file descriptor)
>> openssl_passwd=(password)
>>
>> I'd rather not even store the key in a file and then remove the file,
>> because technically that file might get persisted to disk and remain
>> there after the delete.  The only thing I can think of is that maybe
>> there is something magical you can do with file descriptors to get it
>> to store the key in memory, have a file descriptor point to that
>> memory location and then destroy the fd and memory.
>>
>> I'm unfortunately not that well-versed in how this would work though,
>> so before diving down that potential rabbit hole was hoping to get
>> some guidance from people on this list.
>>
>> All help is appreciated.
>>
>> --Eric
>> --
>> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Thanks,
>
> Michael Chang
> 4B Software Engineering (Class of 2014)
> University of Waterloo
