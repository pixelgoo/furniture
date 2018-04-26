module ApplicationHelper

    def current_path(path)
        "current" if current_page?(path)
    end

    def hide_header?
        controller.class.name == 'ProfilesController' ||
        controller.class.name == 'RequestsController' ||
        controller.class.name == 'Users::RegistrationsController' ||
        controller.class.name == 'Users::SessionsController'
    end

    def hide_footer?
        controller.class.name == 'Users::RegistrationsController' ||
        controller.class.name == 'Users::SessionsController'
    end

    def content_aside?
        controller.class.name == 'ProfilesController' ||
        controller.class.name == 'RequestsController'
    end

    def product_image(product)
        %w(jpg png webp).each do |extension|
            image_path = Pathname.new "#{Rails.root}/app/webpack/images/products/#{product.category_id}/#{product.product_id}_0.#{extension}"
            return image_tag(asset_pack_path("images/products/#{product.category_id}/#{product.product_id}_0.#{extension}")) if image_path.exist?
        end
    end

    def price_per_day(tariff)
        humanized_money(tariff.price).delete(' ').to_i/30
    end

end
