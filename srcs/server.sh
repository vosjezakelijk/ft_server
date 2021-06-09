#!bin/bash

service nginx start
service php7.3-fpm start
service mysql start

echo "CREATE DATABASE wordpress;" | mysql -u root
echo "CREATE USER 'hsamatha'@'localhost' IDENTIFIED BY '1129';" | mysql -u root
echo "GRANT ALL ON wordpress.* TO 'hsamatha'@'localhost' IDENTIFIED BY '1129' WITH GRANT OPTION;" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root