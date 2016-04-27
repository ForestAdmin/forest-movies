class RemoveOldColumns < ActiveRecord::Migration
  def change
    remove_column :movies, :casts
    remove_column :movies, :genre
  end
end
