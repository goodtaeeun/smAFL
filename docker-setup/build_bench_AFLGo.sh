#!/bin/bash

. $(dirname $0)/build_bench_common.sh

# arg1 : Target project
# arg2 : Inserting condition type
# arg3 : Fuzzing targets
function build_with_AFLGo() {
    CC="/fuzzer/AFLGo/afl-clang-fast"
    CXX="/fuzzer/AFLGo/afl-clang-fast++"

    export STR_TYPE=$2
    cd /benchmark

    str_array=($3)
    BIN_NAME=${str_array[0]}

    for BUG_NAME in "${str_array[@]:1}"; do
        export BUG_NAME=$BUG_NAME
        ### Draw CFG and CG with BBtargets
        mkdir -p /benchmark/temp
        # SUBJECT=$PWD
        TMP_DIR=/benchmark/temp
        cp /benchmark/target/stack-trace/$BIN_NAME/$BUG_NAME-$STR_TYPE $TMP_DIR/BBtargets.txt

        ADDITIONAL="-targets=$TMP_DIR/BBtargets.txt \
                    -outdir=$TMP_DIR -flto -fuse-ld=gold \
                    -Wl,-plugin-opt=save-temps"
        build_target $1 $CC $CXX "$ADDITIONAL"
        # find /benchmark/RUNDIR-$1 -name "config.cache" -exec rm -rf {} \;

        cat $TMP_DIR/BBnames.txt | rev | cut -d: -f2- | rev | sort | uniq > $TMP_DIR/BBnames2.txt \
        && mv $TMP_DIR/BBnames2.txt $TMP_DIR/BBnames.txt
        cat $TMP_DIR/BBcalls.txt | sort | uniq > $TMP_DIR/BBcalls2.txt \
        && mv $TMP_DIR/BBcalls2.txt $TMP_DIR/BBcalls.txt

        ### Compute Distances based on the graphs
        cd /benchmark/RUNDIR-$1
        /fuzzer/AFLGo/scripts/genDistance.sh $PWD $TMP_DIR $BIN_NAME

        ### Build with distance info.
        cd /benchmark
        rm -rf /benchmark/RUNDIR-$1
        build_target $1 $CC $CXX "-fsanitize=address -distance=$TMP_DIR/distance.cfg.txt"

        ### copy results
        copy_build_result $1 $BIN_NAME $BUG_NAME $STR_TYPE "AFLGo"
        rm -rf /benchmark/RUNDIR-$1
        rm -rf /benchmark/temp
    done
}

# Build with AFLGo
mkdir -p /benchmark/bin/AFLGo
build_with_AFLGo "binutils-2.26" "original" \
    "cxxfilt 2016-4487 2016-4489 2016-4490 2016-4492"

build_with_AFLGo "binutils-2.26" "strcmp" \
    "cxxfilt 2016-4487 2016-4489 2016-4490 2016-4492"

build_with_AFLGo "binutils-2.26" "strstr" \
    "cxxfilt 2016-4487 2016-4489 2016-4490 2016-4492"

build_with_AFLGo "binutils-2.26" "atoi" \
    "cxxfilt 2016-4487 2016-4489 2016-4490 2016-4492"
