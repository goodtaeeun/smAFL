#!/bin/bash

. $(dirname $0)/build_bench_common.sh

# arg1 : Target project
# arg2 : Inserting condition type
# arg3 : Fuzzing targets
function build_with_ASAN() {
    export STR_TYPE=$2
    cd /benchmark

    str_array=($3)
    BIN_NAME=${str_array[0]}

    for BUG_NAME in "${str_array[@]:1}"; do
        export BUG_NAME=$BUG_NAME
        build_target $1 "clang" "clang++" "-fsanitize=address"
        copy_build_result $1 $BIN_NAME $BUG_NAME $STR_TYPE "ASAN"
    done

    rm -rf RUNDIR-$1 || exit 1
}

# Build with ASAN only
mkdir -p /benchmark/bin/ASAN

export TOOL="ASAN"
build_with_ASAN "binutils-2.26" "original" \
    "cxxfilt 2016-4487 2016-4489 2016-4490 2016-4492"
