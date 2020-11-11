#!/bin/bash

VERSION=0.4.0

set -e

if [ -x "/usr/local/include/ta-lib/" ]; then
    exit 0
fi

wget -O /tmp/ta-lib-${VERSION}.tgz http://prdownloads.sourceforge.net/ta-lib/ta-lib-${VERSION}-src.tar.gz
cd /tmp
tar xzvf /tmp/ta-lib-${VERSION}.tgz
cd /tmp/ta-lib-${VERSION}

./configure
make
sudo make install
