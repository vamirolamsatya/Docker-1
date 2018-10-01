#
# Dockerfile for BFGMiner/FutureBit Moonlander 2
#
# More info: 
#  * https://github.com/jstefanop/bfgminer
#  * https://bitcointalk.org/index.php?topic=2420357.msg24766858#msg24766858
#

FROM       debian:9.5
MAINTAINER 0x03 <0x03-ctrlc@protonmail.com>

# Install prerequisites
RUN apt update; apt -y upgrade; \
    apt -y install -y build-essential autoconf automake libtool pkg-config git \
    libusb-1.0-0 libusb-1.0-0-dev libjansson4 libjansson-dev libgmp10 libgmp-dev \
    libcurl3 libcurl4-openssl-dev libssl1.0.2 libssl-dev libgcrypt20 libgcrypt20-dev \
    libevent-2.0.5 libevent-dev uthash-dev libncurses5 libncurses5-dev

# Get sources and build, install
RUN git clone -b futurebit2_driver https://github.com/jstefanop/bfgminer /usr/src/bfgminer && \
    cd /usr/src/bfgminer && ./gen-version.sh && ./autogen.sh && \
    ./configure CFLAGS="-O3" --prefix=/usr --with-curses --with-libusb --enable-scrypt --enable-futurebit --disable-sha256d --disable-other-drivers && \
    make -j$(nproc) && make install

# Cleanup
RUN apt -y purge build-essential autoconf automake libtool pkg-config git \
    libusb-1.0-0-dev libjansson-dev libgmp-dev libgmp-dev \
    libcurl4-openssl-dev libssl-dev libgcrypt2-dev \
    libevent-dev uthash-dev libncurses5-dev; \
    apt -y autoremove; apt -y autoclean; apt -y clean; \
    rm -rf /var/lib/apt/lists/*; rm -rf /usr/src/bfgminer


WORKDIR "/tmp"
ENTRYPOINT ["/usr/bin/bfgminer", "--scrypt"]
