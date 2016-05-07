git clone https://github.com/bitterypaul/samsung_i9082_local_manifests.git -b cm-13.0-webviewfix local_manifest_i9082
mv local_manifest_i9082/local_manifest.xml .repo/local_manifest.xml
rm -r local_manifest_i9082
repo sync

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
