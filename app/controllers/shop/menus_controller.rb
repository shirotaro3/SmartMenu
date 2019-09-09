class Shop::MenusController < ApplicationController
    def index
        @menus = current_shop.menus
    end

    def create
        @menu = Menu.new(menu_params)
        @menu.shop_id = current_shop.id
        if @menu.save
            redirect_to shop_menu_path(@menu),:notice => 'メニューを作成しました。'
        else
            flash.now[:alert] = '入力内容をご確認下さい。'
            @menus = current_shop.menus
            render :index
        end
    end

    def update
        @menu = Menu.find(params[:id])
        # 直打ち対策
        if @menu.shop_id == current_shop.id
            if @menu.update(menu_params)
                redirect_to shop_menu_path(@menu),:notice=>'変更を保存しました。'
            else
                flash.now[:alert] = '保存に失敗しました。入力内容をご確認下さい。'
                render :edit
            end
        else
            redirect_to top_shop_mypages_path,:notice=>'アクセス権限がありません。'
        end
    end

    def edit
        @menu = Menu.find(params[:id])
    end

    def destroy
        menu = Menu.find(params[:id])
        if menu.shop_id = current_shop.id
            menu.destroy
            redirect_to shop_menus_path, :notice=>'メニューを削除しました。'
        else
            redirect_to shop_mypage_top_path,:alert=>'アクセス権限がありません。'
        end
    end

    def show
        @menu = Menu.find(params[:id])
    end

    # QRコードの表示
    def qrcode
        menu = Menu.find(params[:id])
        @url = qrcode_shop_menu_url(menu)
        render layout: 'layouts/qrcode'
    end

    private
    def menu_params
        params.require(:menu).permit(:menu_name, :color)
    end
end
