class CreateExhibits < ActiveRecord::Migration[5.2]
  def change
    create_table :exhibits do |t|
      t.references       :user,            null: false,foreign_key:true
      t.string           :name,            null: false
      t.text             :detail,          null: false
      t.text             :category,        null: false
      t.text             :condition,       null: false
      t.text             :delicharge,      null: false
      t.text             :shipfrom,        null: false
      t.text             :dalidate,        null: false
      t.integer          :price,           null: false
      t.timestamps
    end
  end
end

