#!/bin/bash

# Get root up in here
sudo su

# Just a simple way of checking if we need to install everything
if [ ! -d "/var/log/movie-upc-api" ]
then
  apt-get install -y python-software-properties build-essential git-core curl vim wget unzip software-properties-common
  # Add MariaDB apt-key and repository
  apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
  add-apt-repository -y 'deb http://nyc2.mirrors.digitalocean.com/mariadb/repo/5.5/ubuntu trusty main'
  # Reload local package database
  apt-get update
  # Install the latest stable version of MariaDB
  export DEBIAN_FRONTEND=noninteractive
  debconf-set-selections <<< 'mariadb-server-5.5 mysql-server/root-password password root'
  debconf-set-selections <<< 'mariadb-server-5.5 mysql-server/root_password_again password root'
  apt-get install -qq mariadb-server

  # Set Up SQL Database
  mysql -uroot -e "create database movieupc;"
  # Add movieupc user and grant privileges
  mysql -uroot -e "GRANT ALL ON movieupc.* TO 'movieupc'@'localhost' IDENTIFIED BY 'D1sneyRocks'; GRANT FILE ON *.* to 'movieupc'@'localhost'; FLUSH PRIVILEGES;"
  # Add Tables to Database
  mysql -uroot movieupc< /home/vagrant/movie-upc-api/movieupc_structure.sql

  # Add sql01 hostname to /etc/hosts to match production
  echo "localhost sql01" >> /etc/hosts

  service mysql restart

  # install NVM
  curl https://raw.githubusercontent.com/creationix/nvm/v0.12.0/install.sh | bash
  source /root/.profile
  nvm install 0.10 # install Node 0.10 latest stable
  nvm alias default 0.10 # set 0.10 latest stable as default node version

  #install Forever globally
  npm install forever -g

  # Run it
  mkdir /var/log/movie-upc-api
  mkdir /var/www/
  mkdir /var/www/domains/
  mkdir /var/www/domains/movieupc.com/
  ln -s /home/vagrant/movie-upc-api/cron /var/www/domains/movieupc.com/cron
  # Import UPC Data
  bash /var/www/domains/movieupc.com/cron/download.sh
  bash /var/www/domains/movieupc.com/cron/import.sh

  cd /home/vagrant/movie-upc-api/
  forever --watch --minUptime 1000 --spinSleepTime 1000 -o /var/log/movie-upc-api/out.log -e /var/log/movie-upc-api/err.log start movieupcapi.js

  # Victory!
  echo "You're all done! Your Movie-UPC-API server should now be listening on http://192.168.32.10:3000"
else
  # Import UPC Data
  bash /var/www/domains/movieupc.com/cron/download.sh
  bash /var/www/domains/movieupc.com/cron/import.sh

  cd /home/vagrant/movie-upc-api/
  forever --watch --minUptime 1000 --spinSleepTime 1000 -o /var/log/movie-upc-api/out.log -e /var/log/movie-upc-api/err.log start movieupcapi.js
  echo "Your Movie-UPC-API server should now be listening on http://192.168.32.10:3000"
fi
