class Shop::MenuItemsController < ApplicationController
    before_action :authenticate_shop!
    def index
        @menu_items = MenuItem.where(item_group_id: params[:item_group_id])
    end
end
