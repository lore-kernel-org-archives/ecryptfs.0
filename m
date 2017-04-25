From: "Natanji ." <natanji@gmail.com>
Subject: Lots of errors "opening lower file for lower_dentry" and
 "ecryptfs_i_size_read: Error attempting to initialize the lower file", how to fix?
Date: Tue, 25 Apr 2017 14:25:51 +0200
Message-ID: <CAG0r0U09WqphOh=4-J++KA1YmJN08T9pHUPYj0rb7o8Cf_D3mQ@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:36055 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1947585AbdDYMZ5 (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Tue, 25 Apr 2017 08:25:57 -0400
Received: by mail-oi0-f48.google.com with SMTP id w12so57119281oiw.3
        for <ecryptfs@vger.kernel.org>; Tue, 25 Apr 2017 05:25:57 -0700 (PDT)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="macroman"
To: ecryptfs@vger.kernel.org

Hi all,
yesterday I wanted to create a git repository in my ecryptfs protected
folder, but was met with an error. It's easily reproducible:
$ git init
Initialisierte leeres Git-Repository in /home/marlin/Private/.git/
$ touch blafoo
$ git add blafoo
error: insufficient permission for adding an object to repository
database .git/objects
error: bla: failed to insert into database
error: unable to index file bla
fatal: Hinzuf=C3=BCgen von Dateien fehlgeschlagen

When researching, I found out that this ONLY happened within the
ecryptfs Private folder - not outside of it in my home folder. I then
checked dmesg and was met with a LOT of errors of ecryptfs saying
"Error opening lower file for lower_dentry..." and
"ecryptfs_i_size_read: Error attempting to initialize the lower file
for the dentry with name..." - and then a filename that looks like a
SHA1 hash, which to my knowledge is how git object files are named. A
list of these errors is at the end of the mail.

My dmesg is completely full with such errors, there are a few with
different file names but the vast amount is indeed git object files,
for some reason? And I don't understand why this error happens at all.
There seems to be something wrong here and I would like to know how I
can fix this before everything blows up and I lose data.

My system is running Ubuntu 14.04.1 LTS with Kernel 4.4.0-72. My home
folder is on an nfs4 network mount. I have been using ecryptfs for
like 2 years without noticing any problems previously. Can you help
me? Googling for these errors didn't turn up any solution.

Best regards,
Natanji

...
[ 2009.485540] Error opening lower file for lower_dentry
[0xffff880065156d80] and lower_mnt [0xffff880234c239a0]; rc =3D [-13]
[ 2009.485543] ecryptfs_i_size_read: Error attempting to initialize
the lower file for the dentry with name
[e00c7464c1a82e342ffadd31a174d8023355e5]; rc =3D [-13]
[ 2009.487234] Error opening lower file for lower_dentry
[0xffff88006510fd80] and lower_mnt [0xffff880234c239a0]; rc =3D [-13]
[ 2009.487237] ecryptfs_i_size_read: Error attempting to initialize
the lower file for the dentry with name
[99a8c4248643d76bd1a52f815ac2f57699d68c]; rc =3D [-13]
[ 2009.488908] Error opening lower file for lower_dentry
[0xffff88019a492600] and lower_mnt [0xffff880234c239a0]; rc =3D [-13]
[ 2009.488912] ecryptfs_i_size_read: Error attempting to initialize
the lower file for the dentry with name
[f395dc7337e50b1509308d04395da4ec5d8e79]; rc =3D [-13]
[ 2009.490631] Error opening lower file for lower_dentry
[0xffff88019a492840] and lower_mnt [0xffff880234c239a0]; rc =3D [-13]
[ 2009.490633] ecryptfs_i_size_read: Error attempting to initialize
the lower file for the dentry with name
[d99e75cce498065aff24f9149021fa7f97f874]; rc =3D [-13]
[ 2009.492422] Error opening lower file for lower_dentry
[0xffff88019a42c480] and lower_mnt [0xffff880234c239a0]; rc =3D [-13]
[ 2009.492425] ecryptfs_i_size_read: Error attempting to initialize
the lower file for the dentry with name
[deb25d601d3c66ad8213a37b9c136379351ab2]; rc =3D [-13]
[ 2009.494135] Error opening lower file for lower_dentry
[0xffff88019a492c00] and lower_mnt [0xffff880234c239a0]; rc =3D [-13]
[ 2009.494137] ecryptfs_i_size_read: Error attempting to initialize
the lower file for the dentry with name
[5329e1e44d059c96a52269e559277cd9641a47]; rc =3D [-13]
[ 2009.495815] Error opening lower file for lower_dentry
[0xffff88006510fe40] and lower_mnt [0xffff880234c239a0]; rc =3D [-13]
[ 2009.495816] ecryptfs_i_size_read: Error attempting to initialize
the lower file for the dentry with name
[6745d7f8f4b569d11965a168313e0032e1e4ad]; rc =3D [-13]
[ 2009.497459] Error opening lower file for lower_dentry
[0xffff88019a493180] and lower_mnt [0xffff880234c239a0]; rc =3D [-13]
[ 2009.497462] ecryptfs_i_size_read: Error attempting to initialize
the lower file for the dentry with name
[b8fc569582288889fc3daf3f64d7e4a4f6430a]; rc =3D [-13]
[ 2009.499191] Error opening lower file for lower_dentry
[0xffff88019a4933c0] and lower_mnt [0xffff880234c239a0]; rc =3D [-13]
[ 2009.499193] ecryptfs_i_size_read: Error attempting to initialize
the lower file for the dentry with name
[def3e328830d82391fdd0876ad0b204b6d5cfb]; rc =3D [-13]
[ 2009.500897] Error opening lower file for lower_dentry
[0xffff88019a42c780] and lower_mnt [0xffff880234c239a0]; rc =3D [-13]
[ 2009.500899] ecryptfs_i_size_read: Error attempting to initialize
the lower file for the dentry with name
[299b509ae517f949a177d52e3563b15bcc0910]; rc =3D [-13]
[ 2009.501701] Error opening lower file for lower_dentry
[0xffff88019a42c6c0] and lower_mnt [0xffff880234c239a0]; rc =3D [-13]
[ 2009.501703] ecryptfs_i_size_read: Error attempting to initialize
the lower file for the dentry with name
[c12008558701d8df7902546885414f20d90ae1]; rc =3D [-13]
[ 2009.503394] Error opening lower file for lower_dentry
[0xffff88019a493f00] and lower_mnt [0xffff880234c239a0]; rc =3D [-13]
[ 2009.503396] ecryptfs_i_size_read: Error attempting to initialize
the lower file for the dentry with name
[e9a61d9154d5c0c378e1b86217943152b9f708]; rc =3D [-13]
[ 2009.504981] Error opening lower file for lower_dentry
[0xffff88019a444300] and lower_mnt [0xffff880234c239a0]; rc =3D [-13]
[ 2009.504983] ecryptfs_i_size_read: Error attempting to initialize
the lower file for the dentry with name
[fd8036a958bbe7051aa985997f876dde3ab4b0]; rc =3D [-13]
[ 2009.506616] Error opening lower file for lower_dentry
[0xffff88019a444540] and lower_mnt [0xffff880234c239a0]; rc =3D [-13]
[ 2009.506618] ecryptfs_i_size_read: Error attempting to initialize
the lower file for the dentry with name
[5bd8066e4ee649b0a3703bf2ad10779b6cfc1c]; rc =3D [-13]
[ 2009.508516] Error opening lower file for lower_dentry
[0xffff88019a42cb40] and lower_mnt [0xffff880234c239a0]; rc =3D [-13]
[ 2009.508518] ecryptfs_i_size_read: Error attempting to initialize
the lower file for the dentry with name
[eb4fefa11989bb6a1c24a6128528236b638706]; rc =3D [-13]
[ 2009.510120] Error opening lower file for lower_dentry
[0xffff88019a42cd80] and lower_mnt [0xffff880234c239a0]; rc =3D [-13]
[ 2009.510122] ecryptfs_i_size_read: Error attempting to initialize
the lower file for the dentry with name
[9574671fc3aa497043bc02017b2d8511a5ac26]; rc =3D [-13]
[ 2009.511688] Error opening lower file for lower_dentry
[0xffff88019a444e40] and lower_mnt [0xffff880234c239a0]; rc =3D [-13]
[ 2009.511691] ecryptfs_i_size_read: Error attempting to initialize
the lower file for the dentry with name
[93edd78dfe3e60ea41811c4e7b57569a63a87e]; rc =3D [-13]
[ 2009.513783] Error opening lower file for lower_dentry
[0xffff88019a42d780] and lower_mnt [0xffff880234c239a0]; rc =3D [-13]
[ 2009.513786] ecryptfs_i_size_read: Error attempting to initialize
the lower file for the dentry with name
[70eaa35e49c0ed23e00ba3a371b077c42f32d0]; rc =3D [-13]
[ 2009.515480] Error opening lower file for lower_dentry
[0xffff88019a4450c0] and lower_mnt [0xffff880234c239a0]; rc =3D [-13]
[ 2009.515482] ecryptfs_i_size_read: Error attempting to initialize
the lower file for the dentry with name
[7201f37c93bc666cbb3e084d1042da55207219]; rc =3D [-13]
[ 2009.517190] Error opening lower file for lower_dentry
[0xffff88019a445300] and lower_mnt [0xffff880234c239a0]; rc =3D [-13]
...
