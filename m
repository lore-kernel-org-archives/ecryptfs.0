From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] eCryptfs: convert mmap functions to use persistent file
Date: Wed, 19 Jan 2022 14:30:11 +0300
Message-ID: <20220119113011.GB8111@kili>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:1754 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354064AbiASLaZ (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Wed, 19 Jan 2022 06:30:25 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20JA8CwJ002457
        for <ecryptfs@vger.kernel.org>; Wed, 19 Jan 2022 11:30:25 GMT
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnc5f4sbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <ecryptfs@vger.kernel.org>; Wed, 19 Jan 2022 11:30:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20JBK5XW037269
        for <ecryptfs@vger.kernel.org>; Wed, 19 Jan 2022 11:30:23 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by userp3020.oracle.com with ESMTP id 3dkqqq6cej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <ecryptfs@vger.kernel.org>; Wed, 19 Jan 2022 11:30:23 +0000
Content-Disposition: inline
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org

Hello eCryptFS developers,

The patch bf12be1cc851: "eCryptfs: convert mmap functions to use
persistent file" from Oct 16, 2007, leads to the following Smatch
static checker warning:

	./include/linux/fs.h:777 inode_lock()
	warn: sleeping in atomic context

ecryptfs_copy_up_encrypted_with_header() <- disables preempt
-> ecryptfs_read_xattr_region()
   -> ecryptfs_getxattr_lower()
      -> inode_lock()

fs/ecryptfs/mmap.c
   108        static int
   109        ecryptfs_copy_up_encrypted_with_header(struct page *page,
   110                                               struct ecryptfs_crypt_stat *crypt_stat)
   111        {
   112                loff_t extent_num_in_page = 0;
   113                loff_t num_extents_per_page = (PAGE_SIZE
   114                                               / crypt_stat->extent_size);
   115                int rc = 0;
   116
   117                while (extent_num_in_page < num_extents_per_page) {
   118                        loff_t view_extent_num = ((((loff_t)page->index)
   119                                                   * num_extents_per_page)
   120                                                  + extent_num_in_page);
   121                        size_t num_header_extents_at_front =
   122                                (crypt_stat->metadata_size / crypt_stat->extent_size);
   123
   124                        if (view_extent_num < num_header_extents_at_front) {
   125                                /* This is a header extent */
   126                                char *page_virt;
   127
   128                                page_virt = kmap_atomic(page);

kmap_atomic() disables preemption

   129                                memset(page_virt, 0, PAGE_SIZE);
   130                                /* TODO: Support more than one header extent */
   131                                if (view_extent_num == 0) {
   132                                        size_t written;
   133
   134                                        rc = ecryptfs_read_xattr_region(
                                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^
ecryptfs_read_xattr_region() cannot succeed without taking a mutex.

   135                                                page_virt, page->mapping->host);
   136                                        strip_xattr_flag(page_virt + 16, crypt_stat);
   137                                        ecryptfs_write_header_metadata(page_virt + 20,
   138                                                                       crypt_stat,
   139                                                                       &written);
   140                                }
   141                                kunmap_atomic(page_virt);
   142                                flush_dcache_page(page);
   143                                if (rc) {
   144                                        printk(KERN_ERR "%s: Error reading xattr "
   145                                               "region; rc = [%d]\n", __func__, rc);
   146                                        goto out;
   147                                }
   148                        } else {

regards,
dan carpenter
