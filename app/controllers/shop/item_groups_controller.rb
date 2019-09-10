class Shop::ItemGroupsController < ApplicationController
    before_action :authenticate_shop!
    def create
        item_group = ItemGroup.new(item_group_params)
        item_group.menu_id = params[:menu_id]
        correct_shop(item_group.menu) and return
        if item_group.save
            redirect_to shop_menu_path(item_group.menu),:notice =>'アイテムグループを作成しました。'
        else
            redirect_to shop_menu_path(params[:menu_id]),:alert=>'登録に失敗しました。'
        end
    end
    def destroy
        item_group = ItemGroup.find(params[:id])
        correct_shop(item_group.menu) and return
        item_group.destroy
        redirect_to shop_menu_path(item_group.menu),:notice=>'アイテムグループを削除しました。'
    end
    private
    def item_group_params
        params.require(:item_group).permit(:category_id,:group_image)
    end
end
