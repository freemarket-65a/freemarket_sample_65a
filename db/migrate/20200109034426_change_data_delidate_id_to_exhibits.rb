class ChangeDataDelidateIdToExhibits < ActiveRecord::Migration[5.2]
  def change
    change_column :exhibits, :delidate_id, :integer
  end
end
