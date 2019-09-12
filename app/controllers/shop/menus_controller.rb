class Shop::MenusController < ApplicationController
    before_action :authenticate_shop!
    
    def index
        @menu = Menu.new
        @menus = current_shop.menus
    end

    def create
        @menu = Menu.new(menu_params)
        @menu.shop_id = current_shop.id
        if @menu.save
            redirect_to shop_menu_path(@menu),:notice => 'メニューを作成しました。'
        else
            flash.now[:alert] = '作成に失敗しました。'
            @menus = current_shop.menus
            render :index
        end
    end

    def update
        @menu = Menu.find(params[:id])
        correct_shop(@menu) and return
        if @menu.update(menu_params)
            redirect_to shop_menu_path(@menu),:notice=>'変更を保存しました。'
        else
            flash[:alert] = '更新に失敗しました。'
            render :edit
        end
    end

    def edit
        @menu = Menu.find(params[:id])
        correct_shop(@menu) and return
    end

    def destroy
        menu = Menu.find(params[:id])
        correct_shop(menu) and return
        menu.destroy
        redirect_to shop_menus_path, :notice=>'メニューを削除しました。'
    end

    def show
        @menu = Menu.find(params[:id])
        correct_shop(@menu) and return
    end

    # QRコードの表示
    def qrcode
        menu = Menu.find(params[:id])
        correct_shop(menu) and return
        @url = qrcode_shop_menu_url(menu)
        render layout: 'layouts/qrcode'
    end

    private
    def menu_params
        params.require(:menu).permit(:menu_name, :color)
    end
end
