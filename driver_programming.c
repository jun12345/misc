/sys/class interface
====================

    error = class_register(&jun); //error == 0: successful
	
	struct class jun = {
 	    .name = "jun",  // will have "/sys/class/jun" dir
	    .class_attrs = jun_class_attrs,
	};

    struct class_attribute jun_class_attrs = {
		__ATTR(jun_file, 0644, jun_file_show, jun_file_store), // will have "/sys/class/jun/jun_file" file
		...
		__ATTR_NULL,
	};

	ssize_t jun_file_show(struct class *class, struct class_attribute *attr, char *buf) {...}
	ssize_t jun_file_store(struct class *class, struct class_attribute *attr, const char *buf, size_t count) {...}



/sys/devices interface
======================

    error = sysfs_create_group(&client->dev.kobj, &jun_attr_group); //error == 0:successful. if client is i2c's device,
																	//then it will have "/sys/devices/i2c-x/x-<addr>/jun"
																    //file.
	struct attribute_group jun_attr_group = {                       //
		.name = NULL, 
		.attrs = jun_attr,
	};

	static DEVICE_ATTR(jun, S_IRWXUGO, jun_read, jun_write);
	static struct attribute* jun_attr[] = {
	       &dev_attr_jun.attr,
	       NULL
	};

    ssize_t jun_read(struct device *dev, struct device_attribute *attr, char *buf){...}
	ssize_t jun_write(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)

video drivers
=============

VGA目前的含义更多地体现为分辨率规范，VGA:640*480, SVGA:800*600, XGA:1024*768, SXGA:1280*1024, QVGA:320*240
在弄TV300项目时会涉及到这些概念。在弄MID时，不会碰到，而是LVDS等概念。

frame buffer is the kernel of linux video drivers system.


nand/nor flash, MTD
===================
cat /proc/mtd
cat /proc/partitions

amlogic m3(PDM829MD) nand driver log(dmesg):

[    2.308054]Amlogic nand flash AVOS driver for M3, Version 1.1 (c) 2010 Amlogic Inc.
	drivers/amlogic/nand/m3_nand.c: m3_nand_init()

[    2.315914]bus_cycle=17, bus_timing=10, start_cycle=10, end_cycle=10,system=5.2ns
    drivers/amlogic/nand/m3_nand.c: m3_nand_probe() --> aml_nand_probe() --> aml_nand_init()
	  <drivers/amlogic/nand/aml_nand.c> --> aml_chip->aml_nand_hw_init(aml_chip)(defined in m3_nand.c, m3_nand_hw_init())

[    2.323309] No NAND device found.
    aml_nand_init() --> nand_scan()<drivers/mtd/nand/nand_base.c> --> ...  注：我猜因为没有在标准的nand_ids.c中加入所
	  支持的芯片设备ID，所以用标准的nand flash找不到device，也就显示出No Nand device found。这不会有问题，因为下面amlogic
	  写了自己的aml_nand_scan()。

[    2.326623] NAND device id: 2c 88 4 4b a9 0 
[    2.330838] NAND device: Manufacturer ID: 0x2c, Chip ID: 0x2c (Micron C revision NAND 8GiB MT29F64G-C)
	aml_nand_init() --> aml_nand_scan() --> aml_nand_scan_ident() --> aml_nand_get_flash_type()

[    2.340224] bus_cycle=4, bus_timing=5, start_cycle=5, end_cycle=6,system=5.2ns
    aml_nand_init() --> aml_chip->aml_nand_adjust_timing(aml_chip)(defined in m3_nand.c, m3_nand_adjust_timing())

[    2.347321] oob size is not enough for selected bch mode: NAND_BCH60_1K_MODE force bch to mode: NAND_BCH30_1K_MODE
    aml_nand_init() --> aml_chip->aml_nand_options_confirm(aml_chip)(defined in m3_nand.c, m3_nand_options_confirm())

[    2.357698] Creating 1 MTD partitions on "C revision NAND 8GiB MT29F64G-C":
	aml_nand_init() --> aml_nand_add_partition(aml_chip) --> add_mtd_partitions()<drivers/mtd/mtdpart.c>

[    2.364548] 0x000000000000-0x000000800000 : "bootloader"
    aml_nand_init() --> aml_nand_add_partition(aml_chip) --> add_mtd_partitions() -->  add_one_partition()

    the follows: m3_nand_probe() --> aml_nand_probe(for (...)) --> the same as above
[    2.370936] bus_cycle=17, bus_timing=10, start_cycle=10, end_cycle=10,system=5.2ns
[    2.377442] No NAND device found.
[    2.380679] NAND device id: 2c 88 4 4b a9 0 
[    2.384917] NAND device: Manufacturer ID: 0x2c, Chip ID: 0x2c (Micron C revision NAND 8GiB MT29F64G-C)
[    2.394220] 1 NAND chips detected
[    2.397589] bus_cycle=4, bus_timing=5, start_cycle=5, end_cycle=6,system=5.2ns
[    2.404674] oob size is not enough for selected bch mode: NAND_BCH60_1K_MODE force bch to mode: NAND_BCH30_1K_MODE
[    2.434715] aml nand env valid addr: c70000 
[    2.472806] nand env: nand_env_probe. 
[    2.473350] Creating 8 MTD partitions on "C revision NAND 8GiB MT29F64G-C":
[    2.477995] 0x000001000000-0x000001800000 : "logo"
[    2.483533] 0x000001800000-0x000002000000 : "aml_logo"
[    2.488688] 0x000002000000-0x000002800000 : "recovery"
[    2.493630] 0x000002800000-0x000003000000 : "boot"
[    2.498524] 0x000003000000-0x000023000000 : "system"
[    2.502648]  NAND bbt detect Bad block at b400000 
[    2.508281] 0x000023000000-0x00002b000000 : "cache"
[    2.513055] 0x00002b000000-0x00004b000000 : "userdata"
[    2.518260] 0x00004b000000-0x000200000000 : "NFTL_Part"

[    2.956480] aml_nftl_check_node Line:119 blk_addr:0  have node length over MAX, and node_len_actual:9
[    2.987411] aml_nftl_check_node Line:119 blk_addr:1  have node length over MAX, and node_len_actual:9
[    3.013214] aml_nftl_check_node Line:119 blk_addr:2  have node length over MAX, and node_len_actual:8
[    3.037299] nftl initilize completely dev size: 0x97800000 21
[    3.038078]  avnftl8: p1
[    3.040581] nftl release flush cache data: 0
