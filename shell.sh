#!/bin/bash

# Getting osmfilter
sudo apt-get install osmctools

# Source data. Only needs to be done once
# wget http://download.geofabrik.de/europe/spain-latest.osm.pbf

# For fast data processing, using o5m is recommended. Only needs to be done once
# osmconvert spain-latest.osm.pbf -B=CiudadMadrid.poly.txt -o=spain.o5m

# Computer Science Vandal (CSV)
# Filter only stops with name
osmconvert spain.o5m --all-to-nodes --csv="@id @lat @lon name" --csv-headline | grep -i '[0-9]*[[:blank:]][0-9]*\.[0-9]*[[:blank:]]-[0-9]\.[0-9]*[[:blank:]][0-9a-zA-Z]' >> stops.csv