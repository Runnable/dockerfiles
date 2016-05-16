FROM runnable/postgres:9.1

# POSTGRES_USER = postgres
# POSTGRES_DB = postgres

# # Uncomment the rest of this file to enable seeding the PostgreSQL DB
# # Make sure to upload a seed dump file (i.e. pg_dump -Fc db_name > seed.dump)
# ADD seed.dump /seed.dump
# # Run the restore script
# RUN gosu postgres pg_ctl -D "$PGDATA" -o "-c listen_addresses='localhost'" -w start \
#  ; gosu postgres /restore.sh \
#  # Uncomment the following line for a custom pg_restore command. Edit, as needed
#  # "pg_restore --no-acl --no-owner -c -v -d db_name /seed.dump" \
#  && gosu postgres pg_ctl -w stop