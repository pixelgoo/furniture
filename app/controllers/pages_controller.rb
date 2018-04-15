class PagesController < ApplicationController
    def show
        render template: "pages/#{params[:page]}"

        @tariffs = Tariff.all
    end
end
