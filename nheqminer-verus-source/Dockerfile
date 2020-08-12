#
# Dockerfile for nheqminer-veruscoin, https://github.com/VerusCoin/nheqminer
# see run.sh
#

FROM debian:buster-slim
LABEL MAINTAINER="0x03 <0x03-ctrlc@protonmail.com>"

ENV GITHUB="https://github.com/VerusCoin/nheqminer" SRCDIR="/usr/src/nheqminer"

RUN apt-get update && apt-get install -y build-essential cmake libboost-all-dev git && \
    git clone ${GITHUB} ${SRCDIR} && mkdir -p ${SRCDIR}/build && cd ${SRCDIR}/build && cmake -DUSE_CUDA_DJEZO=0 -DUSE_CPU_XENONCAT=0 .. && \
    make -j $(nproc) && cp nheqminer /usr/bin && strip /usr/bin/nheqminer && rm -rf ${SRCDIR} && \
    apt-get -y purge build-essential cmake libboost-all-dev && \
    apt-get -y autoremove --purge; apt-get -y autoclean; apt-get -y clean; rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/usr/bin/nheqminer"]

# EOF