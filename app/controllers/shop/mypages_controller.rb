class Shop::MypagesController < ApplicationController
    def show
        @requests = current_shop.requests
        happies = current_shop.happies
        dizzies = current_shop.dizzies
        grins = current_shop.grins
        @data = {'happy' => happies.count, 'dizzy' => dizzies.count, 'grin' => grins.count}
    end
end
