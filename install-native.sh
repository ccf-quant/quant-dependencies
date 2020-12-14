#!/bin/bash

set -e

##################
# quant-backtest #
##################
# gcc-8
bash native/quant-backtest/gcc-8/install.sh
ldconfig -v

# pqxx
bash native/quant-backtest/pqxx/install.sh
ldconfig -v

# backtest
bash native/quant-backtest/install.sh

##########
# ta-lib #
##########
bash native/ta-lib/install.sh
ldconfig -v
