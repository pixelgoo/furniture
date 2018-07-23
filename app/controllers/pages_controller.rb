class PagesController < ApplicationController
  def index
    @furnitures = Furniture.all
    @random_products = Product.order("RANDOM()").first(3)
  end

  def privacy
  end

  def help
  end

  def terms
  end
end
