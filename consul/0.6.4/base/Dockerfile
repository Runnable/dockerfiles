FROM debian:jessie
MAINTAINER Runnable, Inc.

# Install utils
RUN apt-get update -y \
    && apt-get install -y wget unzip dnsutils

# Install GOSU
ENV GOSU_VERSION 1.7
RUN set -x \
    && apt-get install -y --no-install-recommends ca-certificates && rm -rf /var/lib/apt/lists/* \
    && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
    && wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
    && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true

# Install Consul
RUN cd / \
    && wget https://releases.hashicorp.com/consul/0.6.4/consul_0.6.4_linux_amd64.zip \
    && unzip /consul_0.6.4_linux_amd64.zip \
    && mv consul /usr/local/bin \
    && rm -rf /consul_0.6.4_linux_amd64.zip

# Install Web UI (runs on port 8500)
RUN mkdir /consul \
    && wget https://releases.hashicorp.com/consul/0.6.4/consul_0.6.4_web_ui.zip \
    && unzip /consul_0.6.4_web_ui.zip -d /consul \
    && rm -rf /consul/consul_0.6.4_web_ui.zip 

# Edit this json file to change consul configuration
COPY ./config.json /etc/consul.d/bootstrap/config.json

# Open ports
EXPOSE 8300 8400 8500 8600 53 80 8301

CMD consul agent -config-dir /etc/consul.d/bootstrap -advertise=$(hostname -I | cut -d \  -f 2)