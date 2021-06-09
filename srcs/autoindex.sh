#!bin/bash

if grep -q "autoindex on;" /etc/nginx/sites-available/nginx.conf;
then 
  sed -i "s/autoindex on;/autoindex off;/" /etc/nginx/sites-available/nginx.conf;
  echo "autoindex off"
else 
  sed -i "s/autoindex off;/autoindex on;/" /etc/nginx/sites-available/nginx.conf;
  echo "autoindex on"
fi
nginx -s reload