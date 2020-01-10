class ChangeDataConditionIdToExhibits < ActiveRecord::Migration[5.2]
  def change
    change_column :exhibits, :condition_id, :integer
  end
end
