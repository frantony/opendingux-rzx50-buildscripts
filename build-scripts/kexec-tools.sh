#!/bin/bash
#
# clab framework
# (c) 2012, Antony Pavlov
#
# build script for kexec-tools.
# see https://github.com/horms/kexec-tools.git
#

KEXEC_TOOLS_BUILD_CFG=$1
if [ ! -f "$KEXEC_TOOLS_BUILD_CFG" ]; then
	echo "no file $KEXEC_TOOLS_BUILD_CFG"
	exit 1
fi

KEXEC_TOOLS_BUILD_CFG=$(cd $(dirname $KEXEC_TOOLS_BUILD_CFG); pwd)/$(basename $KEXEC_TOOLS_BUILD_CFG)

. $DIST_DIR/functions

. $KEXEC_TOOLS_BUILD_CFG

BUILD_DIR=$TMP_DIR/$VENDOR-build-kexec-tools

if [ "$MAKE_J" != "" ]; then
	KEXEC_TOOLS_MAKE_J="-j $MAKE_J"
else
	KEXEC_TOOLS_MAKE_J=""
fi

run_with_check rm -rf $BUILD_DIR
run_with_check mkdir -p $BUILD_DIR

run_with_check pushd $BUILD_DIR
run_with_check tar vfx $KEXEC_TOOLS_SRC
run_with_check pushd $KEXEC_TOOLS
run_with_check ./configure --prefix=/usr $KEXEC_TOOLS_CONFIGURE_OPTS CC=${CROSS_COMPILE}gcc
#run_with_check make $KEXEC_TOOLS_MAKE_J install DESTDIR=_install CROSS_COMPILE=$CROSS_COMPILE

# FIXME: -static dirty hack
run_with_check make $KEXEC_TOOLS_MAKE_J "LIBS=\"-lz -static\"" build/sbin/kexec CROSS_COMPILE=$CROSS_COMPILE
run_with_check ${CROSS_COMPILE}strip build/sbin/kexec
run_with_check cp build/sbin/kexec $OUT_DIR/kexec

run_with_check popd

run_with_check mv $KEXEC_TOOLS/_install $KEXEC_TOOLS/$KEXEC_TOOLS.$TC_CFG._install
run_with_check tar czf $OUT_DIR/$KEXEC_TOOLS.$TC_CFG._install.tar.gz -C $KEXEC_TOOLS $KEXEC_TOOLS.$TC_CFG._install
chmod -x $OUT_DIR/$KEXEC_TOOLS.$TC_CFG.*
run_with_check popd
