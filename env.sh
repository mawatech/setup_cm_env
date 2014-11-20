# define the different directories
# the default config creates all directories in HOME
BASE_DIR=$HOME
CM_DIR=$BASE_DIR/android/system
OUT_DIR=$CM_DIR/out
CCACHE_DIR=$HOME/.ccache
CM_ARCHIVE_PARTITION=/dev/sdf1
CM_ARCHIVE_DIR=$BASE_DIR/mnt
CM_ARCHIVE_NAME=cmrepo.7z

# configure ramdisk usage
# needs a lot of RAM (!!!)
CM_RAMDISK_ENABLED=1 # should we use a ramdisk for the cm repo?
CM_RAMDISK_SIZE=30G # a CM11 tree needs at least 26 GB of memory
OUT_RAMDISK_ENABLED=1 # should we use a ramdisk for out?
OUT_RAMDISK_SIZE=25G # at least 22 GB
CCACHE_RAMDISK_ENABLED=1 # should we use a ramdisk for the ccache?
CCACHE_RAMDISK_SIZE=50G # the ccache constantly grows, 50 GB should be enough
CM_ARCHIVE_ENABLED=1 # load the inital repo from an archive

PACKAGES_TO_INSTALL="oracle-java7-installer oracle-java7-set-default \
					 git git-core gnupg flex bison gperf libsdl1.2-dev \
					 libesd0-dev libwxgtk2.8-dev squashfs-tools \
					 build-essential zip curl libncurses5-dev zlib1g-dev \
					 pngcrush schedtool libxml2 libxml2-utils xsltproc \
					 g++-multilib lib32z1-dev lib32ncurses5-dev \
					 lib32readline-gplv2-dev gcc-multilib p7zip-full"