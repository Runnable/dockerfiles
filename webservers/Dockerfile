# runnable base
FROM boxcar/raring

# REPOS
RUN apt-get -y update
RUN apt-get install -y -q software-properties-common
RUN add-apt-repository -y "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) universe"
RUN add-apt-repository ppa:cherokee-webserver
RUN apt-get -y update

#SHIMS
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -s /bin/true /sbin/initctl
ENV DEBIAN_FRONTEND noninteractive

#WEBSERVERS
RUN apt-get install -y -q apache2 nginx lighttpd cherokee

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV DEBIAN_FRONTEND dialog