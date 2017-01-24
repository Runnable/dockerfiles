# Runnable Base Image v1.0.0
FROM debian:jessie
MAINTAINER Runnable, Inc.

# Install main dependencies from apt-get
RUN apt-get update && apt-get install --no-install-recommends -y --force-yes \
    autoconf \
    automake \
    bzip2 \
    file \
    g++ \
    gcc \
    imagemagick \
    libbz2-dev \
    libc6-dev \
    libcurl4-openssl-dev \
    libdb-dev \
    libevent-dev \
    libffi-dev \
    libgeoip-dev \
    libglib2.0-dev \
    libjpeg-dev \
    liblzma-dev \
    libmagickcore-dev \
    libmagickwand-dev \
    libmysqlclient-dev \
    libncurses-dev \
    libpng-dev \
    libpq-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    libtool \
    libwebp-dev \
    libxml2-dev \
    libxslt-dev \
    libyaml-dev \
    make \
    patch \
    xz-utils \
    zlib1g-dev \
    build-essential \
    curl \
    wget \
    ca-certificates \
    git \
    net-tools \
    dnsutils \
    dpkg-sig \
    libcap-dev \
    reprepro \
    s3cmd \
    unzip \
    ruby \
    nodejs \
    && rm -rf /var/lib/apt/lists/*

# Get Ruby & Node
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash -
RUN apt-get update && apt-get install --no-install-recommends -y --force-yes \
    ruby \
    nodejs \
    && rm -rf /var/lib/apt/lists/*

# Install gosu (postgres refuses to be run as root)
ENV GOSU_VERSION 1.7
RUN wget -O /usr/local/bin/gosu \
  "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)"

# Verify gosu
RUN wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
  && export GNUPGHOME="$(mktemp -d)" \
  && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
  && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
  && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc

# Initialize gosu
RUN chmod +x /usr/local/bin/gosu
RUN gosu nobody true
