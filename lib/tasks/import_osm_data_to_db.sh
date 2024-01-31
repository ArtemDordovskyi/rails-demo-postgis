#!/bin/bash
# Variable for the database and OSM file name
DB_NAME="russia_latest"

# Construct the OSM data URL using the DB_NAME
OSM_DATA_URL="http://download.geofabrik.de/russia-latest.osm.pbf"

# Download the latest OSM data for Russia
echo "Downloading OSM data for Russia..."
wget $OSM_DATA_URL -O $DB_NAME.osm.pbf

# Create a new PostgreSQL database with the corrected name
echo "Creating new PostgreSQL database named $DB_NAME..."
sudo -u postgres psql -c "CREATE DATABASE $DB_NAME;"
sudo -u postgres psql -d $DB_NAME -c "CREATE EXTENSION postgis;"

# Import the OSM data into the PostgreSQL database using osm2pgsql
echo "Importing OSM data into PostgreSQL database named $DB_NAME..."
osm2pgsql --create \
          --verbose \
          --database $DB_NAME \
          --latlong \
          --number-processes 4 \
          --username postgres \
          --host localhost \
          --port 5432 \
          --password \
          $DB_NAME.osm.pbf

echo "Data import complete."
