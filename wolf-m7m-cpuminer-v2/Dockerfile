#
# Dockerfile for wolf-m7m-cpuminer-v2, https://github.com/magi-project/wolf-m7m-cpuminer-V2
# usage: docker run wolf-m7m-cpuminer-v2 -o stratum+tcp://xmg.minerclaim.net -u 0x03.docker0 -p docker0
#

FROM debian:9.5
MAINTAINER 0x03 <0x03-ctrlc@protonmail.com>

ENV GITHUB="https://github.com/magi-project/wolf-m7m-cpuminer-V2" \
WORKDIR="/usr/src/wolf-m7m-cpuminer-v2"

RUN apt update && apt -y upgrade && \
    apt -y install -y build-essential autoconf automake libjansson-dev \
    libgmp-dev libcurl4-openssl-dev libssl-dev git
    
RUN	git clone ${GITHUB} ${WORKDIR} && \
    cd ${WORKDIR} && perl -pi -e "s/\-flto//g" * && \
    cd ${WORKDIR}/m7 && perl -pi -e "s/\-flto//g" * && \
    cd ${WORKDIR} && ./autogen.sh && \
    ./configure CFLAGS="-O3" && \
    make -j$(nproc --ignore=1)
    
WORKDIR ${WORKDIR}
ENTRYPOINT ["./minerd", "-a", "m7mhash"]
