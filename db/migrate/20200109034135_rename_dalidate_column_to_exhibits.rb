class RenameDalidateColumnToExhibits < ActiveRecord::Migration[5.2]
  def change
    rename_column :exhibits, :dalidate, :delidate_id
  end
end
