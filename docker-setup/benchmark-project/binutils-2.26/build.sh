#!/bin/bash
URL="http://ftp.gnu.org/gnu/binutils/binutils-2.26.tar.gz"
DIRNAME="binutils-2.26"
ARCHIVE=$DIRNAME".tar.gz"
CONFIG_OPTIONS="--disable-shared --disable-gdb --disable-libdecnumber --disable-readline --disable-sim --disable-ld"

wget $URL -O $ARCHIVE
rm -rf $DIRNAME
tar -xzf $ARCHIVE || exit 1
cd $DIRNAME

./configure $CONFIG_OPTIONS || exit 1


## sed with $BUG_NAME and $STR_TYPE


patch -p0 < $(dirname $0)/patches/$TOOL/${BUG_NAME}_${STR_TYPE}.patch

## Parallel building according to https://github.com/aflgo/aflgo/issues/59
## Although an issue with parallel building is observed in libxml (https://github.com/aflgo/aflgo/issues/41), 
## We have not yet encountered a problem with binutils.
make -j || exit 1
cd ../
cp $DIRNAME/binutils/cxxfilt ./cxxfilt || exit 1
