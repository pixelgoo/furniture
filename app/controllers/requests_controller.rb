class RequestsController < ApplicationController
    before_action :authenticate_user!

    def index
        if params[:scope].nil?
            @requests = Request.new
        if Request.respond_to? method_name
        Request.public_send(params[:]) if obj.respond_to? method_name
        @requests = Request.scope_new
    end

    def new

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

    def destroy

    end
end
