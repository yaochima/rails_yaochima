class CreateShakes < ActiveRecord::Migration[5.0]
  def change
    create_table :shakes do |t|
      t.string :location
      t.references :session
      t.references :restaurant
      t.json :parameters
      t.timestamps
    end
  end
end
