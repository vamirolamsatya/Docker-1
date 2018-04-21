#!/bin/bash

GIT=$(which git)
DOCKER=$(which docker)

${GIT} pull .
${DOCKER} build -t bitcoin-scrypt .
