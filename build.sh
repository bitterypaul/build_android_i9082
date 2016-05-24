sudo apt-get update
sudo apt-get install openjdk-7-jdk
sudo apt-get install git-core gnupg flex bison gperf build-essential zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev ccache libgl1-mesa-dev libxml2-utils xsltproc unzip maven schedtool

sudo wget https://storage.googleapis.com/git-repo-downloads/repo -O /usr/local/bin/repo
chmod 777 /usr/local/bin/repo
mkdir ~/cm13
cd ~/cm13
repo init -u https://github.com/CyanogenMod/android.git -b cm-13.0

repo sync -j12
git clone https://github.com/bitterypaul/samsung_i9082_local_manifests.git -b cm-13.0 .repo/local_manifests 

rm .repo/local_manifests/LICENSE.md
rm .repo/local_manifests/README.md
repo sync --force-sync -j32

cd build_tools
./patch
cd ..

mkdir /home/vignesh/ccache
export USE_CCACHE=1
export CCACHE_DIR=/home/vignesh/ccache

ccache -M 50G

echo "add_lunch_combo cm_i9082-userdebug" > device/samsung/i9082/vendorsetup.sh
. build/envsetup.sh
brunch i9082
