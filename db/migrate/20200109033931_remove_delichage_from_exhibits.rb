class RemoveDelichageFromExhibits < ActiveRecord::Migration[5.2]
  def change
    remove_column :exhibits, :delicharge, :text
  end
end
