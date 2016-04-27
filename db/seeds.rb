# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

CSV.foreach('db/csv/omdbFull.csv', encoding: 'bom|utf-8', headers: true, col_sep: '\t') do |row|
  begin
  rescue
    byebug
  end
end

#require_relative '../app/services/movies-importer.rb'
#import = MoviesImporterCSV.new(path: 'db/csv/omdbFull.csv')

#import.valid_header?  # => false
#import.report.message # => "The following columns are required: email"

## Assuming the header was valid, let's run the import!

#import.run!
#import.report.success? # => true
#import.report.message  # => "Import completed. 4 created, 2 updated, 1 failed to update"
