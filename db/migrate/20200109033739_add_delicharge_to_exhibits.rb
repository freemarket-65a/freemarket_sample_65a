class AddDelichargeToExhibits < ActiveRecord::Migration[5.2]
  def change
    add_column :exhibits, :delicharge_id, :integer
  end
end
