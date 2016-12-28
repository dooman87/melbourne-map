#!/usr/bin/env bash

sh /scripts/compile_style.sh

while [ ! -e /var/lib/postgresql/data/DB_INITED ]
do
sleep 5
echo "Waiting while database is initializing..."
done

#Have to wait because once DB created then osm2pgsql restarting postgres.
#TODO: Using pg_isready
echo "DB successfully created, waiting for restart"
sleep 60

echo "Starting renderer"
sh /scripts/run_render.sh
