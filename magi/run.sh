#!/bin/bash

DOCKER=$(which docker)
${DOCKER} run --rm --network=host --hostname=magi --mount source=magi,target=/home/magi --cpus="2.0" -it magi /bin/bash
