#!/bin/bash

. $(dirname $0)/build_bench_common.sh

# arg1 : Target project
# arg2 : Inserting condition type
# arg3 : Fuzzing targets
function build_with_AFL() {
    CC="/fuzzer/AFL/afl-clang-fast"
    CXX="/fuzzer/AFL/afl-clang-fast++"

    export STR_TYPE=$2
    cd /benchmark

    str_array=($3)
    BIN_NAME=${str_array[0]}

    for BUG_NAME in "${str_array[@]:1}"; do
        export BUG_NAME=$BUG_NAME
        build_target $1 $CC $CXX "-fsanitize=address"
        copy_build_result $1 $BIN_NAME $BUG_NAME $STR_TYPE "AFL"
    done

    rm -rf RUNDIR-$1 || exit 1
}

# Build with AFL
mkdir -p /benchmark/bin/AFL
build_with_AFL "binutils-2.26" "original" \
    "cxxfilt 2016-4487 2016-4489 2016-4490 2016-4492"

build_with_AFL "binutils-2.26" "strcmp" \
    "cxxfilt 2016-4487 2016-4489 2016-4490 2016-4492"

build_with_AFL "binutils-2.26" "strstr" \
    "cxxfilt 2016-4487 2016-4489 2016-4490 2016-4492"

build_with_AFL "binutils-2.26" "atoi" \
    "cxxfilt 2016-4487 2016-4489 2016-4490 2016-4492"