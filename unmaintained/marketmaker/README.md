# BarterDEX/marketmaker Dockerfile

See https://komodoplatform.com/decentralized-exchange/

## Whats in this?

A komodo daemon, running for KMD and all Komodo asset chains. And a BarterDEX/marketmaker configured to make use of all of these.

## Prerequisites

Docker, ~50GB of disk space and about 10GB of RAM.


## Building the Docker image

Easiest way to get up and running:

```
git clone https://github.com/BloodyNora/Docker
cd Docker/marketmarker
<edit docker.conf with your favourite editor>
./docker.sh build
./docker.sh run
```

## Interactive shell

```
./docker.sh shell
```


