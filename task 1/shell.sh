#!/bin/bash

# Getting osmfilter
sudo apt-get install osmctools

# Source data. Only needs to be done once
# rm spain-latest.osm.pbf
# wget http://download.geofabrik.de/europe/spain-latest.osm.pbf

# For fast data processing, using o5m is recommended. Only needs to be done once
osmconvert spain-latest.osm.pbf -B=CiudadMadrid.poly.txt -o=madrid.o5m

# Filter data
osmfilter madrid.o5m --keep="public_transport=stop_position train=yes" -o=train-stations.o5m
osmfilter madrid.o5m --keep="railway=subway public_transport=stop_position subway=yes" -o=sw-stations.o5m
osmfilter madrid.o5m --keep="public_transport=stop_position bus=yes" -o=bs-stations.o5m

# Computer Science Vandal (CSV)
# Filter only stops with name
osmconvert train-stations.o5m --all-to-nodes --csv="@id @lat @lon name" --csv-headline --csv-separator=, | grep ",.*,.*,." | python3 csv-to-sql.py


