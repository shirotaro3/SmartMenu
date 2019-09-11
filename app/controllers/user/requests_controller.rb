class User::RequestsController < ApplicationController
    layout 'user'

    def new
        @menu = Menu.find(params[:menu_id])
    end

    def create
        @menu = Menu.find(params[:menu_id])
        @request = Request.new(request_params)
        @request.shop_id = @menu.shop_id
        if @request.save
            redirect_to thanks_user_menu_requests_path(@menu)
        else
            render :new
        end
    end

    def thanks
        @menu = Menu.find(params[:menu_id])
    end

    private
    def request_params
        params.require(:request).permit(:title,:message)
    end
end
