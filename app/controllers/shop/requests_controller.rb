class Shop::RequestsController < ApplicationController
    before_action :authenticate_shop!
    def index
        @requests = current_shop.requests
    end

    def destroy
        request = Request.find(params[:id]
        correct_shop(request) and return
        request.destroy
        redirect_to shop_requests_path
    end
end
