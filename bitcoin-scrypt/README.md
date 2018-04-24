# Bitcoin-sCrypt Dockerfile

## Prerequisites

Docker, ~5GB of disk space, Dockerfile.


## Building the Docker image

Easiest way to get up and running:

```
git clone https://github.com/BloodyNora/Docker
cd Docker/bitcoin-scrypt
./docker.sh build
./dorcker.sh setup
./docker.sh daemon
<ctrl-p><ctrl-q>
```

## Interactive shell

```
docker attach bitcoin-scrypt
```


