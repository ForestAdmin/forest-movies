class Comment < ActiveRecord::Base
  belongs_to :customer
  belongs_to :movie

  enum status: [:pending, :accepted, :rejected]
end
