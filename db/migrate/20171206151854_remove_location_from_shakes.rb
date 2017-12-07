class RemoveLocationFromShakes < ActiveRecord::Migration[5.0]
  def change
    remove_column :shakes, :location, :string
  end
end
