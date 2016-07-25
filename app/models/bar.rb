class Bar < ActiveRecord::Base
  belongs_to :foo, class_name: 'Rental'
end

