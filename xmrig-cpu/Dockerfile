#
# Dockerfile for xmrig, https://github.com/xmrig/xmrig
# usage: docker run xmrig -o stratum+tcp://xmg.minerclaim.net -u 0x03.docker0 -p docker0
#

FROM debian:9.6
MAINTAINER 0x03 <0x03-ctrlc@protonmail.com>

ENV REPO="https://github.com/xmrig/xmrig" WORKDIR="/usr/src/xmrig"

RUN apt update && apt -y upgrade && \
    apt -y install -y build-essential autoconf automake libjansson-dev \
    libgmp-dev libcurl4-openssl-dev libssl-dev git cmake libuv1-dev

RUN git clone ${REPO} ${WORKDIR} && \
	mkdir ${WORKDIR}/build && \
	cd ${WORKDIR}/build && \
	cmake .. -DWITH_HTTPD=off && \
	make -j $(nproc --ignore=1)
    
WORKDIR ${WORKDIR}/build
ENTRYPOINT ["./xmrig", "-a", "cryptonight"]

