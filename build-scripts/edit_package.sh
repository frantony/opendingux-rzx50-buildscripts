#!/bin/bash

TMP_DIR=tmp

mkdir -p $TMP_DIR
PACKAGE_FILE=$1

if [ ! -f "$PACKAGE_FILE" ]; then
	echo "Usage:"
	echo "  edit_package.sh <package file>"
	exit 1
fi

tar vx -C $TMP_DIR -f $PACKAGE_FILE

pushd $TMP_DIR
bash
popd

echo -n "save package [Y/n]?"
read A
if [ "$A" = "Y" ]; then
	tar cz -C $TMP_DIR -f $PACKAGE_FILE .
fi

rm -rf $TMP_DIR
