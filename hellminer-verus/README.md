# Dockerfile for hellminer-verus

For more info see one of these websites: 

 * https://veruscoin.io
 * https://luckpool.net/verus
 * https://github.com/hellcatz/luckpool

## Prerequisites

[Docker](https://docs.docker.com/install/), ~200MB of disk space and the contents of this directory.

## Building the Docker image

Easiest way to get up and running:

```
git clone https://github.com/bloodynora/docker
cd docker/hellminer-verus
./build.sh
<edit hellminer.conf to suit your needs>
./run.sh
```

## LuckPool regional stratum servers

Please note that `hellminer` only supports mining on `LuckPool`. However, depending on your country of origin, it may be wise to use a different `stratum` endpoint. See [here](https://luckpool.net/verus/connect.html) for more info.


## Did this help you? 

Consider donating!

```
VRSC: RJgMwyavimFjJ6DtgdkuxxUqWCuKbpf8rp
```