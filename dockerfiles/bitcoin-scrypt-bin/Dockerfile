FROM ubuntu:16.04
MAINTAINER 0x03 <0x03-ctrlc@protonmail.com>
EXPOSE 30200:30200/tcp 30201:30201/tcp

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y dist-upgrade

RUN apt-get -y install libboost-system1.58.0 libboost-filesystem1.58.0 libboost-program-options1.58.0 libboost-thread1.58.0 software-properties-common python-software-properties git wget

RUN add-apt-repository -y ppa:bitcoin/bitcoin
RUN apt-get update
RUN apt-get -y install libdb4.8++

RUN useradd -m -d /home/bitcoin-scrypt -s /bin/bash bitcoin-scrypt

USER bitcoin-scrypt

RUN mkdir /home/bitcoin-scrypt/bin
RUN wget -O /home/bitcoin-scrypt/bin/bitcoin-scryptd https://github.com/BloodyNora/Bitcoin-sCrypt/raw/master/src/bitcoin-scryptd.armv7l
RUN chmod 0755 /home/bitcoin-scrypt/bin/bitcoin-scryptd

RUN mkdir /home/bitcoin-scrypt/.bitcoin-scrypt
RUN chmod 0700 /home/bitcoin-scrypt/.bitcoin-scrypt

RUN echo rpcuser=bitcoin-scrypt >> /home/bitcoin-scrypt/.bitcoin-scrypt/bitcoin-scrypt.conf
RUN echo rpcpassword=$(head -c 32 /dev/urandom | base64) >> /home/bitcoin-scrypt/.bitcoin-scrypt/bitcoin-scrypt.conf
RUN echo addnode=138.201.185.23:30201 >> /home/bitcoin-scrypt/.bitcoin-scrypt/bitcoin-scrypt.conf
RUN echo addnode=65.102.140.115:30201 >> /home/bitcoin-scrypt/.bitcoin-scrypt/bitcoin-scrypt.conf
RUN chmod 0600 /home/bitcoin-scrypt/.bitcoin-scrypt/bitcoin-scrypt.conf

ENTRYPOINT ["/home/bitcoin-scrypt/bin/bitcoin-scryptd" "-daemon"]

