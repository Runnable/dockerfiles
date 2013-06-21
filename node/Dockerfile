# runnable base
FROM boxcar/raring

# REPOS
RUN apt-get -y update
RUN apt-get install -y -q software-properties-common
RUN add-apt-repository -y "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) universe"
RUN add-apt-repository -y ppa:chris-lea/node.js
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

# BUILD
RUN apt-get install -y -q build-essential
RUN apt-get install -y -q g++

# SERVICES

## COUCHDB
RUN apt-get install -y -q couchdb

## REDIS
RUN apt-get install -y -q redis-server

## MONGO
RUN apt-get install -y -q mongodb-10gen

## SETUP DBPATH
RUN mkdir -p /data/db

## MYSQL
RUN apt-get install -y -q mysql-client
RUN apt-get install -y -q mysql-server

# LANGS

## NODE
RUN apt-get install -y -q nodejs

RUN npm install serve -g

ENV DEBIAN_FRONTEND dialog

# ENV
ENV RUNNABLE_USER_DIR /root/
ENV RUNNABLE_SERVICE_CMDS mongod;redis-server;
ENV RUNNABLE_START_CMD npm start


# FILES

ADD helloworld/server.js /root/
ADD helloworld/package.json /root/
RUN cd /root && npm install

# DOCKWORKER
RUN mkdir /dockworker
RUN cd /dockworker && curl https://raw.github.com/Runnable/dockworker/master/dockworker.js > dockworker.js


