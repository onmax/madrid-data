#!/usr/bin/env python3

import sys, os
import sqlite3

db_name = "stops.db"

if os.path.exists(db_name):
  os.remove(db_name)

con = sqlite3.connect(db_name)
cur = con.cursor()
cur.execute("CREATE TABLE stops (id, lat, lon, name);")

to_db = []
for line in sys.stdin:
    to_db.append(line.split(",", 3))
    
cur.executemany("INSERT INTO stops (id, lat, lon, name) VALUES (?, ?, ?, ?);", to_db)
con.commit()
con.close()
