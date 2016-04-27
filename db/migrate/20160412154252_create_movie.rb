class CreateMovie < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.text :imdb_id
      t.text :title
      t.text :year
      t.text :runtime
      t.text :genre, array: true, default: []
      t.date :released
      t.text :director, array: true, default: []
      t.text :writer, array: true, default: []
      t.text :casts, array: true, default: []
      t.float :imdb_rating
      t.float :imdb_votes
      t.text :poster_url
      t.text :short_plot
      t.text :full_plot
      t.text :language
      t.text :country
      t.text :awards

      t.timestamps
    end
  end
end
