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
osmfilter madrid.o5m --keep="bus = stop or subway = stop or train = stop" --ignore-depedencies | osmconvert - --all-to-nodes --csv="subway bus train @id @lat @lon name" --csv-headline --csv-separator=, | grep ",.*,.*,.*,.*,.*,." | python3 ./public-transports-sql.py

# Second pipe
osmfilter madrid.o5m --keep="amenity=bar or amenity=cafe or amenity=restaurant " --ignore-depedencies | osmconvert - --all-to-nodes --csv="amenity @id @lat @lon website name" --csv-headline --csv-separator=, |  grep ",.*,.*,.*,.*,." | python3 ./leisure-sql.py
