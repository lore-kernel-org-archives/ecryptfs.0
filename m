Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.13.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793712127;
	b=ZlWCB432V0DlSMQTyrEGbMgGAomijaBV8ZF7ReZpzM10edaY7Jv4ZNxa1gC8mPsDsavD
	 BoqqT+VKT9qZmPAgDD20jUMVuaf9/9Dfy112UWCUyk9RPfpUK3K+6K//mHGcS+4UdYefr
	 0qbfy/clYV4vcs1ItQwVFDEVJiWZnAtymErDfEaa2NWwAOO1g098YB6P7VC0J1RuMIc5O
	 8T4+obxReg0NJXaBEUQdEbEUWavh7r/Y+3d2h3gL3M1ZQDXUkNvk8ZL7g96OXFqXIkg9e
	 QWhMUqzq5TcIIXlo5sPBSOfFusT0kSQY+KNBDUj6txK8k+u8shhKy8XSa2T4wStB4Jg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793712127;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:
	 X-MS-Exchange-CrossTenant-rms-persistedconsumerorg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=W9J4EkHdHr5JyJMcl9HOLYygxOCDvwvCdjJpNm1VeIo=;
	b=ptGX1llgVNjNVMalzHWJcXpPU5vmcftUdn9xcz1C2XKoT7aMixpt028F4pIeg42SgmkH
	 fnGU+lgLqHPL/boX8WVCY3iZQFDGScftcYVWbLetesN7R9ZAzRW661ckljKqz7o0uh7eA
	 +BPOm+4ltR/lmEQT9ZZhCOud18z56TCXZBNfG8jL3qd+LgFLm2gDEIPx5sdA+pVrIKIEg
	 H1mNKA8VaMhhs3nhd47mScpqz+AfC0Uhv3Zpr5Cqs3U1Ihk/r1zKCroxMvbN+iktF7WaI
	 5IKdRr6dWWz6C0Fmk3J27Utj7gEwv9aiFUs7fI8tt3KYg5NkHknLUWhNXQWIerbTfuA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=p2igim3B;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.13.21
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010021.outbound.protection.outlook.com [52.103.13.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF0F606A327;
	Tue,  3 Nov 2026 13:22:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FF0F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=p2igim3B
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/FA6w0BpyLAi5hDzc5rmHsh+fxhlFY3eCg1SDQIoDwLc3bpuEQQ7Qn/zoeA8QIMXfr2vU3R66Sps30SLZ3hTsa/Huren9gIVQ94jFzEedVgoKt37jy7p7faUGL/D8XfZDeQVATT5zeoGE7p+Z6U0dSWshqdAc/DiDt5LGTdZ7yIdCVxtyK6bOJK1vAaonXWVg7KUor7mTNRFb5L3B6u8U9W9Li6gSgNa7JHkH1n0VMsgGy2/lnYTdTiY415zowPWPco+dW4frKQHSzrbm1Ce9QGGwOku8bT7Un8Xq+TSchXna92cMhKdHummF2N0pJy1uupERCXQaBR6BfRMnghew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=W9J4EkHdHr5JyJMcl9HOLYygxOCDvwvCdjJpNm1VeIo=;
 b=lH3XnP9mqIg95Q11tcuiif0mwcA277Jou9r1k/4XZstl0CCNtxJhWG6Z36d1cerEslLtUnTaCTjn0Ax+Ffq6yre7QmWGufWd8o1I0x5llD0kKTx59/BuRU6KUhghtm6Re+J7HOkdxzC/T5ODBPXdN8AIxy9qoMvarM9npMvb+AfVOp0vovjDhrX3pVR5iNr4WxgYnSAubQHrbYphVGZbsuV7KItiAR2NvK+j/6b/MgjfC5JrVLOC58tTByqeT5XLtdXOCgc8UeMw4Pe8zHak7ZWr7x8+b9bNa1C26CbGx8fxuuND9XHxq2C9z2FALVm3HVwzaYWqEBapcq0vQNI6Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9J4EkHdHr5JyJMcl9HOLYygxOCDvwvCdjJpNm1VeIo=;
 b=p2igim3BzXX8dJx+VYB0Hg61Gaoh4Rcd8ZnqhUdg1k2LQ59WZfi12YPNYMS6XuA81ekKDCKDm+Kiz65k46qzm0lANRkFQ4hf1zeevslxWa5Y9Q0dJbnfYVieaC9rjlbWr4pQFKbj+JamKkfbc+AwMZF26X+EZ2RarGy673tpsdr7qcTwMqD05kAyCXe7I1aR8MtGTj4N7JRmzpSqiBla/ADh733EoE+yebtxPRUVDIuA04YA6JKBnB4otnkfTe1MMyjsfpdNgXSKHyZRzcPTcRLr8ODkXqDv3JumpNl01/xQA4cRKG8T1tXrQq+mGhWNcLtgHAW389CmxSa1IvJpsw==
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 (2603:10b6:806:39d::17) by IA1PR05MB10150.namprd05.prod.outlook.com
 (2603:10b6:208:3da::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 13:21:41 +0000
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d]) by SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d%6]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 13:21:41 +0000
From: Yingjie Wang <x-professor@outlook.com>
To: "ecryptfs@vger.kernel.org" <ecryptfs@vger.kernel.org>
CC: Tyler Hicks <code@tyhicks.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] ecryptfs: check the message wait timeout at load time
Thread-Topic: [PATCH] ecryptfs: check the message wait timeout at load time
Thread-Index: AQHda5ZDbdqqqpQyjUGgYH8VJFFMkw==
Date: Tue, 3 Nov 2026 13:21:41 +0000
Message-ID:
 <ba98c33585ec18720e243323f57e081039e1aacf.1793712091.git.x-professor@outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR05MB10385:EE_|IA1PR05MB10150:EE_
