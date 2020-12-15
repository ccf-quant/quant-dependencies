#!/bin/bash

set -e

SOURCE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cp "${SOURCE_DIR}/dist/qe-backtest" /usr/local/bin/qe-backtest
cp "${SOURCE_DIR}/dist/qe-backtest-cache.py" /usr/local/bin/qe-backtest-cache.py
chmod +x /usr/local/bin/qe-backtest
chmod +x /usr/local/bin/qe-backtest-cache.py
