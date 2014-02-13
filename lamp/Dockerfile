# runnable base
FROM boxcar/raring

# REPOS
RUN apt-get -y update --fix-missing && date
RUN apt-get install -y -q software-properties-common
RUN add-apt-repository -y "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) universe"
RUN add-apt-repository -y ppa:chris-lea/node.js

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

## NODE
RUN apt-get install -y -q nodejs


## MYSQL
RUN apt-get install -y -q mysql-client mysql-server
RUN mysqld & sleep 2 && mysqladmin create mydb

## PHP
RUN apt-get install -y -q php5 php5-cli php5-dev php-pear php5-fpm php5-common php5-mcrypt php5-gd php-apc

## APACHE
RUN apt-get install -y -q apache2  libapache2-mod-php5

## UPDATE APT
RUN apt-get -y update --fix-missing

## APP
RUN rm -rf /var/www/*
ADD app /var/www

