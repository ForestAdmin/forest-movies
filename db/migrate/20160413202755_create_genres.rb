class CreateGenres < ActiveRecord::Migration
  def change
    create_table :genres do |t|
      t.text :genre
    end

    sql = 'SELECT DISTINCT unnest(genre) FROM movies;'
    ActiveRecord::Base.connection.execute(sql).each do |row|
      Genre.new(genre: row['unnest']).save
    end
  end
end
