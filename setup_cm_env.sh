#!/bin/bash
# 
# Script to setup the environment for a cm build

# define the different directories
# the default config creates all directories in HOME
BASE_DIR=$HOME
CM_DIR=$BASE_DIR/android/system
OUT_DIR=$CM_DIR/out
CCACHE_DIR=$HOME/.ccache

# configure ramdisk usage
# needs a lot of RAM (!!!)
CM_RAMDISK_ENABLED=1 # should we use a ramdisk for the cm repo?
CM_RAMDISK_SIZE=30G # a CM11 tree needs at least 26 GB of memory
OUT_RAMDISK_ENABLED=1 # should we use a ramdisk for out?
OUT_RAMDISK_SIZE=25G # at least 22 GB
CCACHE_RAMDISK_ENABLED=1 # should we use a ramdisk for the ccache?
CCACHE_RAMDISK_SIZE=50G # the ccache constantly grows, 50 GB should be enough

# create the directories
mkdir -p ~/bin
sudo mkdir -p $CM_DIR
sudo mkdir -p $OUT_DIR
mkdir -p $CCACHE_DIR

# if enabled, mount the ramdisks
if [ $CM_RAMDISK_ENABLED -ne 0 ]; then
	sudo mount -t tmpfs -o size=$CM_RAMDISK_SIZE none $CM_DIR
fi

if [ $OUT_RAMDISK_ENABLED -ne 0 ]; then
	sudo mount -t tmpfs -o size=$OUT_RAMDISK_SIZE none $OUT_DIR
fi

if [ $CCACHE_RAMDISK_ENABLED -ne 0 ]; then
	sudo mount -t tmpfs -o size=$CCACHE_RAMDISK_SIZE none $CCACHE_DIR
fi

# ensure we can write into the directories
sudo chown -R ubuntu: $CM_DIR
sudo chown -R ubuntu: $CCACHE_DIR
sudo chown -R ubuntu: $OUT_DIR

# install needed packages
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get update
sudo apt-get -y install oracle-java7-installer oracle-java7-set-default git git-core gnupg flex bison gperf libsdl1.2-dev libesd0-dev libwxgtk2.8-dev squashfs-tools build-essential zip curl libncurses5-dev zlib1g-dev pngcrush schedtool libxml2 libxml2-utils xsltproc g++-multilib lib32z1-dev lib32ncurses5-dev lib32readline-gplv2-dev gcc-multilib

# download the repo command and make it executable
curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo

# export needed env variables
echo 'export PATH=${PATH}:~/bin' >> ~/.bashrc
echo "export USE_CCACHE=1" >> ~/.bashrc
echo "export CCACHE_RAMDISK_SIZE=$CCACHE_RAMDISK_SIZE" >> ~/.bashrc

echo call "source ~/.bashrc" now

exit 0
