class RequestsController < ApplicationController
    before_action :authenticate_user!

    def index
        @requests = Request.newest
        @newest_amount = @requests.length
        if params[:scope].nil?
            @scope = 'newest'
        elsif Request.respond_to? params[:scope]
            @requests = Request.public_send(params[:scope])
            @scope = params[:scope]
        else
            raise 'index#requests: Invalid scope parameter received'
        end
    end
    
    def create
        request = Request.new
        request.user = current_user
        request.product = Product.find(params[:product_id])
        if request.save
            render 'requests/success'
        else
            redirect_to root_path
        end
    end

    def update
        request = current_user.requests.find(params[:request_id])
        case params[:action]
        when 'satisfy' then
            current_user.requests.find(params[:request_id]).satisfy!
        when 'archive' then
            current_user.requests.find(params[:request_id]).archive!
        end
    end
end
