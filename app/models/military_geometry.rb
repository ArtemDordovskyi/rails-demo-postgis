# frozen_string_literal: true

class MilitaryGeometry < ApplicationRecord
  self.primary_key = 'osm_id'

  attribute :geom, :st_point, srid: 4326, geographic: true

  def self.fired
    count = ViirsFireEvent.all.count
    parts = count / 10000

    values = parallel_for(parts) do |part|
      begin
        self.fire_query(part)
      rescue
        retry
      end
    end

    values.map { |val| self.new(val) }
  end

  private
  def self.parallel_for(n, &block)
    threads = (0...n).map do |i|
      Thread.new(i, &block)
    end

    threads.map do |t|
      if t.value.count > 0
        self.map_values_to_attributes(t.value)
      end
    end.compact.flatten
  end

  def self.fire_query(part)
    query = <<-SQL
        SELECT mg.osm_id, 
               mg.geom_type, 
               mg.landuse, 
               mg.military, 
               mg.building, 
               mg.name, 
               mg.operator, 
               mg.geom
        FROM military_geometries AS mg
        WHERE EXISTS (
            SELECT 1
            FROM 
            (SELECT geom
              FROM viirs_fire_events
              OFFSET #{part*10000}
              LIMIT 10000) AS vfe
            WHERE ST_Contains(mg.geom, vfe.geom)
        );
      SQL
    result = []
    ActiveRecord::Base.connection_pool.with_connection do
      result = ActiveRecord::Base.connection.execute(query).values
    end
    result
  end

  def self.map_values_to_attributes(attrs)
    hs = []
    attrs.each do |val|
      h = {}
      self.attribute_names.each_with_index do |attr, index|
        h.merge!(attr => val[index])
      end
      hs << h
    end
    hs
  end
end
