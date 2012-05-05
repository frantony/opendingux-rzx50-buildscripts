#!/bin/bash

PACKAGES_CFG=$1

if [ ! -e "$PACKAGES_CFG" ]; then
	echo "no file $PACKAGES_CFG"
	exit 1
fi

PACKAGES_CFG=$(cd $(dirname $PACKAGES_CFG); pwd)/$(basename $PACKAGES_CFG)

. $DIST_DIR/functions

. $PACKAGES_CFG

TMP_DIR=$PACKAGES_DIR/tmp

mkdir -p $TMP_DIR

if [ ! -e "$OD_ARCHIVE_CONFIG" ]; then
	echo "Usage:"
	echo "  make_local.sh <config file>"
	exit 1
fi

for i in $(cat $OD_ARCHIVE_CONFIG | grep -v "^#"); do
	tar vx -C $TMP_DIR -f $PACKAGES_DIR/$i.tar.gz
	if [ "$?" != "0" ]; then
		exit
	fi
done

tar cz --owner=root --group=root -C $TMP_DIR -f $OD_ARCHIVE_NAME .

rm -rf $TMP_DIR
