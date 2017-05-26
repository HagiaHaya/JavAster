export CROSS_COMPILE=/home/javaster/JavKernel/prebuilts/gcc/linux-x86/arm/arm-linux-eabi-UB-4.8/bin/arm-eabi-
make ARCH=arm lineageos_shinano_leo_defconfig
make ARCH=arm CROSS_COMPILE=$CROSS_COMPILE -j8
