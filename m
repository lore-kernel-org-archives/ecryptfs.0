From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v4 1/3] mm/slab: Use memzero_explicit() in kzfree()
Date: Tue, 16 Jun 2020 16:46:40 +0100
Message-ID: <879079.1592322400@warthog.procyon.org.uk>
References: <56c2304c-73cc-8f48-d8d0-5dd6c39f33f3@redhat.com>
 <20200616015718.7812-1-longman@redhat.com>
 <20200616015718.7812-2-longman@redhat.com>
 <20200616033035.GB902@sol.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <56c2304c-73cc-8f48-d8d0-5dd6c39f33f3@redhat.com>
Content-ID: <879078.1592322400.1@warthog.procyon.org.uk>
List-Id: <ecryptfs.vger.kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Waiman Long <longman@redhat.com>
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>, Michal Hocko <mhocko@suse.com>, linux-btrfs@vger.kernel.org, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, David Sterba <dsterba@suse.cz>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, linux-sctp@vger.kernel.org, keyrings@vger.kernel.org, kasan-dev@googlegroups.com, linux-stm32@st-md-mailman.stormreply.com, devel@driverdev.osuosl.org, linux-cifs@vger.kernel.org, linux-scsi@vger.kernel.org, James Morris <jmorris@namei.org>, Matthew Wilcox <willy@infradead.org>, ebiggers@kernel.org, linux-wpan@vger.kernel.org, David Rientjes <rientjes@google.com>, Dan Carpenter <dan.carpenter@oracle.com>, "Serge E. Hallyn" <serge@hallyn.com>, linux-pm@vger.kernel.org, ecryptfs@vger.kernel.org, linux-fscrypt@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org, virtualization@lists.linux-foundation.org

Waiman Long <longman@redhat.com> wrote:

> The kzfree() function is normally used to clear some sensitive
> information, like encryption keys, in the buffer before freeing it back
> to the pool. Memset()

"memset()" is all lowercase.

> is currently used for buffer clearing. However unlikely, there is still a
> non-zero probability

I'd say "a possibility".

> that

and I'd move "in [the] future" here.

> the compiler may choose to optimize away the
> memory clearing especially if LTO is being used in the future. To make sure
> that this optimization will never happen

"in these cases"

> , memzero_explicit(), which is introduced in v3.18, is now used in

"instead of"?

> kzfree() to future-proof it.

Davod
