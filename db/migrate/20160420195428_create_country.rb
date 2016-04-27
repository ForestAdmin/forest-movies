class CreateCountry < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name
    end

    create_table :countries_movies, id: false do |t|
      t.belongs_to :movie, index: true
      t.belongs_to :country, index: true
    end

    Movie.all.each do |movie|
      movie.country.split(',').map(&:strip).each do |country|
        country = Country.find_or_create_by(name: country)
        movie.countries << country
      end
    end
  end
end
