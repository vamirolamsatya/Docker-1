#!/bin/bash
. ./ccminer.conf
DOCKER=$(which docker)

if [ -z "${DOCKER}" ]; then
	echo "ERROR: Docker does not seem to be installed. Please download and install Docker CE as outlined on https://docs.docker.com/engine/install/."
	exit 1
else
	if [ ! -z "${WORKER_NAME}" ]; then
		PAYOUT_ADDRESS="${PAYOUT_ADDRESS}.${WORKER_NAME}"
	fi
	${DOCKER} run --name ${IMAGE_NAME} --rm -it ${IMAGE_NAME} -a verus -o stratum+ssl://${POOL_HOST}:${POOL_PORT} -u ${PAYOUT_ADDRESS} -p x -t ${THREADS}
fi

# EOF