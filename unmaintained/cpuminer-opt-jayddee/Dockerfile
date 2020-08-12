#
# Dockerfile for cpuminer-opt-jayddee, https://github.com/JayDDee/cpuminer-opt
# usage: docker run --rm -it cpuminer-opt-jayddee -a yescryptR16 -o stratum+tcp://pool.cpu-mining.xyz:6333 -u EXYBBHsZrEVmKHbTtNxsjQSLG1HmGxad15
# or see run.sh
#

FROM debian:9.5
MAINTAINER 0x03 <0x03-ctrlc@protonmail.com>
ENV GITHUB="https://github.com/JayDDee/cpuminer-opt" SRCDIR="/usr/src/cpuminer-opt"

RUN apt-get update && apt-get install -y build-essential autoconf automake git libjansson4 libjansson-dev libgmp10 libgmp-dev libcurl4-openssl-dev libcurl3 libssl-dev git zlib1g zlib1g-dev

RUN git clone ${GITHUB} ${SRCDIR} && cd ${SRCDIR} && ./autogen.sh && ./configure CFLAGS="-O3" CXXFLAGS="-O3" --with-curl --with-crypto && make -j$(nproc --ignore=1) && cp -a ./cpuminer /usr/bin

RUN apt-get -y purge build-essential autoconf automake libjansson-dev libgmp-dev libcurl4-openssl-dev libssl-dev git zlib1g-dev && \
    apt-get -y autoremove; apt-get -y autoclean; apt-get -y clean; rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["cpuminer"]
