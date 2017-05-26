export CROSS_COMPILE=/home/javaster/JavKernel/prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-UB-4.9/bin/arm-linux-androideabi-
make ARCH=arm lineageos_shinano_leo_defconfig
make ARCH=arm CROSS_COMPILE=$CROSS_COMPILE -j8
