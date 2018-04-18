#
# Dockerfile for wolf-m7m-cpuminer-v2, https://github.com/magi-project/wolf-m7m-cpuminer-V2
# usage: docker run wolf-m7m-cpuminer-v2 --url xxxx --user xxxx --pass xxxx
# ex: docker run creack/cpuminer --url stratum+tcp://ltc.pool.com:80 --user creack.worker1 --pass abcdef
#

FROM       ubuntu:16.04
MAINTAINER 0x03 <0x03-ctrlc@protonmail.com>

RUN apt-get update
RUN	apt-get install -y build-essential autoconf automake libjansson-dev libgmp-dev libcurl4-openssl-dev libssl-dev git

RUN	git clone https://github.com/magi-project/wolf-m7m-cpuminer-V2 wolf-m7m-cpuminer

RUN	cd wolf-m7m-cpuminer && perl -pi -e "s/\-flto//g" *; cd m7; perl -pi -e "s/\-flto//g" *; cd ..

RUN	cd wolf-m7m-cpuminer && ./autogen.sh
RUN	cd wolf-m7m-cpuminer && ./configure CFLAGS="-O3"
RUN	cd wolf-m7m-cpuminer && make

WORKDIR	   /wolf-m7m-cpuminer
ENTRYPOINT ["./minerd", "-a", "m7mhash"]

