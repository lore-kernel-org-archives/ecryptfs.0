From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: is size correct in ecryptfs_parse_packet_length()
Date: Wed, 22 Oct 2014 10:58:30 +0300
Message-ID: <20141022075830.GE26918@mwanda>
References: <20141021120435.GA19969@mwanda>
 <20141021212952.GA18270@boyd>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:31100 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347AbaJVH63 (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Wed, 22 Oct 2014 03:58:29 -0400
Content-Disposition: inline
In-Reply-To: <20141021212952.GA18270@boyd>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tyler Hicks <tyhicks@canonical.com>
Cc: ecryptfs@vger.kernel.org

On Tue, Oct 21, 2014 at 05:29:53PM -0400, Tyler Hicks wrote:
> >    101          if (data[0] < 192) {
> >    102                  /* One-byte length */
> >    103                  (*size) = (unsigned char)data[0];
> >    104                  (*length_size) = 1;
> >    105          } else if (data[0] < 224) {
> >    106                  /* Two-byte length */
> >    107                  (*size) = (((unsigned char)(data[0]) - 192) * 256);
> >                                     ^^^^^^^^^^^^^^^
> >    108                  (*size) += ((unsigned char)(data[1]) + 192);
> >                                     ^^^^^^^^^^^^^^^
> > These casts are no-ops because they are "data" is an unsigned char
> > pointer already.  Then the value is type promoted to int, we subtract
> > 192 giving a negative number and we multiply by 256 giving a slightly
> > larger negative then we save it as a very large positive.
> 
> Subtracting 192 from data[0] should never result in a negative number.
> We know that data[0] is greater than or equal to 192 (and less than 224)
> because the previous conditional was false.
> 

Oh right.  Duh...  Thanks.

We could remove the casting though because it's a no-op?

regards,
dan carpenter
