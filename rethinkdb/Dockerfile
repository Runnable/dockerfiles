FROM boxcar/raring

RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:rethinkdb/ppa
RUN add-apt-repository -y ppa:chris-lea/node.js
RUN apt-get -y update

# EDITORS
RUN apt-get install -y -q vim nano

# TOOLS
RUN apt-get install -y -q curl git make wget

# BUILD
RUN apt-get install -y -q build-essential g++

# LANGS

## NODE
RUN apt-get install -y -q nodejs

# SERVICES

## RETHINK
RUN apt-get install -y -q rethinkdb

## CONFIG

ENV RUNNABLE_START_CMD rethinkdb --bind all --http-port 80
