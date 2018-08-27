#!/bin/bash

DOCKER=$(which docker)

if [ -z "${DOCKER}" ]; then
	echo "ERROR: Docker does not seem to be installed. Please download and install Docker CE."
	exit 1
else
	${DOCKER} run --name nheqminer-veruscoin --rm -it nheqminer-veruscoin -v -l stratum.veruspool.xyz:9999 -u RB4E24growBcS5jMLrLTZJTToFdQ7r51VR -t 4
fi
