#!/bin/bash

PACKAGES_CFG=$1

if [ ! -e "$PACKAGES_CFG" ]; then
	echo "no file $PACKAGES_CFG"
	exit 1
fi

PACKAGES_CFG=$(cd $(dirname $PACKAGES_CFG); pwd)/$(basename $PACKAGES_CFG)

. $DIST_DIR/functions

. $PACKAGES_CFG

pack()
{
	PACKAGE_CONF=$1
	if [ ! -f "$PACKAGE_CONF" ]; then
		echo "no file $PACKAGE_CONF"
		exit 1
	fi

	. $PACKAGE_CONF

	#echo PACK_NAME=$PACK_NAME
	#echo PACK_FILES=$PACK_FILES

	echo packing $PACK_NAME ...

	mkdir -p $PACKAGES_DIR
	tar cz -f $PACKAGES_DIR/$PACK_NAME.tar.gz -C $WORK_DIR $PACK_FILES
	if [ "$?" != "0" ]; then
		exit 1
	fi
}

echo "PACKAGES_LIST=$PACKAGES_LIST"

for i in $(cat $PACKAGES_LIST | grep -v "^#"); do
	t=$(dirname $PACKAGES_LIST)/$i
	if [ -f "$t" ]; then
		pack $t
	else
		echo "ERROR: the file $i is absent"
		exit 1
	fi
done
