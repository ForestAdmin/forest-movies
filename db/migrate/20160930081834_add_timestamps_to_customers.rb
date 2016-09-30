class AddTimestampsToCustomers < ActiveRecord::Migration
  def change
    change_table(:customers) { |t| t.timestamps }

    Customer.all.each do |customer|
      customer.created_at = DateTime.now - (rand * 100)
      customer.updated_at = DateTime.now - (rand * 100)

      customer.save
    end
  end
end
