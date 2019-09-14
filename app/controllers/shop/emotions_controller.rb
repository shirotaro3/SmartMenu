class Shop::EmotionsController < ApplicationController
    before_action :authenticate_shop!
    def index
        # インスタンスメソッド・grin・happy・dizzyのカウントをハッシュで返す
        @emotions = current_shop.emotions
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
