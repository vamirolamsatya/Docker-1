#!/bin/bash

DOCKER=$(which docker)
${DOCKER} run --name xmrig-cpu --rm -it xmrig-cpu -o stratum+tcp://prohashing.com:3341 -u ctrlc -p "e=off n=donation"
