# wolf-m7m-cpuminer-V2 Dockerfile

[wolf-m7m-cpuminer-V2 Repository](https://github.com/magi-project/wolf-m7m-cpuminer-V2)

This also works on a RaspberryPi 3.

## Prerequisites

Docker, ~1GB of disk space, Dockerfile.


## Building the Docker image

Easiest way to get up and running:

```
git clone https://github.com/BloodyNora/Docker
cd Docker/wolf-m7m-cpuminer-v2
./build.sh
<edit run.sh to suit your needs>
./run.sh
```
## Optimize Dockerfile for your device

The below example is optimized to run on a `Raspberry Pi 3b`. With GCC 4.7 and above you can use this command to determine useful flags for your CPU: ```gcc -mcpu=native -march=native -Q --help=target```

```
RUN git clone https://github.com/magi-project/wolf-m7m-cpuminer-V2 ${WORKDIR} && \
    cd ${WORKDIR} && perl -pi -e "s/\-O2//g" * && \
    cd ${WORKDIR} && perl -pi -e "s/\-march=native/\-mcpu=cortex-a53/g" * && \
    cd ${WORKDIR} && perl -pi -e "s/\-flto/\-mfpu=neon-vfpv4/g" * && \
    cd ${WORKDIR}/m7 && perl -pi -e "s/\-O2//g" * && \
    cd ${WORKDIR}/m7 && perl -pi -e "s/\-march=native/\-mcpu=cortex-a53/g" * && \
    cd ${WORKDIR}/m7 && perl -pi -e "s/\-flto/\-mfpu=neon-vfpv4/g" * && \
    cd ${WORKDIR} && ./autogen.sh && \
    ./configure CFLAGS="-Ofast" CXXFLAGS="-Ofast" && \
    make -j$(nproc --ignore=1)
```



## Donate

It's easy! Just **don't** change the `run.sh` file and start the miner, this will make it run at my benefit! Thank you!
