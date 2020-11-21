From: Joe Perches <joe@perches.com>
Subject: Re: [RFC] MAINTAINERS tag for cleanup robot
Date: Sat, 21 Nov 2020 09:10:08 -0800
Message-ID: <2105f0c05e9eae8bee8e17dcc5314474b3c0bc73.camel@perches.com>
References: <20201121165058.1644182-1-trix@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <bpf-owner@vger.kernel.org>
In-Reply-To: <20201121165058.1644182-1-trix@redhat.com>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: trix@redhat.com, clang-built-linux@googlegroups.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, tboot-devel@lists.sourceforge.net, kvm@vger.kernel.org, linux-crypto@vger.kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, netdev@vger.kernel.org, linux-media@vger.kernel.org, MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org, linux-wireless@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, ecryptfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, cluster-devel@redhat.com, linux-mtd@lists.infradead.org, keyrings@vger.kernel.org, netfilter-devel@vger.kern

On Sat, 2020-11-21 at 08:50 -0800, trix@redhat.com wrote:
> A difficult part of automating commits is composing the subsystem
> preamble in the commit log.  For the ongoing effort of a fixer producing
> one or two fixes a release the use of 'treewide:' does not seem appropria=
te.
>=20
> It would be better if the normal prefix was used.  Unfortunately normal is
> not consistent across the tree.
>=20
> So I am looking for comments for adding a new tag to the MAINTAINERS file
>=20
> 	D: Commit subsystem prefix
>=20
> ex/ for FPGA DFL DRIVERS
>=20
> 	D: fpga: dfl:

I'm all for it.  Good luck with the effort.  It's not completely trivial.

From a decade ago:

https://lore.kernel.org/lkml/1289919077.28741.50.camel@Joe-Laptop/

(and that thread started with extra semicolon patches too)

> Continuing with cleaning up clang's -Wextra-semi-stmt

> diff --git a/Makefile b/Makefile
[]
> @@ -1567,20 +1567,21 @@ help:
> =A0	 echo  ''
> =A0	@echo  'Static analysers:'
> =A0	@echo  '  checkstack      - Generate a list of stack hogs'
> =A0	@echo  '  versioncheck    - Sanity check on version.h usage'
> =A0	@echo  '  includecheck    - Check for duplicate included header files'
> =A0	@echo  '  export_report   - List the usages of all exported symbols'
> =A0	@echo  '  headerdep       - Detect inclusion cycles in headers'
> =A0	@echo  '  coccicheck      - Check with Coccinelle'
> =A0	@echo  '  clang-analyzer  - Check with clang static analyzer'
> =A0	@echo  '  clang-tidy      - Check with clang-tidy'
> +	@echo  '  clang-tidy-fix  - Check and fix with clang-tidy'

A pity the ordering of the code below isn't the same as the above.

> -PHONY +=3D clang-tidy clang-analyzer
> +PHONY +=3D clang-tidy-fix clang-tidy clang-analyzer
[]
> -clang-tidy clang-analyzer: $(extmod-prefix)compile_commands.json
> +clang-tidy-fix clang-tidy clang-analyzer: $(extmod-prefix)compile_comman=
ds.json
> =A0	$(call cmd,clang_tools)
> =A0else
> -clang-tidy clang-analyzer:
> +clang-tidy-fix clang-tidy clang-analyzer:

[]

> diff --git a/scripts/clang-tools/run-clang-tools.py b/scripts/clang-tools=
/run-clang-tools.py
[]
> @@ -22,43 +22,57 @@ def parse_arguments():
[]
> =A0=A0=A0=A0=A0parser.add_argument("type",
> -                        choices=3D["clang-tidy", "clang-analyzer"],
> +                        choices=3D["clang-tidy-fix", "clang-tidy", "clan=
g-analyzer"],

etc...

