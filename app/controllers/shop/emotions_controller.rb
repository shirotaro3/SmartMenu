class Shop::EmotionsController < ApplicationController
    before_action :authenticate_shop!
    def index
        # apprication_controllerのメソッド・grin・happy・dizzyのカウントをハッシュで返す
        set_emotions(current_shop)
    end

    def reset
        grins = current_shop.grins
        happies = current_shop.happies
        dizzies = current_shop.dizzies
        grins.destroy_all
        happies.destroy_all
        dizzies.destroy_all
        redirect_to shop_emotions_path,:notice=>"エモーションをリセットしました。"
    end
end
