# BFGMiner / FutureBit Moonlander 2 Dockerfile

* [jstefanop's BFGMiner repo](https://github.com/jstefanop/bfgminer)
* [BitcoinTalk support thread](https://bitcointalk.org/index.php?topic=2420357.msg24766858#msg24766858)


This also works on a RaspberryPi 3. In fact, thats what it was made for.

## Prerequisites

Docker, ~512MB of disk space, Dockerfile.


## Building the Docker image

Easiest way to get up and running:

```
git clone https://github.com/BloodyNora/Docker
cd Docker/bfgminer-mld2-jstefanop
./build.sh
# in the ./conf/ subdir, find a config file to copy and adapt.
# then, assuming your config file is named yourpool.conf, run:
./run.sh yourpool
```

## Did this help you? 

Consider donating!

```
LTC:  MHJN9mHjgYzqHQPXNCeYuxmnN4N3vneSvR
BTCS: 12aYzfPWEaYPiAwaVCPgM3DQgekXDFSrKv
EMC2: EfN8Q6bado86srxa66nVKJkfcwDBhbiiow
ABY:  ALHkvwbujjQCjFPujomuLdYi5ZbMeNGG7f
DGB:  DFkcHMPgT9hR2VjFTx6QaSfSiazKhubnXD
```
