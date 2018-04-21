#!/bin/bash

DOCKER=$(which docker)
${DOCKER} run --rm --network=host --hostname=bitcoin-scrypt --name=bitcoin-scrypt --mount source=bitcoin-scrypt,target=/home/bitcoin-scrypt -it bitcoin-scrypt ${@}
