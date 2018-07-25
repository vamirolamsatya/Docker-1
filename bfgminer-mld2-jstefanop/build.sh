#!/bin/bash

GIT=$(which git)
DOCKER=$(which docker)

${GIT} pull
${DOCKER} build -t wolf-m7m-cpuminer-v2 .
