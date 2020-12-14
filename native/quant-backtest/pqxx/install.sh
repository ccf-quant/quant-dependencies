#!/bin/bash

VERSION=7.2.1
URL=https://github.com/jtv/libpqxx/archive/${VERSION}.zip

set -e

if [ -x "/usr/local/include/pqxx" ]; then
    exit 0
fi

mkdir -p /tmp/pqxx-${VERSION}
wget -c -O /tmp/pqxx-${VERSION}/pqxx.zip "${URL}"
cd /tmp/pqxx-${VERSION}
rm -rf libpqxx-${VERSION}
7z x pqxx.zip
cd libpqxx-${VERSION}

./configure
make
make install
