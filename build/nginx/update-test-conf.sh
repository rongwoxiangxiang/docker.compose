#!/bin/bash

# Understanding Nginx Server and Location Block Selection Algorithms
# https://www.digitalocean.com/community/tutorials/understanding-nginx-server-and-location-block-selection-algorithms

pushd nginx/conf.d > /dev/null
for var in *.dev.conf
do
	cp "$var" "${var%dev.conf}test.conf"
done
sed -i 's/\.dev/\.test/g' *.test.conf
popd > /dev/null
