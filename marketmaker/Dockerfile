#
# BarterDEX/marketmaker Dockerfile
# https://github.com/jl777/SuperNET
#
FROM debian:9.4
MAINTAINER 0x03 <0x03-ctrlc@protonmail.com>
EXPOSE 0-65535:0-65535/tcp

ARG PASSPHRASE="the very best default passphrase money cannot buy that you should definitely set using docker.conf"

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
COPY files/profile.d/* /etc/profile.d/
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

# Komodo/KMD config
RUN mkdir ~/.komodo && \
    echo rpcuser=komodo >> ~/.komodo/komodo.conf && \
    echo rpcpassword=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)  >> ~/.komodo/komodo.conf && \
    echo rpcallowip=127.0.0.1 >> ~/.komodo/komodo.conf && \
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

# Revs/REVS AC
RUN mkdir ~/.komodo/REVS && \
    echo rpcport=10196 >> ~/.komodo/REVS/REVS.conf && \
    echo rpcallowip=127.0.0.1 >> ~/.komodo/REVS/REVS.conf && \
    echo rpcuser=komodo-revs >> ~/.komodo/REVS/REVS.conf && \
    echo rpcpassword=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)  >> ~/.komodo/REVS/REVS.conf && \
    echo server=1 >> ~/.komodo/REVS/REVS.conf && \
    echo listen=1 >> ~/.komodo/REVS/REVS.conf && \
    echo txindex=1 >> ~/.komodo/REVS/REVS.conf && \
    echo addnode=78.47.196.146 >> ~/.komodo/REVS/REVS.conf

# SuperNET/SUPERNET AC
RUN mkdir ~/.komodo/SUPERNET && \
    echo rpcport=11341 >> ~/.komodo/SUPERNET/SUPERNET.conf && \
    echo rpcallowip=127.0.0.1 >> ~/.komodo/SUPERNET/SUPERNET.conf && \
    echo rpcuser=komodo-supernet >> ~/.komodo/SUPERNET/SUPERNET.conf && \
    echo rpcpassword=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1) >> ~/.komodo/SUPERNET/SUPERNET.conf && \
    echo server=1 >> ~/.komodo/SUPERNET/SUPERNET.conf && \
    echo listen=1 >> ~/.komodo/SUPERNET/SUPERNET.conf && \
    echo txindex=1 >> ~/.komodo/SUPERNET/SUPERNET.conf && \
    echo addnode=78.47.196.146 >> ~/.komodo/SUPERNET/SUPERNET.conf

# DEX AC
RUN mkdir ~/.komodo/DEX && \
    echo rpcport=11890 >> ~/.komodo/DEX/DEX.conf && \
    echo rpcallowip=127.0.0.1 >> ~/.komodo/DEX/DEX.conf && \
    echo rpcuser=komodo-dex >> ~/.komodo/DEX/DEX.conf && \
    echo rpcpassword=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1) >> ~/.komodo/DEX/DEX.conf && \
    echo server=1 >> ~/.komodo/DEX/DEX.conf && \
    echo listen=1 >> ~/.komodo/DEX/DEX.conf && \
    echo txindex=1 >> ~/.komodo/DEX/DEX.conf && \
    echo addnode=78.48.196.146 >> ~/.komodo/DEX/DEX.conf

# PANGEA AC
RUN mkdir ~/.komodo/PANGEA && \
    echo rpcport=14068 >> ~/.komodo/PANGEA/PANGEA.conf && \
    echo rpcallowip=127.0.0.1 >> ~/.komodo/PANGEA/PANGEA.conf && \
    echo rpcuser=komodo-pangea >> ~/.komodo/PANGEA/PANGEA.conf && \
    echo rpcpassword=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1) >> ~/.komodo/PANGEA/PANGEA.conf && \
    echo server=1 >> ~/.komodo/PANGEA/PANGEA.conf && \
    echo listen=1 >> ~/.komodo/PANGEA/PANGEA.conf && \
    echo txindex=1 >> ~/.komodo/PANGEA/PANGEA.conf && \
    echo addnode=78.48.196.146 >> ~/.komodo/PANGEA/PANGEA.conf

# JUMBLR
RUN mkdir ~/.komodo/JUMBLR && \
    echo rpcport=15106 >> ~/.komodo/JUMBLR/JUMBLR.conf && \
    echo rpcallowip=127.0.0.1 >> ~/.komodo/JUMBLR/JUMBLR.conf && \
    echo rpcuser=komodo-jumblr >> ~/.komodo/JUMBLR/JUMBLR.conf && \
    echo rpcpassword=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1) >> ~/.komodo/JUMBLR/JUMBLR.conf && \
    echo server=1 >> ~/.komodo/JUMBLR/JUMBLR.conf && \
    echo listen=1 >> ~/.komodo/JUMBLR/JUMBLR.conf && \
    echo txindex=1 >> ~/.komodo/JUMBLR/JUMBLR.conf && \
    echo addnode=78.48.196.146 >> ~/.komodo/JUMBLR/JUMBLR.conf

# BET
RUN mkdir ~/.komodo/BET && \
    echo rpcport=14250 >> ~/.komodo/BET/BET.conf && \
    echo rpcallowip=127.0.0.1 >> ~/.komodo/BET/BET.conf && \
    echo rpcuser=komodo-bet >> ~/.komodo/BET/BET.conf && \
    echo rpcpassword=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1) >> ~/.komodo/BET/BET.conf && \
    echo server=1 >> ~/.komodo/BET/BET.conf && \
    echo listen=1 >> ~/.komodo/BET/BET.conf && \
    echo txindex=1 >> ~/.komodo/BET/BET.conf && \
    echo addnode=78.48.196.146 >> ~/.komodo/BET/BET.conf

# CRYPTO
RUN mkdir ~/.komodo/CRYPTO && \
    echo rpcport=8516 >> ~/.komodo/CRYPTO/CRYPTO.conf && \
    echo rpcallowip=127.0.0.1 >> ~/.komodo/CRYPTO/CRYPTO.conf && \
    echo rpcuser=komodo-crypto >> ~/.komodo/CRYPTO/CRYPTO.conf && \
    echo rpcpassword=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1) >> ~/.komodo/CRYPTO/CRYPTO.conf && \
    echo server=1 >> ~/.komodo/CRYPTO/CRYPTO.conf && \
    echo listen=1 >> ~/.komodo/CRYPTO/CRYPTO.conf && \
    echo txindex=1 >> ~/.komodo/CRYPTO/CRYPTO.conf && \
    echo addnode=78.48.196.146 >> ~/.komodo/CRYPTO/CRYPTO.conf

# HODL
RUN mkdir ~/.komodo/HODL && \
    echo rpcport=15395 >> ~/.komodo/HODL/HODL.conf && \
    echo rpcallowip=127.0.0.1 >> ~/.komodo/HODL/HODL.conf && \
    echo rpcuser=komodo-hodl >> ~/.komodo/HODL/HODL.conf && \
    echo rpcpassword=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1) >> ~/.komodo/HODL/HODL.conf && \
    echo server=1 >> ~/.komodo/HODL/HODL.conf && \
    echo listen=1 >> ~/.komodo/HODL/HODL.conf && \
    echo txindex=1 >> ~/.komodo/HODL/HODL.conf && \
    echo addnode=78.48.196.146 >> ~/.komodo/HODL/HODL.conf

# MSHARK
RUN mkdir ~/.komodo/MSHARK && \
    echo rpcport=8846 >> ~/.komodo/MSHARK/MSHARK.conf && \
    echo rpcallowip=127.0.0.1 >> ~/.komodo/MSHARK/MSHARK.conf && \
    echo rpcuser=komodo-mshark >> ~/.komodo/MSHARK/MSHARK.conf && \
    echo rpcpassword=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1) >> ~/.komodo/MSHARK/MSHARK.conf && \
    echo server=1 >> ~/.komodo/MSHARK/MSHARK.conf && \
    echo listen=1 >> ~/.komodo/MSHARK/MSHARK.conf && \
    echo txindex=1 >> ~/.komodo/MSHARK/MSHARK.conf && \
    echo addnode=78.48.196.146 >> ~/.komodo/MSHARK/MSHARK.conf

# BOTS
RUN mkdir ~/.komodo/BOTS && \
    echo rpcport=11964 >> ~/.komodo/BOTS/BOTS.conf && \
    echo rpcallowip=127.0.0.1 >> ~/.komodo/BOTS/BOTS.conf && \
    echo rpcuser=komodo-bots >> ~/.komodo/BOTS/BOTS.conf && \
    echo rpcpassword=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1) >> ~/.komodo/BOTS/BOTS.conf && \
    echo server=1 >> ~/.komodo/BOTS/BOTS.conf && \
    echo listen=1 >> ~/.komodo/BOTS/BOTS.conf && \
    echo txindex=1 >> ~/.komodo/BOTS/BOTS.conf && \
    echo addnode=78.48.196.146 >> ~/.komodo/BOTS/BOTS.conf

# MGW
RUN mkdir ~/.komodo/MGW && \
    echo rpcport=12386 >> ~/.komodo/MGW/MGW.conf && \
    echo rpcallowip=127.0.0.1 >> ~/.komodo/MGW/MGW.conf && \
    echo rpcuser=komodo-mgw >> ~/.komodo/MGW/MGW.conf && \
    echo rpcpassword=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1) >> ~/.komodo/MGW/MGW.conf && \
    echo server=1 >> ~/.komodo/MGW/MGW.conf && \
    echo listen=1 >> ~/.komodo/MGW/MGW.conf && \
    echo txindex=1 >> ~/.komodo/MGW/MGW.conf && \
    echo addnode=78.48.196.146 >> ~/.komodo/MGW/MGW.conf

# COQUI
RUN mkdir ~/.komodo/COQUI && \
    echo rpcport=14276 >> ~/.komodo/COQUI/COQUI.conf && \
    echo rpcallowip=127.0.0.1 >> ~/.komodo/COQUI/COQUI.conf && \
    echo rpcuser=komodo-coqui >> ~/.komodo/COQUI/COQUI.conf && \
    echo rpcpassword=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1) >> ~/.komodo/COQUI/COQUI.conf && \
    echo server=1 >> ~/.komodo/COQUI/COQUI.conf && \
    echo listen=1 >> ~/.komodo/COQUI/COQUI.conf && \
    echo txindex=1 >> ~/.komodo/COQUI/COQUI.conf && \
    echo addnode=78.48.196.146 >> ~/.komodo/COQUI/COQUI.conf

# WLC
RUN mkdir ~/.komodo/WLC && \
    echo rpcport=12167 >> ~/.komodo/WLC/WLC.conf && \
    echo rpcallowip=127.0.0.1 >> ~/.komodo/WLC/WLC.conf && \
    echo rpcuser=komodo-wlc >> ~/.komodo/WLC/WLC.conf && \
    echo rpcpassword=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1) >> ~/.komodo/WLC/WLC.conf && \
    echo server=1 >> ~/.komodo/WLC/WLC.conf && \
    echo listen=1 >> ~/.komodo/WLC/WLC.conf && \
    echo txindex=1 >> ~/.komodo/WLC/WLC.conf && \
    echo addnode=78.48.196.146 >> ~/.komodo/WLC/WLC.conf

# KV
RUN mkdir ~/.komodo/KV && \
    echo rpcport=8299 >> ~/.komodo/KV/KV.conf && \
    echo rpcallowip=127.0.0.1 >> ~/.komodo/KV/KV.conf && \
    echo rpcuser=komodo-kv >> ~/.komodo/KV/KV.conf && \
    echo rpcpassword=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1) >> ~/.komodo/KV/KV.conf && \
    echo server=1 >> ~/.komodo/KV/KV.conf && \
    echo listen=1 >> ~/.komodo/KV/KV.conf && \
    echo txindex=1 >> ~/.komodo/KV/KV.conf && \
    echo addnode=78.48.196.146 >> ~/.komodo/KV/KV.conf

# CEAL
RUN mkdir ~/.komodo/CEAL && \
    echo rpcport=11116 >> ~/.komodo/CEAL/CEAL.conf && \
    echo rpcallowip=127.0.0.1 >> ~/.komodo/CEAL/CEAL.conf && \
    echo rpcuser=komodo-ceal >> ~/.komodo/CEAL/CEAL.conf && \
    echo rpcpassword=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1) >> ~/.komodo/CEAL/CEAL.conf && \
    echo server=1 >> ~/.komodo/CEAL/CEAL.conf && \
    echo listen=1 >> ~/.komodo/CEAL/CEAL.conf && \
    echo txindex=1 >> ~/.komodo/CEAL/CEAL.conf && \
    echo addnode=78.48.196.146 >> ~/.komodo/CEAL/CEAL.conf

# MESH
RUN mkdir ~/.komodo/MESH && \
    echo rpcport=9455 >> ~/.komodo/MESH/MESH.conf && \
    echo rpcallowip=127.0.0.1 >> ~/.komodo/MESH/MESH.conf && \
    echo rpcuser=komodo-mesh >> ~/.komodo/MESH/MESH.conf && \
    echo rpcpassword=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1) >> ~/.komodo/MESH/MESH.conf && \
    echo server=1 >> ~/.komodo/MESH/MESH.conf && \
    echo listen=1 >> ~/.komodo/MESH/MESH.conf && \
    echo txindex=1 >> ~/.komodo/MESH/MESH.conf && \
    echo addnode=78.48.196.146 >> ~/.komodo/MESH/MESH.conf

# Monaize/MNZ
RUN mkdir ~/.komodo/MNZ && \
    echo rpcport=14337 >> ~/.komodo/MNZ/MNZ.conf && \
    echo rpcallowip=127.0.0.1 >> ~/.komodo/MNZ/MNZ.conf && \
    echo rpcuser=komodo-mnz >> ~/.komodo/MNZ/MNZ.conf && \
    echo rpcpassword=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1) >> ~/.komodo/MNZ/MNZ.conf && \
    echo server=1 >> ~/.komodo/MNZ/MNZ.conf && \
    echo listen=1 >> ~/.komodo/MNZ/MNZ.conf && \
    echo txindex=1 >> ~/.komodo/MNZ/MNZ.conf && \
    echo addnode=78.48.196.146 >> ~/.komodo/MNZ/MNZ.conf

# AXO
RUN mkdir ~/.komodo/AXO && \
    echo rpcport=12927 >> ~/.komodo/AXO/AXO.conf && \
    echo rpcallowip=127.0.0.1 >> ~/.komodo/AXO/AXO.conf && \
    echo rpcuser=komodo-axo >> ~/.komodo/AXO/AXO.conf && \
    echo rpcpassword=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1) >> ~/.komodo/AXO/AXO.conf && \
    echo server=1 >> ~/.komodo/AXO/AXO.conf && \
    echo listen=1 >> ~/.komodo/AXO/AXO.conf && \
    echo txindex=1 >> ~/.komodo/AXO/AXO.conf && \
    echo addnode=78.48.196.146 >> ~/.komodo/AXO/AXO.conf

# BTCH
RUN mkdir ~/.komodo/BTCH && \
    echo rpcport=8800 >> ~/.komodo/BTCH/BTCH.conf && \
    echo rpcallowip=127.0.0.1 >> ~/.komodo/BTCH/BTCH.conf && \
    echo rpcuser=komodo-btch >> ~/.komodo/BTCH/BTCH.conf && \
    echo rpcpassword=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1) >> ~/.komodo/BTCH/BTCH.conf && \
    echo server=1 >> ~/.komodo/BTCH/BTCH.conf && \
    echo listen=1 >> ~/.komodo/BTCH/BTCH.conf && \
    echo txindex=1 >> ~/.komodo/BTCH/BTCH.conf && \
    echo addnode=78.48.196.146 >> ~/.komodo/BTCH/BTCH.conf

# PIZZA
RUN mkdir ~/.komodo/PIZZA && \
    echo rpcport=11608 >> ~/.komodo/PIZZA/PIZZA.conf && \
    echo rpcallowip=127.0.0.1 >> ~/.komodo/PIZZA/PIZZA.conf && \
    echo rpcuser=komodo-pizza >> ~/.komodo/PIZZA/PIZZA.conf && \
    echo rpcpassword=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1) >> ~/.komodo/PIZZA/PIZZA.conf && \
    echo server=1 >> ~/.komodo/PIZZA/PIZZA.conf && \
    echo listen=1 >> ~/.komodo/PIZZA/PIZZA.conf && \
    echo txindex=1 >> ~/.komodo/PIZZA/PIZZA.conf && \
    echo addnode=78.48.196.146 >> ~/.komodo/PIZZA/PIZZA.conf

# BEER
RUN mkdir ~/.komodo/BEER && \
    echo rpcport=8923 >> ~/.komodo/BEER/BEER.conf && \
    echo rpcallowip=127.0.0.1 >> ~/.komodo/BEER/BEER.conf && \
    echo rpcuser=komodo-beer >> ~/.komodo/BEER/BEER.conf && \
    echo rpcpassword=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1) >> ~/.komodo/BEER/BEER.conf && \
    echo server=1 >> ~/.komodo/BEER/BEER.conf && \
    echo listen=1 >> ~/.komodo/BEER/BEER.conf && \
    echo txindex=1 >> ~/.komodo/BEER/BEER.conf && \
    echo addnode=78.48.196.146 >> ~/.komodo/BEER/BEER.conf

# NINJA
RUN mkdir ~/.komodo/NINJA && \
    echo rpcport=8427 >> ~/.komodo/NINJA/NINJA.conf && \
    echo rpcallowip=127.0.0.1 >> ~/.komodo/NINJA/NINJA.conf && \
    echo rpcuser=komodo-ninja >> ~/.komodo/NINJA/NINJA.conf && \
    echo rpcpassword=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1) >> ~/.komodo/NINJA/NINJA.conf && \
    echo server=1 >> ~/.komodo/NINJA/NINJA.conf && \
    echo listen=1 >> ~/.komodo/NINJA/NINJA.conf && \
    echo txindex=1 >> ~/.komodo/NINJA/NINJA.conf && \
    echo addnode=78.48.196.146 >> ~/.komodo/NINJA/NINJA.conf

# OOT
RUN mkdir ~/.komodo/OOT && \
    echo rpcport=12467 >> ~/.komodo/OOT/OOT.conf && \
    echo rpcallowip=127.0.0.1 >> ~/.komodo/OOT/OOT.conf && \
    echo rpcuser=komodo-oot >> ~/.komodo/OOT/OOT.conf && \
    echo rpcpassword=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1) >> ~/.komodo/OOT/OOT.conf && \
    echo server=1 >> ~/.komodo/OOT/OOT.conf && \
    echo listen=1 >> ~/.komodo/OOT/OOT.conf && \
    echo txindex=1 >> ~/.komodo/OOT/OOT.conf && \
    echo addnode=78.48.196.146 >> ~/.komodo/OOT/OOT.conf

# Blocknation/BNTN AC
RUN mkdir ~/.komodo/BNTN && \
    echo rpcport=14358 >> ~/.komodo/BNTN/BNTN.conf && \
    echo rpcallowip=127.0.0.1 >> ~/.komodo/BNTN/BNTN.conf && \
    echo rpcuser=komodo-bntn >> ~/.komodo/BNTN/BNTN.conf && \
    echo rpcpassword=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)  >> ~/.komodo/BNTN/BNTN.conf && \
    echo server=1 >> ~/.komodo/BNTN/BNTN.conf && \
    echo listen=1 >> ~/.komodo/BNTN/BNTN.conf && \
    echo txindex=1 >> ~/.komodo/BNTN/BNTN.conf && \
    echo addnode=94.130.169.205 >> ~/.komodo/BNTN/BNTN.conf && \
    echo addnode=78.47.196.146 >> ~/.komodo/BNTN/BNTN.conf

# CHAIN
RUN mkdir ~/.komodo/CHAIN && \
    echo rpcport=15587 >> ~/.komodo/CHAIN/CHAIN.conf && \
    echo rpcallowip=127.0.0.1 >> ~/.komodo/CHAIN/CHAIN.conf && \
    echo rpcuser=komodo-chain >> ~/.komodo/CHAIN/CHAIN.conf && \
    echo rpcpassword=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1) >> ~/.komodo/CHAIN/CHAIN.conf && \
    echo server=1 >> ~/.komodo/CHAIN/CHAIN.conf && \
    echo listen=1 >> ~/.komodo/CHAIN/CHAIN.conf && \
    echo txindex=1 >> ~/.komodo/CHAIN/CHAIN.conf && \
    echo addnode=78.48.196.146 >> ~/.komodo/CHAIN/CHAIN.conf

# PRLPAY
RUN mkdir ~/.komodo/PRLPAY && \
    echo rpcport=9679 >> ~/.komodo/PRLPAY/PRLPAY.conf && \
    echo rpcallowip=127.0.0.1 >> ~/.komodo/PRLPAY/PRLPAY.conf && \
    echo rpcuser=komodo-prlpay >> ~/.komodo/PRLPAY/PRLPAY.conf && \
    echo rpcpassword=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1) >> ~/.komodo/PRLPAY/PRLPAY.conf && \
    echo server=1 >> ~/.komodo/PRLPAY/PRLPAY.conf && \
    echo listen=1 >> ~/.komodo/PRLPAY/PRLPAY.conf && \
    echo txindex=1 >> ~/.komodo/PRLPAY/PRLPAY.conf && \
    echo addnode=78.48.196.146 >> ~/.komodo/PRLPAY/PRLPAY.conf


USER root
RUN apt-get -y purge  libtool pkg-config autoconf automake bsdmainutils && \
    apt-get -y autoremove && \
    apt-get -y autoclean && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
USER barterdex

VOLUME /home/barterdex
WORKDIR /home/barterdex

# no ENTRYPOINT
# see https://stackoverflow.com/questions/37396144/interactive-container-daemon-process-at-container-startup
CMD /home/barterdex/bin/komodod -daemon 1>/dev/null 2>/dev/null && \
    /home/barterdex/bin/komodod -ac_name=REVS -ac_supply=1300000 -daemon 1>/dev/null 2>/dev/null && \
    /home/barterdex/bin/komodod -ac_name=SUPERNET -ac_supply=816061 -daemon 1>/dev/null 2>/dev/null && \
    /home/barterdex/bin/komodod -ac_name=DEX -ac_supply=999999 -daemon 1>/dev/null 2>/dev/null && \
    /home/barterdex/bin/komodod -ac_name=PANGEA -ac_supply=999999 -daemon 1>/dev/null 2>/dev/null && \
    /home/barterdex/bin/komodod -ac_name=JUMBLR -ac_supply=999999 -daemon 1>/dev/null 2>/dev/null && \
    /home/barterdex/bin/komodod -ac_name=BET -ac_supply=999999 -daemon 1>/dev/null 2>/dev/null && \
    /home/barterdex/bin/komodod -ac_name=CRYPTO -ac_supply=999999 -daemon 1>/dev/null 2>/dev/null && \
    /home/barterdex/bin/komodod -ac_name=HODL -ac_supply=999999 -daemon 1>/dev/null 2>/dev/null && \
    /home/barterdex/bin/komodod -ac_name=MSHARK -ac_supply=1400000 -daemon 1>/dev/null 2>/dev/null && \
    /home/barterdex/bin/komodod -ac_name=BOTS -ac_supply=999999 -daemon 1>/dev/null 2>/dev/null && \
    /home/barterdex/bin/komodod -ac_name=MGW -ac_supply=999999 -daemon 1>/dev/null 2>/dev/null && \
    /home/barterdex/bin/komodod -ac_name=COQUI -ac_supply=72000000 -daemon 1>/dev/null 2>/dev/null && \
    /home/barterdex/bin/komodod -ac_name=WLC -ac_supply=210000000 -daemon 1>/dev/null 2>/dev/null && \
    /home/barterdex/bin/komodod -ac_name=KV -ac_supply=1000000 -daemon 1>/dev/null 2>/dev/null && \
    /home/barterdex/bin/komodod -ac_name=CEAL -ac_supply=366666666 -daemon 1>/dev/null 2>/dev/null && \
    /home/barterdex/bin/komodod -ac_name=MESH -ac_supply=1000007 -daemon 1>/dev/null 2>/dev/null && \
    /home/barterdex/bin/komodod -ac_name=MNZ -ac_supply=257142858 -daemon 1>/dev/null 2>/dev/null && \
    /home/barterdex/bin/komodod -ac_name=AXO -ac_supply=200000000 -daemon 1>/dev/null 2>/dev/null && \
    /home/barterdex/bin/komodod -ac_name=BTCH -ac_supply=20998641 -daemon 1>/dev/null 2>/dev/null && \
    /home/barterdex/bin/komodod -ac_name=PIZZA -ac_supply=100000000 -daemon 1>/dev/null 2>/dev/null && \
    /home/barterdex/bin/komodod -ac_name=BEER -ac_supply=100000000 -daemon 1>/dev/null 2>/dev/null && \
    /home/barterdex/bin/komodod -ac_name=NINJA -ac_supply=100000000 -daemon 1>/dev/null 2>/dev/null && \
    /home/barterdex/bin/komodod -ac_name=OOT -ac_supply=216000000 -daemon 1>/dev/null 2>/dev/null && \
    /home/barterdex/bin/komodod -ac_name=BNTN -ac_supply=500000000 -daemon 1>/dev/null 2>/dev/null && \
    /home/barterdex/bin/komodod -ac_name=CHAIN -ac_supply=999999 -daemon 1>/dev/null 2>/dev/null && \
    /home/barterdex/bin/komodod -ac_name=PRLPAY -ac_supply=500000000 -daemon 1>/dev/null 2>/dev/null && \
    cd /home/barterdex/SuperNET/iguana/dexscripts && \
    ./barterdex && \
    /bin/bash -login
