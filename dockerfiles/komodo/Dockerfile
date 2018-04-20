#
# Bitcoin-sCrypt Dockerfile
# https://github.com/bitcoin-scrypt/bitcoin-scrypt
#
FROM ubuntu:16.04
MAINTAINER 0x03 <0x03-ctrlc@protonmail.com>
EXPOSE 7770:7770/tcp 7771:7771/tcp

HEALTHCHECK --interval=1m --timeout=10s \
   CMD curl -sf http://127.0.0.1:30200 | grep Unauthorized

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y dist-upgrade

RUN apt-get -y install libssl-dev build-essential git wget curl autoconf automake
RUN useradd -m -d /home/komodo -s /bin/bash komodo

USER komodo
                       
RUN git clone https://github.com/jl777/komodo ~/komodo
RUN cd ~/komodo && git checkout mergemaster
RUN cd ~/komodo && ./zcutil/fetch-params.sh
RUN cd ~/komodo && ./zcutil/build.sh -j$(nproc --ignore=2)


VOLUME "/home/komodo"
