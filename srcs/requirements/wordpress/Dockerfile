FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y php7.4 php-fpm php-mysql
RUN apt-get install iputils-ping -y

RUN apt-get update && apt-get install -y default-mysql-client \
	&& apt-get install -y mariadb-client

RUN apt-get install -y wget
RUN wget https://wordpress.org/wordpress-6.4.1.tar.gz -P /var/www/html
RUN cd /var/www/html \
	&& tar -xzf /var/www/html/wordpress-6.4.1.tar.gz \
	&& rm /var/www/html/wordpress-6.4.1.tar.gz

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

RUN chown -R www-data:www-data /var/www/*
RUN chmod -R 755 /var/www/*

EXPOSE 9000

COPY ./tools/wp_conf.sh ./
RUN chmod +x ./wp_conf.sh

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

ENTRYPOINT ["bash", "./wp_conf.sh"]
