class Shop::RequestsController < ApplicationController
    before_action :authenticate_shop!
    def index
        @requests = current_shop.requests.page(params[:page]).per(5)
    end

    def destroy
        @request = Request.find(params[:id])
        # apprication_controllerのメソッド・shop_id!=current_shop_idならリダイレクト&trueを返す
        correct_shop(@request) and return
        @request.destroy
        respond_to do |format|
            format.js {flash.now[:notice] = "リクエストを削除しました。"}
            format.html {redirect_to shop_requests_path,:notice=>"リクエストを削除しました。"}
        end
    end
end
