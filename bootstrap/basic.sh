#!/usr/bin/env bash
set -eu

yum update -y
yum install -y git
yum install -y wget
yum install -y boost
yum install -y svn
yum install -y cmake
yum install -y gcc-c++
yum install -y boost-devel
yum install -y tbb-devel
yum install -y librdmacm-devel
yum install -y net-tools
yum install -y gdb

# has to be built...
# yum install -y libevent

# stuff for IB emulator
yum install -y kernel-devel
yum install -y opensm-devel
yum install -y libibverbs-utils
yum install -y librdmacm-utils
yum install -y infiniband-diags
yum install -y rpm-build
