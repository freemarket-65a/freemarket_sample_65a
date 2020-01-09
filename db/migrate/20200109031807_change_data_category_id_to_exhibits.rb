class ChangeDataCategoryIdToExhibits < ActiveRecord::Migration[5.2]
  def change
    change_column :exhibits, :category_id, :integer
  end
end
