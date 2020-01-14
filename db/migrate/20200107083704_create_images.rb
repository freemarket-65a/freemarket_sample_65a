class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.references     :exhibit,   null: false,foreign_key:true
      t.text           :src,       null: false
      t.timestamps
    end
  end
end