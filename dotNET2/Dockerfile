# runnable base
FROM boxcar/raring

# REPOS
RUN apt-get -y update && date
RUN apt-get install -y -q software-properties-common
RUN add-apt-repository -y "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) universe"
RUN add-apt-repository -y ppa:chris-lea/node.js
RUN apt-get -y update

#SHIMS
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -s /bin/true /sbin/initctl
ENV DEBIAN_FRONTEND noninteractive

# EDITORS
RUN apt-get install -y -q vim nano

# TOOLS
RUN apt-get install -y -q curl git make wget

# BUILD
RUN apt-get install -y -q build-essential g++

# SERVICES

## APACHE
RUN apt-get install -y -q apache2

# LANGS

## NODE
RUN apt-get install -y -q nodejs

# RESET
ENV DEBIAN_FRONTEND dialog

# INSTALL MONO
sudo apt-get install mono-xsp2 mono-xsp2-base
sudo apt-get install asp.net2-examples

## CONFIG
ENV RUNNABLE_USER_DIR /var/www
ENV RUNNABLE_SERVICE_CMDS /etc/init.d/apache2 restart
