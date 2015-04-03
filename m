From: Marc de Verdelhan <mdeverdelhan@gmail.com>
Subject: Re: Way to decrypt an encrypted /home
Date: Fri, 3 Apr 2015 14:48:01 +0200
Message-ID: <CAHTahaZ262EtzX+sZ013rfR0JvwK+zmzJCy+yusEYjR+nKehhw@mail.gmail.com>
References: <CAHTahaZZetDg8=X=G4rTRJJWJBRXrN4N1dK86kUqwOXXKhh7bQ@mail.gmail.com>
	<20150401144211.GA11872@boyd>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:35928 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473AbbDCMsD (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 3 Apr 2015 08:48:03 -0400
Received: by lbbug6 with SMTP id ug6so78540806lbb.3
        for <ecryptfs@vger.kernel.org>; Fri, 03 Apr 2015 05:48:01 -0700 (PDT)
In-Reply-To: <20150401144211.GA11872@boyd>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tyler Hicks <tyhicks@canonical.com>
Cc: ecryptfs@vger.kernel.org

Of course not! :) It would have been too easy.

Anyway I finally managed to mount my partition and retrieve my data.
Here is an explanation:

I investigated more around the .ecryptfs/wrapped-passphrase file,
looking for a flaw and/or for a better understanding of the encryption
process. I found that you recently changed the format of this file
(after the CVE-2014-9687:
http://people.canonical.com/~ubuntu-security/cve/2014/CVE-2014-9687.html).

Since the initial Linux Mint installation had been made using
ecryptfs-utils-104-0ubuntu1, I had to check the format of MY
wrapped-passphrase file. After some researches I didn't find any
documentation about that file and its format (but maybe I missed
something). The only description I found was here:
http://bazaar.launchpad.net/~ecryptfs/ecryptfs/trunk/view/839/src/libecryptfs/key_management.c#L768
Quickly checked, my wrapped-passphrase file matches the new format:
':' char: 3A
File version (MUST be 0x02): 02
Wrapping salt: F0 77 85 03 14 2C 3B CD
Signature of wrapping key: <16-bytes-long value>
Encrypted passphrase: <32-bytes-long value>

Mentioned in passing, I think a small effort for documenting the
wrapped-passphrase file format and the authentication/encryption
process would be worthwhile. It could answer to questions like:
- What is the signature of the wrapping key (16 bytes) ? (I don't
understand its role in the encryption process).
- What is the relationship between the signature of the wrapping key
and the encrypted passphrase?
- What is the hashing process to generate the encrypted (hashed?) passphrase?
Maybe a schema would make the job.

Come back to my wrapped-passphrase file: I suppose ecryptfs-utils has
been updated to its version 104-0ubuntu1.14.04.3, just a few days
before I have my problem. (From
http://changelogs.ubuntu.com/changelogs/pool/main/e/ecryptfs-utils/ecryptfs-utils_104-0ubuntu1.14.04.3/changelog
I learn: "If a user has a mount passphrase that was wrapped using the
default salt, their mount passphrase will be rewrapped using a random
salt when they log in with their password.")

What I'm wondering is: What if a user (for instance: me) has a v2
wrapped-passphrase file but try to mount its encrypted directory with
a version of ecryptfs-utils inferior to v104? Did you consider this
case?
After this adventure I can say that returning "ERROR: Your passphrase
is incorrect" when you run a "ecryptfs-mount-private" in that kind of
configuration may get some users to think they really have an
incorrect password and to give up, loosing their data.
At [the very] least you should put a very big warning on
http://ecryptfs.org/ to inform all the users in that situation (which
may occur again since Debian Stable has the version 99-1 of
ecryptfs-utils (https://packages.debian.org/stable/misc/ecryptfs-utils)
and is still maintained).

Thank you.

Marc



On Wed, Apr 1, 2015 at 4:42 PM, Tyler Hicks <tyhicks@canonical.com> wrote:
> On 2015-04-01 09:52:49, Marc de Verdelhan wrote:
>> Hi there,
>
> Hello! Sorry to hear about the trouble you're having.
>
>>
>> I made a huge mistake and I need some help.
>>
>> I was running Linux Mint 17 (based on Ubuntu 14.04) with an encrypted
>> home directory (using eCryptfs). /home and / were on separated
>> partitions.
>> Last week I replaced Mint by Debian. I formatted the / partition and
>> kept the /home one. Now I can't decrypt my data. :/
>
> Did you record the randomly generated mount passphrase? After you set up
> an encrypted home directory in Ubuntu, you receive a pop up dialogue box
> informing you to record the mount passphrase and keep it somewhere safe.
> If you followed that advice, we can save a lot of time debugging the
> issue below.
>
> Tyler
>
>>
>> So I installed the ecryptfs-utils package.
>>
>> "ecryptfs-mount-private" returns:
>> Error: Unwrapping passphrase and inserting into the user session
>> keyring failed [-5]
>> Info: Check the system log for more information from libecryptfs
>> ERROR: Your passphrase is incorrect
>>
>> "/var/log/syslog" contains:
>> ecryptfs-insert-wrapped-passphrase-into-keyring: Incorrect wrapping
>> key for file [/home/login/.ecryptfs/wrapped-passphrase]
>> ecryptfs-insert-wrapped-passphrase-into-keyring: Error attempting to
>> unwrap passphrase from file
>> [/home/login/.ecryptfs/wrapped-passphrase]; rc = [-5]
>>
>> "ecryptfs-unwrap-passphrase
>> /home/.ecryptfs/login/.ecryptfs/wrapped-passphrase" returns:
>> Error: Unwrapping passphrase and inserting into the user session
>> keyring failed [-5]
>> Info: Check the system log for more information from libecryptfs
>>
>> To be sure I reinstalled the original Linux Mint on the / partition,
>> using the same login:password as before my misfortune. Same results.
>> I'm ABSOLUTELY sure that I'm using the same login and password than
>> last week. I installed Linux Mint 17 on June 2014; the ecryptfs-utils
>> version should have been "104-0ubuntu1".
>>
>> So questions are:
>> 1) What happened? Did I erase a configuration file I shouldn't? I
>> would like to understand what operation occurred to be in that
>> unpleasant situation?
>>
>> 2) What are my options? It may involve some C development if needed.
>> According to you, is there a way to brute force something? Or a more
>> intelligent solution, starting with sit down, have a tea and think.
>>
>> Any help will be greatly appreciated. Thank you for reading.
>>
>> Marc
>> --
>> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Marc de Verdelhan

+33 (0)6 18 33 62 52
http://www.verdelhan.eu/
