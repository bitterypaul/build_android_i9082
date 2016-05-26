 
MODULES=frost/codekidX/lib/modules
USER=codekidX
DEVICE=I9082
VERSION=-marshmallow-2.5
CODENAME=-marshion-2.5
DATE=$(date '+%Y%m%d')
Kernel="arch/arm/boot/zImage"

 
chmod +x clean.sh
./clean.sh  


if [ ! -d "toolchain-backup" ]; then
mkdir toolchain-backup
cd toolchain-backup
git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/arm/arm-eabi-4.8.git -b android-6.0.1_r43
cd ..
fi

mkdir toolchain 
cp -r toolchain-backup/* toolchain
  
export ARCH=arm 
export CROSS_COMPILE=$(pwd)/toolchain/arm-eabi-4.8/bin/arm-eabi-
 
make frost_lollipop_defconfig
 
make CONFIG_DEBUG_SECTION_MISMATCH=y -j2
 
if [ -f $Kernel ]
	then
mkdir frost/codekidX
cd frost/codekidX
mkdir lib
mkdir app
cd lib
mkdir modules
cd ../../..
find -name '*.ko' -exec cp {} $MODULES \;
cp prebuilt_modules/VoiceSolution.ko $MODULES
cp prebuilt_modules/KernelAdiutor.apk frost/codekidX/app 
cp $Kernel frost/kernel 
cd frost
zip -r frost-$DATE-$DEVICE-$CODENAME.zip  
rm -rf kernel/zImage
rm -rf codekidX
cd ..
rm -rf toolchain
make clean mrproper
git checkout drivers/misc/vc04_services/interface/vchiq_arm/vchiq_version.c
clear 
fi
