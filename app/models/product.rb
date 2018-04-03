class Product < ApplicationRecord
    belongs_to :category
    has_and_belongs_to_many :textiles
    has_many :requests
end
