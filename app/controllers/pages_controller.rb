class PagesController < ApplicationController
  def index
    @furnitures = Furniture.all
    @random_products = Product.order("RANDOM()").first(3)
    @feedback = Feedback.new
  end

  def privacy
  end

  def offert
  end

  def help
    @feedback = Feedback.new
  end

  def terms
  end
end
