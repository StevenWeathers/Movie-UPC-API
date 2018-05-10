#!/bin/sh

# switch to app folder to download files into
cd /app

#download the dvd upc database csv
wget -N --user-agent="Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.0.3705; .NET CLR 1.1.4322)" "http://hometheaterinfo.com/download/dvd_csv.zip"

#unzip the dvd upc
unzip -o dvd_csv.zip

#delete the zip
rm -f dvd_csv.zip

#delete the copyright file
rm -f copyright.txt

#delete the old file
rm -f upc.txt

#rename the file
mv dvd_csv.txt upc.txt
