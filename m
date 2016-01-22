From: zhangzhilei <sdhzdmzzl@sina.com>
Subject: how to retrun different size to different process when I use ecryptfs
Date: Fri, 22 Jan 2016 07:28:11 +0000 (UTC)
Message-ID: <loom.20160122T080227-125@post.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:60984 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751273AbcAVHfI (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
	Fri, 22 Jan 2016 02:35:08 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfe-ecryptfs@m.gmane.org>)
	id 1aMWFN-0006cf-BU
	for ecryptfs@vger.kernel.org; Fri, 22 Jan 2016 08:35:06 +0100
Received: from 218.247.237.32 ([218.247.237.32])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ecryptfs@vger.kernel.org>; Fri, 22 Jan 2016 08:35:05 +0100
Received: from sdhzdmzzl by 218.247.237.32 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ecryptfs@vger.kernel.org>; Fri, 22 Jan 2016 08:35:05 +0100
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: ecryptfs@vger.kernel.org

SGkKCiAgICBhIGZpbGUgbmFtZWQgMS50eHQgLGFuZCB0aGUgY29udGVudCBpcyAxMjM0LHdoZW4gbW91bnRlZCBlY3J5cHRmcywgc2l6ZQppcyA0LGFmdGVyIHVtb3VudGVkIGVjcnlwdGZzLCBzaXplIGlzIDEyMjg4LgogICAgSSBoYXZlICBpbXBsZW1lbnRlZCBhIGZlYXR1cmUgbGlrZSB0aGlzIGJ5IG1vZGlmeSBlY3J5cHRmcyBzb3VyY2UgY29kZToKICAgIDE6d2hlbiBnZWRpdCByZWFkIHRoaXMgZmlsZSwgcmV0dXJuIHNpemUgaXMgNCxhbmQgdGhlIGNvbnRlbnQgIGlzIDEyMzQ7CiAgICAyOndoZW4gc29tZSBvdGhlciBwcm9jZXNzIHJlYWQgdGhpcyBmaWxlLCB0aGUgY29udGVudCBpcyBsaWtlIHdoYXQKdW1vdW50ZWQgcmVhZDsKCiAgICB3aGVuIGZpbGUgaXMgY2xvc2UsIEkgdXNlIGlfc2l6ZV93cml0ZSB0byB3cml0ZSBiYWNrIHRoZSBzaXplIG9mIGZpbGU7CiAgICBhZnRlciBnZWRpdCBjbG9zZSB0aGUgZmlsZSAsdXNlIHN0YXQgLHNpemUgaXMgNDsKICAgIGFmdGVyIGFueSBvdGhlciBwcm9jZXNzIGNsb3NlIHRoZSBmaWxlLHVzZSBzdGF0ICxzaXplIGlzIDEyMjg4OwoKICAgIHdoYXQgSSB3YW50IHRvIGFzayBpcyBob3cgY2FuIGRpZmZl
 cmVudCBzaXplIHJldHVybiB3aGVuIGRpZmZlcmVudApwcm9jZXNzIHJlYWQgc2l6ZSBieSBzdGF044CCIAogICAgIGkuZe+8mnRoZSBmaWxlIHNpemUgaXMgMTAwO3doZW4gcHJvY2VzcyBhIHN0YXRzIGl0LCByZXR1cm4gc2l6ZSAxMDAwLGFuZAp3aGVuIHByb2Nlc3Mgc3RhdHMgaXQsIHJldHVybiBzaXplIDEwMDsKICAgICBidXQgd2hlbiBJIHVzZSBzdGF0LCBpdCBhcHBlYXJzIHRoYXQgc3RhdCBkaXJlY3QgcmVhZCBjYWNoZSAsbm90IGdvZXMKaW50byBlY3J5cHRmcydzIHByb2NlZHVyZTsKCiAgICAgdGhhbmsgeW91IQ==
