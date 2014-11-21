#!/bin/bash
# 
# Script to checkout and prepare the cm build

cd $CM_DIR

if [ $CM_ARCHIVE_ENABLED -ne 0 ]; then
	7z -y x $CM_ARCHIVE_DIR/$CM_ARCHIVE_NAME -o$CM_DIR
	repo sync -j 8 -d -f
else
	# initialize the cyanogenmod tree
	repo init -u git://github.com/CyanogenMod/android.git -b $CM_VERSION
	repo sync -j 8
fi

# get the prebuilts
cd $CM_DIR/vendor/cm
./get-prebuilts

# set the ccache size
cd $CM_DIR
prebuilts/misc/linux-x86/ccache/ccache -M $CCACHE_RAMDISK_SIZE

exit 0