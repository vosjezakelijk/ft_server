FROM debian:buster

RUN apt-get update && apt-get upgrade
RUN apt-get install wget nginx vim mariadb-server \
	php7.3 php-mysql php-fpm php-pdo php-gd php-cli php-mbstring

RUN mkdir /var/www/localhost
WORKDIR /var/www/localhost

COPY ./srcs/config.inc.php phpmyadmin

RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-english.tar.gz
RUN tar -xf phpMyAdmin-5.0.1-english.tar.gz && rm -rf phpMyAdmin-5.0.1-english.tar.gz
RUN mv phpMyAdmin-5.0.1-english phpMyAdmin

RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xvzf latest.tar.gz && rm -rf latest.tar.gz
COPY ./srcs/wp-config.php /var/www/localhost/wordpress/

COPY ./srcs/nginx.conf /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/nginx.conf
RUN	rm /etc/nginx/sites-enabled/default && rm /etc/nginx/sites-available/default

COPY ./srcs/server.sh ./
COPY ./srcs/autoindex.sh ./

RUN openssl req -x509 -nodes -days 365 \
-subj "/C=RU/ST=MOSCOW/L=MOSCOW/O=SCHOOL21/OU=21MOSCOW/CN=hsamatha" \
-newkey rsa:2048 \
-keyout /etc/ssl/nginx-selfsigned.key \
-out /etc/ssl/nginx-selfsigned.crt;

RUN chmod -R 755 /var/www/*
RUN chown -R www-data /var/www/*

EXPOSE 80 443

ENTRYPOINT ["sh", "server.sh"]