#!/bin/bash
# 
# Script to setup the environment for a cm build

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

if [ $CM_ARCHIVE_ENABLED -ne 0 ]; then
	sudo mkdir -p $CM_ARCHIVE_DIR
	sudo mount /dev/sdf1 $CM_ARCHIVE_DIR
fi

# ensure we can write into the directories
sudo chown -R ubuntu: $CM_DIR
sudo chown -R ubuntu: $CCACHE_DIR
sudo chown -R ubuntu: $OUT_DIR
sudo chown -R ubuntu: $CM_ARCHIVE_DIR

# install needed packages
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get update
sudo apt-get -y install $PACKAGES_TO_INSTALL

# download the repo command and make it executable
curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo

# export needed env variables
echo 'export PATH=${PATH}:~/bin' >> ~/.bashrc
echo "export USE_CCACHE=1" >> ~/.bashrc

echo call "source ~/.bashrc" now

exit 0
