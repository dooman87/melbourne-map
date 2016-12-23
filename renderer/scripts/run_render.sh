#!/usr/bin/env bash

cp /map_data/stylesheet.xml /openstreetmap-carto

cd /gopnik/bin

./gopnikrender --config /map_data/config.json &
./gopnikdispatcher --config /map_data/config.json

pkill gopnikrender