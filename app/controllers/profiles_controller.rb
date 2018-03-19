class ProfilesController < ApplicationController
    before_action :authenticate_user!

    def show
        render template: "profile"
    end

    def settings
        render template: "settings"
    end

    def account
        render template: "account"
    end
end
