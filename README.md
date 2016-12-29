# Melbourne map

Provides a configuration to launch your own retina ready map renderer.

## Run it

```
$ ./download.sh
$ docker-compose build
$ docker-compose up
```

It will take a while for a first start (up to 10 mins) because of DB import.
You will know that renderer is ready to use when see logs like this:

```
postgis_1   | LOG:  autovacuum launcher started
renderer_1  | Starting renderer
renderer_1  | 2016/12/27 23:34:30 app.go:266: [INFO] Serving debug data (/debug/vars) on %s... :9080
renderer_1  | 2016/12/27 23:34:30 app.go:267: [INFO] Serving monitoring xml data on %s... :9080
renderer_1  | 2016/12/27 23:34:30 renderselector.go:209: [DEBUG] ping error %v dial tcp 127.0.0.1:8090: getsockopt: connection refused
renderer_1  | 2016/12/27 23:34:30 renderselector.go:117: [DEBUG] '%v' is %v localhost:8090 Offline
renderer_1  | 2016/12/27 23:34:30 main.go:118: [INFO] Starting on %s... :8080
renderer_1  | 2016/12/27 23:34:30 app.go:266: [INFO] Serving debug data (/debug/vars) on %s... :9090
renderer_1  | 2016/12/27 23:34:30 app.go:267: [INFO] Serving monitoring xml data on %s... :9090
renderer_1  | 2016/12/27 23:34:35 main.go:95: [INFO] Done in %v seconds 4.84147165
renderer_1  | 2016/12/27 23:34:35 main.go:103: [INFO] Starting on %s... :8090
```

Then you can open example in your favourite web browser:
```
http://localhost:8888
```
The initial rendering may take 10-30 seconds, after which you will see a fabulous map of Melbourne city.


## Renders other areas

You will need to update postgis image to render other city/area:

* Update postgis/Dockerfile by adding different pbf file to container
```
wget https://s3.amazonaws.com/metro-extracts.mapzen.com/melbourne_australia.osm.pbf
```
* Update postgis/initdb-postgis.sh to use a new file
```
osm2pgsql --style /openstreetmap-carto/openstreetmap-carto.style -d gis -U postgres -k --slim /melbourne_australia.osm.pbf
```

## Using custom style

This project is using [forked version](https://github.com/dooman87/openstreetmap-carto) of 
 [openstreetmap-carto style](https://github.com/gravitystorm/openstreetmap-carto) that
 optimised for hi-res displays.

There are two places that you have to tweak to use different style:

* postgis/initdb-postgis.sh is using style during DB import (--style option):
```
osm2pgsql --style /openstreetmap-carto/openstreetmap-carto.style -d gis -U postgres -k --slim /melbourne_australia.osm.pbf
```
* renderer/map_data/config.json defines style on line 72:
```
"Cmd": ["/gopnik/bin/gopnikslave", 
"-stylesheet", "/openstreetmap-carto/stylesheet.xml", 
"-pluginsPath", "/usr/lib/mapnik/2.2/input", 
"-fontsPath", "/usr/share/fonts", "-scaleFactor", "2"],
```

## Update database
You can update database by removing data volume and restart containers:
```
$ ./clean.sh
$ docker-compose up
```
