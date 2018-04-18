#
# Bitcoin-sCrypt Dockerfile
# https://github.com/bitcoin-scrypt/bitcoin-scrypt
#
FROM ubuntu:16.04
MAINTAINER 0x03 <0x03-ctrlc@protonmail.com>
EXPOSE 30200:30200/tcp 30201:30201/tcp

ENV BTCS_NAME="bitcoin-scrypt" \
    BTCS_BUILD_GITHUB="https://github.com/bitcoin-scrypt/bitcoin-scrypt" \
    BTCS_BUILD_SRCDIR="/usr/src/bitcoin-scrypt" \
    BTCS_OUT_BINARY="/usr/local/bin/bitcoin-scryptd" \
    BTCS_USER_NAME="bitcoin-scrypt" \
    BTCS_USER_HOMEDIR="/home/bitcoin-scrypt" \
    BTCS_CONF_DIR="/home/bitcoin-scrypt/.bitcoin-scrypt" \
    BTCS_CONF_FILE="bitcoin-scrypt.conf" \
    BTCS_CONF_RPCUSER="bitcoin-scrypt" \
    BTCS_CONF_RPCPASS="$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)"

HEALTHCHECK --interval=1m --timeout=10s \
   CMD curl -f --user ${BTCS_CONF_RPCUSER}:${BTCS_CONF_RPCPASS} --data "{\"method\": \"getinfo\"}" http://127.0.0.1:30200 || exit 1


    
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y dist-upgrade

RUN apt-get -y install libboost-system1.58-dev libboost-filesystem1.58-dev \
                       libboost-program-options1.58-dev libboost-thread1.58-dev \
                       software-properties-common python-software-properties \
                       libssl-dev build-essential git

RUN add-apt-repository -y ppa:bitcoin/bitcoin
RUN apt-get update
RUN apt-get -y install libdb4.8++-dev

RUN git clone ${BTCS_BUILD_GITHUB} ${BTCS_BUILD_SRCDIR}
RUN cd ${BTCS_BUILD_SRCDIR}/src && make -f makefile.unix USE_UPNP=- USE_IPV6=1
RUN strip ${BTCS_BUILD_SRCDIR}/src/bitcoin-scryptd
RUN install -m 0755 ${BTCS_BUILD_SRCDIR}/src/bitcoin-scryptd ${BTCS_OUT_BINARY}

RUN useradd -m -d ${BTCS_USER_HOMEDIR} -s /bin/bash ${BTCS_USER_NAME}
USER ${BTCS_USER_NAME}

RUN mkdir ${BTCS_CONF_DIR}
RUN chmod 0700 ${BTCS_CONF_DIR}

RUN echo rpcuser=${BTCS_CONF_RPCUSER} >> ${BTCS_CONF_DIR}/${BTCS_CONF_FILE}
RUN echo rpcpassword=${BTCS_CONF_RPCPASS} >> ${BTCS_CONF_DIR}/${BTCS_CONF_FILE}
RUN echo listen=1 >> ${BTCS_CONF_DIR}/${BTCS_CONF_FILE}
RUN echo addnode=138.201.185.23:30201 >> ${BTCS_CONF_DIR}/${BTCS_CONF_FILE}
RUN echo addnode=65.102.140.115:30201 >> ${BTCS_CONF_DIR}/${BTCS_CONF_FILE}
RUN echo addnode=62.59.168.89:30201 >> ${BTCS_CONF_DIR}/${BTCS_CONF_FILE}
RUN chmod 0600 ${BTCS_CONF_DIR}/${BTCS_CONF_FILE}

VOLUME "/home/bitcoin-scrypt"
CMD ["/usr/local/bin/bitcoin-scryptd", "-daemon"]
ENTRYPOINT ["/usr/local/bin/bitcoin-scryptd"]
