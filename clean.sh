#!/usr/bin/env bash

if [ -d ./data ]; then
    rm -rf ./data
fi

docker-compose down