class RemovePosterUrl < ActiveRecord::Migration
  def change
    remove_column :movies, :poster_url
    remove_column :customers, :geoloc
  end
end
