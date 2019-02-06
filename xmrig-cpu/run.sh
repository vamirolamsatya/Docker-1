#!/bin/bash

DOCKER=$(which docker)
${DOCKER} run --name xmrig-cpu --rm -it xmrig-cpu -o stratum+tcp://prohashing.com:3341 -u ctrlc -p "e=off n=miner2 d=512" -x socks://172.27.20.1:9050 -s 1
