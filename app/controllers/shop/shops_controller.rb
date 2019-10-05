class Shop::ShopsController < ApplicationController
    before_action :authenticate_shop!
    
    def top
        @requests = current_shop.requests
        happies = current_shop.happies
        dizzies = current_shop.dizzies
        grins = current_shop.grins
        @data = {'happy' => happies.count, 'dizzy' => dizzies.count, 'grin' => grins.count}
    end
end
