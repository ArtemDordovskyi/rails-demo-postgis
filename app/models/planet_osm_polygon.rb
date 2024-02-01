# frozen_string_literal: true

class PlanetOsmPolygon < ApplicationRecord
  self.table_name = 'planet_osm_polygon'
  self.primary_key = 'osm_id'

  attribute :way, srid: 4326, geographic: true
end
