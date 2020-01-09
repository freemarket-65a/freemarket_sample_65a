class RenameCategoryColumnToExhibits < ActiveRecord::Migration[5.2]
  def change
    rename_column :exhibits, :category, :category_id
  end
end

