class ProfilesController < ApplicationController
    before_action :authenticate_user!

    def show
    end

    def settings
        @tariffs = Tariff.all
    end

    def account
    end
end
