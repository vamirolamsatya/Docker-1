#
# Dockerfile for bfgminer/MLD2, https://github.com/jstefanop/bfgminer
#

FROM       debian:9.4
MAINTAINER 0x03 <0x03-ctrlc@protonmail.com>

RUN	apt-get update && apt-get install -y build-essential autoconf automake libtool pkg-config git libusb-1.0-0 libusb-1.0-0-dev libjansson-dev libgmp-dev libcurl4-openssl-dev libssl-dev libevent-dev libgcrypt20-dev uthash-dev libncurses5-dev

RUN	cd /usr/src && git clone https://github.com/jstefanop/bfgminer && cd bfgminer && git checkout futurebit2_driver && ./gen-version.sh && ./autogen.sh
RUN cd /usr/src/bfgminer && ./configure CFLAGS="-O3" --prefix=/opt/bfgminer --with-curses --with-libusb --enable-scrypt --enable-futurebit --disable-sha256d --disable-other-drivers
RUN	cd /usr/src/bfgminer && make -j$(nproc) && make install

WORKDIR "/usr/src/bfgminer"
ENTRYPOINT ["./bfgminer"]

