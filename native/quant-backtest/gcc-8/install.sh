#!/bin/bash

if [ "$(gcc -v | grep 'gcc version 8')" = "" ]; then
    apt-get remove -y build-essential gcc-7 g++-7

    apt-get install -y \
        dpkg-dev libc-dev libc6-dev libstdc++-7-dev libstdc++-8-dev \
        gcc-8 g++-8 \
        autoconf make cmake \
        tmux screen zsh htop iotop htop wget \
        git gnuplot sqlite unzip p7zip-full
    
    update-alternatives --remove-all gcc
    update-alternatives --remove-all g++

    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 50
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-8 50

    update-alternatives --install /usr/bin/cc cc /usr/bin/gcc 50
    update-alternatives --set cc /usr/bin/gcc

    update-alternatives --install /usr/bin/c++ c++ /usr/bin/g++ 50
    update-alternatives --set c++ /usr/bin/g++
fi
