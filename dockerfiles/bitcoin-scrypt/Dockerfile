FROM       ubuntu:16.04
MAINTAINER 0x03 <0x03-ctrlc@protonmail.com>
EXPOSE     30200:30200/tcp 30201:30201/tcp

ENV BTCS_NAME="bitcoin-scrypt"
ENV BTCS_BUILD_GITHUB="https://github.com/bitcoin-scrypt/bitcoin-scrypt"
ENV BTCS_BUILD_SRCDIR="/usr/src/bitcoin-scrypt"
ENV BTCS_INSTALL_DIR="/usr/local/bin"
ENV BTCS_USER_NAME="bitcoin-scrypt"
ENV BTCS_USER_HOMEDIR="/home/bitcoin-scrypt"
ENV BTCS_CONF_DIR="/home/bitcoin-scrypt/.bitcoin-scrypt"
ENV BTCS_CONF_FILE="bitcoin-scrypt.conf"
ENV BTCS_USE_PNP="-"
ENV BTCS_USE_IPV6="0"
    
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y dist-upgrade

RUN apt-get -y install libboost-all-dev \
                       software-properties-common python-software-properties \
                       libssl-dev build-essential git

RUN add-apt-repository -y ppa:bitcoin/bitcoin
RUN apt-get update
RUN apt-get -y install libdb4.8++-dev

RUN git clone ${BTCS_BUILD_GITHUB} ${BTCS_BUILD_SRCDIR}
RUN cd ${BTCS_BUILD_SRCDIR}/src && make -f makefile.unix USE_UPNP=- USE_IPV6=${BTCS_USE_IPV6} -j$(nproc)
RUN strip ${BTCS_BUILD_SRCDIR}/src/bitcoin-scryptd
RUN install -m 0755 ${BTCS_BUILD_SRCDIR}/src/bitcoin-scryptd ${BTCS_INSTALL_DIR}

RUN useradd -m -d ${BTCS_USER_HOMEDIR} -s /bin/bash ${BTCS_USER_NAME}
USER ${BTCS_USER_NAME}

RUN mkdir ${BTCS_CONF_DIR}
RUN chmod 0700 ${BTCS_CONF_DIR}

RUN echo rpcuser=bitcoin-scrypt >> ${BTCS_CONF_DIR}/${BTCS_CONF_FILE}
RUN echo rpcpassword=$(head -c 32 /dev/urandom | base64) >> ${BTCS_CONF_DIR}/${BTCS_CONF_FILE}
RUN echo listen=1 >> ${BTCS_CONF_DIR}/${BTCS_CONF_FILE}
RUN echo addnode=138.201.185.23:30201 >> ${BTCS_CONF_DIR}/${BTCS_CONF_FILE}
RUN echo addnode=65.102.140.115:30201 >> ${BTCS_CONF_DIR}/${BTCS_CONF_FILE}
RUN echo addnode=62.59.168.89:30201 >> ${BTCS_CONF_DIR}/${BTCS_CONF_FILE}
RUN chmod 0600 ${BTCS_CONF_DIR}/${BTCS_CONF_FILE}

VOLUME     "/home/bitcoin-scrypt"
