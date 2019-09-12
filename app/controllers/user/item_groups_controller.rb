class User::ItemGroupsController < ApplicationController
    layout 'layouts/user'
    def show
        @menu = Menu.find(params[:menu_id])
        @item_group = ItemGroup.find(params[:id])
        set_emotions(@menu.shop)
    end
end
