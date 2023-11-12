#!/bin/bash

cd /var/www/html/wordpress

if ! wp core is-installed --allow-root; then
	wp config create	--allow-root --dbname=${MYSQL_DATABASE} \
				--dbuser=${MYSQL_USER} \
				--dbpass=${MYSQL_USER_PASSWORD} \
				--dbhost=mariadb:3306 \
				--url=https://${DOMAIN_NAME};

	wp core install	--allow-root \
				--url=https://${DOMAIN_NAME} \
				--title=${WP_TITLE} \
				--admin_user=${WP_ADMIN_USER} \
				--admin_password=${WP_ADMIN_PASSWORD} \
				--admin_email=${WP_ADMIN_EMAIL};

	wp user create		--allow-root \
				${WP_USER1_LOGIN} ${WP_USER1_MAIL} \
				--role=author \
				--user_pass=${WP_USER1_PASS} ;

	wp cache flush --allow-root
	wp plugin install contact-form-7 --activate
	wp language core install en_US --activate
	wp theme delete twentynineteen twentytwenty
	wp plugin delete hello
	wp rewrite structure '/%postname%/'
fi

if [ ! -d /run/php ]; then
	mkdir /run/php;
	echo "On a creer le dossier du coup"
fi

exec /usr/sbin/php-fpm7.4 -F -R