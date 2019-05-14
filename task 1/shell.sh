#!/bin/bash

# Getting osmfilter
sudo apt-get install osmctools

# Source data. Only needs to be done once
# rm spain-latest.osm.pbf
# wget http://download.geofabrik.de/europe/spain-latest.osm.pbf

# For fast data processing, using o5m is recommended. Only needs to be done once
#osmconvert spain-latest.osm.pbf -B=CiudadMadrid.poly.txt -o=madrid.o5m

# Filter data
osmfilter madrid.o5m --keep="bus = stop or subway = stop or train = stop" --ignore-depedencies | osmconvert - --all-to-nodes --csv="subway bus train @id @lat @lon name" --csv-headline --csv-separator=, | grep ",.*,.*,.*,.*,.*,." | python3 csv-to-sql.py

osmfilter madrid.o5m --keep="amenity=restaurant" -o=restaurants.o5m
osmfilter madrid.o5m --keep="amenity =bar" -o=bar.o5m
osmfilter madrid.o5m --keep="amenity=cafe" -o=cafe.o5m 

# Computer Science Vandal (CSV)
# Filter only stops with name
# osmconvert restaurants.o5m --all-to-nodes --csv="@id @lon lat name" --csv-headline --csv-separator=, | grep ",.*,.*,." | python3 csv-to-sql.py restaurants
# osmconvert bar.o5m --all-to-nodes --csv="@id @lon @lat name" --csv-headline --csv-separator=, | grep ",.*,.*,." | python3 csv-to-sql.py bar
# osmconvert cafe.o5m --all-to-nodes --csv="@id @lon @lat name" --csv-headline --csv-separator=, | grep ",.*,.*,." | python3 csv-to-sql.py cafes