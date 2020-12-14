#!/bin/bash

set -e

docker build -t quant-dependencies-backtest .
docker run -v "$(pwd)":"$(pwd)" -w "$(pwd)" \
    quant-dependencies-backtest \
    bash compile_internal.sh
