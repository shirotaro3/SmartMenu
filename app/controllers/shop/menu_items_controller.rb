class Shop::MenuItemsController < ApplicationController
    before_action :authenticate_shop!
end
