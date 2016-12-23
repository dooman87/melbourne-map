# melbourne-map

Provides a configuration to launch your own map renderer.

## Run it

```
$ docker-compose build
$ docker-compose up
$ docker compose exec renderer bash
# sh ./fill_database.sh /map_data/melbourne_australia.osm.pbf
# sh ./compile_style.sh
# sh ./run_render.sh
```

