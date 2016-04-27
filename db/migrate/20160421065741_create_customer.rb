class CreateCustomer < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :stripe_id
      t.string :country
      t.string :city
      t.string :street_address
      t.string :zip_code
      t.string :state
      t.string :geoloc
    end
  end
end
