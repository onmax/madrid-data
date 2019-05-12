#!/bin/bash

# Getting osmfilter
sudo apt-get install osmctools python3-pip

# Source data. Only needs to be done once
# rm spain-latest.osm.pbf
# wget http://download.geofabrik.de/europe/spain-latest.osm.pbf

# For fast data processing, using o5m is recommended. Only needs to be done once
osmconvert spain-latest.osm.pbf -B=CiudadMadrid.poly.txt -o=madrid.o5m

rm madrid-stops.csv
# Filter data
osmfilter madrid.o5m --keep="public_transport=stop_position train=yes" -o=train-stations.o5m

# Computer Science Vandal (CSV)
# Filter only stops with name
# TODO: Improve sed pipe to allow full name. Rigth now, it splitting all name
osmconvert train-stations.o5m --all-to-nodes --csv="@id @lat @lon name" --csv-headline --csv-separator=, | grep ",.*,.*,." >> madrid-stops.csv
sed -i '1iid,lat,lon,name' madrid-stops.csv

# python dependencies
# pip3 install -r requirements.txt
rm madrid-stops.db
python3 csv-to-sql.py
