From: Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [RFC] MAINTAINERS tag for cleanup robot
Date: Mon, 23 Nov 2020 17:52:20 +0200
Message-ID: <87y2ism5or.fsf@intel.com>
References: <20201121165058.1644182-1-trix@redhat.com>
 <5843ef910b0e86c00d9c0143dec20f93823b016b.camel@HansenPartnership.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <5843ef910b0e86c00d9c0143dec20f93823b016b.camel@HansenPartnership.com>
List-Id: <ecryptfs.vger.kernel.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>, trix@redhat.com, joe@perches.com, clang-built-linux@googlegroups.com
Cc: linux-hyperv@vger.kernel.org, kvm@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, keyrings@vger.kernel.org, linux-mtd@lists.infradead.org, linux-scsi@vger.kernel.org, amd-gfx@lists.freedesktop.org, cluster-devel@redhat.com, linux-acpi@vger.kernel.org, tboot-devel@lists.sourceforge.net, coreteam@netfilter.org, xen-devel@lists.xenproject.org, MPT-FusionLinux.pdl@broadcom.com, linux-media@vger.kernel.org, alsa-devel@alsa-project.org, intel-gfx@lists.freedesktop.org, ecryptfs@vger.kernel.org, linux-omap@vger.kernel.org, devel@acpica.org, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, netfilter-devel@vger.kernel.org, linux-crypto@vger.kernel.org

On Sat, 21 Nov 2020, James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> On Sat, 2020-11-21 at 08:50 -0800, trix@redhat.com wrote:
>> A difficult part of automating commits is composing the subsystem
>> preamble in the commit log.  For the ongoing effort of a fixer
>> producing
>> one or two fixes a release the use of 'treewide:' does not seem
>> appropriate.
>> 
>> It would be better if the normal prefix was used.  Unfortunately
>> normal is
>> not consistent across the tree.
>> 
>> 
>> 	D: Commit subsystem prefix
>> 
>> ex/ for FPGA DFL DRIVERS
>> 
>> 	D: fpga: dfl:
>> 
>
> I've got to bet this is going to cause more issues than it solves.

Agreed.

> SCSI uses scsi: <driver>: for drivers but not every driver has a
> MAINTAINERS entry.  We use either scsi: or scsi: core: for mid layer
> things, but we're not consistent.  Block uses blk-<something>: for all
> of it's stuff but almost no <somtehing>s have a MAINTAINERS entry.  So
> the next thing you're going to cause is an explosion of suggested
> MAINTAINERs entries.

On the one hand, adoption of new MAINTAINERS entries has been really
slow. Look at B, C, or P, for instance. On the other hand, if this were
to get adopted, you'll potentially get conflicting prefixes for patches
touching multiple files. Then what?

I'm guessing a script looking at git log could come up with better
suggestions for prefixes via popularity contest than manually maintained
MAINTAINERS entries. It might not always get it right, but then human
outsiders aren't going to always get it right either.

Now you'll only need Someone(tm) to write the script. ;)

Something quick like this:

git log --since={1year} --pretty=format:%s -- <FILES> |\
	grep -v "^\(Merge\|Revert\)" |\
        sed 's/:[^:]*$//' |\
        sort | uniq -c | sort -rn | head -5

already gives me results that really aren't worse than some of the
prefixes invented by drive-by contributors.

> Has anyone actually complained about treewide:?

As Joe said, I'd feel silly applying patches to drivers with that
prefix. If it gets applied by someone else higher up, literally
treewide, then no complaints.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
