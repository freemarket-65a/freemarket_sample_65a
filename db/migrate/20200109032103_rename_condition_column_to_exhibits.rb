class RenameConditionColumnToExhibits < ActiveRecord::Migration[5.2]
  def change
    rename_column :exhibits, :condition, :condition_id
  end
end
