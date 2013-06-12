From: Will Morrison <camocrazed@gmail.com>
Subject: Re: Plans for adding cipher mode to file headers
Date: Wed, 12 Jun 2013 00:05:49 -0400
Message-ID: <51B7F39D.40309@gmail.com>
References: <51AEA774.7010702@gmail.com> <20130611140752.GC30092@boyd>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:43528 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796Ab3FLEFg (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Wed, 12 Jun 2013 00:05:36 -0400
Received: by mail-ie0-f178.google.com with SMTP id at1so17582032iec.23
        for <ecryptfs@vger.kernel.org>; Tue, 11 Jun 2013 21:05:36 -0700 (PDT)
In-Reply-To: <20130611140752.GC30092@boyd>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Tyler Hicks <tyhicks@canonical.com>
Cc: ecryptfs@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

We've been discussing what to do about back/forwards compatibility.
We've run into a few dead ends trying to figure it out, and the best
we've come up with is to special-case CBC encrypted files, and always
write out old style headers for those.

There are version fields in tag 1 and 3 packets, and we thought about
possibly writing out two packets, one for each version, but if a file
contains what it considers to be a malformed packet, it will not
continue looking for packets, and just avoid the file. Changing the
version in the packets would count as malformed for the current code.

The only way we can currently see of letting older versions read files
created by newer versions is to special-case CBC mode encryption, and
always write the current version headers (no cipher mode field, file
version 3) when encrypting with CBC. If encrypting with any other
mode, the new style headers would be written, since older eCryptfs
builds would not be able to read them anyway. This would add some
extra logic in the functions dealing with writing headers to handle
the special-casing. It would also require that the
ECRYPTFS_FILE_VERSION constant be used dynamically depending on what
the cipher mode was.

I don't know what is better, extra code paths that should be tested
and maintained, or a lack of forward compatibility between versions of
eCryptfs for files encrypted with CBC. Do you have any thoughts one
way or the other?

- -Will
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJRt/OdAAoJEH8zVN2+6bAcvXkP/1UqY82h7wl54Eiv//3XewrN
c4VByoYKwO28pbNz3JRSl9WEUHD9viji0aJdnnjx3aWYJ3OWc0IKSdsJpPYSnaHa
wXaohMD6MV0i20iFyPy15SMjdt1KcpEGyX4j3bhYvP+lObhhP5/jbF6sFa0RJdfI
qjF4ujPxAKdB111UOSZYzxmoC4ljowbMV/TBy1p61h98AR9tWvkck+2W/RLCIJ7G
H2la2h017dKMqnqSfgJSb5ATbDqH6fUfvn6+iof+ZbfGHQ7yU4aPbqcNCogZSBYt
CZ5d/Y46eo5KcX+0rHsVbXJg3ctV8zWdlMHAwdlvZrXepCnQXHccpm/GIQI2gChD
fyffsevnQRYreYqsjikF4z7h4WgsU0TUPsRGOpalmT3u72Hh9DPTKOw2SDRBTrSR
LFqlYnxL5vr6w0Qbm9VYjtqZz1XQWDalJM7OIHk7zllsMPufYcb1fawhhdeyYl4t
4hSsK4gitRsvbBhatvMXygvCIwrOgz4I4L0zsT6eymirzgf5FmVFxNCNiknDcV3/
qC20B0TsHnINiWq1XlpQGP80IhGnor1tKDA46SIbQukmoIicJAD7CDpLztsvj1qo
qbRO9kPYNXPVqsggll+axDmAsGmZV+8L2uPvj9Gy7reFIrzfaSidAzjuipTLx2RT
IjJnvbuOmy7Psng5Vtmd
=HBO0
-----END PGP SIGNATURE-----
