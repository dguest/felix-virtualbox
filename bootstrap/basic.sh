#!/usr/bin/env bash
set -eu

yum update -y
yum install -y git
yum install -y boost
yum install -y svn
yum install -y cmake
yum install -y gcc
