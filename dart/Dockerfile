FROM stackbrew/ubuntu:saucy
MAINTAINER runnable.com <support@runnable.com>

# REPOS
RUN apt-get -y update
RUN apt-get install -y -q software-properties-common
RUN add-apt-repository -y "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) universe"
RUN add-apt-repository -y ppa:chris-lea/node.js
RUN add-apt-repository ppa:hachre/dart
RUN apt-get -y update

# EDITORS
RUN apt-get install -y -q vim nano

# TOOLS
RUN apt-get install -y -q curl git make wget unzip

# BUILD
RUN apt-get install -y -q build-essential g++

# LANGS

## NODE
RUN apt-get install -y -q nodejs

## DART
RUN apt-get install -y -q dartsdk

## CONFIG
ENV RUNNABLE_USER_DIR /root
ENV RUNNABLE_START_CMD dart server.dart

