class Product < ApplicationRecord
    belongs_to :category
    has_many :textiles
    has_many :requests
    
    scope :chosen_furniture, -> furniture { Furniture.where(id: furniture).first }
    scope :furniture, -> furniture { Furniture.where(id: furniture).first.products }
    scope :category, -> category { where category_id: category }
    scope :factory, -> factory { where factory: factory }
    scope :style, -> style { where style: style }
    scope :facade, -> { where facade: facade }
    scope :structure, -> structure { where structure: structure }
    scope :product_type, -> product_type { where product_type: product_type}
end
