    echo -e "Making marmite zImage\n"
    export PATH=$PATH:/opt/toolchain3/bin/
    export ARCH=arm
    export SUBARCH=arm
    export CROSS_COMPILE=arm-cortex_a8-linux-gnueabi-

# delete everything
#rm -fR kernelinjector.oxp/structure.new/modules/*
#rm -f kernelinjector.oxp/zImage.new/zImage

# cd kernelinjector.oxp
# sh extract
# cd ..

rm ./.config

git apply -R cm_ioctrl.patch

# make
make bedalus_defconfig
make -j7

# copy modules
find ./ -type f -name '*.ko' -exec cp -f {} ../marmite_zip/system/modules \;

# copy zImage
cp -f arch/arm/boot/zImage ../marmite_zip/kernel/

cd ../marmite_zip
zip -r ../marmite.zip * > /dev/null 2>&1
mv ../marmite.zip ../../Documents_OSX/
cd ../marmite

cp ./.config ./arch/arm/configs/slim_defconfig
rm ./.config
