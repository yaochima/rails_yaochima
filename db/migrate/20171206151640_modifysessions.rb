class Modifysessions < ActiveRecord::Migration[5.0]
  def change
    add_column :sessions, :lat, :float
    add_column :sessions, :lng, :float
  end
end
