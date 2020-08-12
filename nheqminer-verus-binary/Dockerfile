#
# Dockerfile for nheqminer-verus-binary, https://github.com/veruscoin/nheqminer/releases
# see run.sh
#

FROM debian:buster-slim
LABEL MAINTAINER="0x03 <0x03-ctrlc@protonmail.com>"

RUN apt-get update && apt-get -y install wget && cd /opt && wget https://github.com/VerusCoin/nheqminer/releases/download/v0.8.2/nheqminer-Linux-v0.8.2.tgz && \
	tar xf nheqminer-Linux-v0.8.2.tgz && tar xf nheqminer-Linux-v0.8.2.tar.gz && \
    mv /opt/nheqminer /opt/nheq && mv /opt/nheq/nheqminer /opt &&  rm -rf /opt/nheqminer-Linux* /opt/nheq  && \
	apt-get -y purge wget && apt-get -y autoremove --purge && rm -rf /var/lib/apt-get/lists/*

USER nobody:nogroup
WORKDIR "/opt"
ENTRYPOINT ["/opt/nheqminer"]

# EOF
