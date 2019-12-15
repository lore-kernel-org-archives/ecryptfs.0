From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH] ecryptfs: replace BUG_ON with error handling code
Date: Sun, 15 Dec 2019 22:20:29 +0100
Message-ID: <098249a9-cf0b-720d-766b-1acdeb78fe22@web.de>
References: <20191215172404.28204-1-pakki001@umn.edu>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191215172404.28204-1-pakki001@umn.edu>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Aditya Pakki <pakki001@umn.edu>, ecryptfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>, Tyler Hicks <tyhicks@canonical.com>

> In crypt_scatterlist, if the crypt_stat argument is not set up
> correctly, we avoid crashing, by returning the error upstream.

Can an other change description be more helpful here?


> This patch performs the fix.

Please replace this sentence by the tag =E2=80=9CFixes=E2=80=9D.

Regards,
Markus
