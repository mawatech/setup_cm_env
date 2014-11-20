#!/bin/bash
# 
# Script to checkout and prepare the cm build

BASE_DIR=$HOME
CM_DIR=$BASE_DIR/android/system

# initialize the cyanogenmod tree
cd $CM_DIR
repo init -u git://github.com/CyanogenMod/android.git -b cm-11.0
repo sync

# get the prebuilts
cd $CM_DIR/vendor/cm
./get-prebuilts

# set the ccache size
cd $CM_DIR
prebuilts/misc/linux-x86/ccache/ccache -M $CCACHE_RAMDISK_SIZE

exit 0