class AddActorImages < ActiveRecord::Migration
  def change
    create_table :actor_images do |t|
      t.string :url
      t.references :actor, index: true
    end
  end
end
