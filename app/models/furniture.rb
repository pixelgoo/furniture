class Furniture < ApplicationRecord
  has_many :categories
  has_many :products, through: :categories
  has_and_belongs_to_many :users
end
