#!/bin/bash

DOCKER=$(which docker)
${DOCKER} run --name magiminer --rm -it wolf-m7m-cpuminer-v2 -o stratum+tcp://xmg.minerclaim.net:7008 -u 0x03.donation -p donation
