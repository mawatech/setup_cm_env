# define the different directories

export BASE_DIR=/mnt
export CM_DIR=$BASE_DIR/android/system
export SECOND_PARTITION=/dev/xvdc
export SECOND_PARTITION_MOUNTPOINT=$CM_DIR/out
export OUT_DIR=$CM_DIR/out

# we create the inital tree by unpacking an archive
# this is faster then the inital checkout
export CM_ARCHIVE_ENABLED=1 # load the inital repo from an archive
export CM_ARCHIVE_PARTITION=/dev/xvdf1
export CM_ARCHIVE_DIR=$HOME/archive
export CM_ARCHIVE_NAME=cmrepo.7z

export PACKAGES_TO_INSTALL="openjdk-7-jdk \
					 git git-core gnupg flex bison gperf libsdl1.2-dev \
					 libesd0-dev libwxgtk2.8-dev squashfs-tools \
					 build-essential zip curl libncurses5-dev zlib1g-dev \
					 pngcrush schedtool libxml2 libxml2-utils xsltproc \
					 g++-multilib lib32z1-dev lib32ncurses5-dev \
					 lib32readline-gplv2-dev gcc-multilib p7zip-full"

sudo mkdir -p $SECOND_PARTITION_MOUNTPOINT
sudo mount $SECOND_PARTITION $SECOND_PARTITION_MOUNTPOINT
sudo chown -R ubuntu: $SECOND_PARTITION_MOUNTPOINT

# create the directories
mkdir -p ~/bin
sudo mkdir -p $CM_DIR
sudo mkdir -p $OUT_DIR

sudo mount -t tmpfs -o size=2G none /tmp

sudo mkdir -p $CM_ARCHIVE_DIR
sudo mount $CM_ARCHIVE_PARTITION $CM_ARCHIVE_DIR

# ensure we can write into the directories
sudo chown -R ubuntu: $CM_DIR
sudo chown -R ubuntu: $CCACHE_DIR
sudo chown -R ubuntu: $OUT_DIR
sudo chown -R ubuntu: $CM_ARCHIVE_DIR

sudo touch /etc/apt/sources.list.d/sources.list
sudo chown ubuntu: /etc/apt/sources.list.d/sources.list

cat << EOF > /etc/apt/sources.list.d/sources.list
	deb http://eu-central-1b.clouds.archive.ubuntu.com/ubuntu/ trusty main universe restricted multiverse
	deb-src http://eu-central-1b.clouds.archive.ubuntu.com/ubuntu/ trusty main universe restricted multiverse

	deb http://eu-central-1b.clouds.archive.ubuntu.com/ubuntu/ trusty-updates main universe restricted multiverse
	deb-src http://eu-central-1b.clouds.archive.ubuntu.com/ubuntu/ trusty-updates main universe restricted multiverse

	deb http://security.ubuntu.com/ubuntu trusty-security main universe restricted multiverse
	deb-src http://security.ubuntu.com/ubuntu trusty-security main universe restricted multiverse

	deb http://archive.canonical.com/ubuntu trusty partner
	deb-src http://archive.canonical.com/ubuntu trusty partner
EOF

# install needed packages
sudo add-apt-repository -y ppa:git-core/ppa
sudo apt-get update
sudo apt-get -y install $PACKAGES_TO_INSTALL

# download the repo command and make it executable
curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo

# export needed env variables
echo 'export PATH=${PATH}:~/bin' >> ~/.bashrc

source ~/.bashrc

cd $CM_DIR

7z -y x $CM_ARCHIVE_DIR/$CM_ARCHIVE_NAME -o$CM_DIR

repo init -u git://github.com/CyanogenMod/android.git -b cm-12.0

cd $CM_DIR/.repo
git clone https://github.com/mawatech/u8833_manifest.git local_manifests

cd $CM_DIR
repo sync -j 8 -d -f

# get the prebuilts
cd $CM_DIR/vendor/cm
./get-prebuilts

echo call \"source ~/.bashrc \&\& source build/envsetup.sh\" now

exit 0