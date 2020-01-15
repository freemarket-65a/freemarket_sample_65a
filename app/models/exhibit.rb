class Exhibit < ApplicationRecord
  # ↓追加
  belongs_to :user
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

  paginates_per 10

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :shipfrom
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :delicharge
  belongs_to_active_hash :delidate

  belongs_to :category

  validates :name, presence: true
  validates :detail, presence: true
  validates :category_id, presence: true
  validates :condition_id, presence: true
  validates :delicharge_id, presence: true
  validates :shipfrom_id, presence: true
  validates :delidate_id, presence: true
  validates :price, presence: true

end

