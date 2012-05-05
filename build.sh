#!/bin/bash

BUILD_TOOLCHAIN_FLAG="no"
BUILD_QEMU_FLAG="no"

CLEAN_OUT_DIR="no"
BUILD_FIRMWARE_FLAG="no"
BUILD_LINUX_FLAG="no"
BUILD_ROOTFS_FLAG="no"
BUILD_PACKAGES_FLAG="no"
MAKE_OD_ARCHIVE_FLAG="no"


do_help() {
    cat <<__EOF__
\`build.sh'

USAGE: ./build.sh <OPTION>...

Configuration:
  -h, --help              display this help and exit
  --build-toolchain       build and install toolchain
  --clean-out-dir         clean 'out' directory
                          remove compiled firmware, linux and rootfs
  --build-linux           build linux kernel and install it to 'out'
  --build-rootfs          build linux rootfs and install it to 'out'
                          rootfs contain busybox and dropbear
  --build-packages        make packages for 'out' files
  --make-od-archive

  --config <file>         get options from <file>

__EOF__
}

if [ $# -eq 0 ]; then
	do_help
	exit 1
fi

while [ $# -ne 0 ]; do
    case "$1" in
        --build-toolchain) BUILD_TOOLCHAIN_FLAG="yes"; shift;;
        --clean-out-dir)   CLEAN_OUT_DIR="yes"; shift;;
        --build-firmware)  BUILD_FIRMWARE_FLAG="yes"; shift;;
        --build-linux)     BUILD_LINUX_FLAG="yes"; shift;;
        --build-rootfs)    BUILD_ROOTFS_FLAG="yes"; shift;;
        --build-packages)  BUILD_PACKAGES_FLAG="yes"; shift;;
        --make-od-archive) MAKE_OD_ARCHIVE_FLAG="yes"; shift;;
        --config)          shift; BUILD_CFG=$1; shift;;

        --help|-h|*)       printf "Unrecognised option: '${1}'\n"; do_help; exit 1;;
    esac
done

if [ ! -f "$BUILD_CFG" ]; then
	echo "no config file $BUILD_CFG"
	exit 1
fi

BUILD_CFG=$(cd $(dirname $BUILD_CFG); pwd)/$(basename $BUILD_CFG)

. $BUILD_CFG

. functions

# force -j make option
#export MAKE_J=8

export ARCH
export VENDOR
export PREFIX
export TC_CFG
export CROSS_COMPILE

# build and install toolchain and emulator.
# the programs will be installed to PREFIX.
if [ "$BUILD_TOOLCHAIN_FLAG" = "yes" ]; then
	# if PREFIX exists then clean it.
	if [ -e $PREFIX ]; then
		# if toolchain was build with option <<read-only toolchain>>
		# make it writable.
		run_with_check chmod -R +w $PREFIX
		run_with_check rm -rf $PREFIX
	fi

	run_with_check build-scripts/toolchain.sh $BUILD_TOOLCHAIN_CONFIG
fi

# build and install software that will be runned on RZX-50
# this software will be installed to OUT_DIR.

if [ "$CLEAN_OUT_DIR" = "yes" ]; then
	# if OUT_DIR exists then clean it.
	if [ -e $OUT_DIR ]; then
		run_with_check chmod -R +w $OUT_DIR
		run_with_check rm -rf $OUT_DIR
	fi
fi

run_with_check mkdir -p $OUT_DIR

if [ "$BUILD_LINUX_FLAG" = "yes" ]; then
	run_with_check build-scripts/linux.sh $BUILD_LINUX_CONFIG
fi

if [ "$BUILD_ROOTFS_FLAG" = "yes" ]; then
#	if [ "$BUILD_KEXEC_TOOLS_CONFIG" != "" ]; then
#		run_with_check build-scripts/kexec-tools.sh $BUILD_KEXEC_TOOLS_CONFIG
#	fi

	run_with_check build-scripts/buildroot.sh $BUILDROOT_CONFIG
fi

if [ "$BUILD_PACKAGES_FLAG" = "yes" ]; then
	run_with_check build-scripts/make_packages.sh $BUILD_CFG
fi

if [ "$MAKE_OD_ARCHIVE_FLAG" = "yes" ]; then
	run_with_check build-scripts/make_od_archive.sh $BUILD_CFG
fi
