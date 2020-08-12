#
# Dockerfile for ccminer-verus, https://github.com/monkins1010/ccminer
# see ccminer.conf and run.sh for details
#

FROM debian:buster-slim
LABEL MAINTAINER="0x03 <0x03-ctrlc@protonmail.com>"

RUN apt-get update && apt-get -y upgrade && apt-get -y install build-essential autoconf automake git libssl-dev libcurl4-openssl-dev libgomp1 && \
    cd /usr/src && git clone https://github.com/monkins1010/ccminer && cd ccminer && \
	./autogen.sh && ./configure --prefix=/usr && make -j$(nproc) && make install && \
    cd && rm -rf /usr/src/ccminer && apt-get -y purge build-essential autoconf automake git libssl-dev && \
    apt-get -y autoremove --purge; apt-get -y autoclean; apt-get -y clean; rm -rf /var/lib/apt-get/lists/*

USER nobody:nogroup
ENTRYPOINT ["ccminer"]

# EOF
