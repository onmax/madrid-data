import csv, sqlite3

con = sqlite3.connect("madrid-stops.db")
cur = con.cursor()
cur.execute("CREATE TABLE stops (id, lat, lon, name);")

with open('madrid-stops.csv','rt', encoding='utf-8') as fin:
    dr = csv.DictReader(fin)
    to_db = [(i['id'], i['lat'], i['lon'], i['name']) for i in dr]

cur.executemany("INSERT INTO stops (id, lat, lon, name) VALUES (?, ?, ?, ?);", to_db)
con.commit()
con.close()
