#
# Dockerfile for bfgminer/MLD2, https://github.com/jstefanop/bfgminer
# usage: docker run wolf-m7m-cpuminer-v2 --url xxxx --user xxxx --pass xxxx
# ex: docker run creack/cpuminer --url stratum+tcp://ltc.pool.com:80 --user creack.worker1 --pass abcdef
#

FROM       debian:9.4
MAINTAINER 0x03 <0x03-ctrlc@protonmail.com>

RUN apt-get update
RUN	apt-get install -y build-essential autoconf automake libjansson-dev libgmp-dev libcurl4-openssl-dev libssl-dev git

RUN	cd /usr/src && git clone https://github.com/jstefanop/bfgminer

RUN cd /usr/src/bfgminer && ./autogen.sh
RUN cd /usr/src/bfgminer && ./configure --prefix=/usr/local CFLAGS="-O3"
RUN	cd /usr/src/bfgminer && make -j$(nproc --ignore=1)

WORKDIR "/usr/src/bfgminer"
ENTRYPOINT ["./bfgminer"]

