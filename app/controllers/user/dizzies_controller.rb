class User::DizziesController < ApplicationController
  def create
    @menu = Menu.find(params[:menu_id])
    shop = @menu.shop
    dizzy = Dizzy.new(shop_id: shop.id)
    dizzy.save
    respond_to do |format|
      format.js {@emotions = shop.emotions}
      format.html {redirect_to user_menu_path(@menu)}
    end
  end
end
