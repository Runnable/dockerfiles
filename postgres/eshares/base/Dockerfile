FROM debian:jessie
MAINTAINER Runnable, Inc.

# Install ca-certificates and wget
RUN apt-get update \
  && set -x \
  && apt-get update \
  && apt-get install -y --no-install-recommends ca-certificates wget \
  && rm -rf /var/lib/apt/lists/*

# Install gosu (postgres refuses to be run as root)
ENV GOSU_VERSION 1.7
RUN wget -O /usr/local/bin/gosu \
  "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)"

# Verify gosu
RUN wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
  && export GNUPGHOME="$(mktemp -d)" \
  && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
  && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
  && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc

# Initialize gosu
RUN chmod +x /usr/local/bin/gosu
RUN gosu nobody true
RUN apt-get purge -y --auto-remove ca-certificates wget

# Explicitly set user/group IDs for postgres
RUN groupadd -r postgres --gid=999 \
  && useradd -r -g postgres --uid=999 postgres

# Make the "en_US.UTF-8" locale so postgres will be utf-8 enabled by default
ENV LANG en_US.utf8
RUN apt-get update \
  && apt-get install -y locales \
  && rm -rf /var/lib/apt/lists/* \
  && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

# Install PostgreSQL
ENV PG_MAJOR 9.4
RUN apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8
RUN echo 'deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main' $PG_MAJOR > /etc/apt/sources.list.d/pgdg.list
RUN apt-get update \
  && apt-get install -y postgresql-common \
  && sed -ri 's/#(create_main_cluster) .*$/\1 = false/' /etc/postgresql-common/createcluster.conf \
  && apt-get install -y \
      postgresql-$PG_MAJOR \
      postgresql-contrib-$PG_MAJOR \
  && rm -rf /var/lib/apt/lists/*

# Install PostGIS
ENV POSTGIS_MAJOR 2.2
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
      "postgresql-${PG_MAJOR}-postgis-${POSTGIS_MAJOR}" \
      postgis \
  && rm -rf /var/lib/apt/lists/*

# make the sample config easier to munge (and "correct by default")
RUN mv -v /usr/share/postgresql/$PG_MAJOR/postgresql.conf.sample /usr/share/postgresql/ \
  && ln -sv ../postgresql.conf.sample /usr/share/postgresql/$PG_MAJOR/ \
  && sed -ri "s!^#?(listen_addresses)\s*=\s*\S+.*!\1 = '*'!" /usr/share/postgresql/postgresql.conf.sample

# Ensure we have a run directory for postgres and make the group own it
RUN mkdir -p /var/run/postgresql \
  && chown -R postgres /var/run/postgresql

ENV PGDATA /var/lib/postgresql/data
ENV PATH /usr/lib/postgresql/$PG_MAJOR/bin:$PATH

# Setup postgresql data directory and initialize database
RUN mkdir -p "$PGDATA"
RUN chmod 777 "$PGDATA"
RUN chown -R postgres "$PGDATA"
RUN gosu postgres initdb

# Allow all clients on the server
RUN { echo; echo "host all all 0.0.0.0/0 trust"; } >> "$PGDATA/pg_hba.conf"

# Copy init script
COPY init.sh /
RUN chmod +x /init.sh

# Add crontab file in the cron directory
ADD crontab /etc/cron.d/update_db
 
# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/update_db
 
# Run the command on container startup
CMD cron && tail -f /var/log/cron.log

# Start postgresql
EXPOSE 5432
CMD gosu postgres postgres