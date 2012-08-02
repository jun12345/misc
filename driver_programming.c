1. /sys/class interface

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



2. /sys/devices interface

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
