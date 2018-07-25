#!/bin/bash

DOCKER=$(which docker)
${DOCKER} run --name bfgminer-mld2 --privileged -v /dev//bus/usb:/dev/bus/usb --rm -itd bfgminer-mld2-jstefanop --scrypt -o stratum+tcp://litecoinpool.org:3333 -u BloodyNora.1 -p 1 -S ALL --set MLD:clock=876
