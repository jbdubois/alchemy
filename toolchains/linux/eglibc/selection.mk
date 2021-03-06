###############################################################################
## @file toolchains/linux/eglibc/selection.mk
## @author Y.M. Morgan
## @date 2016/03/05
##
## Setup toolchain variables.
###############################################################################

ifndef TARGET_CROSS
  ifeq ("$(TARGET_ARCH)","arm")
    ifeq ("$(TARGET_CPU)","p6")
      TARGET_CROSS := /opt/arm-2009q1/bin/arm-none-linux-gnueabi-
    else ifeq ("$(TARGET_CPU)","p6i")
      TARGET_CROSS := /opt/arm-2009q1/bin/arm-none-linux-gnueabi-
    else ifeq ("$(TARGET_CPU)","o3")
      TARGET_CROSS := /opt/arm-2015.02-ct-ng/bin/arm-unknown-linux-gnueabi-
    else
      TARGET_CROSS := /opt/arm-2012.03/bin/arm-none-linux-gnueabi-
    endif
  else ifeq ("$(TARGET_ARCH)","aarch64")
      TARGET_CROSS := /opt/arm-2016.02-aarch64-linaro/bin/aarch64-linux-gnu-
  endif
endif

# TODO: move this in autotools setup
# Machine targetted by toolchain to be used by autotools
# Use a name that will force autotools to believe we are cross-compiling
# Do nothing for non chroot native build with TARGET_ARCH = HOST_ARCH
ifeq ("$(TARGET_OS_FLAVOUR)-$(TARGET_ARCH)","native-$(HOST_ARCH)")
  # Leave GNU_TARGET_NAME undefined
else ifeq ("$(subst -chroot,,$(TARGET_OS_FLAVOUR))","native")
  # Native with foreign architecture or native chroot
  ifeq ("$(TARGET_ARCH)","x64")
    GNU_TARGET_NAME := x86_64-pc-linux-gnu
  else ifeq ("$(TARGET_ARCH)","x86")
    GNU_TARGET_NAME := i686-pc-linux-gnu
  endif
else
  # Not a native flavour
  ifeq ("$(TARGET_ARCH)","x64")
    GNU_TARGET_NAME := x86_64-none-linux-gnu
  else ifeq ("$(TARGET_ARCH)","x86")
    GNU_TARGET_NAME := i686-none-linux-gnu
  endif
endif
