class Category < ApplicationRecord
  belongs_to :furniture
  has_many :products
end
