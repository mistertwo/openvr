#!/bin/bash

# For 32 bit
#ARCHFLAG="-m32"
#ARCH=32

# For 64 bit
ARCH=64

# For debugging
#EXTRAARGS="-O0 -ggdb"

EXTRAARGS="-march=native -Ofast -flto"

cd samples/shared
echo "Build pathtools"
g++ $ARCHFLAG pathtools.cpp -DLINUX=1 -std=c++11 -ldl -fPIC -shared -Wl,-soname,libpathtools.so -o libpathtools.so $EXTRAARGS
echo "Build lodepng"
g++ $ARCHFLAG lodepng.cpp -std=c++11 -ldl -fPIC -shared -Wl,-soname,liblodepng.so -o liblodepng.so $EXTRAARGS
echo "Build Matrices"
g++ $ARCHFLAG Matrices.cpp -std=c++11 -ldl -fPIC -shared -Wl,-soname,libMatrices.so -o libMatrices.so $EXTRAARGS
echo "Copy libraries to lib/linux$ARCH"
cp libpathtools.so liblodepng.so libMatrices.so ../../lib/linux$ARCH

cd ../hellovr_opengl
echo "Build hellovr"
g++ $ARCHFLAG hellovr_opengl_main.cpp -I/usr/include/SDL2 -I../../headers/ -I../../samples -DCOMPILER_GCC=1 -DLINUX=1 -std=c++11 -lGL -lGLEW -lSDL2 -L../../lib/linux$ARCH/ -lopenvr_api -lpathtools -llodepng -lMatrices -o hellovr $EXTRAARGS

