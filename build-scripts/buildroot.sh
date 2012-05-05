#!/bin/bash
#
# rzx50 framework
# (c) 2012, Antony Pavlov
#
# buildroot-rzx50 script
#

BUILDROOT_BUILD_CFG=$1
if [ ! -f "$BUILDROOT_BUILD_CFG" ]; then
	echo "no file $BUILDROOT_BUILD_CFG"
	exit 1
fi

BUILDROOT_BUILD_CFG=$(cd $(dirname $BUILDROOT_BUILD_CFG); pwd)/$(basename $BUILDROOT_BUILD_CFG)

. $DIST_DIR/functions

. $BUILDROOT_BUILD_CFG

BUILD_DIR=$TMP_DIR/$TC_CFG-build-buildroot-rzx50

if [ "1" = "1" ]; then
run_with_check rm -rf $BUILD_DIR
run_with_check mkdir -p $BUILD_DIR
fi

run_with_check pushd $BUILD_DIR

if [ "1" = "1" ]; then
run_with_check tar vfx $BUILDROOT_SRC
fi

run_with_check pushd $BUILDROOT

if [ "1" = "1" ]; then

for i in $BUILDROOT_PATCHES; do
	echo patch -p1 "<" $i
	patch -p1 < $i
	if [ "$?" != 0 ]; then
		exit 1
	fi
done

run_with_check cp $BUILDROOT_CONFIG .config
run_with_check rm -rf src
run_with_check ln -s $DIST_DIR/src
run_with_check make oldconfig
run_with_check make
fi
set -x
pwd
run_with_check cp output/images/rootfs.ext2 $OUT_DIR/
run_with_check rm -rf $OUT_DIR/local
run_with_check cp -a output/dingux-local $OUT_DIR/local

#extra copy
run_with_check cp output/images/rootfs.ext2 $OUT_DIR/rootfs

run_with_check popd

run_with_check popd
