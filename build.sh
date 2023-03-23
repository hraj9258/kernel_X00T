#!/bin/bash

# Colours
blue='\033[0;34m'
cyan='\033[0;36m'
yellow='\033[0;33m'
red='\033[0;31m'
green='\033[32m'
nocol='\033[0m'

# Params
KERNEL_DEFCONFIG=vendor/phoenix_user_defconfig
BUILD_START=$(date +"%s")

echo ""
# Compilation
echo -e "$yellow Compiling the kernel $nocol"


export PATH="$(pwd)/../proton-clang/bin:$PATH"
export ARCH=arm64

make O=out clean
make O=out mrproper
make O=out sdm660-perf_defconfig

make -j$(nproc --all) \
     O=out \
     ARCH=arm64 \
     CC=clang \
     CROSS_COMPILE=aarch64-linux-gnu- \
     CROSS_COMPILE_ARM32=arm-linux-gnueabi-

echo ""
BUILD_END=$(date +"%s")
DIFF=$(($BUILD_END - $BUILD_START))
echo -e "$blue ########## Kernel Compiled in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds ##########$nocol"
echo ""