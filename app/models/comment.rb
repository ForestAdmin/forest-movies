class Comment < ActiveRecord::Base
  belongs_to :customer
  belongs_to :movie
end
