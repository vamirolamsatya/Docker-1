#!/bin/bash

DOCKER=$(which docker)
${DOCKER} run --name nheqminer-veruscoin --rm -it nheqminer-veruscoin -v -l stratum.veruspool.xyz:9999 -u RB4E24growBcS5jMLrLTZJTToFdQ7r51VR -t 4
