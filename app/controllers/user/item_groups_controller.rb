class User::ItemGroupsController < ApplicationController
    layout 'layouts/user'
    def show
        @menu = Menu.find(params[:menu_id])
        @item_group = ItemGroup.find(params[:id])
        @emotions = menu.shop.emotions
    end
end
