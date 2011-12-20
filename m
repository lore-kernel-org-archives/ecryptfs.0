From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] eCryptfs: Improve statfs reporting
Date: Mon, 19 Dec 2011 17:02:42 -0800
Message-ID: <CAGXu5j+cx_jGBDQ4cvd_9JumZceDraRMAq7B1vvwEaNDrMeiUg@mail.gmail.com>
References: <CAGXu5jKj=UcH_8GXM5EHFbdxx09T_wk003mgGZmfrxKfvVwvVQ@mail.gmail.com>
	<1324341095-14086-1-git-send-email-tyhicks@canonical.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51991 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753269Ab1LTBCo (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 19 Dec 2011 20:02:44 -0500
Received: by iaeh11 with SMTP id h11so9375660iae.19
        for <ecryptfs@vger.kernel.org>; Mon, 19 Dec 2011 17:02:44 -0800 (PST)
In-Reply-To: <1324341095-14086-1-git-send-email-tyhicks@canonical.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tyler Hicks <tyhicks@canonical.com>
Cc: ecryptfs@vger.kernel.org, John Johansen <john.johansen@canonical.com>

On Mon, Dec 19, 2011 at 4:31 PM, Tyler Hicks <tyhicks@canonical.com> wrote:
> statfs() calls on eCryptfs files returned the wrong filesystem type and,
> when using filename encryption, the wrong maximum filename length.
>
> If mount-wide filename encryption is enabled, the cipher block size and
> the lower filesystem's max filename length will determine the max
> eCryptfs filename length. Pre-tested, known good lengths are used when
> the lower filesystem's namelen is 255 and a cipher with 8 or 16 byte
> block sizes is used. In other, less common cases, we fall back to a safe
> rounded-down estimate when determining the eCryptfs namelen.
>
> https://launchpad.net/bugs/885744
>
> Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
> Reported-by: Kees Cook <keescook@chromium.org>

Looks good!

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
ChromeOS Security
