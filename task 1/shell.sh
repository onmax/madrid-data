#!/bin/bash

# Getting osmfilter
# sudo apt-get install osmctools

# Source data. Only needs to be done once
# rm spain-latest.osm.pbf
# wget http://download.geofabrik.de/europe/spain-latest.osm.pbf

# For fast data processing, using o5m is recommended. Only needs to be done once
# It has to be here
osmconvert spain-latest.osm.pbf -B=CiudadMadrid.poly.txt -o=madrid.o5m 

# First pipe
./pipe-1.sh

# Second pipe
./pipe-2.sh

