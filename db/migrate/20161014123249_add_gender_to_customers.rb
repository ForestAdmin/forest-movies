class AddGenderToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :gender, :string

    Customer.all.each do |customer|
      customer.update(gender: [:Male, :Female].sample)
    end
  end
end
