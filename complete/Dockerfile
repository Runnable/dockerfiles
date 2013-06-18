# runnable base
FROM ubuntu:12.10

# REPOS
RUN apt-get -y update
RUN apt-get install -y -q software-properties-common
RUN add-apt-repository -y "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) universe"
RUN add-apt-repository -y ppa:gophers/go/ubuntu
RUN add-apt-repository -y ppa:chris-lea/node.js
RUN add-apt-repository -y ppa:webupd8team/java
RUN add-apt-repository -y ppa:nginx/stable
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
RUN echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/10gen.list
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
# RUN apt-get install -y -q supervisor

# BUILD
RUN apt-get install -y -q build-essential
RUN apt-get install -y -q g++

# SERVICES

## MEMCACHED
RUN apt-get install -y -q memcached
#RUN pecl install -y memcache

## COUCHDB
RUN apt-get install -y -q couchdb

## REDIS
RUN apt-get install -y -q redis-server

## MONGO
RUN apt-get install -y -q mongodb-10gen

## POSTGRES
RUN echo "#!/bin/sh\nexit 101" > /usr/sbin/policy-rc.d; chmod +x /usr/sbin/policy-rc.d
RUN apt-get install -y -q postgresql-9.1
RUN apt-get install -y -q postgresql-contrib-9.1
RUN rm /usr/sbin/policy-rc.d
RUN apt-get install -y -q pgadmin3

## MAGICK
RUN apt-get install -y -q imagemagick
RUN apt-get install -y -q graphicsmagick
RUN apt-get install -y -q graphicsmagick-libmagick-dev-compat
# #RUN pecl install -y imagick

## APACHE
RUN apt-get install -y -q apache2
RUN apt-get install -y -q libapache2-mod-php5

## MYSQL
RUN apt-get install -y -q mysql-client
RUN apt-get install -y -q mysql-server

## NGINX
RUN apt-get install -y -q nginx

# LANGS

## GO
RUN apt-get install -y -q golang

## RUBY
RUN apt-get install -y -q ruby

## NODE
RUN apt-get install -y -q nodejs

## PHP
RUN apt-get install -y -q php5
RUN apt-get install -y -q php-pear

## ERLANG
RUN apt-get install -y -q erlang

# # # JAVA
# # # Broken
# # RUN debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
# # RUN debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
# # RUN apt-get install -y -q oracle-java7-installer

## PYTHON
RUN apt-get install -y -q python-software-properties
RUN apt-get install -y -q python
RUN apt-get install -y -q python-dev
RUN apt-get install -y -q python-distribute
RUN apt-get install -y -q python-pip
RUN pip --no-input --exists-action=w install --upgrade pip

# LIBS
RUN apt-get install -y -q libjpeg8-dev
RUN apt-get install -y -q zlib1g-dev
RUN apt-get install -y -q libfreetype6-dev
RUN apt-get install -y -q liblcms1-dev
RUN apt-get install -y -q libwebp-dev
RUN apt-get install -y -q libtiff-dev

ENV DEBIAN_FRONTEND dialog