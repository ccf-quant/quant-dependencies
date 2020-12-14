#!/bin/bash

set -e

for name in ta-lib; do
(
    if [ "${SUDO}" = "1" ]; then
        bash native/ta-lib/install.sh
    fi
);
done

ldconfig -v
