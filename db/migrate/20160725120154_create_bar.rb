class CreateBar < ActiveRecord::Migration
  def change
    create_table :bars do |t|
      t.string :comment
      t.belongs_to :foo, index: true

      t.timestamps
    end
  end
end
