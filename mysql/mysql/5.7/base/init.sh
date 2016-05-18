#!/bin/bash
set -eo pipefail

: ${MYSQL_USER:=mysql}
: ${MYSQL_PASSWORD:=mysql}
: ${MYSQL_ROOT_PASSWORD:=root}
: ${MYSQL_DATABASE:=test}
: ${SEED_FILE:=seed.sql}
export MYSQL_USER MYSQL_PASSWORD MYSQL_ROOT_PASSWORD MYSQL_DATABASE SEED_FILE

mysqld --skip-networking --basedir=/usr/local/mysql &
pid="$!"

mysql=( mysql --protocol=socket -uroot )

for i in {30..0}; do
	if echo 'SELECT 1' | "${mysql[@]}" &> /dev/null; then
		break
	fi
	echo 'MySQL init process in progress...'
	sleep 1
done
if [ "$i" = 0 ]; then
	echo 'MySQL init process failed.'
	exit 1
fi

if [ -z "$MYSQL_INITDB_SKIP_TZINFO" ]; then
	# sed is for https://bugs.mysql.com/bug.php?id=20545
	mysql_tzinfo_to_sql /usr/share/zoneinfo | sed 's/Local time zone must be set--see zic manual page/FCTY/' | "${mysql[@]}" mysql
fi

if [ ! -z "$MYSQL_RANDOM_ROOT_PASSWORD" ]; then
	MYSQL_ROOT_PASSWORD="$(pwgen -1 32)"
	echo "GENERATED ROOT PASSWORD: $MYSQL_ROOT_PASSWORD"
fi

echo "Creating superuser..."
"${mysql[@]}" <<-EOSQL
	-- What's done in this file shouldn't be replicated
	--  or products like mysql-fabric won't work
	SET @@SESSION.SQL_LOG_BIN=0;

	DELETE FROM mysql.user ;
	CREATE USER 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}' ;
	GRANT ALL ON *.* TO 'root'@'%' WITH GRANT OPTION ;
	DROP DATABASE IF EXISTS test ;
	FLUSH PRIVILEGES ;
EOSQL

if [ ! -z "$MYSQL_ROOT_PASSWORD" ]; then
	mysql+=( -p"${MYSQL_ROOT_PASSWORD}" )
fi

if [ "$MYSQL_DATABASE" ]; then
	echo "Creating database: $MYSQL_DATABASE"
	echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` ;" | "${mysql[@]}"
	mysql+=( "$MYSQL_DATABASE" )
fi

if [ "$MYSQL_USER" -a "$MYSQL_PASSWORD" ]; then
	echo "Creating user: $MYSQL_USER"
	echo "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' ;" | "${mysql[@]}"

	if [ "$MYSQL_DATABASE" ]; then
		echo "GRANT ALL ON \`$MYSQL_DATABASE\`.* TO '$MYSQL_USER'@'%' ;" | "${mysql[@]}"
	fi

	echo 'FLUSH PRIVILEGES ;' | "${mysql[@]}"
fi
echo

# Seed database, if seed.sql is present.
if [ -f $SEED_FILE ]
then
	"${mysql[@]}" < $SEED_FILE
fi

if ! kill -s TERM "$pid" || ! wait "$pid"; then
	echo >&2 'MySQL init process failed.'
	exit 1
fi

echo
echo 'MySQL init process done. Ready for start up.'
echo