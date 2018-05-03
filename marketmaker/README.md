# BarterDEX/marketmaker Dockerfile

See https://komodoplatform.com/decentralized-exchange/

This Dockerfile comes with all assetchains enabled per default.

## Prerequisites

Docker, ~50GB of disk space, Dockerfile and a beefy machine (16GB+ RAM).


## Building the Docker image

Easiest way to get up and running:

```
git clone https://github.com/BloodyNora/Docker
cd Docker/marketmarker
./docker.sh build
./dorcker.sh run
<ctrl-p><ctrl-q>
```

## Interactive shell

```
docker attach marketmaker
```


