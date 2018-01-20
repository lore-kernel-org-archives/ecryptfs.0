From: Guenter Roeck <linux@roeck-us.net>
Subject: ecryptfs problems with encrypted/ unencrypted file names
Date: Sat, 20 Jan 2018 15:55:54 -0800
Message-ID: <5765d47f-81a1-07d8-0a85-6d34b7a770bd@roeck-us.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:42119 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756726AbeATXz6 (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Sat, 20 Jan 2018 18:55:58 -0500
Content-Language: en-US
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Tyler Hicks <tyhicks@canonical.com>
Cc: ecryptfs@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>

Hi,

Commit 88ae4ab9802e ("ecryptfs_lookup(): try either only encrypted or plaintext name")
was supposed to fix a situation where two files with the same name and same inode could
be created in ecryptfs. One of those files had an encrypted file name, the other file
name was unencrypted.

The impact of 88ae4ab9802e is that a mix of encrypted and unencrypted file names
is now no longer possible, or at least presumably that was the idea. However,
that is not the case. The only difference I can see is that it is now even easier
to create a situation where two files with the same name coexist (one encrypted
and the other not encrypted). In practice, this looks like the following
(files created with v4.14.12).

ecryptfs mounted with file name encryption enabled:

$ ls -li
total 48
5252822 -rw-rw-r-- 1 groeck groeck 10 Jan 20 13:02 myfile
5252822 -rw-rw-r-- 1 groeck groeck 10 Jan 20 13:02 myfile
5252824 -rw-rw-r-- 1 groeck groeck 10 Jan 20 15:36 myfile2
5252824 -rw-rw-r-- 1 groeck groeck 10 Jan 20 15:36 myfile2
$ grep . *
myfile:encrypted
myfile:encrypted
myfile2:encrypted
myfile2:encrypted

$ ls -li
total 48
5252824 -rw-rw-r-- 1 groeck groeck 10 Jan 20 15:36 ECRYPTFS_FNEK_ENCRYPTED.FWbF9U6H6L6ekEZYGWnkfR4wMiyeTVoCeVun.BU8Zu5-njbcIPoApxk7-E--
5252822 -rw-rw-r-- 1 groeck groeck 10 Jan 20 13:02 ECRYPTFS_FNEK_ENCRYPTED.FWbF9U6H6L6ekEZYGWnkfR4wMiyeTVoCeVunt0fda7t9YCtJ70cm911yZ---
5252817 -rw-rw-r-- 1 groeck groeck 12 Jan 20 12:52 myfile
5252827 -rw-rw-r-- 1 groeck groeck 12 Jan 20 15:37 myfile2

$ grep . *
ECRYPTFS_FNEK_ENCRYPTED.FWbF9U6H6L6ekEZYGWnkfR4wMiyeTVoCeVun.BU8Zu5-njbcIPoApxk7-E--:encrypted
ECRYPTFS_FNEK_ENCRYPTED.FWbF9U6H6L6ekEZYGWnkfR4wMiyeTVoCeVunt0fda7t9YCtJ70cm911yZ---:encrypted
myfile:unencrypted
myfile2:unencrypted

On top of that, if I create a file with file name encryption disabled, then remount with file
name encryption enabled, I see the following:

$ ls -li
ls: cannot access 'myfile3': No such file or directory
total 48
5252822 -rw-rw-r-- 1 groeck groeck 10 Jan 20 13:02 myfile
5252822 -rw-rw-r-- 1 groeck groeck 10 Jan 20 13:02 myfile
5252824 -rw-rw-r-- 1 groeck groeck 10 Jan 20 15:36 myfile2
5252824 -rw-rw-r-- 1 groeck groeck 10 Jan 20 15:36 myfile2
       ? -????????? ? ?      ?       ?            ? myfile3

Pre-88ae4ab9802e, the file system had to be mounted with encrypted file names first to create
a file, then the same had to be repeated after mounting with unencrypted file names. Now the
duplicate files can be create both ways (unencrypted _or_ encrypted first).

What I fail to see is how the current code is better than before. I can only see downsides
- when mounted with encrypted file names, it is no longer possible to access files with
unencrypted names, _and_ it is even easier than before to create duplicate names.

Am I missing something ?

Thanks,
Guenter
