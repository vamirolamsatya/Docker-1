#!/bin/bash

DOCKER=$(which docker)
${DOCKER} run --rm --network=host --hostname=bitcoin-scrypt --mount source=bitcoin-scrypt,target=/home/bitcoin-scrypt --cpus="2.0" -it bitcoin-scrypt
