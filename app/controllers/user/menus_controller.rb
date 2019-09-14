class User::MenusController < ApplicationController
    layout 'layouts/user'
    def show
        @menu = Menu.find(params[:id])
        @emotions = menu.shop.emotions
    end
end
