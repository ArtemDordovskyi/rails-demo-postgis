class AddGeomIndexes < ActiveRecord::Migration[7.1]
  def change
    add_index :military_geometries, :geom, using: :gist
    add_index :planet_osm_line, :way, using: :gist
    add_index :planet_osm_point, :way, using: :gist
    add_index :planet_osm_polygon, :way, using: :gist
    add_index :planet_osm_roads, :way, using: :gist
    add_index :viirs_fire_events, :geom, using: :gist
  end
end
