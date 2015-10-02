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
# has to be built...
# yum install -y libevent
