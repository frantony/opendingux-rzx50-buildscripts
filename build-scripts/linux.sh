#!/bin/bash
#
# rzx50 framework
# (c) 2012, Antony Pavlov
#
# build script for linux.
#
# see http://www.kernel.org
#     http://www.linux-mips.org

LINUX_BUILD_CFG=$1
if [ ! -f "$LINUX_BUILD_CFG" ]; then
	echo "no file $LINUX_BUILD_CFG"
	exit 1
fi

LINUX_BUILD_CFG=$(cd $(dirname $LINUX_BUILD_CFG); pwd)/$(basename $LINUX_BUILD_CFG)

. $DIST_DIR/functions

. $LINUX_BUILD_CFG

BUILD_DIR=$TMP_DIR/$VENDOR-build-linux

run_with_check rm -rf $BUILD_DIR
run_with_check mkdir -p $BUILD_DIR

run_with_check pushd $BUILD_DIR

run_with_check tar vfx $LINUX_SRC | grep "/$"

run_with_check pushd $LINUX
run_with_check cp $LINUX_CONFIG .config

for i in $LINUX_PATCHES; do
	run_with_check patch -p1 < $i
done

run_with_check make oldconfig ARCH=$LINUX_ARCH

if [ "$MAKE_J" != "" ]; then
	LINUX_MAKE_J="-j $MAKE_J"
else
	LINUX_MAKE_J=""
fi

run_with_check tar vfx ${LINUX_MININIT_SRC}
run_with_check cd $LINUX_MININIT
run_with_check make CROSS=$CROSS_COMPILE
run_with_check mkdir tmp
run_with_check cd tmp
run_with_check sudo tar fx ../initrd_skeleton.tar.bz2
run_with_check sudo mknod dev/mmcblk1 b 179 8
run_with_check sudo mknod dev/mmcblk1p1 b 179 9
run_with_check cp ../init .
# FIXME
find | cpio -H newc --create > ../../initrd.cpio
run_with_check cd ../..
run_with_check sudo rm -rf $LINUX_MININIT

run_with_check make $LINUX_MAKE_J vmlinux ARCH=mips CROSS_COMPILE=$CROSS_COMPILE
#run_with_check make $LINUX_MAKE_J uImage ARCH=mips CROSS_COMPILE=$CROSS_COMPILE
run_with_check make $LINUX_MAKE_J modules ARCH=mips CROSS_COMPILE=$CROSS_COMPILE

LOUT_DIR=$OUT_DIR/$LINUX$LINUX_SUFFIX
run_with_check mkdir -p $LOUT_DIR

run_with_check cp vmlinux $LOUT_DIR/vmlinux$LINUX_SUFFIX
run_with_check cp .config $LOUT_DIR/config$LINUX_SUFFIX
run_with_check cp System.map $LOUT_DIR/System.map$LINUX_SUFFIX
#run_with_check cp arch/mips/boot/uImage $LOUT_DIR/uImage$LINUX_SUFFIX
${CROSS_COMPILE}objdump -D vmlinux > $LOUT_DIR/vmlinux.dis$LINUX_SUFFIX
run_with_check make $LINUX_MAKE_J modules_install \
	INSTALL_MOD_PATH=$LOUT_DIR ARCH=mips CROSS_COMPILE=$CROSS_COMPILE

#extra copy
run_with_check cp vmlinux $OUT_DIR

run_with_check mkdir -p $OUT_DIR/local/lib/modules
find -P $LOUT_DIR -iname '*ko' -exec cp -v {} $OUT_DIR/local/lib/modules ';'

run_with_check popd

run_with_check popd
