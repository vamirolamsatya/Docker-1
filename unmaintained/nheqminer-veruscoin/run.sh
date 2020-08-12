#!/bin/bash

DOCKER=$(which docker)
. ./nheqminer.conf

if [ -z "${DOCKER}" ]; then
	echo "ERROR: Docker does not seem to be installed. Please download and install Docker CE."
	exit 1
else
	if [ ! -z "${WORKER_NAME}" ]; then
		PAYOUT_ADDRESS="${PAYOUT_ADDRESS}.${WORKER_NAME}"
	fi
	${DOCKER} run --name nheqminer-veruscoin --rm -it nheqminer-veruscoin -v -l ${POOL_HOST}:${POOL_PORT} -u ${PAYOUT_ADDRESS} -t ${NHEQ_THREADS}
fi
