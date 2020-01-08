class Image < ApplicationRecord
  # ↓追加
  mount_uploader :src, ImageUploader
  belongs_to :exhibit
end
