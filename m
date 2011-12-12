From: Robert Freeman-Day <presgas@gmail.com>
Subject: Re: ecryptfs & ssh authentication
Date: Mon, 12 Dec 2011 10:27:20 -0500
Message-ID: <4EE61D58.8010607@gmail.com>
References: <alpine.DEB.2.01.1112120042000.787@trent.utfs.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-qw0-f53.google.com ([209.85.216.53]:60342 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790Ab1LLP1Y (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 12 Dec 2011 10:27:24 -0500
Received: by qadb15 with SMTP id b15so4695387qad.19
        for <ecryptfs@vger.kernel.org>; Mon, 12 Dec 2011 07:27:23 -0800 (PST)
In-Reply-To: <alpine.DEB.2.01.1112120042000.787@trent.utfs.org>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: ecryptfs@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/12/2011 06:06 AM, Christian Kujau wrote:
> Hi,
> 
> I'm using ecryptfs-utils (v83-4) on this Debian/stable system (powerpc, 
> Linux 3.2-rc4) and migrated a home directory via ecryptfs-migrate-home.
> I've also configured PAM so that I can login remotely via SSH with this 
> user and the homedirectory is mounted - perfect.
> 
> But I also wanted to login via SSH keys - so I configured openssh to use  
> /etc/ssh/authorized_keys.%u as its AuthorizedKeysFile and I can login with 
> public key authentication - so far, so good.
> 
> For the first few logins the home directory is mounted - but then it 
> stops and a few logins (and logouts) later I still can login via SSH
> keys - but the home directory just isn't mounted any more.
> 
> However, when I'm NOT using the SSH key but a password to login (via SSH), 
> the home directory is mounted again.
> 
> I've reproduced this just now on this very system:
> 
> 1) useradd -d /home/joe -m -s /bin/bash joe && passwd joe
> 2) ecryptfs-migrate-home -u joe
> 3) login joe    -> logged in, $HOME is mounted -> OK
> 4) login via ssh, with keys/passwords a few times. After
>    some 5 or 10 logins the home directory is only mounted for
>    password logins. Logging in via key still succeeds, but
>    the home directory is not mounted any more
> 
> A few things to note here:
> 
> * The powerpc system is a PowerBook G4, throttled to 750Mhz
>   and the initial "ecryptfs-migrate-home" of an almost emtpy
>   home directory takes a while. The unlocking of the home directory
>   takes ~30s. "sshd" or "login" is pretty busy during this time. This
>   is OK for me, I just thought I should mention it. Syslog has the
>   following (abbreviated):
> 
>   02:13:00 pam_sm_authenticate: Called
>   02:13:00 pam_sm_authenticate: username = [joe]
>   02:13:00 Passphrase file wrapped
>   02:13:31 Accepted password for joe from 192.168.0.103 port 59819 ssh2
>   02:13:31 pam_unix(sshd:session): session opened for user joe by (uid=0)
>   02:13:31 Received disconnect from 192.168.0.103: 11: disconnected by user
>   02:13:31 pam_unix(sshd:session): session closed for user joe
> 
> * When logging in with SSH keys, the login is instantly - but of course 
>   the home directory is not mounted :-\
> 
> * I've tested this on a Debian/stable system (i386 in a 2x2.2Ghz virtual 
>   machine) and I could NOT reproduce this: added a user, used 
>   ecryptfs-migrate-home to migrate the $HOME, both ssh with keys and with
>   passwords are working and continue to work. Even running logins
>   in a loop, constantly logging in and out the same user did not manage to
>   reproduce the behaviour.
>   Apart from being on a different architecture (fast i386 vs slow 
>   powerpc), the version numbers of the installed software are pretty much 
>   the same, since both are using Debian/stable.
> 
> * I've installed ecryptfs-utils from Debian/testing where it shows a 
>   version number of 93-1, but this did not make a difference. In fact,
>   I upgraded (again) just now and tried to reproduce the behaviour:
>   the home directory was not even unlocked once when logging in via
>   SSH keys. When loggin in with a passwords, it's fine.
> 
> I've put some strace outputs of the SSH process handling the login here:
> 
>     http://nerdbynature.de/bits/ecryptfs/
> 
> The files named "failed" refer to the system where the SSH key logins are 
> not mounting the ecryptfs container. The files named "working" refer to 
> the other box, where I could NOT reproduce this issue.
> 
> The files with "_open" in it only lists the open() calls strace recorded. 
> Please note the diff-y.txt file, where Private.mnt is read on one system, 
> but not on the other.
> 
> Phew, that's a long write-up. I hope this makes any sense to someone. I'm 
> out of ideas right now - can anybody enlighten me what's going on here?
> 
> Thanks,
> Christian.

Christian,

The reason your local logins mound the ecryptfs system is because you
are using the pam stack.  ecryptfs-utils offers a pam module that auto
mounts it, see first entry here:

http://packages.debian.org/squeeze/powerpc/ecryptfs-utils/filelist

The ssh packages offer no method to tie in with ecryptfs unless you tell
sshd to use the pam stack.  Then you will likely need to use libpam-ssh
(http://packages.debian.org/squeeze/libpam-ssh).

You will really want to take a look at this security-wise.  It is likely
that your key passphrase as well as your login/ecryptfs unwrap
passphrase will need to be the same (anyone else want to chime in on
this to make sure?).

I would look at the following to read up as well:

http://pam-ssh.sourceforge.net/
http://www.clasohm.com/blog/one-entry?entry_id=12085

Robert
- -- 
________

Robert Freeman-Day

https://launchpad.net/~presgas
GPG Public Key:
http://keyserver.ubuntu.com:11371/pks/lookup?op=get&search=0xBA9DF9ED3E4C7D36
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7mHVQACgkQup357T5MfTZ5JACfeEU1WVE/aj9gNPOf39dht1Lh
zpIAoJ0nGpzxvgJXm8oZO7F0HcnbG/9n
=tQSy
-----END PGP SIGNATURE-----