x-ms-office365-filtering-correlation-id: a0a3ceb2-1f1f-4347-906c-08df39ad65e5
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|24071999003|24121999003|41001999006|24021099003|39105399006|15080799012|8060799015|8062599012|20031999006|12121999013|38102599003|22091999003|19110799012|4140399003|25010399006|102099032|3412199025|440099028|26121999007|40105399003;
x-microsoft-antispam-message-info:
 =?utf-8?B?R0czQUYxMXFjUG15TzVzd1M3Zm9FZVBkcWd2UnVnQTlyRHdyL0s3ekI4MzR1?=
 =?utf-8?B?cnpObVdIU2YxOWhCRTI4bXJNZFUxZHhyN0hveWw1RVlUeW8zNUVnaml0ZHdI?=
 =?utf-8?B?RVNCTWNIM3VjZ2sxVEJqM2RtM2RvTldHUkdDOEQ2ZUlWTzBRSHpCMzZJWFRi?=
 =?utf-8?B?NlA4ZFVIemhueWorVUtBOXQwdXdTeWZTZ3lLOTNId2huS0FtL1Y4V1BYdThZ?=
 =?utf-8?B?RFNXUUU1OUFZaytrQXFESVpMUytheVkwMlo2R2orbWNrUWV4dTFKSVBVTTls?=
 =?utf-8?B?aGk1OUQ1NCtFZC9FOFlZRjkvaDBSeVRBck54MmZNL3B2L2FGVVVJZFUxQXM2?=
 =?utf-8?B?Q2x5amt2cGczdzN5MStPbi9kR3kyZjAxaXJUeEhQdWNxNlI2TVc4VHdnbCto?=
 =?utf-8?B?ZkJXRHQ3QXBSQnY5U25iQ0hpUUxFTGxDa2NvUDJXL29SV25LcG1vbzdzaDNk?=
 =?utf-8?B?b0ZnKzUvMGZvWFQ5c0svZ0hveWtoWWNDVis1V1R3bXVhc29hY3NlamZoSFR1?=
 =?utf-8?B?dkJyVFpWTFRxS0lNMEh2bjZhRzM5VTdlL2dtcjUzQUhhNEVlVHZNUGM2Ykcw?=
 =?utf-8?B?Sm9VM2RHaTdRcU1JUVlONVg3UmlYRnlkWjY1a0F6ajdMY1VTdGZLaC9IZTdo?=
 =?utf-8?B?YUZva1BrbUtZQUV5M3pYUFdLbTBITlRtbGtPUk5rYXU2VkQxN3FyRU04YUp4?=
 =?utf-8?B?Q3duRHBMMmVtOTJDSU1SemRKVE1ZbWh6M3ViY3cvMVBTK3l4amZWeHBLcC9v?=
 =?utf-8?B?eHBBL1RDV0p4Y3NHRHFQa0t5OGhvT2ZScnQ1NFpLeGF3a3lWWGwvK2dvdzgx?=
 =?utf-8?B?NXM5Zm5LNmhhVnJMdHRZK3VqSGVGQU1qdkV5RTBMejZMWGswYzVVQnNMUG5M?=
 =?utf-8?B?bUFKK1ozTk9JQUlWSFdkUUxjM05KblZBVERNMlBwWUU4Nld4SGpmQ3hQZHpI?=
 =?utf-8?B?MGU4a1FacFVzVXo2Q2lwOVF1d2dsZlFxRTVGMFJmVFJzd0RjeEJJd2p6K0NL?=
 =?utf-8?B?TXoyVlhVaHpFeHJTNnhRWHRQNlFhTWo3TmxGaFIyNlBsazN3N3FRRXBRTWUr?=
 =?utf-8?B?NVo1UERmNGlvbzRHVGFqNUJ1VngySFBJYURSR2E1WkRPQVo0UkdSY1E0M2oy?=
 =?utf-8?B?WUxhZDZmMUc5RlJkbzJsWjhJcktDblJHSHV2SmMxV0haWGhndFJqVUhnSWNk?=
 =?utf-8?B?S052ZTluOFR3NHJPTjhSVmFxd3dxaUhJU05IeC9YejZYVTE3SGloWTJsSDZ1?=
 =?utf-8?B?RzAzQ2psc0tmdk90dHByYnc1ZUhka0tIRGZ6cjd0UXlIZkNrQ0NwWEtlcHJS?=
 =?utf-8?B?cG8zZHdvQjlOU2RqbFJNOW9nanNiaGJxQWNOeDA0bUw1Vjl3T0NRMTBTN3p2?=
 =?utf-8?B?TlEwK28zRE02c25NaWVjdWo5L0twT2ZZOExJMG8rOG5ab05lWUZkZkJkQldX?=
 =?utf-8?B?YU1BL2twRjJwQnY2ZkRjdTE1bGdhNnpZSUVKYmEwbk1KLzY1OHpRclFTdzV5?=
 =?utf-8?B?R3JmOTRhUGdhanMvaHoxL3dLNXk4NUtsdmVjQVM5NkFvL2FGa1VNNXhGVDI3?=
 =?utf-8?Q?8Ry6llIoc00uJjT6Jl/QNtDpD28OJTvzBD25kCxBGrrLCJ?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T3JqdlBNVEhTTjNKaGR3K2ZUVVVwTzNBaU1oSlpMQVE2Nk1ndkpyZjc3SFFY?=
 =?utf-8?B?TVVlLy9hc3FHVDBmM0F1WE5XUkJzRkxFK3lsWG92c2FGeUY1K21DOWZCaHhu?=
 =?utf-8?B?dWJwL0E3TVViNWZmUFllYm5wWHhTSVR4SmFqczc4V2RFblRKcCtVMi9Xc1Jy?=
 =?utf-8?B?WDV6cUhxV0pmRUlucUlWUDAwVWN1UHkwRXdzb3o0TG96VHRIYWJ1RUo2c1g3?=
 =?utf-8?B?MUV1Q1hkQVg0cGZwdi8vRlFrak5NUzU0SlUreUxONmU4TnhpMnM0R2RZM0JH?=
 =?utf-8?B?Vm50aFllMlRjMjFUbCtydm9McEtHRElHUXNBNTNoa3B4Uy9xQWhyTTU3eFNa?=
 =?utf-8?B?YkdLRlhjY0dyZE5NU21ITTRnemRLenpNWmdKYmw5K2tFWHRhNzI2c0tvNktU?=
 =?utf-8?B?VzdGMWVseXRSa1hUOUxHVTk4L2hiVzI3a1BWWGpFSGFEZzV4dG1BWHVFa1BY?=
 =?utf-8?B?WGhUWVVYWkxlWW56NWl5Z1FkTTgwemVISXFhem9CYUM2bW1KYSsrYkQ0clhY?=
 =?utf-8?B?Y1VjRFVPU2p5VFQzUS9ta3lJNXpod0dNVFB3ZXRHMjNNQ1l1c3VtQTdkdmJp?=
 =?utf-8?B?UWdUdXN4Rnd6WTNrZEVGdXpsQXVZckYwaU5sS0RvUVVEcmFyWUkzay8xc25W?=
 =?utf-8?B?bUEyZ0dWVHhSSGFFcktHYUlNbThNbWl3MHpka3BkbVNDZHp3UDFIOFFhK2Iy?=
 =?utf-8?B?VFpmY1hLd1JhRmg4N2dUY1o5Q2Y0cFRXMUlxM04yY05VeUQyUk8rZ3dtS251?=
 =?utf-8?B?ck1KOWdVazFxams5ZFdKZmhPWTVRc0Fob3N2VnRZNmJFV2hxc3drWWMrblBa?=
 =?utf-8?B?b1U5RDY5aUVSZnlYSEtUMHVlOUQxdHI5U0FHRUgrUWdTaDZHSEdjVmU0VmdB?=
 =?utf-8?B?ZmYvY3B6K25meVF6cGtlSmFHTktSN0lxZllTc3J4UWs4ZUM4RUZqYlZac01q?=
 =?utf-8?B?a2FYem50b05tRkROWVRLcW8wbkNqcjE4NGc5M2RUZ01KemRYVENxK2ZyMXVp?=
 =?utf-8?B?SEtrSGN6clR4d3l3UGxVbERJdDgveGRCQ0FCNE5aK3dCOFI5S0U0eFpPM1Rk?=
 =?utf-8?B?T3JZN05rb0hRZVZHdnhXMDN2cTdVWlFOcDR0MTQwOXIyK1hNck9EaHhCQncw?=
 =?utf-8?B?aHdVczU2ZkU1WkJCTXh3SUJOcmdFaE1MZkZEVE4zUXJ0ZmVmVVFkZVowQnlM?=
 =?utf-8?B?REZIOXR0ZUFOVTRJcEhTYTFwR3VSVTMvOFNzdkRmNEhGSTQ1ZkVlMjc0RFEw?=
 =?utf-8?B?MEk3TGhwTzA3NVBiNkt5dElBMXFmVkdZZ21wVXZ0MERmWkthbkIyNC83S04y?=
 =?utf-8?B?d0wxelZLSmJLTjZld05aTTVIMjlES3hkUktPblhPWEZqYWdTS25jTWlpaC80?=
 =?utf-8?B?OVJzZDNIZXJqN2VpSG9Wc2U0dmMyQVZ2OWM3N2NpL2h6ZHBpL2QrVDhWaVdi?=
 =?utf-8?B?WUc3YmRNWFRPV3dDdnR3ZlpCMmFyUDJjVkw4Q3M5V3dKVkFhd2lLbkpVN0VP?=
 =?utf-8?B?SXRXSDFYODhib3prb2NkMWk4elViYXVwTVlDNDE0cGtWZVFJdm85N3g0WGh1?=
 =?utf-8?B?Y01tRUhITFE1OHNmOVlhZm9EOElvVnNteVp3aC8xVkU0MUdiODJYTWdqbVNm?=
 =?utf-8?B?dWFXQjEzT01lVzhZY0N4by9teldzc0V6WmEybmc5aGltaGtuVWZtNmkza3VM?=
 =?utf-8?B?MHpjT3djc3BmZVBpZTFYWXdWRmdJSzhWTXpxVnpuNGVUcGFCQ3Z5V3p5MVBi?=
 =?utf-8?B?cjh5b0hWTDVPM1p0akNZZlhEb0l4U21mU3RUaDB4eGVyUU5hZ3Z0anRNTVYy?=
 =?utf-8?B?VlVsK1VGUXM1YTVMakZlRUk1Z2JZQzBrbk5MU1dOcVVFRlpvNndNRDVpa0ZS?=
 =?utf-8?Q?j5DxDffyxi4gg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Post: <mailto:ecryptfs@vger.kernel.org>
