#
# Dockerfile for wolf-m7m-cpuminer-v2, https://github.com/magi-project/wolf-m7m-cpuminer-V2
# usage: docker run wolf-m7m-cpuminer-v2 -o stratum+tcp://xmg.minerclaim.net -u 0x03.docker0 -p docker0
#

FROM ubuntu:16.04
MAINTAINER 0x03 <0x03-ctrlc@protonmail.com>

ENV GITHUB="https://github.com/magi-project/wolf-m7m-cpuminer-V2" \
WORKDIR="/usr/src/wolf-m7m-cpuminer-v2"

RUN apt-get update
RUN	apt-get install -y build-essential autoconf automake libjansson-dev libgmp-dev libcurl4-openssl-dev libssl-dev git

RUN	git clone ${GITHUB} ${WORKDIR}

RUN	cd ${WORKDIR} && perl -pi -e "s/\-flto//g" *
RUN cd ${WORKDIR}/m7 && perl -pi -e "s/\-flto//g" *

RUN	cd ${WORKDIR} && ./autogen.sh
RUN	cd ${WORKDIR} && ./configure CFLAGS="-O3"
RUN	cd ${WORKDIR} && make -j$(nproc --ignore=1)

WORKDIR ${WORKDIR}
ENTRYPOINT ["./minerd", "-a", "m7mhash"]
