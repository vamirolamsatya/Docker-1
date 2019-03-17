#!/bin/bash

GIT=$(which git)
DOCKER=$(which docker)

if [ -z "${DOCKER}" ]; then
    echo "ERROR: Docker does not seem to be installed. Please download and install Docker CE."
    exit 1
else
	${GIT} pull
	${DOCKER} build -t nheqminer-veruscoin .
fi

