class MoviesImporterCSV
  include CSVImporter

  model Movie

  column :id, required: true
  column :imdbID, to: -> () { 'imdb_id' }, required: true
  column :title, to: -> (title) { title.downcase }, required: true
  column :year, to: -> (year) { year.downcase }, required: true

  identifier :id
  when_invalid :skip
end
