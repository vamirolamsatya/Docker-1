#
# BarterDEX/marketmaker Dockerfile
# https://github.com/jl777/SuperNET
#
FROM debian:9.4
MAINTAINER 0x03 <0x03-ctrlc@protonmail.com>
EXPOSE 0-65535:0-65535/tcp

ARG PASSPHRASE="the very best default passphrase money cannot buy"

HEALTHCHECK --interval=1m --timeout=10s \
   CMD curl -sf http://127.0.0.1:7783

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install libcurl4-openssl-dev build-essential cmake curl wget pax libleveldb-dev git vim libtool autoconf automake bsdmainutils pkg-config

RUN cd /usr/src && \
    git clone https://github.com/nanomsg/nanomsg && \
    cd nanomsg && \
    ./configure --prefix=/usr/local && \
    make && \
    make install && \
    ldconfig

RUN useradd -m -d /home/barterdex -s /bin/bash barterdex
USER barterdex

RUN cd /home/barterdex && \
    git clone https://github.com/jl777/SuperNET && \
    cd /home/barterdex/SuperNET && \
    git checkout dev && \
    cd /home/barterdex/SuperNET/iguana/exchanges && \
    ./install

RUN cd /home/barterdex/SuperNET/iguana/dexscripts && \
    echo "export passphrase=\"${PASSPHRASE}\"" > passphrase && \
    chmod 0600 passphrase

USER root
COPY files/get_userpass /home/barterdex/SuperNET/iguana/dexscripts
COPY files/barterdex /home/barterdex/SuperNET/iguana/dexscripts
RUN cd /home/barterdex/SuperNET/iguana/dexscripts && \
    chown barterdex:barterdex ./get_userpass && \
    chown barterdex:barterdex ./barterdex


USER barterdex
RUN cd /home/barterdex/SuperNET/iguana/dexscripts && \
    ./get_userpass

RUN cd /home/barterdex && \
    git clone https://github.com/jl777/komodo && \
    cd ~/komodo && \
    ./zcutil/fetch-params.sh && \
    ./zcutil/build.sh -j$(nproc --ignore=2) && \
    mkdir ~/bin && \
    cp ~/komodo/src/komodod ~/bin && \
    cp ~/komodo/src/komodo-tx ~/bin && \
    cp ~/komodo/src/komodo-cli ~/bin && \
    strip ~/bin/komodo* && \
    rm -rf ~/komodo

RUN mkdir ~/.komodo && \
    echo rpcuser=komodo >> ~/.komodo/komodo.conf && \
    echo rpcpassword=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)  >> ~/.komodo/komodo.conf && \
    echo server=1 >> ~/.komodo/komodo.conf && \
    echo listen=1 >> ~/.komodo/komodo.conf && \
    echo txindex=1 >> ~/.komodo/komodo.conf && \
    echo addnode=5.9.102.210 >> ~/.komodo/komodo.conf && \
    echo addnode=78.47.196.146 >> ~/.komodo/komodo.conf && \
    echo addnode=178.63.69.164 >> ~/.komodo/komodo.conf && \
    echo addnode=88.198.65.74 >> ~/.komodo/komodo.conf && \
    echo addnode=5.9.122.241 >> ~/.komodo/komodo.conf && \
    echo addnode=144.76.94.38 >> ~/.komodo/komodo.conf && \
    echo addnode=89.248.166.91 >> ~/.komodo/komodo.conf

USER root
RUN apt-get -y purge  libtool pkg-config autoconf automake bsdmainutils && \
    apt-get -y autoremove && \
    apt-get -y autoclean && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
USER barterdex

VOLUME /home/marketmaker
WORKDIR /home/marketmaker

# no ENTRYPOINT
# see https://stackoverflow.com/questions/37396144/interactive-container-daemon-process-at-container-startup
CMD /home/barterdex/bin/komodod -daemon && \
    cd /home/barterdex/SuperNET/iguana/dexscripts && \
    ./barterdex && \
    /bin/bash -login
