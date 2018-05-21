class PagesController < ApplicationController
    def show
        case params[:page]
        when 'index'
            @furnitures = Furniture.all
        end

        render template: "pages/#{params[:page]}"
    end
end
