class SetMovieGenres < ActiveRecord::Migration
  def up
    Movie.find_in_batches do |movies|
      movies.each do |movie|
        movie.genre.each do |g|
          movie.genres << Genre.find_by(genre: g)
        end
      end
    end
  end

  def down
  end
end
