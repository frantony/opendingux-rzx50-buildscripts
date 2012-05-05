#!/bin/bash
#
# rzx50 framework
# (c) 2012, Antony Pavlov
#

WORK_DIR=$(pwd)/out/rzx50-20120320/
PACKAGES_DIR=$(pwd)/packages

PACKAGES_CFG=$1
if [ ! -f "$PACKAGES_CFG" ]; then
	echo "no file $PACKAGES_CFG"
	exit 1
fi

PACKAGES_CFG=$(cd $(dirname $PACKAGES_CFG); pwd)/$(basename $PACKAGES_CFG)

. $DIST_DIR/functions

. $PACKAGES_CFG

BUILD_DIR=$TMP_DIR/$TC_CFG-build-toolchain


pack()
{
	PACK_CFG=$1
	if [ ! -f "$PACK_CFG" ]; then
		echo "no file $PACK_CFG"
		exit 1
	fi

	. $PACK_CFG

	echo $PACK_NAME
	#echo PACK_NAME=$PACK_NAME
	#echo PACK_FILES=$PACK_FILES

	mkdir -p $PACKAGES_DIR
	tar cz -f $PACKAGES_DIR/$PACK_NAME.tar.gz -C $WORK_DIR $PACK_FILES
}

	#kernel-2.6.34 \
	#kernel-2.6.34-modules \
for i in \
	kexec-static \
	rootfs \
	local \
	; do
	pack configs/$i
done
