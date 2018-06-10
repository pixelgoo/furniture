class Furniture < ApplicationRecord
  has_many :categories
  has_many :products, through: :categories
end
