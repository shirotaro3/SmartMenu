class Admin::DeletedShopsController < ApplicationController
    layout 'layouts/admin'

    before_action :current_admin
    before_action :require_admin_sign_in!

    def index
        @deleted_shops = DeletedShop.all.page(params[:page]).per(15)
    end
    
    def show
        @deleted_shop = DeletedShop.find(params[:id])
    end
end
