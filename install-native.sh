#!/bin/bash

set -e

for name in ta-lib; do
(
    bash native/ta-lib/install.sh
);
done

ldconfig -v
