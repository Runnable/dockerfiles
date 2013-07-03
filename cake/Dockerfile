# runnable base
FROM boxcar/raring

# REPOS
RUN apt-get -y update
RUN apt-get install -y -q software-properties-common
RUN add-apt-repository -y "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) universe"
RUN apt-get -y update

#SHIMS
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -s /bin/true /sbin/initctl
ENV DEBIAN_FRONTEND noninteractive

# EDITORS
RUN apt-get install -y -q vim
RUN apt-get install -y -q nano

# TOOLS
RUN apt-get install -y -q curl
RUN apt-get install -y -q git
RUN apt-get install -y -q make
RUN apt-get install -y -q wget

# BUILD
RUN apt-get install -y -q build-essential
RUN apt-get install -y -q g++

# LANGS

## PHP
RUN apt-get install -y -q php5
RUN apt-get install -y -q php5-cli
RUN apt-get install -y -q php5-dev
RUN apt-get install -y -q php-pear
RUN apt-get install -y -q php5-fpm
RUN apt-get install -y -q php5-common
RUN apt-get install -y -q php5-mcrypt
RUN apt-get install -y -q php5-gd
RUN apt-get install -y -q php-apc
RUN curl -sS https://getcomposer.org/installer | php

# SERVICES

## MEMCACHED
RUN apt-get install -y -q memcached
#RUN pecl install -y memcache

## MAGICK
RUN apt-get install -y -q imagemagick
RUN apt-get install -y -q graphicsmagick
RUN apt-get install -y -q graphicsmagick-libmagick-dev-compat
RUN pecl install imagick

## APACHE
RUN apt-get install -y -q apache2
RUN apt-get install -y -q libapache2-mod-php5

## MYSQL
RUN apt-get install -y -q mysql-client
RUN apt-get install -y -q mysql-server
RUN apt-get install -y -q php5-mysql

## CAKE
ADD cake.json /root/cake.json
RUN cd /root && php composer.phar install

# RESET

ENV DEBIAN_FRONTEND dialog