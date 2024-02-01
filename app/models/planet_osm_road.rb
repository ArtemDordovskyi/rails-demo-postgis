# frozen_string_literal: true

class PlanetOsmRoad < ApplicationRecord
  self.primary_key = 'osm_id'

  attribute :way, :line_string, srid: 4326, geographic: true
end
