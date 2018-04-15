class PagesController < ApplicationController
    def show
        case params[:page]
        when 'index'
            @tariffs = Tariff.all
        end

        render template: "pages/#{params[:page]}"
    end
end
