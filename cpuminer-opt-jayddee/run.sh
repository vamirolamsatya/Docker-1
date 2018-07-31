#!/bin/bash

DOCKER=$(which docker)
${DOCKER} run --name eliminer --rm -itd cpuminer-opt-jayddee -a yescryptR16 -o stratum+tcp://pool.cpu-mining.xyz:6333 -u EXYBBHsZrEVmKHbTtNxsjQSLG1HmGxad15
