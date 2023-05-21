#!/bin/bash
cp /root/.htaccess /var/www/html
#cp /root/env.php /var/www/html
chmod 666 /var/www/html/.htaccess
chmod 666 /var/www/html/env.php
mv /var/www/html/protected/config/main.php.dist /var/www/html/protected/config/main.php
mv /var/www/html/protected/config/console.php.dist /var/www/html/protected/config/console.php

mkdir /var/www/html/assets
mkdir -p /var/www/html/pdf/albaranes
mkdir -p /var/www/html/pdf/facturas
mkdir -p /var/www/html/pdf/facturas_proveedores
#chown www-data:www-data -R /var/www/html/*
chmod -R +x /var/www/html/protected/scripts/sales/*
chmod -R +x /var/www/html/protected/scripts/ics/*

find /var/www/html/ -type d -exec chmod 777 {} \;
find /var/www/html/ -type f -exec chmod 666 {} \;

/usr/sbin/apachectl -DFOREGROUND &
/usr/local/sbin/php-fpm
