# Bitcoin-sCrypt Dockerfile

## Prerequisites

Docker, ~5GB of disk space, Dockerfile.


## Building the Docker image

Easiest way to get up and running:

```
git clone https://github.com/BloodyNora/Docker
cd Docker/dockerfiles/bitcoin-scrypt
./build.sh
```

## Preparing the container

We'll need a volume to store the datadir on.

```
docker volume create bitcoin-scrypt
```

## Starting the container

In this example, we'll set a custom hostname and use the volume we created before. The target= parameter is crucial.

```
docker run --rm --hostname=bitcoin-scrypt --network=host --mount source=bitcoin-scrypt,target=/home/bitcoin-scrypt --name bitcoin-scrypt -it bitcoin-scrypt
```
