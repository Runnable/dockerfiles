# runnable base
FROM boxcar/raring

# REPOS
RUN apt-get -y update
RUN apt-get install -y -q software-properties-common
RUN add-apt-repository -y "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) universe"
RUN add-apt-repository -y ppa:chris-lea/node.js
RUN apt-get -y update

#SHIMS
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -s /bin/true /sbin/initctl
ENV DEBIAN_FRONTEND noninteractive

# EDITORS
RUN apt-get install -y -q vim nano

# TOOLS
RUN apt-get install -y -q curl git make wget

# BUILD
RUN apt-get install -y -q build-essential g++

# LANGS

## PHP
RUN apt-get install -y -q php5 php5-cli php5-dev php-pear php5-fpm php5-common php5-mcrypt php5-gd php-apc

## NODE
RUN apt-get install -y -q nodejs

# SERVICES

## MEMCACHED
RUN apt-get install -y -q memcached
RUN pecl install memcache

## MAGICK
RUN apt-get install -y -q imagemagick graphicsmagick graphicsmagick-libmagick-dev-compat
RUN pecl install imagick

## APACHE
RUN apt-get install -y -q apache2 libapache2-mod-php5

## MYSQL
RUN apt-get install -y -q mysql-client mysql-server php5-mysql

## CODEIGNITER
RUN a2enmod php5 rewrite
RUN rm -rf /var/www/*
RUN git clone https://github.com/EllisLab/CodeIgniter.git /var/www

# RESET

ENV DEBIAN_FRONTEND dialog

## CONFIG
ENV RUNNABLE_USER_DIR /var/www/application
ENV RUNNABLE_SERVICE_CMDS memcached -d -u www-data; /etc/init.d/apache2 restart; mysqld
