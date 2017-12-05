class CreateRestaurants < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :category
      t.string :profile_photo
      t.string :rating
      t.string :location
      t.string :price_range
      t.string :phone_number
      t.string :address
      t.string :lat
      t.string :long
      t.date :opening_time
      t.date :closing_time
    end
  end
end
