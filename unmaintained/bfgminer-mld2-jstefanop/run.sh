#!/bin/bash

DOCKER=$(which docker)
if [ -z "${DOCKER}" ]; then
	echo "ERROR: Docker was not found. exiting!"
	echo "to install, simply run: \"curl https://get.docker.com | sudo sh\""
	exit
fi

if [ -z "${1}" ]; then
	echo "ERROR: no config file given, exiting!"
	echo "USAGE: ${0} example"
	exit
elif [ ! -f ./conf/${1}.conf ]; then
	echo "ERROR: no such config file \"${1}.conf\", exiting!"
	exit
else
	# load config
	. ./conf/${1}.conf
	# WORKER_PASS not needed on all pools, thus not checking
	if [ -z "${POOL_HOST}" ] || [ -z "${WORKER_NAME}" ]; then
		echo "ERROR: config file \"${1}.conf\" is either missing some crucial parameters or is complete crap. exiting!"
		exit
	else
		if [ -z "${MOONLANDER_DEVICES}" ]; then
			# use all available devices per default
			MOONLANDER_DEVICES="ALL"
		fi
		if [ -z "${MOONLANDER_CLOCK}" ]; then
			# per default a lower, pretty much safe clock speed
			MOONLANDER_CLOCK="768"
		fi

		#
		# docker startting happens here
		# 
		${DOCKER} run --name ${DOCKER_NAME} \
			--privileged -v /dev/bus/usb:/dev/bus/usb --rm \
			-it ${DOCKER_DETACH} bfgminer-mld2-jstefanop -o ${POOL_HOST} -u ${WORKER_NAME} -p "${WORKER_PASS}" ${MOONLANDER_DEVICES} ${MOONLANDER_CLOCK} ${BFGMINER_EXTRA_ARGS}
	fi
fi

# EOF
