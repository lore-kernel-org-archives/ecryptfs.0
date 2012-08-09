From: Douglas Leeder <douglas.leeder-j34lQMj1tz/QT0dZR+AlfA@public.gmane.org>
Subject: Process/Scanner hang with ecryptfs and fanotify
Date: Thu, 9 Aug 2012 14:33:00 +0100
Message-ID: <a5effe9d-2674-4495-883c-a18b93333139@ABN-EXCH1A.green.sophos>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <malware-list-bounces-h+Im9A44IAFcMpApZELgcQ@public.gmane.org>
List-Id: <ecryptfs.vger.kernel.org>
List-Unsubscribe: <http://dmesg2.printk.net/cgi-bin/mailman/options/malware-list>,
	<mailto:malware-list-request-h+Im9A44IAFcMpApZELgcQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://dmesg2.printk.net/pipermail/malware-list>
List-Post: <mailto:malware-list-h+Im9A44IAFcMpApZELgcQ@public.gmane.org>
List-Help: <mailto:malware-list-request-h+Im9A44IAFcMpApZELgcQ@public.gmane.org?subject=help>
List-Subscribe: <http://dmesg2.printk.net/cgi-bin/mailman/listinfo/malware-list>,
	<mailto:malware-list-request-h+Im9A44IAFcMpApZELgcQ@public.gmane.org?subject=subscribe>
Sender: malware-list-bounces-h+Im9A44IAFcMpApZELgcQ@public.gmane.org
Errors-To: malware-list-bounces-h+Im9A44IAFcMpApZELgcQ@public.gmane.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "malware-list-h+Im9A44IAFcMpApZELgcQ@public.gmane.org" <malware-list-h+Im9A44IAFcMpApZELgcQ@public.gmane.org>, ecryptfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: douglas.leeder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Eric Paris <eparis-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, dustin.kirkland-Bv2LyzZ6GzxBDgjK7y7TUQ@public.gmane.org

Hello,

We are in the final stages of producing a version of Sophos Anti-Virus
for Linux that uses fanotify, and have hit an issue with fanotify
against ecryptfs mounts.

ecryptfs is used for encrypted home directories on (at least) Ubuntu.

This issue I'm seeing is on Ubuntu 12.04 with encrypted home
directories. (3.2 kernel)

After using Firefox for a short while with fanotify scanning happening
(for both the host fs, and the ecryptfs mount), it will go grey (or gray
:-)), signalling it has hung.

Two threads in Firefox with be in the D state (IO sleep), and two of the
scanner threads will be stuck reading from the fanotify fd.
These remain stuck until the machine is rebooted.

I've got a test 'scanner' that I've managed to reproduce the issue with:

github:
https://github.com/paperclip/fanotify-ecryptfs-test

(If anyone wants this tarred up, I can send it directly - but I can't
send it to the mailing list due to size limits)

However it doesn't happen every time, and I've not reproduced it on a VM.

Points on note:
1) Every file on ecryptfs is backed by a file on the host fs
2) Thus every access to an ecryptfs also generates a file access to the
host fs.
3) fanotify can deliver multiple file accesses in a single event.


Given the unreliable nature of the reproduction steps; and the fact that
when things hang it is always 2 threads, rather than 1 or 3 that hang: I
believe that there is some kind of race condition when more than one
file on an ecryptfs mount is accessed at the same time.

I wonder if each fanotify event contains the ecryptfs access from one
client thread, and the host  fs access from the other?

In the git repository there are two dmesg outputs, from the stuck
threads' backtraces. Definitely stuck between fanotify and ecryptfs.

Is there any advice you can offer? I wonder if fanotify needs to deliver
permission events one at a time? Or can you point me at appropriate
sources to look at for further information.

In an ideal world there would be some fix to the scanner to avoid the
problem, but I'm not sure what it could be, so the solution might only
be applicable to future kernels.

(Sophos defect DEF83746)

Thanks.


--
Douglas Leeder, Senior Software Engineer

________________________________

Sophos Limited, The Pentagon, Abingdon Science Park, Abingdon, OX14 3YP, United Kingdom.
Company Reg No 2096520. VAT Reg No GB 991 2418 08.
