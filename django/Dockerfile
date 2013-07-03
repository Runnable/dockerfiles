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

# SERVICES

## MEMCACHED
RUN apt-get install -y -q memcached
#RUN pecl install -y memcache

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

# LANGS

## PYTHON
RUN apt-get install -y -q python-software-properties
RUN apt-get install -y -q python
RUN apt-get install -y -q python-setuptools
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

# Django
RUN easy_install django

ENV DEBIAN_FRONTEND dialog