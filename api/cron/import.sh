#!/bin/sh

# todo - rebuild this as a nodejs import script to mongodb
mysqlimport --fields-enclosed-by='"' --fields-terminated-by="|" --lines-terminated-by="\r\n" movieupc /var/www/domains/movieupc.com/cron/upc.txt -umovieupc -pD1sneyRocks --delete --columns=DVD_Title,Studio,Released,Status,Sound,Versions,Price,Rating,Year,Genre,Aspect,UPC,DVD_ReleaseDate,ID,Timestamp