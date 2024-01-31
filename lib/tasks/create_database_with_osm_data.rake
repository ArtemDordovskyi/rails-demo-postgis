require 'csv'

namespace :db do
  desc "Create database and download osm data"
  task :create_with_osm_data do
    exec "#{Rails.root}/lib/tasks/import_osm_data_to_db.sh"
  end

  desc "Seed viirs_fire_events"
  task :seed_viirs_fire_events => :environment do
    def check_header(line)
      line.start_with?(/\D/)
    end

    # remove last "type" header
    def extract_headers(line)
      line.strip.split(',').map(&:to_sym)[0..-2]
    end

    # "0102" convert to "01:02"
    def fix_time(value)
      "#{value[0, 2]}:#{value[2,2]}"
    end

    def extract_date_time(headers, row_data, value, index)
      header = headers[index - 1]
      date = row_data[headers[index - 1]]
      value = "#{date} #{fix_time(value)}"
      [header, value]
    end

    def assign_data(line, headers)
      values = line.strip.split(',')
      row_data = {}

      headers.each_with_index do |header, index|
        value = values[index]
        if header == :acq_time
          header, value = extract_date_time(headers, row_data, value, index)
        end
        row_data.merge!(header => value)
      end

      row_data
    end

    # Get and unzip interesting country before
    # wget https://firms.modaps.eosdis.nasa.gov/data/country/zips/viirs-snpp_2021_all_countries.zip
    path = "#{Rails.root}/lib/tasks/viirs_2021.csv"
    arr = []
    headers = []
    File.foreach(path) do |line|
      if check_header(line)
        headers = extract_headers(line)
      else
        arr << assign_data(line, headers)
      end
    end

    ViirsFireEvent.upsert_all(arr)
  end
end
