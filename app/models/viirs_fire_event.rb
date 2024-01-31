# frozen_string_literal: true

class ViirsFireEvent < ApplicationRecord
  attribute :geom, :st_point, srid: 4326, geographic: true
end
