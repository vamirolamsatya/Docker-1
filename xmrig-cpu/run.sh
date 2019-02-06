#!/bin/bash

DOCKER=$(which docker)
${DOCKER} run --name xmrig-cpu --rm -it xmrig-cpu --donation-level=1 -o stratum+tcp://prohashing.com:3341 -u ctrlc -p "e=off n=donation"
