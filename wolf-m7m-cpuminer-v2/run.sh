#!/bin/bash

DOCKER=$(which docker)
${DOCKER} run --rm -it wolf-m7m-cpuminer-v2 -o stratum+tcp://xmg.minerclaim.net:7008 -u 0x03.x220 -p x220
