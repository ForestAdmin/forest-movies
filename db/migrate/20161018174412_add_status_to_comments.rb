class AddStatusToComments < ActiveRecord::Migration
  def change
    add_column :comments, :status, :integer

    Comment.where('created_at > ?', 6.month.ago).update_all(status: 0)
    Comment.where('customer_id > ?', 19000).update_all(status: 2)
    Comment.where(status: nil).update_all(status: 1)
  end
end
