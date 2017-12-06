class ChangeColumnTypes < ActiveRecord::Migration[5.0]
  def change

    remove_column :restaurants, :rating, :string
    add_column :restaurants, :rating, :integer

    remove_column :restaurants, :price_range, :string
    add_column :restaurants, :price_per_person, :integer

    remove_column :restaurants, :lat, :string
    add_column :restaurants, :lat, :float

    remove_column :restaurants, :long, :string
    add_column :restaurants, :lng, :float
  end
end
