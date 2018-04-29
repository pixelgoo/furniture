class RequestsController < ApplicationController
    before_action :authenticate_user!

    def index
        @status = params[:status]
        if Request::STATUSES.include?(@status)
            @active_requests = current_user.manufacturer_requests.where(status: 'active')
            if @status == 'new'
                @requests = Request.where(status: 'new').where.not(token: current_user.manufacturer_requests.pluck(:token))
            else
                @requests = current_user.manufacturer_requests.where(status: @status)
            end
        else
            logger.warn "index#requests: Invalid status parameter received"
            redirect_to requests_path(status: 'new')
        end
    end
    
    def create
        request = Request.new
        request.customer = current_user
        request.product = Product.find(params[:product_id])
        if request.save
            render 'requests/success'
        else
            redirect_to root_path
        end
    end

    def update
        # Initially Request has 'new' status and is not attached to any Manufacturer.
        # Activating request means duplicating Active Record object and attaching new copy to Manufacturer. 
        # Thus each Manufacturer can have his own Request and can perform operations on it independently.
        # Requests for same product from same user but owned by different Manufacturers can be found by request token.

        request = current_user.request(params[:id]) || Request.find_by(id: params[:id]).assign_to_manufacturer(current_user)

        if request.send(:set_status, params[:new_status], current_user)
            redirect_to requests_path(status: params[:new_status])
        else
            logger.warn "update#requests: Invalid new_status parameter received"
            redirect_to requests_path
        end
    end
end
