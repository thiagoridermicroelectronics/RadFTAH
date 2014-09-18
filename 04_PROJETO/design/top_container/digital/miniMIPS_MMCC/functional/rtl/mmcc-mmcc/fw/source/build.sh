export CC=gcc-3.3
export DIR=/mips_tools
mkdir $DIR
cp ./gcc-3.3.1.tar.bz2 $DIR/.
cp ./binutils-2.14.tar.bz2 $DIR/.
cp ./newlib-1.11.0.tar.gz $DIR/.
cd $DIR
tar -xvjf gcc-3.3.1.tar.bz2
tar -xvjf binutils-2.14.tar.bz2
tar -xvzf newlib-1.11.0.tar.gz
export ARCH=mips
mkdir build-$ARCH-binutils
cd build-$ARCH-binutils 
../binutils-2.14/configure --prefix=$DIR/$ARCH --target=$ARCH-elf
make
make install
cd ..
PATH=$PATH:$PWD/$ARCH/bin
ln -s $PWD/newlib-1.11.0/newlib/ $PWD/gcc-3.3.1/newlib
mkdir build-$ARCH-gcc-3.3.1; cd build-$ARCH-gcc-3.3.1
../gcc-3.3.1/configure --prefix=$DIR/$ARCH --target=$ARCH-elf --with-gnu-as --with-gnu-ld --with-newlib --enable-languages=c++,c
make
make install
cd ..
mkdir build-$ARCH-newlib-1.11.0; cd build-$ARCH-newlib-1.11.0
../newlib-1.11.0/configure --prefix=$DIR/$ARCH --target=$ARCH-elf
make
make install
cd ..
rm -R build-mips*
rm -R gcc-3.3.1*
rm -R binutils-2.14*
rm -R newlib-1.11.0*