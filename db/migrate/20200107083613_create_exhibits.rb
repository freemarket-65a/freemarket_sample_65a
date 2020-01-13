class CreateExhibits < ActiveRecord::Migration[5.2]
  def change
    create_table :exhibits do |t|
      t.references       :user,            null: false,foreign_key:true
      t.string           :name,            null: false
      t.text             :detail,          null: false
      t.integer          :category_id,     null: false
      t.integer          :condition_id,    null: false
      t.integer          :delicharge_id,   null: false
      t.integer          :shipfrom_id,     null: false
      t.integer          :delidate_id,     null: false
      t.integer          :price,           null: false
      t.integer          :status,          null: false, default: 1 
      t.timestamps
    end
  end
end