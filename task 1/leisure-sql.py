#!/usr/bin/env python3

import sys
import os
import sqlite3

db_name = "madrid-data.db"

con = sqlite3.connect(db_name)
cur = con.cursor()

to_db = {"bar": [], "cafe": [], "restaurant": []}
[cur.execute("CREATE TABLE IF NOT EXISTS {0} (id, lat, lon, web, name);"
             .format(i)) for i in to_db]

for line in sys.stdin:
    row = line[:-1].split(",", 5)
    if(row[1][0] == "@"):
        continue
    to_db[row[0]].append(row[1:])

for amenity in to_db:
    cur.executemany("INSERT INTO {0}(id, lat, lon, web, name) VALUES(?, ?, ?, ?, ?)".format(
        amenity), to_db[amenity])

con.commit()
con.close()
