 sudo apt-get install --yes --force-yes git autoconf curl g++ zlib1g-dev libcurl4-openssl-dev gawk gperf libtool autopoint swig default-jre

     git clone https://github.com/raspberrypi/tools
     sudo cp -r tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64 /opt

     git clone https://github.com/raspberrypi/firmware
     sudo mkdir -p /opt/bcm-rootfs/opt
     sudo cp -r firmware/opt/vc /opt/bcm-rootfs/opt

     sudo mkdir -p /opt/kodi-bcm
     sudo chmod 777 /opt/kodi-bcm

     git clone https://github.com/xbmc/xbmc

     cd xbmc/tools/depends
     ./bootstrap
     PATH="PATH:/opt/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin" \
       ./configure --host=arm-linux-gnueabihf \
       --prefix=/opt/kodi-bcm/kodi-dbg \
       --with-toolchain=/usr/local/bcm-gcc/arm-bcm2708hardfp-linux-gnueabi/sysroot \
       --with-firmware=/opt/bcm-rootfs \
       --with-platform=raspberry-pi2 \
       --build=i686-linux

     make
     cd ../..

    CONFIG_EXTRA="--with-platform=raspberry-pi2 \
       --enable-libcec --enable-player=omxplayer \
       --disable-x11 --disable-xrandr --disable-openmax \
       --disable-optical-drive --disable-dvdcss --disable-joystick \
       --disable-crystalhd --disable-vtbdecoder --disable-vaapi \
       --disable-vdpau --enable-alsa" \
       make -C tools/depends/target/xbmc

     make
     sudo make install
