class Shop::MenuItemsController < ApplicationController
    before_action :authenticate_shop!

    def index
        @menu_item = MenuItem.new
        @item_group = ItemGroup.find(params[:item_group_id])
        # sessionチェック
        correct_shop(@item_group.menu) and return
        @menu_items = MenuItem.where(item_group_id: @item_group.id)
    end

    def create
        @item_group = ItemGroup.find(params[:item_group_id])
        # sessionチェック
        correct_shop(@item_group.menu) and return
        @menu_item = MenuItem.new(menu_item_params)
        @menu_item.item_group_id = @item_group.id
        if @menu_item.save
            redirect_to shop_item_group_menu_items_path(@item_group),:notice=>'アイテムを追加しました。'
        else
            @menu_items = MenuItem.where(item_group_id: params[:item_group_id])
            flash.now[:alert] = '登録に失敗しました。'
            render :index
        end
    end

    def update
        @menu_item = MenuItem.find(params[:id])
        # sessionチェック
        correct_shop(@menu_item.item_group.menu) and return
        if @menu_item.update(menu_item_params)
            redirect_to shop_item_group_menu_items_path(@menu_item.item_group),:notice => "アイテムを更新しました。"
        else
            flash.now[:alert] = "更新に失敗しました。"
            render :edit
        end
    end

    def show
        @menu_item = MenuItem.find(params[:id])
        correct_shop(@menu_item.item_group.menu) and return
    end
    
    def edit
        @menu_item = MenuItem.find(params[:id])
        correct_shop(@menu_item.item_group.menu) and return
    end

    def destroy
        menu_item = MenuItem.find(params[:id])
        correct_shop(menu_item.item_group.menu) and return
        menu_item.destroy
        redirect_to shop_item_group_menu_items_path(menu_item.item_group),:notice=>'アイテムを削除しました。'
    end
    
    # 並べ替え用
    def move_higher
        menu_item = MenuItem.find(params[:id])
        # sessionチェック
        correct_shop(menu_item.item_group.menu) and return
        # positionカラム更新(gem:acts_as_list)
        menu_item.move_higher
        # htmlならリダイレクト、jsなら処理用のデータを渡す
        respond_to do |format|
            format.js {@menu_items = MenuItem.where(item_group_id: menu_item.item_group_id)}
            format.html {redirect_to shop_item_group_menu_items_path(menu_item)}
        end
    end

    # 並べ替え用
    def move_lower
        menu_item = MenuItem.find(params[:id])
        correct_shop(menu_item.item_group.menu) and return
        menu_item.move_lower
        respond_to do |format|
            format.js { @menu_items = MenuItem.where(item_group_id: menu_item.item_group_id)}
            format.html {redirect_to shop_item_group_menu_items_path(menu_item)}
        end
    end

    private
    def menu_item_params
        params.require(:menu_item).permit(:price,:item_name,:item_text,:item_image)
    end
end
