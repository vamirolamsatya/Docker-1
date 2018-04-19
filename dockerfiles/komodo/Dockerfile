#
# Bitcoin-sCrypt Dockerfile
# https://github.com/bitcoin-scrypt/bitcoin-scrypt
#
FROM ubuntu:16.04
MAINTAINER 0x03 <0x03-ctrlc@protonmail.com>
EXPOSE 7770:7770/tcp 7771:7771/tcp

ENV BTCS_BUILD_GITHUB="https://github.com/bitcoin-scrypt/bitcoin-scrypt" \
    BTCS_BUILD_SRCDIR="/usr/src/bitcoin-scrypt" \
    BTCS_OUT_BINARY="/usr/local/bin/bitcoin-scryptd" \
    BTCS_USER_NAME="bitcoin-scrypt" \
    BTCS_USER_HOMEDIR="/home/bitcoin-scrypt" \
    BTCS_CONF_DIR="/home/bitcoin-scrypt/.bitcoin-scrypt" \
    BTCS_CONF_FILE="bitcoin-scrypt.conf"

HEALTHCHECK --interval=1m --timeout=10s \
   CMD curl -sf http://127.0.0.1:30200 | grep Unauthorized


RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y dist-upgrade

RUN apt-get -y install libboost-system1.58-dev libboost-filesystem1.58-dev \
                       libboost-program-options1.58-dev libboost-thread1.58-dev \
                       libdb4.8++-dev libssl-dev build-essential git

RUN git clone https://github.com/jl777/komodo /usr/src/komodo
RUN cd /usr/src/komodo && ./zcutil/fetch-params.sh
RUN cd /usr/src/komodo && ./zcutil/build.sh -j$(nproc --ignore=1)
