FROM runnable/mysql:5.5

# Set required environment variables
# ENV MYSQL_USER sohail
# ENV MYSQL_PASSWORD ahmed
# ENV MYSQL_ROOT_PASSWORD test
# ENV MYSQL_DATABASE app

# Uncomment the following ADD line to enable seeding the PostgreSQL DB
# Make sure to upload a mysql dump file (i.e. mysqldump [options] > seed.sql)
ADD seed.sql /seed.sql

# Run the initialization script (leave this alone)
RUN gosu mysql /init.sh
