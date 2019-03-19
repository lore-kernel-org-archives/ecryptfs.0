From: James Bottomley <jejb@linux.ibm.com>
Subject: Re: [PATCH 0/6] security/keys/encrypted: Break module dependency
 chain
Date: Tue, 19 Mar 2019 14:08:34 -0700
Message-ID: <1553029714.2932.43.camel@linux.ibm.com>
References: <155297557534.2276575.16264199708584900090.stgit@dwillia2-desk3.amr.corp.intel.com>
         <CAPcyv4ij2nHD7JumKNcNYB4gAGujWzCPkcpoi=XafmG3EP2b0g@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPcyv4ij2nHD7JumKNcNYB4gAGujWzCPkcpoi=XafmG3EP2b0g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dan Williams <dan.j.williams@intel.com>, keyrings@vger.kernel.org
Cc: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>, Tyler Hicks <tyhicks@canonical.com>, Keith Busch <keith.busch@intel.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, David Howells <dhowells@redhat.com>, Vishal Verma <vishal.l.verma@intel.com>, Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org, ecryptfs@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, 2019-03-19 at 14:01 -0700, Dan Williams wrote:
> On Mon, Mar 18, 2019 at 11:18 PM Dan Williams <dan.j.williams@intel.c
> om> wrote:
> > 
> > With v5.1-rc1 all the nvdimm sub-system regression tests started
> > failing because the libnvdimm module failed to load in the qemu-kvm 
> > test environment.  Critically that environment does not have a TPM.
> > Commit 240730437deb "KEYS: trusted: explicitly use tpm_chip
> > structure..." started to require a TPM to be present for the
> > trusted.ko module to load where there was no requirement for that
> > before.
> > 
> > Rather than undo the "fail if no hardware" behavior James points
> > out that the module dependencies can be broken by looking up the
> > key-type by name. Remove the dependencies on the "key_type_trusted"
> > and "key_type_encrypted" symbol exports, and clean up other
> > boilerplate that supported those exports in different
> > configurations.
> 
> Any feedback? Was hoping to get at least patch1 in the queue for
> v5.1-rc2 since this effectively disables the nvdimm driver on typical
> configurations. Jarkko, would you be willing to merge it since the
> regression came through your tree?

The reason I sent out the RFC was to see if the people who actually
wrote the code had any reasons they needed the current way of doing
things preserving.

I think your series looks fine except you need to export
key_type_lookup (patch 2) before you use it (patch 1) to preserve
bisectability of builds.

James

