# Dynamic Dynode Dockerfile

## Prerequisites

Docker, ~1GB (probably less) of disk space, Dockerfile.


## Building the Docker image

Easiest way to get up and running:

```
git clone https://github.com/BloodyNora/Docker
cd Docker/Dynamic.Dynode
<edit docker.conf with your editor of choice, at least adapt DOCKER_BUILD_NODEKEY>
./docker.sh build
./docker.sh daemon
<the usual setup procedure for dynodes from your control wallet>
```

## Interactive shell

```
docker attach dynode
OR
./docker.sh shell
```


