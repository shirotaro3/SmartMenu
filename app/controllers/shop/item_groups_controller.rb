class Shop::ItemGroupsController < ApplicationController
    before_action :authenticate_shop!
    def create
        item_group = ItemGroup.new(item_group_params)
        item_group.menu_id = params[:menu_id]
        if item_group.save!
            redirect_to shop_menu_path(params[:menu_id]),:notice =>'アイテムグループを作成しました。'
        else
            redirect_to shop_menu_path(params[:menu_id]),:alert=>'登録に失敗しました。'
        end
    end
    def destroy
        item_group = ItemGroup.find(params[:id])
        if item_group.menu.shop_id == current_shop.id
            item_group.destroy
            redirect_to shop_menu_path(item_group.menu),:notice=>'アイテムグループを削除しました。'
        else
            redirect_to top_shop_mypages_path,:alert=>'アクセス権限がありません。'
        end
    end
    private
    def item_group_params
        params.require(:item_group).permit(:category_id,:group_image)
    end
end
