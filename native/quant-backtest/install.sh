#!/bin/bash

set -e

SOURCE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cp "${SOURCE_DIR}/dist/qe-backtest" /usr/local/bin/qe-backteset
