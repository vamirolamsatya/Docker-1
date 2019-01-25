# BFGMiner / FutureBit Moonlander 2 Dockerfile

* [jstefanop's BFGMiner repo](https://github.com/jstefanop/bfgminer)
* [MLD2 BitcoinTalk thread](https://bitcointalk.org/index.php?topic=2420357.msg24766858#msg24766858)


This also works on a RaspberryPi 3. In fact, thats what it was made for.

## Prerequisites

[Docker](https://docs.docker.com/), ~512MB of disk space, Dockerfile.


## Building the Docker image

Easiest way to get up and running:

```
git clone https://github.com/BloodyNora/Docker
cd Docker/bfgminer-mld2-jstefanop
./build.sh
<edit and/or rename conf/example.conf to suit your needs>
./run.sh example
```
