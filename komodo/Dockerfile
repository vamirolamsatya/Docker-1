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

RUN apt-get -y install build-essential libtool pkg-config autoconf automake \
                       bsdmainutils libcurl4-openssl-dev curl wget git

RUN useradd -m -d /home/komodo -s /bin/bash komodo

USER komodo
                       
RUN git clone https://github.com/jl777/komodo -b dev ~/komodo-src
RUN cd ~/komodo-src && ./zcutil/fetch-params.sh
RUN cd ~/komodo-src && ./zcutil/build.sh -j$(nproc --ignore=2)

RUN mkdir ~/bin
RUN cp ~/komodo-src/src/komodod ~/bin
RUN cp ~/komodo-src/src/komodo-tx ~/bin
RUN cp ~/komodo-src/src/komodo-cli ~/bin
RUN strip ~/bin/komodo*

RUN rm -rf ~/komodo-src

RUN mkdir ~/.komodo

RUN echo rpcuser=komodo >> ~/.komodo/komodo.conf
RUN echo rpcpassword=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)  >> ~/.komodo/komodo.conf
RUN echo server=1 >> ~/.komodo/komodo.conf
RUN echo listen=1 >> ~/.komodo/komodo.conf
RUN echo txindex=1 >> ~/.komodo/komodo.conf

USER root

RUN apt-get -y purge  build-essential libtool pkg-config autoconf automake \
                      bsdmainutils libcurl4-openssl-dev curl wget git
RUN apt-get -y autoremove
RUN apt-get -y autoclean
RUN apt-get -y clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER komodo
VOLUME "/home/komodo"
ENTRYPOINT ["/home/komodo/bin/komodod", "-daemon"]

