FROM runnable/postgres:9.2

# Set recommended environment variables
# ENV POSTGRES_USER postgres
# ENV POSTGRES_DB postgres

# # Uncomment the following ADD line to enable seeding the PostgreSQL DB
# # Make sure to upload a pg_dump file (i.e. pg_dump -Fc db_name -f seed.dump)
# ADD seed.dump /seed.dump

# Run the initialization script
RUN gosu postgres /init.sh \
  # Uncomment the following line for a custom pg_restore command. Edit, as needed
  # "pg_restore --no-acl --no-owner -c -v -d $POSTGRES_DB /seed.dump"