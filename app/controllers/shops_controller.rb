class ShopsController < ApplicationController
    # Shopログイン後　遷移先ページ
    def show
        @shop = current_shop
    end
end
