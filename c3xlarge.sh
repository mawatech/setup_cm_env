# define the different directories
# the default config creates all directories in HOME
export BASE_DIR=/mnt
export CM_DIR=$BASE_DIR/android/system
export OUT_DIR=$SECOND_PARTITION_MOUNTPOINT/out
export CCACHE_DIR=$HOME/.ccache
export CM_ARCHIVE_PARTITION=/dev/xvdf1
export CM_ARCHIVE_DIR=$HOME/archive
export CM_ARCHIVE_NAME=cmrepo.7z

export SECOND_PARTITION=/dev/xvdc
export SECOND_PARTITION_MOUNTPOINT=/mnt2

# configure ramdisk usage
# needs a lot of RAM (!!!)
export CM_RAMDISK_ENABLED=0 # should we use a ramdisk for the cm repo?
export CM_RAMDISK_SIZE=30G # a CM11 tree needs at least 26 GB of memory
export OUT_RAMDISK_ENABLED=0 # should we use a ramdisk for out?
export OUT_RAMDISK_SIZE=25G # at least 22 GB
export CCACHE_RAMDISK_ENABLED=0 # should we use a ramdisk for the ccache?
export CCACHE_RAMDISK_SIZE=5G # the ccache constantly grows, 50 GB should be enough
export CM_ARCHIVE_ENABLED=1 # load the inital repo from an archive

export PACKAGES_TO_INSTALL="oracle-java7-installer oracle-java7-set-default \
					 git git-core gnupg flex bison gperf libsdl1.2-dev \
					 libesd0-dev libwxgtk2.8-dev squashfs-tools \
					 build-essential zip curl libncurses5-dev zlib1g-dev \
					 pngcrush schedtool libxml2 libxml2-utils xsltproc \
					 g++-multilib lib32z1-dev lib32ncurses5-dev \
					 lib32readline-gplv2-dev gcc-multilib p7zip-full"
