#!/usr/bin/env python3

import csv
file2 = "test.csv"
with open(file2) as csvfile:
    reader = csv.reader(csvfile,delimiter=",")
    for row in reader:
        print("\t".join(row))

with open("outtest.csv","w") as csvfile:
    writer = csv.writer(csvfile,delimiter=",")
    writer.writerow(["Name","Flavor","Color"])
    writer.writerow(["Apple","Sweet","Red\tYellow"])
    writer.writerow(["Pretzel","Salty","Brown"])
