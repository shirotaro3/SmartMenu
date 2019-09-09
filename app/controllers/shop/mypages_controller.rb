class Shop::MypagesController < ApplicationController
    before_action :authenticate_shop!
    def top
        @requests = current_shop.requests
        happies = current_shop.happies
        dizzies = current_shop.dizzies
        grins = current_shop.grins
        @data = {'happy' => happies.count, 'dizzy' => dizzies.count, 'grin' => grins.count}
    end

    def cancel
    end

    def show
        reject_incorrect
    end

    def edit
        reject_incorrect
    end

    def destroy
        reject_incorrect
        shop = current_shop
        shop.destroy
        redirect_to root_path
    end

    def update
        reject_incorrect
        @shop = current_shop
        if @shop.update(shop_params)
            redirect_to shop_mypage_path(@shop),:notice=>'変更を保存しました。'
        else
            render :edit
        end
    end

    def reject_incorrect
        # URL直打ちを弾く(param[:id]とログイン中のidが同じか)
        redirect_to top_shop_mypages_path if params[:id].to_i != current_shop.id
    end

    private
    def shop_params
        params.require(:shop).permit(:state,:city,:street,:phone_number,:shop_name,:postal_code,:email)
    end
end
