class Movie < ActiveRecord::Base
  has_and_belongs_to_many :genres
  has_and_belongs_to_many :actors
  has_and_belongs_to_many :countries
  has_many :rentals
  has_many :comments

  has_attached_file :poster, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :poster, content_type: /\Aimage\/.*\Z/
end
