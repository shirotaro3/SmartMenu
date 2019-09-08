class Shop::RequestsController < ApplicationController
    before_action :authenticate_shop!
    def index
        @requests = current_shop.requests
    end
end
