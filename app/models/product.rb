class Product < ApplicationRecord
    belongs_to :category
    has_many :textiles
    has_many :requests

    def image_path
        i = 0
        path = ""
        
        if Rails.env.production?

        else
            loop do
                path = "products/#{self.category_id}/#{self.product_id}_#{i}.jpg"
                break if Rails.application.precompiled_assets.include? path
                i += 1
            end
        end

        path
    end
end
