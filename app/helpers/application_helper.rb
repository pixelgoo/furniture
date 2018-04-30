module ApplicationHelper

    def current?(name)
        "current" if controller_name == name || current_page?(name)
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

    def price_per_day(tariff)
        humanized_money(tariff.price).delete(' ').to_i/30
    end

end
