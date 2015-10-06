#!/usr/bin/env bash
set -eu

svn co svn+ssh://dguest@svn.cern.ch/reps/FELIX/hostSoftware

if [[ -d pib ]] ; then
    rm -rf pib
fi

# get and install IB emulator
git clone https://github.com/nminoru/pib.git
# HACK to use newer kernel version
K1=/usr/src/kernels/3.10.0-229.14.1.el7.x86_64/
K2=/usr/src/kernels/3.10.0-229.11.1.el7.x86_64
sudo ln -s $K1 $K2
(
    cd pib/driver/
    make
    sudo make modules_install
)

# build the rpm
if [[ -d rpmbuild ]] ; then
    rm -rf rpmbuild
fi
(
    VERSION=0.4.6
    cp -r pib/driver pib-$VERSION
    mkdir -p ${HOME}/rpmbuild/SOURCES/
    tar czvf ${HOME}/rpmbuild/SOURCES/pib-${VERSION}.tar.gz pib-${VERSION}/
    cp pib/driver/pib.conf ${HOME}/rpmbuild/SOURCES/
    cp pib/driver/pib.files ${HOME}/rpmbuild/SOURCES/
    rpmbuild -bs pib/driver/pib.spec

    SRPMNAME=pib-${VERSION}-1.el7.centos.src.rpm
    rpmbuild --rebuild ${HOME}/rpmbuild/SRPMS/${SRPMNAME}
    RPMNAME=pib-debuginfo-${VERSION}-1.el7.centos.x86_64.rpm
    sudo rpm -ihv ${HOME}/rpmbuild/RPMS/x86_64/${RPMNAME}
)

# userspace plugin
(
    VERSION=0.0.6
    echo building userspace plugin
    cp -r pib/libpib libpib-${VERSION}
    mkdir -p ${HOME}/rpmbuild/SOURCES/
    tar czvf ${HOME}/rpmbuild/SOURCES/libpib-${VERSION}.tar.gz \
	libpib-${VERSION}/
    rpmbuild -bs pib/libpib/libpib.spec

    SRPMNAME=libpib-${VERSION}-1.el7.centos.src.rpm
    rpmbuild --rebuild ${HOME}/rpmbuild/SRPMS/${SRPMNAME}
    RPMNAME=libpib-${VERSION}-1.el7.centos.x86_64.rpm
    sudo rpm -ihv ${HOME}/rpmbuild/RPMS/x86_64/${RPMNAME}
)
