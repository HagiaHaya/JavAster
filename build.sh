# Measure time
start=$(date +%s)
# Make it faster to write
export Scripts=prebuilts/Scripts
export Boot=prebuilts/Bootable
export CROSS_COMPILE=prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-UB-4.9/bin/arm-linux-androideabi-
# Delete things from last build
make clean
make mrproper
rm -rf boot && rm -rf out
# Time to make kernel zImage
make ARCH=arm lineageos_shinano_leo_defconfig
make ARCH=arm CROSS_COMPILE=$CROSS_COMPILE -j8
mkdir out
# Time to make kernel booting
perl $Scripts/split_boot $Scripts/boot.img 
./$Scripts/mkbootimg --kernel arch/arm/boot/zImage-dtb --ramdisk boot/boot.img-ramdisk.cpio.gz --base 0x00000000 --ramdisk_offset 0x02000000 --tags_offset 0x01E00000 --pagesize 2048 --cmdline "androidboot.hardware=qcom ehci-hcd.park=3 dwc3.maximum_speed=high dwc3_msm.prop_chg_detect=Y" -o out/boot.img
# On the other hand, we can make bootable zip. It's simple.
cp -r $Boot/META-INF out/META-INF
cp -r $Boot/magisk out/magisk
cd out && zip -r JavKernel.zip *
# Print some things
echo -e "\e[96m--------------------------"
echo -e "\e[96mYour \e[91mBootImage \e[96mis \e[96min \e[96mout \e[96mdir"
echo -e "\e[96m--------------------------"
end=$(date +%s)
runtime=$(python -c "print '%u:%02u' % ((${end} - ${start})/60, (${end} - ${start})%60)")
echo -e "\e[96mBuild \e[96mtook \e[91m$runtime"
echo -e "\e[96m--------------------------"
