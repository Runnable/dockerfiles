# runnable base
FROM boxcar/raring

# REPOS
RUN apt-get -y update
RUN apt-get install -y -q software-properties-common
RUN add-apt-repository -y "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) universe"
RUN apt-get -y update

#SHIMS
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -s /bin/true /sbin/initctl
ENV DEBIAN_FRONTEND noninteractive

#WEBSERVERS
RUN apt-get install -y -q apache2
RUN apt-get install -y -q nginx
RUN apt-get install -y -q lighttpd
RUN add-apt-repository ppa:cherokee-webserver
RUN apt-get -y update
RUN apt-get install -y -q cherokee

ENV DEBIAN_FRONTEND dialog