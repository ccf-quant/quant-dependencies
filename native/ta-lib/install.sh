#!/bin/bash

VERSION=0.4.0

set -e

if [ -x "/usr/local/include/ta-lib/" ]; then
    exit 0
fi

mkdir /tmp/ta-lib-${VERSION}
wget -O /tmp/ta-lib-${VERSION}/ta-lib.tgz http://prdownloads.sourceforge.net/ta-lib/ta-lib-${VERSION}-src.tar.gz
cd /tmp/ta-lib-${VERSION}
tar xzvf ta-lib.tgz
cd ta-lib

./configure
make
sudo make install
