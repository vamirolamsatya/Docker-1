#
# Dockerfile for ccminer-veruscoin, https://github.com/monkins1010/ccminer
# see run.sh
#

FROM debian:buster-slim
LABEL MAINTAINER="0x03 <0x03-ctrlc@protonmail.com>"

ENV GITHUB="https://github.com/monkins1010/ccminer" SRCDIR="/usr/src/ccminer"

RUN apt update && apt -y upgrade && apt -y install build-essential autoconf automake git libssl-dev libcurl4-openssl-dev libgomp1 && \
    git clone ${GITHUB} ${SRCDIR} && cd ${SRCDIR} && \
	./autogen.sh && ./configure --prefix=/opt/ccminer && make -j$(nproc) && make install && \
    rm -rf ${SRCDIR} && apt -y purge build-essential autoconf automake git libssl-dev && \
    apt -y autoremove --purge; apt -y autoclean; apt -y clean; rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/opt/ccminer/bin/ccminer"]

# EOF
