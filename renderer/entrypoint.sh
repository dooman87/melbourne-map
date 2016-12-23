#!/usr/bin/env bash

rm /status/DB_INITED

sh /scripts/compile_style.sh

while [ ! -e /status/DB_INITED ]
do
sleep 1
echo "Waiting while database is initializing..."
done

echo "DB is ready, just waiting while DB is restarting..."
sleep 60

echo "Starting renderer"
sh /scripts/run_render.sh
