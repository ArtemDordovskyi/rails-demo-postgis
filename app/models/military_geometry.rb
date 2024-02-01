# frozen_string_literal: true

class MilitaryGeometry < ApplicationRecord
  self.primary_key = 'osm_id'

  attribute :geom, :st_polygon, srid: 4326, geographic: true
end
