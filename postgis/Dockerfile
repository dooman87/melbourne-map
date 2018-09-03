FROM mdillon/postgis:9.5

WORKDIR /

RUN apt-get update && \
    apt-get install -y osm2pgsql git wget && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/dooman87/openstreetmap-carto.git && \
    wget https://download.bbbike.org/osm/bbbike/Melbourne/Melbourne.osm.pbf


#Overriding init script to add hstore extension that osm2pgsql requires
COPY ./initdb-postgis.sh /docker-entrypoint-initdb.d/postgis.sh
