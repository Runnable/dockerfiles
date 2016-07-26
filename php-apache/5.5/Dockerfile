FROM runnable/base:1.0.0

# persistent / runtime deps
ENV PHPIZE_DEPS \
    autoconf \
    file \
    g++ \
    gcc \
    libc-dev \
    make \
    pkg-config \
    re2c
RUN apt-get update && apt-get install -y \
    $PHPIZE_DEPS \
    ca-certificates \
    curl \
    libedit2 \
    libsqlite3-0 \
    libxml2 \
    xz-utils \
  --no-install-recommends && rm -r /var/lib/apt/lists/*

ENV PHP_INI_DIR /usr/local/etc/php
RUN mkdir -p $PHP_INI_DIR/conf.d

RUN apt-get update && apt-get install -y apache2-bin apache2.2-common --no-install-recommends && rm -rf /var/lib/apt/lists/*

ENV APACHE_CONFDIR /etc/apache2
ENV APACHE_ENVVARS $APACHE_CONFDIR/envvars

# setup directories and permissions
RUN set -ex \
  && . "$APACHE_ENVVARS" \
  && for dir in \
    "$APACHE_LOCK_DIR" \
    "$APACHE_RUN_DIR" \
    "$APACHE_LOG_DIR" \
    /var/www/html \
  ; do \
    rm -rvf "$dir" \
    && mkdir -p "$dir" \
    && chown -R "$APACHE_RUN_USER:$APACHE_RUN_GROUP" "$dir"; \
  done

# Apache + PHP requires preforking Apache for best results
RUN a2dismod mpm_event && a2enmod mpm_prefork

# logs should go to stdout / stderr
RUN set -ex \
  && . "$APACHE_ENVVARS" \
  && ln -sfT /dev/stderr "$APACHE_LOG_DIR/error.log" \
  && ln -sfT /dev/stdout "$APACHE_LOG_DIR/access.log" \
  && ln -sfT /dev/stdout "$APACHE_LOG_DIR/other_vhosts_access.log"

# PHP files should be handled by PHP, and should be preferred over any other file type
RUN { \
    echo '<FilesMatch \.php$>'; \
    echo '\tSetHandler application/x-httpd-php'; \
    echo '</FilesMatch>'; \
    echo; \
    echo 'DirectoryIndex disabled'; \
    echo 'DirectoryIndex index.php index.html'; \
    echo; \
    echo '<Directory /var/www/>'; \
    echo '\tOptions -Indexes'; \
    echo '\tAllowOverride All'; \
    echo '</Directory>'; \
  } | tee "$APACHE_CONFDIR/conf-available/docker-php.conf" \
  && a2enconf docker-php

ENV PHP_EXTRA_BUILD_DEPS apache2-dev
ENV PHP_EXTRA_CONFIGURE_ARGS --with-apxs2

ENV GPG_KEYS 0B96609E270F565C13292B24C13C70B87267B52D 0BD78B5F97500D450838F95DFE857D9A90D90EC1 F38252826ACD957EF380D39F2F7956BC5DA04B5D

ENV PHP_VERSION 5.5.37
ENV PHP_FILENAME php-5.5.37.tar.xz
ENV PHP_SHA256 c322444fdf6d3ba26aa67d67ee32d1e815a877f35831351c83763431a80e3612

RUN set -xe \
  && cd /usr/src/ \
  && curl -fSL "http://php.net/get/$PHP_FILENAME/from/this/mirror" -o php.tar.xz \
  && echo "$PHP_SHA256 *php.tar.xz" | sha256sum -c - \
  && curl -fSL "http://php.net/get/$PHP_FILENAME.asc/from/this/mirror" -o php.tar.xz.asc \
  && export GNUPGHOME="$(mktemp -d)" \
  && for key in $GPG_KEYS; do \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
  done \
  && gpg --batch --verify php.tar.xz.asc php.tar.xz \
  && rm -r "$GNUPGHOME"

COPY docker-php-source /usr/local/bin/

RUN set -xe \
  && buildDeps=" \
    $PHP_EXTRA_BUILD_DEPS \
    libcurl4-openssl-dev \
    libedit-dev \
    libsqlite3-dev \
    libssl-dev \
    libxml2-dev \
  " \
  && apt-get update && apt-get install -y $buildDeps --no-install-recommends && rm -rf /var/lib/apt/lists/* \
  && docker-php-source extract \
  && cd /usr/src/php \
  && ./configure \
    --with-config-file-path="$PHP_INI_DIR" \
    --with-config-file-scan-dir="$PHP_INI_DIR/conf.d" \
    $PHP_EXTRA_CONFIGURE_ARGS \
    --disable-cgi \
# --enable-mysqlnd is included here because it's harder to compile after the fact than extensions are (since it's a plugin for several extensions, not an extension in itself)
    --enable-mysqlnd \
# --enable-mbstring is included here because otherwise there's no way to get pecl to use it properly (see https://github.com/docker-library/php/issues/195)
    --enable-mbstring \
    --with-curl \
    --with-libedit \
    --with-openssl \
    --with-zlib \
  && make -j"$(nproc)" \
  && make install \
  && { find /usr/local/bin /usr/local/sbin -type f -executable -exec strip --strip-all '{}' + || true; } \
  && make clean \
  && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false $buildDeps \
  && docker-php-source delete

COPY docker-php-ext-* /usr/local/bin/

COPY apache2-foreground /usr/local/bin/
WORKDIR /var/www/html

EXPOSE 80
CMD ["apache2-foreground"]
