class ProductsController < ApplicationController
  before_action :authenticate_user!
  
  has_scope :furniture
  has_scope :category
  has_scope :factory
  has_scope :style
  has_scope :facade
  has_scope :structure
  has_scope :product_type

  def index
    @products = apply_scopes(Product).all.page(params[:page]).per(10)
    @furnitures = Furniture.all
    @chosen_furniture = Furniture.chosen_furniture(request.query_parameters[:furniture])
  end

  def show
    @product = Product.find(params[:id])
  end
end
