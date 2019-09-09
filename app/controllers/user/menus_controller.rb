class User::MenusController < ApplicationController
    layout 'layouts/user'
    def show
        @menu = Menu.find(params[:id])
    end
end
