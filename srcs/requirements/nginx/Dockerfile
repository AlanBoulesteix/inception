FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y nginx
RUN apt-get install -y curl

RUN mkdir -p /var/www/html
RUN chmod 755 /var/www/html

RUN mkdir -p /etc/nginx/ssl
RUN apt-get install -y openssl

RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=aboulest.42.fr/UID=aboulest"

RUN mkdir -p /var/run/nginx
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

ENTRYPOINT ["nginx", "-g", "daemon off;"]