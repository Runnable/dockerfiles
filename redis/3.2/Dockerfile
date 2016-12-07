FROM runnable/base:1.0.0

# Install Redis 3.2

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r redis && useradd -r -g redis redis

ENV REDIS_VERSION 3.2.1
ENV REDIS_DOWNLOAD_URL http://download.redis.io/releases/redis-3.2.1.tar.gz
ENV REDIS_DOWNLOAD_SHA1 26c0fc282369121b4e278523fce122910b65fbbf

# for redis-sentinel see: http://redis.io/topics/sentinel
RUN buildDeps='gcc libc6-dev make' \
  && set -x \
  && apt-get update && apt-get install -y $buildDeps --no-install-recommends \
  && rm -rf /var/lib/apt/lists/* \
  && wget -O redis.tar.gz "$REDIS_DOWNLOAD_URL" \
  && echo "$REDIS_DOWNLOAD_SHA1 *redis.tar.gz" | sha1sum -c - \
  && mkdir -p /usr/src/redis \
  && tar -xzf redis.tar.gz -C /usr/src/redis --strip-components=1 \
  && rm redis.tar.gz \
	\
# Disable Redis protected mode [1] as it is unnecessary in context
# of Docker. Ports are not automatically exposed when running inside
# Docker, but rather explicitely by specifying -p / -P.
# [1] https://github.com/antirez/redis/commit/edd4d555df57dc84265fdfb4ef59a4678832f6da
  && grep -q '^#define CONFIG_DEFAULT_PROTECTED_MODE 1$' /usr/src/redis/src/server.h \
  && sed -ri 's!^(#define CONFIG_DEFAULT_PROTECTED_MODE) 1$!\1 0!' /usr/src/redis/src/server.h \
  && grep -q '^#define CONFIG_DEFAULT_PROTECTED_MODE 0$' /usr/src/redis/src/server.h \
	\
	&& make -C /usr/src/redis \
  && make -C /usr/src/redis install \
  && rm -r /usr/src/redis \
  && apt-get purge -y --auto-remove $buildDeps

RUN mkdir /data && chown redis:redis /data

WORKDIR /data

EXPOSE 6379

CMD gosu redis redis-server 
