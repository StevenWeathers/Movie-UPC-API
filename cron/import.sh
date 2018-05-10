#!/bin/sh

# todo - rebuild this as a nodejs import script to mongodb
# mysqlimport --fields-enclosed-by='"' --fields-terminated-by="," --lines-terminated-by="\r\n" movieupc /app/upc.txt -umovieupc -pD1sneyRocks --delete --columns=DVD_Title,Studio,Released,Status,Sound,Versions,Price,Rating,Year,Genre,Aspect,UPC,DVD_ReleaseDate,ID,Timestamp

mongoimport --host mongo --db movieupc --collection movies --type csv --columnsHaveTypes --fields "DVD_Title.string(),Studio.string(),Released.string(),Status.string(),Sound.string(),Versions.string(),Price.string(),Rating.string(),Year.string(),Genre.string(),Aspect.string(),UPC.string(),DVD_ReleaseDate.string(),ID.string(),Timestamp.string()" --upsertFields "UPC" --file /app/upc.txt
