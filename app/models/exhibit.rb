class Exhibit < ApplicationRecord
  # ↓追加
  belongs_to :user
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :shipfrom
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :delicharge
  belongs_to_active_hash :delidate

end
