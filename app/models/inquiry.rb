class Inquiry < ApplicationRecord
    validates :name, presence: true, length: { maximum: 20 }
    validates :message, presence: true, length: { in: 20..200 }

    def insert_shop_info(shop)
        self.shop_id = shop.id
        self.shop_name = shop.shop_name
        self.email = shop.email
    end
end
