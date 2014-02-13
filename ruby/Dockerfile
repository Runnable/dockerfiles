# runnable base
FROM boxcar/raring

# REPOS
RUN apt-get -y update
RUN apt-get install -y -q software-properties-common
RUN add-apt-repository -y "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) universe"
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
RUN echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/10gen.list
RUN apt-get -y update --fix-missing

#SHIMS
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -s /bin/true /sbin/initctl
ENV DEBIAN_FRONTEND noninteractive

# TOOLS
RUN apt-get install -y -q curl vim nano git make wget build-essential g++

## MEMCACHED
RUN apt-get install -y -q memcached redis-server mongodb-10gen

## POSTGRES
RUN echo "#!/bin/sh\nexit 101" > /usr/sbin/policy-rc.d; chmod +x /usr/sbin/policy-rc.d
RUN apt-get install -y -q postgresql-9.1
RUN apt-get install -y -q postgresql-contrib-9.1
RUN rm /usr/sbin/policy-rc.d
RUN apt-get install -y -q pgadmin3

## MYSQL
RUN apt-get install -y -q mysql-client mysql-server

## RUBY
RUN apt-get install -y -q ruby

ENV DEBIAN_FRONTEND dialog