List-Help: <mailto:ecryptfs+help@vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ecryptfs+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR05MB10385.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a3ceb2-1f1f-4347-906c-08df39ad65e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2026 13:21:41.1033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR05MB10150

ZWNyeXB0ZnNfd2FpdF9mb3JfcmVzcG9uc2UoKSBtdWx0aXBsaWVzIHRoZSBlY3J5cHRmc19tZXNz
YWdlX3dhaXRfdGltZW91dAptb2R1bGUgcGFyYW1ldGVyIGJ5IEhaIGFuZCBwYXNzZXMgdGhlIHJl
c3VsdCB0bwpzY2hlZHVsZV90aW1lb3V0X2ludGVycnVwdGlibGUoKS4gVGhlIHBhcmFtZXRlciBp
cyBhIHNpZ25lZCBsb25nIHdpdGggbm8Kc2VtYW50aWMgcmFuZ2UgY2hlY2suIE5lZ2F0aXZlIGFu
ZCBzdWZmaWNpZW50bHkgbGFyZ2UgcG9zaXRpdmUgdmFsdWVzIGNhbgpwcm9kdWNlIGFuIGludmFs
aWQgdGltZW91dCB3aGVuIG11bHRpcGxpZWQgYnkgSFouIEEgbmVnYXRpdmUgcmVzdWx0IG1ha2Vz
CnNjaGVkdWxlX3RpbWVvdXQoKSBwcmludCAid3JvbmcgdGltZW91dCB2YWx1ZSIgd2l0aCBhIHN0
YWNrIGR1bXAgYW5kIHJldHVybgphdCBvbmNlLiBSZXF1ZXN0cyB0byBlY3J5cHRmc2QgdGhlbiBm
YWlsIHdpdGggLUVJTyB3aXRob3V0IHdhaXRpbmcgZm9yIGl0cwpyZXBseS4gT24geDg2LTY0IHdp
dGggSFo9MTAwMCwgLTEgYW5kIDkyMjMzNzIwMzY4NTQ3NzYgbWFkZSBjcmVhdGluZyBhIGZpbGUK
aW4gYSBwcml2YXRlLWtleSBtb3VudCBmYWlsIHdpdGhpbiAxMCBtcyBhbHRob3VnaCB0aGUgZGFl
bW9uIGFuc3dlcmVkIGFmdGVyCjAuNyBzZWNvbmRzLgoKVGhlIHBhcmFtZXRlciBjYW5ub3QgYmUg
Y2hhbmdlZCBhZnRlciBsb2FkLCBzbyB2YWxpZGF0ZSBpdCBvbmNlIGluCmVjcnlwdGZzX2luaXRf
bWVzc2FnaW5nKCkuIFdhcm4gYW5kIHJlc3RvcmUgdGhlIHRocmVlLXNlY29uZCBkZWZhdWx0IGZv
cgp2YWx1ZXMgYmVsb3cgemVybyBvciBhYm92ZSBNQVhfSklGRllfT0ZGU0VUIC8gSFosIGZvbGxv
d2luZyB0aGUgbG9hZC10aW1lCm5vcm1hbGl6YXRpb24gcGF0dGVybiBhbHJlYWR5IHVzZWQgZm9y
IGVjcnlwdGZzX251bWJlcl9vZl91c2Vycy4KCkZpeGVzOiBkZGRmYTQ2MWZjODkgKCJbUEFUQ0hd
IGVDcnlwdGZzOiBQdWJsaWMga2V5OyBwYWNrZXQgbWFuYWdlbWVudCIpClNpZ25lZC1vZmYtYnk6
IFlpbmdqaWUgV2FuZyA8eC1wcm9mZXNzb3JAb3V0bG9vay5jb20+Ci0tLQoKTm90ZXM6CiAgICBU
ZXN0ZWQgb24geDg2LTY0IChIWj0xMDAwKSBpbiBRRU1VIGJ5IGxvYWRpbmcgdGhlIG1vZHVsZSB3
aXRoIGVhY2gKICAgIHZhbHVlIGFuZCBjcmVhdGluZyBhIGZpbGUgaW4gYSBtb3VudCB0aGF0IHVz
ZXMgYSBwcml2YXRlLWtleSBhdXRoIHRva2VuOwogICAgYSB0ZXN0IHByb2dyYW0gaGVsZCAvZGV2
L2VjcnlwdGZzIGFuZCBhbnN3ZXJlZCB0aGUgdGFnIDY2IHJlcXVlc3QgYWZ0ZXIKICAgIDcwMCBt
cy4gV2l0aCB0aGUgcGF0Y2gsIC0xLCA5MjIzMzcyMDM2ODU0Nzc2LCA5MjIzMzcyMDM2ODU0Nzc1
IGFuZAogICAgNDYxMTY4NjAxODQyNzM4OCBsb2cgdGhlIG5ldyB3YXJuaW5nLCBmYWxsIGJhY2sg
dG8gMyBzZWNvbmRzLCBhbmQgdGhlCiAgICBjcmVhdGUgc3VjY2VlZHM7IDIgYW5kIDQ2MTE2ODYw
MTg0MjczODcgYmVoYXZlIHRoZSBzYW1lIG9uIGJvdGgKICAgIGtlcm5lbHMuIEFsc28gYnVpbHQg
Zm9yIGkzODYgd2l0aCBXPTEuCgogZnMvZWNyeXB0ZnMvbWVzc2FnaW5nLmMgfCA3ICsrKysrKysK
IDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9mcy9lY3J5cHRm
cy9tZXNzYWdpbmcuYyBiL2ZzL2VjcnlwdGZzL21lc3NhZ2luZy5jCmluZGV4IDczYzdiODIxNWU2
Ni4uODBmNTNiY2I5MDc5IDEwMDY0NAotLS0gYS9mcy9lY3J5cHRmcy9tZXNzYWdpbmcuYworKysg
Yi9mcy9lY3J5cHRmcy9tZXNzYWdpbmcuYwpAQCAtMzcxLDYgKzM3MSwxMyBAQCBpbnQgX19pbml0
IGVjcnlwdGZzX2luaXRfbWVzc2FnaW5nKHZvaWQpCiAJCSAgICAgICAidG9vIGxhcmdlLCBkZWZh
dWx0aW5nIHRvIFslZF0gdXNlcnNcbiIsIF9fZnVuY19fLAogCQkgICAgICAgZWNyeXB0ZnNfbnVt
YmVyX29mX3VzZXJzKTsKIAl9CisJLyogZWNyeXB0ZnNfd2FpdF9mb3JfcmVzcG9uc2UoKSBtdWx0
aXBsaWVzIHRoaXMgYnkgSFogKi8KKwlpZiAoZWNyeXB0ZnNfbWVzc2FnZV93YWl0X3RpbWVvdXQg
PCAwIHx8CisJICAgIGVjcnlwdGZzX21lc3NhZ2Vfd2FpdF90aW1lb3V0ID4gTUFYX0pJRkZZX09G
RlNFVCAvIEhaKSB7CisJCWVjcnlwdGZzX21lc3NhZ2Vfd2FpdF90aW1lb3V0ID0gRUNSWVBURlNf
TUFYX01TR19DVFhfVFRMIC8gSFo7CisJCXByX3dhcm4oIiVzOiBNZXNzYWdlIHdhaXQgdGltZW91
dCBvdXQgb2YgcmFuZ2UsIGRlZmF1bHRpbmcgdG8gWyVsZF0gc2Vjb25kc1xuIiwKKwkJCV9fZnVu
Y19fLCBlY3J5cHRmc19tZXNzYWdlX3dhaXRfdGltZW91dCk7CisJfQogCW11dGV4X2xvY2soJmVj
cnlwdGZzX2RhZW1vbl9oYXNoX211eCk7CiAJZWNyeXB0ZnNfaGFzaF9iaXRzID0gMTsKIAl3aGls
ZSAoZWNyeXB0ZnNfbnVtYmVyX29mX3VzZXJzID4+IGVjcnlwdGZzX2hhc2hfYml0cykKCmJhc2Ut
Y29tbWl0OiA4ZjY2MjZiZDY1OTRhNzhmNDU0ZDAyYjI3Yjc0YTU4MGM4OTBjYWI5Ci0tIAoyLjQz
LjAKCg==
