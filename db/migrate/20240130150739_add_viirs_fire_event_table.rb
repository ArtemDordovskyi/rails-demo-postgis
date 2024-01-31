class AddViirsFireEventTable < ActiveRecord::Migration[7.1]
  def change
    create_table :viirs_fire_events do |t|
      t.float    :latitude
      t.float    :longitude
      t.float    :bright_ti4
      t.float    :scan
      t.float    :track
      t.datetime :acq_date
      t.text     :satellite
      t.text     :instrument
      t.text     :confidence
      t.text     :version
      t.float    :bright_ti5
      t.float    :frp
      t.text     :daynight
      t.geometry :geom, as: "ST_MakePoint(longitude, latitude)", srid: 4326, stored: true
    end
  end
end
