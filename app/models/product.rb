class Product < ApplicationRecord
    belongs_to :category
    has_many :textiles
    has_many :requests
end
