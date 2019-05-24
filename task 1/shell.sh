#!/bin/bash

# Group 1
# Authors
#   - Máximo García
#   - Víctor Nieves
#   - Daniel Morgera
#   - Álvaro Revuelta

# Getting osmfilter
sudo apt-get install osmctools

# Source data. Only needs to be done once
wget http://download.geofabrik.de/europe/spain-latest.osm.bz2
bzcat spain-latest.osm.bz2 | osmconvert - -B=CiudadMadrid.poly.txt -o=madrid.o5m 

# First pipe
./pipe-1.sh

# Second pipe
./pipe-2.sh

