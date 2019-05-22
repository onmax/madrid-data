#!/bin/bash

# Group 1
# Authors
#   - Máximo García
#   - Víctor Nieves
#   - Daniel Morgera
#   - Álvaro Revuelta

# Getting osmfilter
# sudo apt-get install osmctools

# Source data. Only needs to be done once
# wget http://download.geofabrik.de/europe/spain-latest.osm.bz2
# bzcat spain-latest.osm.bz2 | osmconvert - -B=CiudadMadrid.poly.txt -o=madrid.o5m 

# First pipe
osmfilter madrid.o5m --keep="bus = stop or subway = stop or train = stop" --ignore-depedencies | osmconvert - --all-to-nodes --csv="subway bus train @id @lat @lon name" --csv-headline --csv-separator=, | grep ",.*,.*,.*,.*,.*,." | python3 ./public-transports-sql.py

# Second pipe
osmfilter madrid.o5m --keep="amenity=bar or amenity=cafe or amenity=restaurant " --ignore-depedencies | osmconvert - --all-to-nodes --csv="amenity @id @lat @lon website name" --csv-headline --csv-separator=, |  grep ",.*,.*,.*,.*,." | python3 ./leisure-sql.py
