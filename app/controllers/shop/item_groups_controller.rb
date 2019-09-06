class Shop::ItemGroupsController < ApplicationController
    before_action :authenticate_shop!
    def create
        item_group = ItemGroup.new(item_group_params)
        if item_group.save
            redirect_to shop_item_group_menu_items_path(item_group),:notice =>'アイテムグループを作成しました。'
        else
            redirect_to shop_menu_path(item_group.menu),:alert=>'登録に失敗しました。'
        end
    end
    private
    def item_group_params
        params.require(:item_group).permit(:category_id,:menu_id)
    end
end
