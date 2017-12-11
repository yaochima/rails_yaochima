class RealDataForRest < ActiveRecord::Migration[5.0]
  def change
    add_column :restaurants, :dianping_id, :integer
    add_column :restaurants, :dianping_url, :string
    add_column :restaurants, :rating_flavor, :float
    add_column :restaurants, :rating_environ, :float
    add_column :restaurants, :rating_service, :float
  end
end
