1. /sys/class interface

    error = class_register(&jun); //error == 0: successful
	
	struct class jun = {
 	    .name = "jun",  // will have "/sys/class/jun" dir
	    .class_attrs = jun_class_attrs,
	};

    struct class_attribute jun_class_attrs = {
		__ATTR(jun_file, 0644, jun_file_show, jun_file_store), // will have "/sys/class/jun_file" file
		...
		__ATTR_NULL,
	};

	ssize_t jun_file_show(struct class *class, struct class_attribute *attr, char *buf) {...}
	ssize_t jun_file_store(struct class *class, struct class_attribute *attr, const char *buf, size_t count) {...}


