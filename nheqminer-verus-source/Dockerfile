#
# Dockerfile for nheqminer-veruscoin, https://github.com/VerusCoin/nheqminer
# see run.sh
#

FROM debian:buster-slim
LABEL MAINTAINER="0x03 <0x03-ctrlc@protonmail.com>"

RUN apt-get update && apt-get install -y build-essential cmake libboost-all-dev git && \
    cd /usr/src && git clone https://github.com/VerusCoin/nheqminer && mkdir -p nheqminer/build && cd nheqminer/build && cmake -DUSE_CUDA_DJEZO=0 -DUSE_CPU_XENONCAT=0 .. && \
    make -j $(nproc) && cp nheqminer /usr/bin && strip /usr/bin/nheqminer &&  \
    apt-get -y purge build-essential cmake libboost-all-dev git && rm -rf /usr/src/nheqminer && \
    apt-get -y autoremove --purge; apt-get -y autoclean; apt-get -y clean; rm -rf /var/lib/apt/lists/*

USER nobody:nogroup
ENTRYPOINT ["/usr/bin/nheqminer"]

# EOF
