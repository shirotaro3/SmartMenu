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
        # 更新失敗時に階層リンクの文字が変わるのを防止
        @menu_name = @menu.menu_name
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
        # 更新失敗時に階層リンクの文字が変わるのを防止
        @menu_name = @menu.menu_name
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

    # 2次元コードの表示
    def qrcode
        @menu = Menu.find(params[:id])
        correct_shop(@menu) and return
        # MENUのURL 2次元コードヘルパーで使用
        @url = user_menu_url(@menu)
        respond_to do |format|
            format.html{render layout: 'layouts/qrcode'}
            format.pdf do
                render  pdf: 'qrcode',
                        layout: 'layouts/qrcode',
                        encoding: 'utf-8'
            end
        end
    end

    private
    def menu_params
        params.require(:menu).permit(:menu_name, :color)
    end
end
