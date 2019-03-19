From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 0/6] security/keys/encrypted: Break module dependency chain
Date: Mon, 18 Mar 2019 23:06:15 -0700
Message-ID: <155297557534.2276575.16264199708584900090.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: keyrings@vger.kernel.org
Cc: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>, Tyler Hicks <tyhicks@canonical.com>, Keith Busch <keith.busch@intel.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, David Howells <dhowells@redhat.com>, Vishal Verma <vishal.l.verma@intel.com>, James Bottomley <jejb@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org, ecryptfs@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org

With v5.1-rc1 all the nvdimm sub-system regression tests started failing
because the libnvdimm module failed to load in the qemu-kvm test
environment.  Critically that environment does not have a TPM. Commit
240730437deb "KEYS: trusted: explicitly use tpm_chip structure..."
started to require a TPM to be present for the trusted.ko module to load
where there was no requirement for that before.

Rather than undo the "fail if no hardware" behavior James points out
that the module dependencies can be broken by looking up the key-type by
name. Remove the dependencies on the "key_type_trusted" and
"key_type_encrypted" symbol exports, and clean up other boilerplate that
supported those exports in different configurations.

---

Dan Williams (6):
      security/keys/encrypted: Allow operation without trusted.ko
      security/keys/encrypted: Clean up request_trusted_key()
      libnvdimm/security: Drop direct dependency on key_type_encrypted
      security/keys/ecryptfs: Drop direct dependency on key_type_encrypted
      security/integrity/evm: Drop direct dependency on key_type_encrypted
      security/keys/encrypted: Drop export of key_type_encrypted


 drivers/nvdimm/security.c                        |   11 ++++-
 fs/ecryptfs/ecryptfs_kernel.h                    |   22 -----------
 fs/ecryptfs/keystore.c                           |   12 ++++++
 include/keys/encrypted-type.h                    |    2 -
 include/linux/key.h                              |    1 
 security/integrity/evm/evm_crypto.c              |    9 ++++
 security/keys/encrypted-keys/Makefile            |    3 -
 security/keys/encrypted-keys/encrypted.c         |   35 ++++++++++++++++-
 security/keys/encrypted-keys/encrypted.h         |   12 ------
 security/keys/encrypted-keys/masterkey_trusted.c |   46 ----------------------
 security/keys/internal.h                         |    2 -
 security/keys/key.c                              |    1 
 12 files changed, 65 insertions(+), 91 deletions(-)
 delete mode 100644 security/keys/encrypted-keys/masterkey_trusted.c
