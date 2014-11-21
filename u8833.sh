#!/bin/bash
# 
# Script to prepare the huawei y300 build

# get the device specific local manifest
cd $CM_DIR/.repo
git clone https://github.com/mawatech/u8833_manifest.git local_manifests

# sync the tree
cd $CM_DIR
repo sync -j 8 -f -d

. build/envsetup.sh

device/huawei/msm7x27a-common/patches/apply.sh

device/huawei/u8833/patches/apply.sh

echo call ". build/envsetup.sh" and "brunch u8833" now

exit 0