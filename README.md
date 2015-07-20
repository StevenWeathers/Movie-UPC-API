Movie UPC API
=======

Movie UPC API

Runs on Docker, Node 0.10.x (Planning to upgrade to 0.12.x soon)

Requires MySQL (MariaDB imo) and CRON for the data download/import

CRONTAB task
```
0  0   *   *   * sh /home/upc/cron.sh
```

```
docker build -t movieupcapi .

docker run -d -p "3000:3000" --name movieupcapi movieupcapi
```
