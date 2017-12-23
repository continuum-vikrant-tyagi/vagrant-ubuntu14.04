#!/usr/bin/env bash

sudo apt-get update

#install apache2
sudo apt-get -y install apache2

#install php5
sudo apt-get -y install php5 libapache2-mod-php5 php5-mcrypt
sudo apt-get -y install php5-cgi php5-cli php5-common php5-curl php5-gd php5-mysql php5-xmlrpc

#install mysql

sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password vagrant'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password vagrant'
sudo apt-get -y install mysql-server libapache2-mod-auth-mysql php5-mysql

sudo service apache2 restart

cd /var/www

## Create Database and Import SQL File
echo Create Database 

sudo mysql -uroot -pvagrant -e "CREATE DATABASE db_dev_tapovan";

echo Import SQL FIle
sudo mysql -uroot -pvagrant db_dev_tapovan < db/db_tapovanprasad.sql

## virtual host setup

sudo cp startup/tapovan /etc/apache2/sites-available/
sudo a2ensite tapovan
sudo a2enmod rewrite 
sudo service apache2 restart
