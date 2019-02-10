#!/bin/bash

DOCKER=$(which docker)
${DOCKER} run --name magiminer --rm -it wolf-m7m-cpuminer-v2 -o stratum+tcp://xmg.pool-mining.xyz:3002 -u 9CKNi7Pv9eaHJCN889PTAZ6L8KbeU4JZTs -p x
