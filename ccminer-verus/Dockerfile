#
# Dockerfile for ccminer-verus, https://github.com/monkins1010/ccminer
# see ccminer.conf and run.sh for details
#

FROM debian:buster-slim
LABEL MAINTAINER="0x03 <0x03-ctrlc@protonmail.com>"

ENV SRC="/usr/src/ccminer"

RUN apt update && apt -y upgrade && apt -y install build-essential autoconf automake git libssl-dev libcurl4-openssl-dev libgomp1 && \
    git clone https://github.com/monkins1010/ccminer ${SRC} && cd ${SRC} && \
	./autogen.sh && ./configure --prefix=/usr && make -j$(nproc) && make install && \
    rm -rf ${SRC} && apt -y purge build-essential autoconf automake git libssl-dev && \
    apt -y autoremove --purge; apt -y autoclean; apt -y clean; rm -rf /var/lib/apt/lists/*

USER nobody:nogroup
ENTRYPOINT ["ccminer"]

# EOF
