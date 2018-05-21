class Product < ApplicationRecord
    belongs_to :category
    has_many :textiles
    has_many :requests

    FILTERS = %w(factory style facade structure product_type)
    
    scope :category, -> category { where category_id: category }
    scope :factory, -> factory { where factory: factory }
    scope :style, -> style { where style: style }
    scope :facade, -> facade { where facade: facade }
    scope :structure, -> structure { where structure: structure }
    scope :product_type, -> product_type { where product_type: product_type}
end
