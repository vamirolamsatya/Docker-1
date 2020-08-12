#
# Dockerfile for hellminer-verus, https://github.com/hellcatz/luckpool
# see run.sh
#

FROM debian:buster-slim
LABEL MAINTAINER="0x03 <0x03-ctrlc@protonmail.com>"

RUN cd /root && apt update && apt -y install wget && wget https://github.com/hellcatz/luckpool/raw/master/miners/hellminer_cpu_linux.tar.gz && \
	tar xf hellminer_cpu_linux.tar.gz && rm -rf /root/hellminer_cpu_linux.tar.gz && \
	apt -y purge wget && apt -y autoremove --purge && apt -y clean && apt -y autoclean; rm -rf /var/lib/apt/lists/*

WORKDIR "/root"
ENTRYPOINT ["/root/hellminer"]

# EOF