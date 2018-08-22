#
# Dockerfile for nheqminer-veruscoin, https://github.com/VerusCoin/nheqminer
# usage: docker run --rm -it nheqminer-veruscoie -v -l 95.216.13.66:9999 -u RB4E24growBcS5jMLrLTZJTToFdQ7r51VR
# or see run.sh
#

FROM debian:9.4
MAINTAINER 0x03 <0x03-ctrlc@protonmail.com>
ENV GITHUB="https://github.com/VerusCoin/nheqminer" SRCDIR="/usr/src/nheqminer"

RUN apt-get update && apt-get install -y build-essential cmake libboost-all-dev git

RUN git clone ${GITHUB} ${SRCDIR} && mkdir -p ${SRCDIR}/build && cd ${SRCDIR}/build && cmake -DUSE_CUDA_DJEZO=0 -DUSE_CPU_XENONCAT=0 .. && make -j $(nproc) && cp nheqminer /usr/bin && strip /usr/bin/nheqminer

RUN apt-get -y autoremove; apt-get -y autoclean; apt-get -y clean; rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["nheqminer"]
