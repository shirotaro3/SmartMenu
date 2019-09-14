class DeletedShop < ApplicationRecord
    
    # shopから複製するクラスメソッド
    def self.duplicate(shop)
        new(shop_name: shop.shop_name,
            postal_code: shop.postal_code,
            state: shop.state,
            city: shop.city,
            street: shop.street,
            phone_number: shop.phone_number,
            email: shop.email
        )
    end
end