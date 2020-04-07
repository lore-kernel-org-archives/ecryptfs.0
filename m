From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 0/2] Don't generate thousands of new warnings when building docs
Date: Tue, 07 Apr 2020 13:46:23 +1000
Message-ID: <87lfn8klf4.fsf@mpe.ellerman.id.au>
References: <cover.1584716446.git.mchehab+huawei@kernel.org>
Mime-Version: 1.0
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <cover.1584716446.git.mchehab+huawei@kernel.org>
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, "Martin K. Petersen" <martin.petersen@oracle.com>, Paul Mackerras <paulus@samba.org>, Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>, "David S. Miller" <davem@davemloft.net>, Ricardo Ribalda Delgado <ribalda@kernel.org>, Luca Ceresoli <luca@lucaceresoli.net>, dmaengine@vger.kernel.org, Matthias Maennich <maennich@google.com>, Harry Wei <harryxiyou@gmail.com>, x86@kernel.org, ecryptfs@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, target-devel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Johannes Berg <johannes.berg@intel.com>, Jacopo Mondi <jacopo@j>

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> This small series address a regression caused by a new patch at
> docs-next (and at linux-next).
>
> Before this patch, when a cross-reference to a chapter within the
> documentation is needed, we had to add a markup like:
>
> 	.. _foo:
>
> 	foo
> 	===
>
> This behavor is now different after this patch:
>
> 	58ad30cf91f0 ("docs: fix reference to core-api/namespaces.rst")
>
> As a Sphinx extension now creates automatically a reference
> like the above, without requiring any extra markup.
>
> That, however, comes with a price: it is not possible anymore to have
> two sections with the same name within the entire Kernel docs!
>
> This causes thousands of warnings, as we have sections named
> "introduction" on lots of places.
>
> This series solve this regression by doing two changes:
>
> 1) The references are now prefixed by the document name. So,
>    a file named "bar" would have the "foo" reference as "bar:foo".
>
> 2) It will only use the first two levels. The first one is (usually) the
>    name of the document, and the second one the chapter name.
>
> This solves almost all problems we have. Still, there are a few places
> where we have two chapters at the same document with the
> same name. The first patch addresses this problem.

I'm still seeing a lot of warnings. Am I doing something wrong?

cheers

