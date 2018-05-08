#!/bin/bash
. ./docker.conf

GIT=$(which git)
DOCKER=$(which docker)
PWD=$(pwd)


function docker_build {
	if [ -z "$(${DOCKER} image ls | grep ${DOCKER_BUILD_TAG})" ]; then 
		echo "Image \"${DOCKER_BUILD_TAG}\" not found, building..."
		${GIT} pull .

		${DOCKER} build --build-arg=DYN_CONFIG_RPCPASSWORD=${DOCKER_BUILD_RPCPASSWORD} \
                    --build-arg=DYN_NODE_KEY=${DOCKER_BUILD_NODEKEY} \
		                --label=${DOCKER_BUILD_LABEL} \
		                --tag=${DOCKER_BUILD_TAG} \
		                ${PWD}
	else
		echo -n "Image \"${DOCKER_BUILD_TAG}\" already exists: "
		${DOCKER} image ls | grep ${DOCKER_BUILD_TAG}
		echo "Exiting!"
	fi
}

function docker_cleanup {
	if [ -z "$(${DOCKER} image ls | grep ${DOCKER_NAME})" ]; then
		echo "Image \"${DOCKER_NAME}\" does not exist, exiting!"
	else
		${DOCKER} image rm ${DOCKER_NAME}
	fi
}

function docker_cli {
	if [ -z "$(${DOCKER} ps | grep ${DOCKER_NAME})" ]; then
		echo "Container \"${DOCKER_NAME}\" not running, exiting!"
	else
		shift
		echo "Executing \"${@}\":"
		${DOCKER} run --rm \
		              --network=host \
		              --mount source=${DOCKER_VOLUME},target=${DOCKER_VOLUME_TARGET} \
		              -it ${DOCKER_NAME} \
		              dynamic-cli ${@}
	fi
}

function docker_daemon {
	if [ ! -z "$(${DOCKER} ps | grep ${DOCKER_NAME})" ]; then
		echo "Container \"${DOCKER_NAME}\" is already running, exiting!"
	else
		echo "Launching container \"${DOCKER_NAME}\":"
		${DOCKER} run --rm \
		              --network=host \
		              --hostname=${DOCKER_NAME} \
		              --name=${DOCKER_NAME} \
		              --mount source=${DOCKER_VOLUME},target=${DOCKER_VOLUME_TARGET} \
		              -idt ${DOCKER_NAME}
	fi
}

function docker_setup {
	if [ -z "$(${DOCKER} volume ls -q | grep ${DOCKER_VOLUME})" ]; then
		echo "Volume \"${DOCKER_VOLUME}\" not found, creating!"
		${DOCKER} volume create ${DOCKER_VOLUME}
	else
		echo "Volume \"${DOCKER_VOLUME}\" already existing, exiting!"
	fi
}

function docker_shell {
	if [ -z "$(${DOCKER} ps | grep ${DOCKER_NAME})" ]; then
		echo "Container \"${DOCKER_NAME}\" is not running, exiting!"
	else
		echo "Attaching to container \"${DOCKER_NAME}\":"
		${DOCKER} attach ${DOCKER_NAME}
	fi
}

function docker_stop {
	if [ -z "$(${DOCKER} ps | grep ${DOCKER_NAME})" ]; then
		echo "Container \"${DOCKER_NAME}\" is not running, exiting!"
	else
		echo -n "Halting container: "
		${DOCKER} stop ${DOCKER_NAME}
		echo "Done!"
	fi
}


case "${1}" in
	build)
		docker_build
		;;
	cleanup)
		docker_cleanup
		;;
	cli)
		docker_cli ${@}
		;;
	daemon)
		docker_daemon
		;;
	setup)
		docker_setup
		;;
	shell)
		docker_shell
		;;
	stop)
		docker_stop
		;;
	*)
		echo "Error, no such command \"${1}\"!"
		echo "Available commands: "
		echo "  - build   Builds the docker image"
		echo "  - cleanup Removes built images"
		echo "  - cli     Interacts with the running container in cli mode"
		echo "  - daemon  Launches the daemon"
		echo "  - setup   Creates persistent data volume"
		echo "  - shell   Attaches to running container"
		echo "  - stop    Stops the running container"
    echo
		exit 1
esac

exit 0
