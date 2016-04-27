class CreateComment < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :comment
      t.belongs_to :customer, index: true
      t.belongs_to :movie, index: true

      t.timestamps
    end

    Rental.limit(15000).each do |rental|
      date = Faker::Time.backward(365)

      Comment.create({
        customer: rental.customer,
        movie: rental.movie,
        comment: Faker::Hipster.paragraph,
        created_at: date,
        updated_at: date
      })
    end
  end
end
