FROM       ubuntu:16.04
MAINTAINER 0x03 <0x03-ctrlc@protonmail.com>
EXPOSE     30200:30200/tcp 30201:30201/tcp

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y dist-upgrade

RUN apt-get -y install libboost-all-dev \
                       software-properties-common python-software-properties \
                       libssl-dev build-essential git

RUN add-apt-repository -y ppa:bitcoin/bitcoin
RUN apt-get update
RUN apt-get -y install libdb4.8++-dev

RUN useradd -m -d /home/bitcoin-scrypt -s /bin/bash bitcoin-scrypt

USER bitcoin-scrypt

RUN mkdir /home/bitcoin-scrypt/bin
RUN git clone https://github.com/BloodyNora/bitcoin-scrypt src

RUN cd src/src; make -f makefile.unix USE_UPNP=- USE_IPV6=1
RUN cp bitcoin-scryptd /home/bitcoin-scrypt/bin 
RUN strip /home/bitcoin-scrypt/bin/bitcoin-scryptd

RUN mkdir /home/bitcoin-scrypt/.bitcoin-scrypt
RUN chmod 0700 /home/bitcoin-scrypt/.bitcoin-scrypt

RUN echo listen=1 >> /home/bitcoin-scrypt/.bitcoin-scrypt/bitcoin-scrypt.conf
RUN echo rpcuser=bitcoin-scrypt >> /home/bitcoin-scrypt/.bitcoin-scrypt/bitcoin-scrypt.conf
RUN echo rpcpassword=$(head -c 32 /dev/urandom | base64) >> /home/bitcoin-scrypt/.bitcoin-scrypt/bitcoin-scrypt.conf
RUN echo addnode=138.201.185.23:30201 >> /home/bitcoin-scrypt/.bitcoin-scrypt/bitcoin-scrypt.conf
RUN echo addnode=65.102.140.115:30201 >> /home/bitcoin-scrypt/.bitcoin-scrypt/bitcoin-scrypt.conf
RUN chmod 0600 /home/bitcoin-scrypt/.bitcoin-scrypt/bitcoin-scrypt.conf

#CMD ["/home/bitcoin-scrypt/bin/bitcoin-scryptd" "-daemon"]

