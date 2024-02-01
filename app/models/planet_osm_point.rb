# frozen_string_literal: true

class PlanetOsmPoint < ApplicationRecord
  self.table_name = 'planet_osm_point'
  self.primary_key = 'osm_id'

  attribute :way, :st_point, srid: 4326, geographic: true
end
