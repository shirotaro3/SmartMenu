class Admin::ShopsController < ApplicationController
    layout 'layouts/admin'
    
    before_action :current_admin
    before_action :require_admin_sign_in!
    def index
        @shops = Shop.all.page(params[:page]).per(15)
    end

    def destroy
        shop = Shop.find(params[:id])
        deleted_shop = DeletedShop.duplicate(shop)
        begin
            ActiveRecord::Base.transaction do
                deleted_shop.save!
                shop.destroy!
                redirect_to admin_shops_path,:alert=>"Shopを削除しました。"
            end
        rescue
            redirect_to action: :cancel,:danger=>"削除に失敗しました。"
        end
    end

    def show
        @shop = Shop.find(params[:id])
    end

    def edit
        @shop = Shop.find(params[:id])
    end

    def update
        @shop = Shop.find(params[:id])
        if @shop.update(shop_params)
            redirect_to admin_shops_path
        else
            flash.now[:alert] = "failed"
            render :edit
        end
    end
    private
    def shop_params
        params.require(:shop).permit(:shop_name,:state,:city,:street,:postal_code,:phone_number,:email)
    end
end
