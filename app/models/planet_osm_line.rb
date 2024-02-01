# frozen_string_literal: true

class PlanetOsmLine < ApplicationRecord
  self.table_name = 'planet_osm_line'
  self.primary_key = 'osm_id'

  attribute :way, :line_string, srid: 4326, geographic: true
end
