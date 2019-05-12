#!/bin/bash

# Getting osmfilter
sudo apt-get install osmctools

# Source data. Only needs to be done once
# rm spain-latest.osm.pbf
# wget http://download.geofabrik.de/europe/spain-latest.osm.pbf

# For fast data processing, using o5m is recommended. Only needs to be done once
osmconvert spain-latest.osm.pbf -B=CiudadMadrid.poly.txt -o=madrid.o5m

# Filter data
osmfilter madrid.o5m --keep="bus = bus_stop" -o=bus_stops.o5m 
osmfilter madrid.o5m --keep="subway = subway_stop" -o=subway_stops.o5m 
osmfilter madrid.o5m --keep="train = train_stop" -o=train_stops.o5m 

osmfilter madrid.o5m --keep="amenity=restaurant" -o=restaurants.o5m
osmfilter madrid.o5m --keep="amenity =bar" -o=bar.o5m
osmfilter madrid.o5m --keep="amenity=cafe" -o=cafe.o5m 

# Computer Science Vandal (CSV)
# Filter only stops with name
osmconvert bus_stops.o5m --all-to-nodes --csv="@id @lat @lon name" --csv-headline --csv-separator=, | grep ",.*,.*,." | python3 csv-to-sql.py bus_stops
osmconvert subway_stops.o5m --all-to-nodes --csv="@id @lat @lon name" --csv-headline --csv-separator=, | grep ",.*,.*,." | python3 csv-to-sql.py subway_stops
osmconvert train_stops.o5m --all-to-nodes --csv="@id @lat @lon name" --csv-headline --csv-separator=, | grep ",.*,.*,." | python3 csv-to-sql.py train_stops


osmconvert restaurants.o5m --all-to-nodes --csv="@id @lon @lat name" --csv-headline --csv-separator=, | grep ",.*,.*,." | python3 csv-to-sql.py restaurants
osmconvert bar.o5m --all-to-nodes --csv="@id @lon @lat name" --csv-headline --csv-separator=, | grep ",.*,.*,." | python3 csv-to-sql.py bar
osmconvert cafe.o5m --all-to-nodes --csv="@id @lon @lat name" --csv-headline --csv-separator=, | grep ",.*,.*,." | python3 csv-to-sql.py cafes

