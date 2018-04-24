#
# Bitcoin-sCrypt Dockerfile
# https://github.com/bitcoin-scrypt/bitcoin-scrypt
#
FROM ubuntu:16.04
MAINTAINER 0x03 <0x03-ctrlc@protonmail.com>
EXPOSE 8233:8233/tcp

ENV MAGI_BUILD_GITHUB="https://github.com/magi-project/magi" \
    MAGI_BUILD_SRCDIR="/usr/src/magi" \
    MAGI_OUT_BINARY="/usr/local/bin/magid" \
    MAGI_USER_NAME="magi" \
    MAGI_USER_HOMEDIR="/home/magi" \
    MAGI_CONF_DIR="/home/magi/.magi" \
    MAGI_CONF_FILE="magi.conf"

HEALTHCHECK --interval=1m --timeout=10s \
   CMD curl -sf http://127.0.0.1:30200 | grep Unauthorized


RUN echo deb http://ppa.launchpad.net/bitcoin/bitcoin/ubuntu xenial main >> /etc/apt/sources.list    
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv D46F45428842CE5E
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y dist-upgrade

RUN apt-get -y install libboost-system1.58-dev libboost-filesystem1.58-dev \
                       libboost-program-options1.58-dev libboost-thread1.58-dev \
                       libgmpxxv4-4 libgmpv4-dev libdb4.8++-dev libssl-dev build-essential git

RUN git clone ${MAGI_BUILD_GITHUB} ${MAGI_BUILD_SRCDIR}
RUN cd ${MAGI_BUILD_SRCDIR}/src && make -f makefile.unix USE_UPNP=- USE_IPV6=1 -j$(nproc --ignore=1)
RUN strip ${MAGI_BUILD_SRCDIR}/src/magid
RUN install -m 0755 ${MAGI_BUILD_SRCDIR}/src/magid ${MAGI_OUT_BINARY}
RUN rm -rf ${MAGI_BUILD_SRCDIR}

RUN apt-get -y purge   libboost-system1.58-dev libboost-filesystem1.58-dev \
                       libboost-program-options1.58-dev libboost-thread1.58-dev \
                       libssl-dev build-essential git libdb4.8-dev libdb4.8++-dev

RUN apt-get -y install libboost-system1.58.0 libboost-filesystem1.58.0 \
                       libboost-program-options1.58.0 libboost-thread1.58.0 \
                       libdb4.8++ libssl1.0.0 libgmpxxv4-4

RUN apt-get -y autoremove
RUN apt-get -y autoclean
RUN apt-get -y clean

RUN useradd -m -d ${MAGI_USER_HOMEDIR} -s /bin/bash ${MAGI_USER_NAME}
USER ${MAGI_USER_NAME}

RUN mkdir ${MAGI_CONF_DIR}
RUN chmod 0700 ${MAGI_CONF_DIR}

RUN echo rpcuser=${MAGI_USER_NAME}    >> ${MAGI_CONF_DIR}/${MAGI_CONF_FILE}
RUN echo rpcpassword=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1) >> ${MAGI_CONF_DIR}/${MAGI_CONF_FILE}
RUN echo daemon=1                     >> ${MAGI_CONF_DIR}/${MAGI_CONF_FILE}
RUN echo listen=1                     >> ${MAGI_CONF_DIR}/${MAGI_CONF_FILE}
RUN echo addnode=213.32.21.37:8233 >> ${MAGI_CONF_DIR}/${MAGI_CONF_FILE}
RUN echo addnode=104.128.225.215:8233 >> ${MAGI_CONF_DIR}/${MAGI_CONF_FILE}
RUN echo addnode=5.79.74.141:8233 >> ${MAGI_CONF_DIR}/${MAGI_CONF_FILE}
RUN echo addnode=38.128.141.172:8233 >>${MAGI_CONF_DIR}/${MAGI_CONF_FILE}
RUN echo addnode=95.211.186.214:8233 >>${MAGI_CONF_DIR}/${MAGI_CONF_FILE}
RUN echo addnode=88.198.68.186:8233 >>${MAGI_CONF_DIR}/${MAGI_CONF_FILE}
RUN echo addnode=89.248.114.111:8233 >>${MAGI_CONF_DIR}/${MAGI_CONF_FILE}
RUN echo addnode=37.48.118.9:8233 >>${MAGI_CONF_DIR}/${MAGI_CONF_FILE}
RUN echo addnode=77.247.178.69:8233 >>${MAGI_CONF_DIR}/${MAGI_CONF_FILE}
RUN echo addnode=149.202.78.181:8233 >>${MAGI_CONF_DIR}/${MAGI_CONF_FILE}
RUN echo addnode=90.193.226.180:8233 >>${MAGI_CONF_DIR}/${MAGI_CONF_FILE}
RUN chmod 0600 ${MAGI_CONF_DIR}/${MAGI_CONF_FILE}

VOLUME ${MAGI_USER_HOMEDIR}
CMD /usr/local/bin/magid -daemon && /bin/bash -login
