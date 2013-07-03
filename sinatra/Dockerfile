# runnable base
FROM boxcar/raring

# REPOS
RUN apt-get -y update
RUN apt-get install -y -q software-properties-common
RUN add-apt-repository -y "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) universe"
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

## MYSQL
RUN apt-get install -y -q mysql-client
RUN apt-get install -y -q mysql-server

# LANGS

## RUBY
RUN apt-get install -y -q ruby

## SINATRA
RUN gem install sinatra

ENV DEBIAN_FRONTEND dialog