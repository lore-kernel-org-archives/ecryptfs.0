From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] ecryptfs: Restore support for both encrypted and
 unencrypted file names
Date: Wed, 28 Mar 2018 06:33:02 -0700
Message-ID: <6f35b462-8c36-5ba3-4712-a0782961e548@roeck-us.net>
References: <1518561368-8324-1-git-send-email-linux@roeck-us.net>
 <740f5325-331d-d38c-e9d4-5f81b95a6872@canonical.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <740f5325-331d-d38c-e9d4-5f81b95a6872@canonical.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Tyler Hicks <tyhicks@canonical.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>

On 03/27/2018 08:58 AM, Tyler Hicks wrote:
> Hello Guenter
> 
> On 02/13/2018 04:36 PM, Guenter Roeck wrote:
>> Commit 88ae4ab9802e ("ecryptfs_lookup(): try either only encrypted or
>> plaintext name") was supposed to fix a situation where two files with
>> the same name and same inode could be created in ecryptfs. One of those
>> files had an encrypted file name, the other file name was unencrypted.
> 
> That's correct. Al was concerned about possible deadlocks with aliased
> dentries and I thought it would be best to only support encrypted and
> unencrypted but not both.
> 
>>
>> After commit 88ae4ab9802e, having a mix of encrypted and unencrypted file
>> names is no longer supposed to be possible. However, that is not the case.
>> The only difference is that it is now even easier to create a situation
>> where two files with the same name coexist (one encrypted and the other
>> not encrypted). In practice, this looks like the following (files
>> created with v4.14.12).
>>
>> ecryptfs mounted with file name encryption enabled:
>>
>> $ ls -li
>> total 48
>> 5252822 -rw-rw-r-- 1 groeck groeck 10 Jan 20 13:02 myfile
>> 5252822 -rw-rw-r-- 1 groeck groeck 10 Jan 20 13:02 myfile
>> 5252824 -rw-rw-r-- 1 groeck groeck 10 Jan 20 15:36 myfile2
>> 5252824 -rw-rw-r-- 1 groeck groeck 10 Jan 20 15:36 myfile2
>> $ grep . *
>> myfile:encrypted
>> myfile:encrypted
>> myfile2:encrypted
>> myfile2:encrypted
>>
>> $ ls -li
>> total 48
>> 5252824 -rw-rw-r-- 1 groeck groeck 10 Jan 20 15:36
>> ECRYPTFS_FNEK_ENCRYPTED.FWbF9U6H6L6ekEZYGWnkfR4wMiyeTVoCeVun.BU8Zu5-njbcIPoApxk7-E--
>> 5252822 -rw-rw-r-- 1 groeck groeck 10 Jan 20 13:02
>> ECRYPTFS_FNEK_ENCRYPTED.FWbF9U6H6L6ekEZYGWnkfR4wMiyeTVoCeVunt0fda7t9YCtJ70cm911yZ---
>> 5252817 -rw-rw-r-- 1 groeck groeck 12 Jan 20 12:52 myfile
>> 5252827 -rw-rw-r-- 1 groeck groeck 12 Jan 20 15:37 myfile2
>>
>> $ grep . *
>> ECRYPTFS_FNEK_ENCRYPTED.FWbF9U6H6L6ekEZYGWnkfR4wMiyeTVoCeVun.BU8Zu5-njbcIPoApxk7-E--:encrypted
>> ECRYPTFS_FNEK_ENCRYPTED.FWbF9U6H6L6ekEZYGWnkfR4wMiyeTVoCeVunt0fda7t9YCtJ70cm911yZ---:encrypted
>> myfile:unencrypted
>> myfile2:unencrypted
>>
>> Creating a file with file name encryption disabled and remounting with
>> file name encryption enabled results in the following.
>>
>> $ ls -li
>> ls: cannot access 'myfile3': No such file or directory
>> total 48
>> 5252822 -rw-rw-r-- 1 groeck groeck 10 Jan 20 13:02 myfile
>> 5252822 -rw-rw-r-- 1 groeck groeck 10 Jan 20 13:02 myfile
>> 5252824 -rw-rw-r-- 1 groeck groeck 10 Jan 20 15:36 myfile2
>> 5252824 -rw-rw-r-- 1 groeck groeck 10 Jan 20 15:36 myfile2
>>        ? -????????? ? ?      ?       ?            ? myfile3
>>
>> Prior to commit 88ae4ab9802e, the file system had to be mounted with
>> encrypted file names first to create a file, then the same had to be
>> repeated after mounting with unencrypted file names. Now the duplicate
>> files can be created both ways (unencrypted _or_ encrypted first).
>>
>> The only real difference is that it is no longer possible to have a
>> _working_ combination of encrypted and unencrypted file names. In other
>> words, commit 88ae4ab9802e results in reduced functionality with no
>> benefit whatsoever.
>>
>> Restore ability to have a mix of unencrypted and encrypted files.
>> This effectively reverts commit 88ae4ab9802e, but the code is now
>> better readable since it avoids a number of goto statements.
> 
> I'd like for us to correctly fix 88ae4ab9802e rather than try to support
> both filename types under a single mount since that's complex and there
> are unknown corner cases to consider. I think this can be done by not
> copying up the lower filename when an error is encountered in
> ecryptfs_decode_and_decrypt_filename(). If filename encryption is
> enabled, it should only return decrypted filenames or an error if it
> isn't possible to decrypt the lower filename.
> 

NP. I'll leave it alone, then. Since our use case requires both encrypted
and unencrypted file names, our "fix" will be to carry this patch along
locally as long as needed and stop using ecryptfs otherwise.

Guenter

> Tyler
> 
>>
>> Cc: Al Viro <viro@zeniv.linux.org.uk>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   fs/ecryptfs/inode.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
>> index 847904aa63a9..14a5c096ead6 100644
>> --- a/fs/ecryptfs/inode.c
>> +++ b/fs/ecryptfs/inode.c
>> @@ -392,11 +392,11 @@ static struct dentry *ecryptfs_lookup(struct inode *ecryptfs_dir_inode,
>>   	int rc = 0;
>>   
>>   	lower_dir_dentry = ecryptfs_dentry_to_lower(ecryptfs_dentry->d_parent);
>> -
>> +	lower_dentry = lookup_one_len_unlocked(name, lower_dir_dentry, len);
>>   	mount_crypt_stat = &ecryptfs_superblock_to_private(
>>   				ecryptfs_dentry->d_sb)->mount_crypt_stat;
>> -	if (mount_crypt_stat
>> -	    && (mount_crypt_stat->flags & ECRYPTFS_GLOBAL_ENCRYPT_FILENAMES)) {
>> +	if (IS_ERR(lower_dentry) &&
>> +	    (mount_crypt_stat->flags & ECRYPTFS_GLOBAL_ENCRYPT_FILENAMES)) {
>>   		rc = ecryptfs_encrypt_and_encode_filename(
>>   			&encrypted_and_encoded_name, &len,
>>   			mount_crypt_stat, name, len);
>> @@ -405,10 +405,10 @@ static struct dentry *ecryptfs_lookup(struct inode *ecryptfs_dir_inode,
>>   			       "filename; rc = [%d]\n", __func__, rc);
>>   			return ERR_PTR(rc);
>>   		}
>> -		name = encrypted_and_encoded_name;
>> +		lower_dentry = lookup_one_len_unlocked(
>> +			encrypted_and_encoded_name, lower_dir_dentry, len);
>>   	}
>>   
>> -	lower_dentry = lookup_one_len_unlocked(name, lower_dir_dentry, len);
>>   	if (IS_ERR(lower_dentry)) {
>>   		ecryptfs_printk(KERN_DEBUG, "%s: lookup_one_len() returned "
>>   				"[%ld] on lower_dentry = [%s]\n", __func__,
>>
> 
> 

