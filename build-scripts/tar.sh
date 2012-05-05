#!/bin/bash
#
# clab framework
# (c) 2011, Antony Pavlov
#
# script for making tar archive of clab sources.
#

TAR_EXCLUDE=tar.exclude
DIRNAME=$(basename $(pwd))
ARCNAME=$DIRNAME.tar.gz

echo src > $TAR_EXCLUDE
echo core >> $TAR_EXCLUDE
echo out >> $TAR_EXCLUDE
echo $TAR_EXCLUDE >> $TAR_EXCLUDE
echo $ARCNAME >> $TAR_EXCLUDE

tar cvzf $ARCNAME -C .. $DIRNAME --totals -X $TAR_EXCLUDE
rm $TAR_EXCLUDE
