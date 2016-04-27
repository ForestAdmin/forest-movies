class Movie < ActiveRecord::Base
  has_and_belongs_to_many :genres
  has_and_belongs_to_many :actors
  has_and_belongs_to_many :countries
  has_many :rentals
  has_many :comments
end