/linux/Documentation/powerpc/cxl.rst:406: WARNING: duplicate label powerpc/cxl:open, other instance in /linux/Documentation/powerpc/cxl.rst
/linux/Documentation/powerpc/cxl.rst:412: WARNING: duplicate label powerpc/cxl:ioctl, other instance in /linux/Documentation/powerpc/cxl.rst
/linux/Documentation/powerpc/syscall64-abi.rst:86: WARNING: duplicate label powerpc/syscall64-abi:parameters and return value, other instance in /linux/Documentation/powerpc/syscall64-abi.rst
/linux/Documentation/powerpc/syscall64-abi.rst:90: WARNING: duplicate label powerpc/syscall64-abi:stack, other instance in /linux/Documentation/powerpc/syscall64-abi.rst
/linux/Documentation/powerpc/syscall64-abi.rst:94: WARNING: duplicate label powerpc/syscall64-abi:register preservation rules, other instance in /linux/Documentation/powerpc/syscall64-abi.rst
/linux/Documentation/powerpc/syscall64-abi.rst:103: WARNING: duplicate label powerpc/syscall64-abi:invocation, other instance in /linux/Documentation/powerpc/syscall64-abi.rst
/linux/Documentation/powerpc/syscall64-abi.rst:108: WARNING: duplicate label powerpc/syscall64-abi:transactional memory, other instance in /linux/Documentation/powerpc/syscall64-abi.rst
/linux/Documentation/powerpc/ultravisor.rst:339: WARNING: duplicate label powerpc/ultravisor:syntax, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:351: WARNING: duplicate label powerpc/ultravisor:return values, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:365: WARNING: duplicate label powerpc/ultravisor:description, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:387: WARNING: duplicate label powerpc/ultravisor:use cases, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:406: WARNING: duplicate label powerpc/ultravisor:syntax, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:416: WARNING: duplicate label powerpc/ultravisor:return values, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:429: WARNING: duplicate label powerpc/ultravisor:description, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:438: WARNING: duplicate label powerpc/ultravisor:use cases, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:452: WARNING: duplicate label powerpc/ultravisor:syntax, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:462: WARNING: duplicate label powerpc/ultravisor:return values, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:477: WARNING: duplicate label powerpc/ultravisor:description, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:484: WARNING: duplicate label powerpc/ultravisor:use cases, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:514: WARNING: duplicate label powerpc/ultravisor:syntax, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:521: WARNING: duplicate label powerpc/ultravisor:return values, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:527: WARNING: duplicate label powerpc/ultravisor:description, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:545: WARNING: duplicate label powerpc/ultravisor:use cases, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:561: WARNING: duplicate label powerpc/ultravisor:syntax, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:573: WARNING: duplicate label powerpc/ultravisor:return values, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:588: WARNING: duplicate label powerpc/ultravisor:description, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:594: WARNING: duplicate label powerpc/ultravisor:use cases, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:613: WARNING: duplicate label powerpc/ultravisor:syntax, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:622: WARNING: duplicate label powerpc/ultravisor:return values, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:633: WARNING: duplicate label powerpc/ultravisor:description, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:639: WARNING: duplicate label powerpc/ultravisor:use cases, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:650: WARNING: duplicate label powerpc/ultravisor:syntax, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:658: WARNING: duplicate label powerpc/ultravisor:return values, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:669: WARNING: duplicate label powerpc/ultravisor:description, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:674: WARNING: duplicate label powerpc/ultravisor:use cases, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:688: WARNING: duplicate label powerpc/ultravisor:syntax, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:697: WARNING: duplicate label powerpc/ultravisor:return values, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:708: WARNING: duplicate label powerpc/ultravisor:description, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:721: WARNING: duplicate label powerpc/ultravisor:use cases, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:737: WARNING: duplicate label powerpc/ultravisor:syntax, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:746: WARNING: duplicate label powerpc/ultravisor:return values, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:757: WARNING: duplicate label powerpc/ultravisor:description, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:771: WARNING: duplicate label powerpc/ultravisor:use cases, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:782: WARNING: duplicate label powerpc/ultravisor:syntax, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:789: WARNING: duplicate label powerpc/ultravisor:return values, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:798: WARNING: duplicate label powerpc/ultravisor:description, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:808: WARNING: duplicate label powerpc/ultravisor:use cases, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:819: WARNING: duplicate label powerpc/ultravisor:syntax, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:828: WARNING: duplicate label powerpc/ultravisor:return values, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:842: WARNING: duplicate label powerpc/ultravisor:description, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:849: WARNING: duplicate label powerpc/ultravisor:use cases, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:886: WARNING: duplicate label powerpc/ultravisor:syntax, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:893: WARNING: duplicate label powerpc/ultravisor:return values, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:900: WARNING: duplicate label powerpc/ultravisor:description, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:909: WARNING: duplicate label powerpc/ultravisor:use cases, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:921: WARNING: duplicate label powerpc/ultravisor:syntax, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:928: WARNING: duplicate label powerpc/ultravisor:return values, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:938: WARNING: duplicate label powerpc/ultravisor:description, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:944: WARNING: duplicate label powerpc/ultravisor:use cases, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:957: WARNING: duplicate label powerpc/ultravisor:syntax, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:964: WARNING: duplicate label powerpc/ultravisor:return values, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:980: WARNING: duplicate label powerpc/ultravisor:description, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:1002: WARNING: duplicate label powerpc/ultravisor:use cases, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:1017: WARNING: duplicate label powerpc/ultravisor:syntax, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:1027: WARNING: duplicate label powerpc/ultravisor:return values, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:1037: WARNING: duplicate label powerpc/ultravisor:description, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:1053: WARNING: duplicate label powerpc/ultravisor:use cases, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:1076: WARNING: duplicate label powerpc/ultravisor:syntax, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:1086: WARNING: duplicate label powerpc/ultravisor:return values, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:1096: WARNING: duplicate label powerpc/ultravisor:description, other instance in /linux/Documentation/powerpc/ultravisor.rst
/linux/Documentation/powerpc/ultravisor.rst:1105: WARNING: duplicate label powerpc/ultravisor:use cases, other instance in /linux/Documentation/powerpc/ultravisor.rst
