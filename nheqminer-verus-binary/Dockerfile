#
# Dockerfile for nheqminer-verus-binary, https://github.com/veruscoin/nheqminer/releases
# see run.sh
#

FROM debian:buster-slim
LABEL MAINTAINER="0x03 <0x03-ctrlc@protonmail.com>"

RUN cd /root && apt update && apt -y install wget && wget https://github.com/VerusCoin/nheqminer/releases/download/v0.8.2/nheqminer-Linux-v0.8.2.tgz && \
	tar xf nheqminer-Linux-v0.8.2.tgz && tar xf nheqminer-Linux-v0.8.2.tar.gz && rm -rf /root/nheqminer-Linux*  && \
	apt -y purge wget && apt -y autoremove --purge && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/root/nheqminer/nheqminer"]

# EOF
