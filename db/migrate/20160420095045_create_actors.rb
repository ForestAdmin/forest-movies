class CreateActors < ActiveRecord::Migration
  def change
    create_table :actors do |t|
      t.text :name
    end

    create_table :actors_movies, id: false do |t|
      t.belongs_to :movie, index: true
      t.belongs_to :actor, index: true
    end

    sql = 'SELECT DISTINCT unnest(casts) FROM movies;'
    ActiveRecord::Base.connection.execute(sql).each do |row|
      Actor.new(name: row['unnest']).save
    end

    Movie.find_in_batches do |movies|
      movies.each do |movie|
        movie.casts.each do |c|
          movie.actors << Actor.find_by(name: c)
        end
      end
    end
  end
end
