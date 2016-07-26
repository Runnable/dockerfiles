FROM runnable/base:1.0.0

# Install MongoDB 3.2

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r mongodb && useradd -r -g mongodb mongodb

# pub   4096R/EA312927 2015-10-09 [expires: 2017-10-08]
#       Key fingerprint = 42F3 E95A 2C4F 0827 9C49  60AD D68F A50F EA31 2927
# uid                  MongoDB 3.2 Release Signing Key <packaging@mongodb.com>
#
ENV GPG_KEYS \
  DFFA3DCF326E302C4787673A01C4E7FAAAB2461C \
  42F3E95A2C4F08279C4960ADD68FA50FEA312927
RUN set -ex \
  && for key in $GPG_KEYS; do \
    apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
  done

ENV MONGO_MAJOR 3.2
ENV MONGO_VERSION 3.2.8

RUN echo "deb http://repo.mongodb.org/apt/debian wheezy/mongodb-org/$MONGO_MAJOR main" > /etc/apt/sources.list.d/mongodb-org.list

RUN set -x \
  && apt-get update \
  && apt-get install -y \
    mongodb-org=$MONGO_VERSION \
    mongodb-org-server=$MONGO_VERSION \
    mongodb-org-shell=$MONGO_VERSION \
    mongodb-org-mongos=$MONGO_VERSION \
    mongodb-org-tools=$MONGO_VERSION \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /var/lib/mongodb \
  && mv /etc/mongod.conf /etc/mongod.conf.orig

RUN mkdir -p /data/db /data/configdb \
  && chown -R mongodb:mongodb /data/db /data/configdb

EXPOSE 27017
CMD gosu mongodb mongod
