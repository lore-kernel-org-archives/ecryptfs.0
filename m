From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 2/2] crypto: Remove unnecessary memzero_explicit()
Date: Tue, 14 Apr 2020 12:44:49 -0700
Message-ID: <2a58f592879cf67b4c6b8e859ce87e1f9652902a.camel@perches.com>
References: <20200413211550.8307-1-longman@redhat.com>
 <20200413222846.24240-1-longman@redhat.com>
 <eca85e0b-0af3-c43a-31e4-bd5c3f519798@c-s.fr>
 <e194a51f-a5e5-a557-c008-b08cac558572@redhat.com>
 <20200414191601.GZ25468@kitsune.suse.cz>
 <578fe9b6-1ccd-2698-60aa-96c3f2dd2c31@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <578fe9b6-1ccd-2698-60aa-96c3f2dd2c31@redhat.com>
List-Id: <ecryptfs.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Waiman Long <longman@redhat.com>, Michal =?ISO-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: linux-btrfs@vger.kernel.org, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, virtualization@lists.linux-foundation.org, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, linux-sctp@vger.kernel.org, keyrings@vger.kernel.org, kasan-dev@googlegroups.com, samba-technical@lists.samba.org, linux-stm32@st-md-mailman.stormreply.com, devel@driverdev.osuosl.org, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, x86@kernel.org, James Morris <jmorris@namei.org>, Matthew Wilcox <willy@infradead.org>, cocci@systeme.lip6.fr, linux-wpan@vger.kernel.org, intel-wired-lan@lists.osuosl.org, David Rientjes <rientjes@google.com>, "Serge E. Hallyn" <serge@hallyn.com>, linux-pm@vger.kernel.org, ecryptfs@vger.kernel.org, linux-nfs@vger.kernel.org, linux-fscrypt@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-integrity@vger.kernel.org

On Tue, 2020-04-14 at 15:37 -0400, Waiman Long wrote:
> OK, I can change it to clear the key length when the allocation failed
> which isn't likely.


Perhaps:

	kfree_sensitive(op->key);
	op->key = NULL;
	op->keylen = 0;

but I don't know that it impacts any possible state.
