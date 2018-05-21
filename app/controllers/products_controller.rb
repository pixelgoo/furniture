class ProductsController < ApplicationController
  before_action :authenticate_user!

  has_scope :category
  has_scope :factory
  has_scope :style
  has_scope :facade
  has_scope :structure
  has_scope :product_type

  def index
    if request.query_parameters[:furniture]
      @query = request.query_parameters
      @current_filters = { }
      @filters = { 
        furniture: Furniture.all,
        category: Category.where(furniture_id: @query['furniture'])
      }
      
      @filters.each do |filter, value| 
        @current_filters[filter] = value.find(@query[filter]) if @query[filter].present?
      end

      if @current_filters[:category].present?
        Product::FILTERS.each do |product_filter|
          filter_values = @current_filters[:category].products.pluck(product_filter).uniq
          @filters[product_filter] = filter_values if filter_values.present?

          if @query[product_filter].present?
            @current_filters[product_filter] = @query[product_filter]
          end
        end
      end

      @products = apply_scopes(@current_filters[:furniture].products).all.page(params[:page]).per(10)
    else
      redirect_to root_path
    end
  end

  def show
    @product = Product.find(params[:id])
  end

end
