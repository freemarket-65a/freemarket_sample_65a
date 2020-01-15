class Category < ApplicationRecord
  has_many :exhibits
  has_ancestry
end
