class RenameDelichargeColumnToExhibits < ActiveRecord::Migration[5.2]
  def change
    rename_column :exhibits, :delicharge, :delicharge_id
  end
end
