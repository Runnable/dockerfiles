# Full list of versions available here: https://registry.hub.docker.com/_/php/tags/manage/
FROM php:7.0.12-apache

# Packages
RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng12-dev \
    libbz2-dev \
    libxslt-dev \
    libssl-dev \
    libcurl4-openssl-dev \
    pkg-config \
    libldap2-dev \
    php-pear \
    curl \
    git \
    subversion \
    unzip \
    wget \
  && rm -r /var/lib/apt/lists/*

# PHP Extensions
RUN docker-php-ext-install bcmath mcrypt zip bz2 mbstring pcntl xsl \
  && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
  && docker-php-ext-install gd \
  && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \
  && docker-php-ext-install ldap \
  && docker-php-ext-install pdo_mysql

RUN a2enmod rewrite

# Memory Limit
RUN echo "memory_limit=-1" > $PHP_INI_DIR/conf.d/memory-limit.ini

# Time Zone
RUN echo "date.timezone=${PHP_TIMEZONE:-UTC}" > $PHP_INI_DIR/conf.d/date_timezone.ini

# Disable Populating Raw POST Data
# Not needed when moving to PHP 7.
# http://php.net/manual/en/ini.core.php#ini.always-populate-raw-post-data
RUN echo "always_populate_raw_post_data=-1" > $PHP_INI_DIR/conf.d/always_populate_raw_post_data.ini

# Register the COMPOSER_HOME environment variable
ENV COMPOSER_HOME /composer

# Add global binary directory to PATH and make sure to re-export it
ENV PATH /composer/vendor/bin:$PATH

# Allow Composer to be run as root
ENV COMPOSER_ALLOW_SUPERUSER 1

# Install Mongo driver
RUN pecl install mongodb && echo "extension=mongodb.so" > /usr/local/etc/php/conf.d/mongo.ini

# Setup the Composer installer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
