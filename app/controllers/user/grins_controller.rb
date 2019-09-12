class User::GrinsController < ApplicationController
  def create
    @menu = Menu.find(params[:menu_id])
    shop = @menu.shop
    grin = Grin.new(shop_id: shop.id)
    grin.save
    respond_to do |format|
      format.js {set_emotions(shop)}
      format.html {redirect_to user_menu_path(@menu)}
    end
  end
end
