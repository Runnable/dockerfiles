FROM stackbrew/ubuntu:saucy
MAINTAINER runnable.com <support@runnable.com>

# REPOS
RUN apt-get -y update
RUN apt-get install -y -q software-properties-common
RUN add-apt-repository -y "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) universe"
RUN add-apt-repository -y ppa:chris-lea/node.js
RUN apt-get -y update

# INSTALL
RUN apt-get install -y -q build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion pkg-config libmysqlclient-dev libpq-dev make wget unzip git vim nano nodejs mysql-client mysql-server gawk libgdbm-dev libffi-dev

# RVM
RUN curl -L get.rvm.io | bash -s stable --auto
RUN /usr/local/rvm/bin/rvm install 2.0.0
RUN /usr/local/rvm/bin/rvm --default use 2.0.0

# GEMS
RUN gem install rails -v 4.0.0 mysql2

# CONFIG
ENV RUNNABLE_USER_DIR /var/www/app/ 
ENV RUNNABLE_START_CMD rails server -p 80
ENV RUNNABLE_SERVICE_CMDS rm -rf /var/www/app/tmp/pids/server.pid; mysqld;
