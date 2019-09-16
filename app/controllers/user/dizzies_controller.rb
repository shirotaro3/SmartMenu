class User::DizziesController < ApplicationController

  before_action :set_menu
  before_action :reject_countinuous!

  def create
    shop = @menu.shop
    dizzy = Dizzy.new(shop_id: shop.id)
    dizzy.save
    session["shop#{@menu.shop_id}"] = "diz"
    respond_to do |format|
      format.js {@emotions = shop.emotions}
      format.html {redirect_to user_menu_path(@menu)}
    end
  end

  def set_menu
    @menu = Menu.find(params[:menu_id])
  end

  # 連投防止
  def reject_countinuous!
    redirect_to user_menu_path(@menu) if session["shop#{@menu.shop_id}"]
  end
end
