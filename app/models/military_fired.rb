# frozen_string_literal: true

class MilitaryFired < ApplicationRecord
  attribute :geom, :st_polygon, srid: 4326, geographic: true
  def readonly?
    true
  end

  def self.refresh
    Scenic.database.refresh_materialized_view(table_name, concurrently: false, cascade: false)
  end

  def self.coordinates
    self.all.map{ |mf| mf.geom.coordinates }
  end
end
