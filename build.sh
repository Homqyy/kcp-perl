#!/bin/bash

#
# Copyright (c) homqyy
#

#################################### global variable

G_PROJECT_DIR=`cd $( dirname $0 ); pwd`

G_KCP_SRC_DIR=$G_PROJECT_DIR/kcp-src
G_KCP_BUILD_DIR=$G_KCP_SRC_DIR/build

G_PERL_KCP_DIR=$G_PROJECT_DIR/KCP

#################################### function

function usage
{
    echo "Usage: $0 [OPTIONS] [ACTION]
OPTIONS:
  -h            : help

ACTION: [configure|compile|test|install|clean]
  configure : configure the code
  compile   : compile the code
  test      : test the code
  install   : pack library, header and config of cmake.
  clean     : clean" >& 2
}

function configure
{
    echo "configure..."

    cmake -B ${G_KCP_BUILD_DIR} -S ${G_KCP_SRC_DIR} -DCMAKE_C_FLAGS="-fPIC" \
        || return 1

    # for kcp module
    error=0
    cd ${G_PERL_KCP_DIR} && perl ${G_PERL_KCP_DIR}/Makefile.PL \
        || error=1
    cd -

    return $error
}

function compile
{
    echo "compile..."

    make -C ${G_KCP_BUILD_DIR} \
        || return 1

    # buildin library and header
    cp $G_KCP_SRC_DIR/ikcp.h $G_KCP_BUILD_DIR/libkcp.a $G_PERL_KCP_DIR \
        || return 1

    make -C ${G_PERL_KCP_DIR}
}

function test_case
{
    echo "test..."

    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$G_KCP_BUILD_DIR"

    make -C ${G_PERL_KCP_DIR} test
}

function install
{
    echo "install..."

    make -C ${G_PERL_KCP_DIR} install
}

function clean
{
    echo "clean..."

    [ -d ${G_KCP_BUILD_DIR} ] && rm -rf ${G_KCP_BUILD_DIR}

    make -C ${G_PERL_KCP_DIR} clean
}

############################################### main

while getopts :h opt
do
    case $opt in
        h)
        usage
        exit 0;
            ;;
        '?')
            error_msg "$0: invalid option -$OPTARG"
            usage
            exit 1
            ;;
    esac
done

shift $(($OPTIND - 1))

if [[ $# -eq 1 ]]; then
    action=$1

    case $action in
        configure)
            configure
            ;;
        compile)
            compile
            ;;
        test)
            test_case
            ;;
        install)
            install
            ;;
        clean)
            clean
            ;;
        *)
            usage
            exit 1
    esac
elif [[ $# -gt 1 ]]; then
    error_msg "arguments too much"
    usage
    exit 1
else
    configure && compile && test_case && install
fi