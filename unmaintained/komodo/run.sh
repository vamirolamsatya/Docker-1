#!/bin/bash

DOCKER=$(which docker)
${DOCKER} run --rm --network=host --hostname=komodo --mount source=komodo,target=/home/komodo --cpus="2.0" -it komodo /bin/bash
