Movie UPC API
=======

Movie UPC API

Runs on Docker, Node 0.12.x

Requires MySQL (I suggest MariaDB) and CRON for the data download/import

CRONTAB task
```
0  0   *   *   * sh /home/upc/cron.sh
```

```
docker build -t movieupcapi .

docker run -d -p "3000:3000" --name movieupcapi movieupcapi
```
