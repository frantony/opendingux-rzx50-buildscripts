#!/bin/bash
#
# rzx50 framework
# (c) 2012, Antony Pavlov
#
# cross toolchain build script (crosstool-ng wrapper)
# see http://crosstool-ng.org

CT_NG_BUILD_CFG=$1
if [ ! -f "$CT_NG_BUILD_CFG" ]; then
	echo "no file $CT_NG_BUILD_CFG"
	exit 1
fi

CT_NG_BUILD_CFG=$(cd $(dirname $CT_NG_BUILD_CFG); pwd)/$(basename $CT_NG_BUILD_CFG)

. $DIST_DIR/functions

. $CT_NG_BUILD_CFG

BUILD_DIR=$TMP_DIR/$TC_CFG-build-toolchain

run_with_check rm -rf $BUILD_DIR
run_with_check mkdir -p $BUILD_DIR

run_with_check pushd $BUILD_DIR

run_with_check tar vfx $CT_NG_SRC
run_with_check pushd $CT_NG

if [ "$MAKE_J" != "" ]; then
	CT_NG_BUILD_J=".$MAKE_J"
else
	CT_NG_BUILD_J=""
fi

for i in $CT_NG_PATCHES; do
	echo patch -p1 "<" $i
	patch -p1 < $i
	if [ "$?" != 0 ]; then
		exit 1
	fi
done

#if ct-ng < 1.14
#	run_with_check ./configure --local
#else
	run_with_check ./bootstrap
	run_with_check ./configure --enable-local
#fi

run_with_check make
run_with_check cp $CT_NG_CONFIG .config

if [ -e $DIST_DIR/src ]; then
	sed -i "s#^CT_LOCAL_TARBALLS_DIR=.*\$#CT_LOCAL_TARBALLS_DIR=\"$DIST_DIR/src\"#" .config
fi

sed -i "s#^CT_PREFIX_DIR=.*\$#CT_PREFIX_DIR=\"$PREFIX\"#" .config

if [ "$CT_NG_LIBC_CFG" != "" ]; then
	run_with_check cp $CT_NG_LIBC_CFG .
fi

run_with_check ./ct-ng oldconfig
run_with_check ./ct-ng build$CT_NG_BUILD_J

TC_CP_CFG=$PREFIX/crosstool-ng.$TC_CFG.config/
run_with_check chmod +w $PREFIX
run_with_check mkdir -p ${TC_CP_CFG}

run_with_check cp .config ${TC_CP_CFG}/crosstool.config
if [ "$CT_NG_LIBC_CFG" != "" ]; then
	run_with_check cp $CT_NG_LIBC_CFG ${TC_CP_CFG}/
fi
if [ -f $(dirname $CT_NG_BUILD_CFG)/reported.by ]; then
	run_with_check cp $(dirname $CT_NG_BUILD_CFG)/reported.by ${TC_CP_CFG}/
fi
run_with_check popd

run_with_check popd

