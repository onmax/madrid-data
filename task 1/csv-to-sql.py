#!/usr/bin/env python3

import sys
import os
import sqlite3

db_name = "stops.db"

if os.path.exists(db_name):
    os.remove(db_name)

con = sqlite3.connect(db_name)
cur = con.cursor()
transports = ["subway", "bus", "train"]
[cur.execute("CREATE TABLE {0} (id, lat, lon, name);".format(i))
 for i in transports]

to_db = {"subway": [], "bus": [], "train": []}
for line in sys.stdin:
    if(line[0] == "@"):
        continue
    row = line.split(",", 6)
    to_db[transports[[i for i, e in enumerate(
        row[0:3]) if e != ''][0]]].append(row[3:])

for transport in transports:
    cur.executemany("INSERT INTO {0}(id, lat, lon, name) VALUES(?, ?, ?, ?)".format(
        transport), to_db[transport])

con.commit()
con.close()
