From: Will Morrison <camocrazed@gmail.com>
Subject: Plans for adding cipher mode to file headers
Date: Tue, 04 Jun 2013 22:50:28 -0400
Message-ID: <51AEA774.7010702@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:63186 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905Ab3FECuZ (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 4 Jun 2013 22:50:25 -0400
Received: by mail-ie0-f176.google.com with SMTP id at20so2204988iec.7
        for <ecryptfs@vger.kernel.org>; Tue, 04 Jun 2013 19:50:24 -0700 (PDT)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Tyler Hicks <tyhicks@canonical.com>
Cc: ecryptfs@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

To make the changes to store the cipher mode in the file header, we
are proposing the following.

1. Change ECRYPTFS_SUPPORTED_FILE_VERSION to 4. This should prevent
old versions of eCryptfs from trying to read new style headers.

2. Add a new cipher mode field in the appropriate packets of version 4
file headers. (I believe these are tag 1 and tag 3, for asymmetric and
symmetric keys). Since there is no equivalent to this field in the
OpenPGP RFCs, we will be creating a new list of constants similar to
the ones in ecryptfs.h for the mode type.

3. When reading a file header and initializing a crypt_stat, if the
version number is 4 or greater, read the mode out of the header,
otherwise, default to CBC.

4. When writing out headers, refer to the file_version field in the
crypt_stat to determine what to write out. If it's 4 or greater,
include the mode field.

This should result in the new version 4 header being written for all
new files. Old files would still be read and written with the version
3 headers and default to using CBC mode. Older versions of eCryptfs
should refuse to open files with version 4 headers.

Does this make sense? If not, what are we missing?

Thanks,
- -Will
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJRrqd0AAoJEH8zVN2+6bAcD3UP/3r/FuHfQv175nccZ+JOemZZ
65hn9zMi5dFVCTcvqBwMFWFymOKyOJLYM5yP2rX093JpIA3MgquN3yNgOiEd+adt
8hLKZ84KPMnA41m220ujOLvKD6UA4GQpSTwkDsbvYxQV9W3EuPsR65WtSt23uECj
VjU9EtKZ4xAQbQeXbRTTL678jIRUf4rffUEsFV/KWosdjeINNxZQPoZJHAwiTMDY
lemxgXnMmgr/fs/NnW6W+D9hBehIXUXrqlZ/f+EkFygXCafHOLS6f7JHuq5MNDeD
O5A53ClD2p6984sh745oUMltt0j0cQdF+gE//1hS1RhqHe2//K5YQe7Xgqab/Ahb
lsOdc2cDa8B+w6jITyPfn31CJdmS3o/o+ltavTmK2hnMJB773ibmoPG8q2EGUOnO
ePs6C9uCaBEV48svjlIrcWHE+NgbqK+cetyF5DP3mo1dPR+GiSPthEKrr0Tp96Ys
ECYHWq+6N+cJnzb1GKM0frRAZPgvSmxtRdNQSiH82Moz5ThUIYaS6buhLApBvBIR
TtDbL+hgZ8E90gcyeaPNTzmAmaVkj79F03HBq1GtkjesF78+AGmxL4xnUyJaV2s2
wc8xKvcwBctcHj+i2NoJq5dRX/8mGclA4sP18LPXqLxhyg3G13P/xZPtmdReRvpH
/pBAmFxFCl3rfQkqsZdp
=fnmV
-----END PGP SIGNATURE-----
