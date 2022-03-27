# frozen_string_literal: true

require 'yaml'
require 'csv'

PACKWERK_OUTPUT_FOLDER = './packwerk-outputs'
CSV_HEADERS = %w[domain violation_name file_name].freeze

CSV.open('myfile.csv', 'w') do |csv_data|
  csv_data << CSV_HEADERS
  Dir.entries(PACKWERK_OUTPUT_FOLDER).each do |f|
    file = File.join(PACKWERK_OUTPUT_FOLDER, f)
    next unless File.file? file

    domain = f.split('.').first # domain inferred from file name
    pw_data = YAML.load_file(file)

    pw_data['.'].each do |(v_name, v_data)| # for each violation
      v_data['files'].each do |file_name|
        csv_data << [domain, v_name, file_name]
      end
    end
  end
end

# Dir.entries(PACKWERK_OUTPUT_FOLDER).reduce([CSV_HEADERS]) do |csv_data, f|
#   file = File.join(PACKWERK_OUTPUT_FOLDER, f)
#   next csv_data unless File.file? file
#
#   domain = f.split('.').first # domain inferred from file name
#   pw_data = YAML.load_file(file)
#
#   pw_data['.'].each do |(v_name, v_data)| # for each violation
#     v_data['files'].each do |file_name|
#       csv_data << [domain, v_name, file_name]
#     end
#   end
#
#   csv_data
# end

# puts pw_data_marged
