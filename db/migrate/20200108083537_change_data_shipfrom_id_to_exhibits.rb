class ChangeDataShipfromIdToExhibits < ActiveRecord::Migration[5.2]
  def change
    change_column :exhibits, :shipfrom_id, :integer
  end
end
