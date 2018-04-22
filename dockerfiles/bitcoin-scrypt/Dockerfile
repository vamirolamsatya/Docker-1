#
# Bitcoin-sCrypt Dockerfile
# https://github.com/bitcoin-scrypt/bitcoin-scrypt
#
FROM ubuntu:16.04
MAINTAINER 0x03 <0x03-ctrlc@protonmail.com>
EXPOSE 30201:30201/tcp

ARG BTCS_CONFIG_RPCPORT="30200"
ARG BTCS_CONFIG_PORT="30201"
ARG BTCS_CONFIG_RPCUSER="bitcoin-scrypt-rpc"
ARG BTCS_CONFIG_RPCPASSWORD="b17c01n*5cryp7#0815%f00bar"
ARG BTCS_CONFIG_DAEMON="1"
ARG BTCS_CONFIG_LISTEN="1"

ENV BTCS_SOURCEDIR="/usr/src/bitcoin-scrypt" \
    BTCS_USERNAME="bitcoin-scrypt" \
    BTCS_HOMEDIR="/home/bitcoin-scrypt" \
    BTCS_DATADIR="/home/bitcoin-scrypt/.bitcoin-scrypt" \
    BTCS_CFGFILE="/home/bitcoin-scrypt/.bitcoin-scrypt/bitcoin-scrypt.conf"

HEALTHCHECK CMD curl -s http://127.0.0.1:30200 | grep -q Unauthorized && true

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
                       libdb4.8++ libdb4.8++-dev libssl1.0.0 libssl-dev \
                       build-essential git && \
    git -c http.sslVerify=false clone https://github.com/bitcoin-scrypt/bitcoin-scrypt ${BTCS_SOURCEDIR} && \
    cd ${BTCS_SOURCEDIR}/src && make -f makefile.unix USE_UPNP=- USE_IPV6=1 && \
    strip ${BTCS_SOURCEDIR}/src/bitcoin-scryptd && \
    install -m 0755 ${BTCS_SOURCEDIR}/src/bitcoin-scryptd /usr/local/bin/bitcoin-scryptd && \
    rm -rf ${BTCS_SOURCEDIR} && \
    apt-get -y purge   libboost-program-options1.58-dev libboost-filesystem1.58-dev \
                       libboost-system1.58-dev libboost-thread1.58-dev \
                       libdb4.8++-dev libssl-dev \
                       build-essential git && \
    apt-get -y autoremove && \
    apt-get -y autoclean && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN useradd -m -d ${BTCS_HOMEDIR} -s /bin/bash ${BTCS_USERNAME}
USER ${BTCS_USERNAME}

RUN mkdir ${BTCS_DATADIR} && \
    chmod 0700 ${BTCS_DATADIR}

RUN echo port=${BTCS_CONFIG_PORT} >> ${BTCS_CFGFILE} && \
    echo port=${BTCS_CONFIG_RPCPORT} >> ${BTCS_CFGFILE} && \
    echo rpcuser=${BTCS_CONFIG_RPCUSER} >> ${BTCS_CFGFILE} && \
    echo rpcpassword=${BTCS_CONFIG_RPCPASSWORD} >> ${BTCS_CFGFILE} && \
    echo daemon=${BTCS_CONFIG_DAEMON} >> ${BTCS_CFGFILE} && \
    echo listen=${BTCS_CONFIG_LISTEN} >> ${BTCS_CFGFILE} && \
    echo addnode=138.201.185.23:30201 >> ${BTCS_CFGFILE} && \
    echo addnode=65.102.140.115:30201 >> ${BTCS_CFGFILE} && \
    echo addnode=62.59.168.89:30201 >> ${BTCS_CFGFILE} && \
    echo addnode=45.55.216.92:30201 >> ${BTCS_CFGFILE} && \
    echo addnode=79.137.57.54:30201 >> ${BTCS_CFGFILE} && \
    echo addnode=81.7.13.208:30201 >> ${BTCS_CFGFILE} && \
    chmod 0600 ${BTCS_CFGFILE}

VOLUME ${BTCS_HOMEDIR}
WORKDIR ${BTCS_HOMEDIR}

# no ENTRYPOINT
# see https://stackoverflow.com/questions/37396144/interactive-container-daemon-process-at-container-startup
CMD /usr/local/bin/bitcoin-scryptd && /bin/bash -login
