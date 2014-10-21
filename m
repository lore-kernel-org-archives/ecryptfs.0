From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: is size correct in ecryptfs_parse_packet_length()
Date: Tue, 21 Oct 2014 15:04:35 +0300
Message-ID: <20141021120435.GA19969@mwanda>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:33523 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755281AbaJUME5 (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 21 Oct 2014 08:04:57 -0400
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id s9LC4tti011676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ecryptfs@vger.kernel.org>; Tue, 21 Oct 2014 12:04:56 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id s9LC4t4F008466
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ecryptfs@vger.kernel.org>; Tue, 21 Oct 2014 12:04:55 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id s9LC4siP019073
	for <ecryptfs@vger.kernel.org>; Tue, 21 Oct 2014 12:04:54 GMT
Content-Disposition: inline
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org

fs/ecryptfs/keystore.c +93
    85  /**
    86   * ecryptfs_parse_packet_length
    87   * @data: Pointer to memory containing length at offset
    88   * @size: This function writes the decoded size to this memory
    89   *        address; zero on error
    90   * @length_size: The number of bytes occupied by the encoded length
    91   *
    92   * Returns zero on success; non-zero on error
    93   */
    94  int ecryptfs_parse_packet_length(unsigned char *data, size_t *size,
    95                                   size_t *length_size)
    96  {
    97          int rc = 0;
    98  
    99          (*length_size) = 0;
   100          (*size) = 0;
   101          if (data[0] < 192) {
   102                  /* One-byte length */
   103                  (*size) = (unsigned char)data[0];
   104                  (*length_size) = 1;
   105          } else if (data[0] < 224) {
   106                  /* Two-byte length */
   107                  (*size) = (((unsigned char)(data[0]) - 192) * 256);
                                    ^^^^^^^^^^^^^^^
   108                  (*size) += ((unsigned char)(data[1]) + 192);
                                    ^^^^^^^^^^^^^^^
These casts are no-ops because they are "data" is an unsigned char
pointer already.  Then the value is type promoted to int, we subtract
192 giving a negative number and we multiply by 256 giving a slightly
larger negative then we save it as a very large positive.

I don't know this well enough to say what the intent was.

   109                  (*length_size) = 2;
   110          } else if (data[0] == 255) {
   111                  /* If support is added, adjust ECRYPTFS_MAX_PKT_LEN_SIZE */
   112                  ecryptfs_printk(KERN_ERR, "Five-byte packet length not "
   113                                  "supported\n");
   114                  rc = -EINVAL;
   115                  goto out;
   116          } else {
   117                  ecryptfs_printk(KERN_ERR, "Error parsing packet length\n");
   118                  rc = -EINVAL;
   119                  goto out;
   120          }
   121  out:
   122          return rc;
   123  }

regards,
dan carpenter
