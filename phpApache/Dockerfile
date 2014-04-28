FROM ubuntu:latest
MAINTAINER Praful Rana <praful@runnable.com>

# Install packages
RUN apt-get update && apt-get -y upgrade && DEBIAN_FRONTEND=noninteractive apt-get -y install supervisor git apache2 libapache2-mod-php5 php5-mysql php5-gd php-pear php-apc curl && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin && mv /usr/local/bin/composer.phar /usr/local/bin/composer

# Add image configuration and scripts
ADD start.sh /start.sh
ADD run.sh /run.sh
RUN chmod 755 /*.sh
ADD supervisord-apache2.conf /etc/supervisor/conf.d/supervisord-apache2.conf

# Checkout and configure Hello World app
WORKDIR /var/www
RUN git clone https://github.com/prafulrana/php
RUN cp -vr php/* .
RUN rm -rf php

EXPOSE 80
CMD ["/run.sh"]
