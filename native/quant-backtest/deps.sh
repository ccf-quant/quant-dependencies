#!/bin/bash

set -e

apt-get update
apt-get -y install cmake libboost-all-dev libpq-dev libhiredis-dev
