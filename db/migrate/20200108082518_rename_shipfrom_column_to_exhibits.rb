class RenameShipfromColumnToExhibits < ActiveRecord::Migration[5.2]
  def change
    rename_column :exhibits, :shipfrom, :shipfrom_id
  end
end
