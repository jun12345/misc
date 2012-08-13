JNI
===

Java中在成员方法前用上native，表明实现是相应的c/c++。所以，只要声明。
  for example:
    frameworks/base/core/java/android/os/Power.java: 声明
    frameworks/base/core/jni/android_os_Power.cpp: 实现


shutdown,reboot, and so on
==========================

frameworks/base/core/java/com/android/internal/app/ShutdownThread.java: rebootOrShutdown() calls
	Power.shutdown()

frameworks/base/core/java/android/os/Power.java: native method "shutdown"

frameworks/base/core/jni/android_os_Power.cpp: shutdown()(implements Power.java's shutdown) calls
	android_reboot()

system/core/libcutils/android_reboot.c: android_reboot() calls
    reboot() or __reboot()

bionic/libc/include/sys/reboot.h declares:
    reboot() and __reboot()
bionic/libc/arch-arm/syscalls/__reboot.S has the above two function definition

