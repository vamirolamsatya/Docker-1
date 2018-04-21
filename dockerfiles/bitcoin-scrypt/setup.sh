#!/bin/bash
DOCKER=$(which docker)
DOCKER_VOLUME="bitcoin-scrypt"

if [ -z "$(docker volume ls -q | grep ${DOCKER_VOLUME})" ]; then
	echo "Volume \"${DOCKER_VOLUME}\" not found, creating!"
	${DOCKER} volume create ${DOCKER_VOLUME}
else
	echo "Volume \"${DOCKER_VOLUME}\" already existing, exiting!"
fi

