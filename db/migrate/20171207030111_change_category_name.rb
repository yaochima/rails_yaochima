class ChangeCategoryName < ActiveRecord::Migration[5.0]
  def change
    rename_column :restaurants, :category, :type
  end
end
