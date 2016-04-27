class AddPriceToMovie < ActiveRecord::Migration
  def change
    add_column :movies, :price, :decimal

    Movie.all.each do |movie|
      movie.price = (((5.0 - 1.0) * rand() + 1) * 100).round / 100.0
      movie.save
    end
  end
end
