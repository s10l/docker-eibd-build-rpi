#!/bin/bash
export BUILD_PATH=/eibdbuild
mkdir -p $BUILD_PATH
cd $BUILD_PATH

export RASPBERRY_CROSS_COMPILER=$BUILD_PATH/raspPiTools
mkdir -p $RASPBERRY_CROSS_COMPILER
cd $RASPBERRY_CROSS_COMPILER

#git clone git://github.com/raspberrypi/tools.git

PATH=$PATH:$RASPBERRY_CROSS_COMPILER/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin

arm-linux-gnueabihf-gcc -v
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$RASPBERRY_CROSS_COMPILER/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/arm-linux-gnueabihf/libc/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$RASPBERRY_CROSS_COMPILER/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/arm-linux-gnueabihf/libc/lib/arm-linux-gnueabihf

#cp $RASPBERRY_CROSS_COMPILER/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/arm-linux-gnueabihf/libc/lib/ld-linux-armhf.so.3 /lib/

export TARGET_ARCH=arm-linux-gnueabihf

export BUILD_ROOT=$BUILD_PATH/build

cd $BUILD_PATH
mkdir pthsem
cd pthsem
#wget http://www.auto.tuwien.ac.at/~mkoegler/pth/pthsem_2.0.8.tar.gz
tar -xvzf pthsem_2.0.8.tar.gz
cd pthsem-2.0.8
./configure \
	--enable-static=yes \
	--build=i386-linux-gnu \
	--target=$TARGET_ARCH \
	--host=$TARGET_ARCH \
	--prefix=$BUILD_ROOT \
	CC="$TARGET_ARCH-gcc" \
	CFLAGS="-static -static-libgcc -static-libstdc++ -marm -mfpu=vfp -mfloat-abi=hard -march=armv6zk -mtune=arm1176jzf-s" \
	--with-mctx-mth=sjlj \
	--with-mctx-dsp=ssjlj \
	--with-mctx-stk=sas \
	LDFLAGS="-static -static-libgcc -static-libstdc++"
	
make && make install

export LD_LIBRARY_PATH=$BUILD_ROOT/lib:$LD_LIBRARY_PATH

cd $BUILD_PATH
mkdir bcusdk
cd bcusdk
#wget http://netcologne.dl.sourceforge.net/project/bcusdk/bcusdk/bcusdk_0.0.5.tar.gz
tar -xvzf bcusdk_0.0.5.tar.gz
cd bcusdk-0.0.5

./configure \
	--enable-onlyeibd \
	--enable-tpuarts \
	--enable-tpuart \
	--enable-ft12 \
	--enable-eibnetip \
	--enable-eibnetiptunnel \
	--enable-eibnetipserver \
	--enable-groupcache \
	--enable-static=yes \
	--build=i386-linux-gnu \
	--target=$TARGET_ARCH \
	--host=$TARGET_ARCH \
	--prefix=$BUILD_ROOT \
	--with-pth=$BUILD_ROOT \
	--without-pth-test \
	CC="$TARGET_ARCH-gcc" \
	CFLAGS="-static -static-libgcc -static-libstdc++ -marm  -mfpu=vfp -mfloat-abi=hard -march=armv6zk -mtune=arm1176jzf-s" \
	LDFLAGS="-static -static-libgcc -static-libstdc++ -s" \
	CPPFLAGS="-static -static-libgcc -static-libstdc++ -Os -fmerge-constants"

make && make install

ls -l $BUILD_ROOT/bin

cd $BUILD_ROOT/bin