# DemoRailsPostGIS

DemoRailsPostGIS is a Rails application for getting, analyzing and visualizing
information about objects on map.

## Installation

Clone repository

```bash
git clone git@github.com:ArtemDordovskyi/rails-demo-postgis.git
```

Install libraries
```bash
bundle install
```

Create database and import schema to postgresql, then migrate
```bash
### More details inside lib/tasks/import_osm_data_to_db.sh
bin/rake db:create_with_osm_data
bin/rake db:migrate
```

Seed database with viirs fire events. 
```bash
wget https://firms.modaps.eosdis.nasa.gov/data/country/zips/viirs-snpp_2021_all_countries.zip
unzip viirs-snpp_2021_all_countries.zip
cp viirs-snpp/2021/viirs-snpp_2021_Zimbabwe.csv ./lib/tasks/virs_2021.csv
bin/rake db:seed_viirs_fire_events
```

## Usage

In process...


## Contributing

Pull requests are welcome. For major changes, please open an issue first
to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)
