#!/bin/bash
set -e

: ${POSTGRES_USER:=postgres}
: ${POSTGRES_DB:=$POSTGRES_USER}
: ${SEED_FILE:=seed.dump}
export POSTGRES_USER POSTGRES_DB SEED_FILE

psql=( psql -v ON_ERROR_STOP=1 )

echo 'Starting PostgreSQL server temporarily....'
pg_ctl -D "$PGDATA" -o "-c listen_addresses='localhost'" -w start \

echo "Creating database"
if [ "$POSTGRES_DB" != 'postgres' ]; then
	"${psql[@]}" --username postgres <<-EOSQL
		CREATE DATABASE "$POSTGRES_DB" ;
	EOSQL
	echo
fi

if [ "$POSTGRES_USER" = 'postgres' ]; then
	op='ALTER'
else
	op='CREATE'
fi
"${psql[@]}" --username postgres <<-EOSQL
	$op USER "$POSTGRES_USER" WITH SUPERUSER;
EOSQL
echo

# Create the 'template_postgis' template db
psql --dbname="$POSTGRES_DB" <<- 'EOSQL'
CREATE DATABASE template_postgis;
UPDATE pg_database SET datistemplate = TRUE WHERE datname = 'template_postgis';
EOSQL

# Load PostGIS into both template_database and $POSTGRES_DB
for DB in template_postgis "$POSTGRES_DB"; do
	echo "Loading PostGIS extensions into $DB"
	psql --dbname="$DB" <<-'EOSQL'
		CREATE EXTENSION postgis;
		CREATE EXTENSION postgis_topology;
		CREATE EXTENSION fuzzystrmatch;
		CREATE EXTENSION postgis_tiger_geocoder;
EOSQL
done
echo 'PostGIS Initialization Complete'

echo "Beginning restore from database dump"
pg_restore_command=$1
if [[ -n "$pg_restore_command" ]]; then
	eval $pg_restore_command
else
	pg_restore --no-acl --no-owner -v -d $POSTGRES_DB $SEED_FILE
fi

echo 'PostgreSQL init process complete; ready for start up.'
pg_ctl -w stop
