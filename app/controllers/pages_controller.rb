class PagesController < ApplicationController
  def show
    case params[:page]
    when 'index'
      @furnitures = Furniture.all
      @random_products = Product.order("RANDOM()").first(3)
    end

    render template: "pages/#{params[:page]}"
  end
end
