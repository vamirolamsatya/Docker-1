#!/bin/bash
. ./ccminer.conf
GIT=$(which git)
DOCKER=$(which docker)

if [ -z "${DOCKER}" ]; then
    echo "ERROR: Docker does not seem to be installed. Please download and install Docker CE as outlined on https://docs.docker.com/engine/install/."
    exit 1
elif [ -z "${GIT}" ]; then
	echo "ERROR: git does not seem to be installed. Please install git for your OS/distribution."
	exit 1
else
	${GIT} pull
	${DOCKER} build -t ${IMAGE_NAME} .
fi

# EOF
