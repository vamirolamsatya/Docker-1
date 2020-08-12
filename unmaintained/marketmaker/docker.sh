#!/bin/bash
. ./docker.conf

GIT=$(which git)
DOCKER=$(which docker)
PWD=$(pwd)


function docker_build {
	if [ -z "$(${DOCKER} image ls | grep ${DOCKER_BUILD_TAG})" ]; then 
		echo "Image \"${DOCKER_BUILD_TAG}\" not found, building..."

		${DOCKER} build --build-arg=PASSPHRASE="${DOCKER_BUILD_PASSPHRASE}" \
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

  #if [ -z "$(${DOCKER} volume ls | grep ${DOCKER_VOLUME})" ]; then
  #  echo "Volume \"${DOCKER_VOLUME}\" does not exist, exiting!"
  #else
  #  ${DOCKER} volume rm ${DOCKER_VOLUME}
  #fi

}

function docker_run {
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
	run)
		docker_run
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
		echo "  - run     Launches the daemon"
		echo "  - shell   Attaches to running container"
		echo "  - stop    Stops the running container"
    echo
		exit 1
esac

exit 0
