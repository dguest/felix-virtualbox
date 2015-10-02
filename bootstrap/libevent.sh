#!/usr/bin/env bash
set -eu

(
    mkdir -p build/libevent
    cd build/libevent
    wget https://github.com/downloads/libevent/libevent/libevent-2.0.21-stable.tar.gz
    tar xf libevent-2.0.21-stable.tar.gz
    cd libevent-2.0.21-stable
    ./configure && make
    make install
    ldconfig
)
