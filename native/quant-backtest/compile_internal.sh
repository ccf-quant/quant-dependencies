#!/bin/bash

set -e

cd ./quant-backtest/cpp
mkdir -p cmake-build-release
cd cmake-build-release
cmake -DCMAKE_BUILD_TYPE=Release .. && make

mkdir -p ../../../dist
cp qe-backtest ../../../dist/qe-backtest
cp ../scripts/cache_tool.py ../../../dist/qe-backtest-cache.py
