#
# Bitcoin-sCrypt Dockerfile
# https://github.com/bitcoin-scrypt/bitcoin-scrypt
#
FROM ubuntu:16.04
MAINTAINER 0x03 <0x03-ctrlc@protonmail.com>
EXPOSE 30201:30201/tcp

ARG DYN_CONFIG_RPCPORT="33350"
ARG DYN_CONFIG_PORT="33300"
ARG DYN_CONFIG_RPCUSER="dynamic-rpc"
ARG DYN_CONFIG_RPCPASSWORD="dyn4m1c*du4l1ty#s0lu7ions"
ARG DYN_CONFIG_DAEMON="1"
ARG DYN_CONFIG_LISTEN="1"

ENV DYN_SOURCEDIR="/usr/src/Dynamic" \
    DYN_USERNAME="dynamic" \
    DYN_HOMEDIR="/home/dynamic" \
    DYN_DATADIR="/home/dynamic/.dynamic" \
    DYN_CFGFILE="/home/dynamic/.dynamic/dynamic.conf"

HEALTHCHECK CMD curl -s http://127.0.0.1:33350 | grep -q Unauthorized && true

RUN echo deb http://ppa.launchpad.net/bitcoin/bitcoin/ubuntu xenial main >> /etc/apt/sources.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv D46F45428842CE5E && \
    apt-get update && \
    apt-get -y upgrade && \
    apt-get -y dist-upgrade && \
    apt-get --no-install-recommends -y install \
                       libboost-filesystem1.58.0 libboost-filesystem1.58-dev \
                       libboost-program-options1.58.0 libboost-program-options1.58-dev \
                       libboost-system1.58.0 libboost-system1.58-dev \
                       libboost-thread1.58.0 libboost-thread1.58-dev \
                       libdb4.8++ libdb4.8++-dev libssl1.0.0 libssl-dev libevent-dev \
                       build-essential autoconf automake libtool pkg-config git && \
    git -c http.sslVerify=false clone https://github.com/duality-solutions/Dynamic ${DYN_SOURCEDIR} && \
    cd ${DYN_SOURCEDIR} && \
    ./autogen.sh && \
    ./configure --disable-tests --disable-gui-tests --disable-bench --disable-zmq --enable-experimental-asm --with-incompatible-bdb --with-gui=no && \
    make -j$(nproc --ignore=1) && \
    strip ${DYN_SOURCEDIR}/src/dynamicd && \
    strip ${DYN_SOURCEDIR}/src/dynamic-tx && \
    strip ${DYN_SOURCEDIR}/src/dynamic-cli && \
    make install && \
    rm -rf ${DYN_SOURCEDIR} && \
    apt-get -y purge   libboost-program-options1.58-dev libboost-filesystem1.58-dev \
                       libboost-system1.58-dev libboost-thread1.58-dev \
                       libdb4.8++-dev libssl-dev \
                       build-essential git && \
    apt-get -y autoremove && \
    apt-get -y autoclean && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN useradd -m -d ${DYN_HOMEDIR} -s /bin/bash ${DYN_USERNAME}
USER ${DYN_USERNAME}

RUN mkdir ${DYN_DATADIR} && \
    chmod 0700 ${DYN_DATADIR}

RUN echo port=${DYN_CONFIG_PORT} >> ${DYN_CFGFILE} && \
    echo port=${DYN_CONFIG_RPCPORT} >> ${DYN_CFGFILE} && \
    echo rpcuser=${DYN_CONFIG_RPCUSER} >> ${DYN_CFGFILE} && \
    echo rpcpassword=${DYN_CONFIG_RPCPASSWORD} >> ${DYN_CFGFILE} && \
    echo daemon=${DYN_CONFIG_DAEMON} >> ${DYN_CFGFILE} && \
    echo listen=${DYN_CONFIG_LISTEN} >> ${DYN_CFGFILE} && \
    chmod 0600 ${DYN_CFGFILE}

VOLUME ${DYN_HOMEDIR}
WORKDIR ${DYN_HOMEDIR}

# no ENTRYPOINT
# see https://stackoverflow.com/questions/37396144/interactive-container-daemon-process-at-container-startup
CMD /usr/local/bin/dynamicd && /bin/bash -login
